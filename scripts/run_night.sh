#!/usr/bin/env bash
# SPIRAL nightly batch: run research cycles back-to-back until the window closes.
#
# One cycle takes ~4-5 min, so a single cron firing wastes most of the idle-quota
# window. This spaces cycles by schedule.cycle_interval_min (measured start-to-start,
# so the quota refills between runs) and hard-stops at schedule.window_end_utc.
#
# Each cycle is committed and pushed as soon as it validates: if the runner is
# killed mid-night, finished cycles survive and the next night resumes from the
# queue entry they left behind.
set -uo pipefail   # deliberately NOT -e: one bad cycle must not end the whole night
cd "$(dirname "$0")/.."

# Normalised to whole seconds in Python: bash arithmetic cannot handle a fractional
# config value, and without `set -e` that failure would silently end the night after
# one cycle instead of erroring.
INTERVAL_SEC=$(python -c "import yaml;print(int(round(float(yaml.safe_load(open('config.yml'))['schedule']['cycle_interval_min'])*60)))")
START_UTC=$(python -c "import yaml;print(yaml.safe_load(open('config.yml'))['schedule']['window_start_utc'])")
END_UTC=$(python -c "import yaml;print(yaml.safe_load(open('config.yml'))['schedule']['window_end_utc'])")
MAX_FAIL=$(python -c "import yaml;print(int(yaml.safe_load(open('config.yml'))['schedule']['abort_after_consecutive_failures']))")
MAX_INVALID=$(python -c "import yaml;print(int(yaml.safe_load(open('config.yml'))['schedule']['abort_after_consecutive_invalid']))")

# Wall-clock bounds from today's window_{start,end}_utc. The end is a hard stop: a late
# cron firing shortens the night rather than pushing it past the intended local time.
BOUNDS=$(python - <<'EOF'
import datetime, sys, yaml
s = yaml.safe_load(open('config.yml'))['schedule']
now = datetime.datetime.now(datetime.timezone.utc)
def stamp(v):
    h, m = (int(x) for x in str(v).split(':'))
    return int(now.replace(hour=h, minute=m, second=0, microsecond=0).timestamp())
start, end = stamp(s['window_start_utc']), stamp(s['window_end_utc'])
if start >= end:
    sys.exit("window_start_utc must be earlier than window_end_utc")
print(start, end)
EOF
)
read -r START_AT DEADLINE <<< "$BOUNDS"

# Cron fires early on purpose; wait out the gap so research still runs at the intended
# local hour. A late firing skips this and starts immediately on what is left.
WAIT=$((START_AT - $(date +%s)))
if [ "$WAIT" -gt 0 ]; then
  echo "cron fired early — holding ${WAIT}s until the window opens at ${START_UTC}Z"
  sleep "$WAIT"
fi

echo "SPIRAL night batch — start $(date -u +%FT%TZ), window ${START_UTC}Z-${END_UTC}Z, interval ${INTERVAL_SEC}s"

n=0
consec_fail=0
consec_invalid=0
while true; do
  n=$((n + 1))
  START=$(date +%s)
  echo "════════ night cycle #${n} @ $(date -u +%T)Z ════════"

  # Read the label from the queue entry being dispatched, not from the agent-written
  # last_completed_task.txt: this is what actually ran, so the commit history stays
  # accurate even when a cycle dies before writing that file.
  TASK=$(python -c "
import json
n = {'T1':'collect','T2':'structure','T3':'investigate','T4':'assess','T5':'select'}
t = json.load(open('state/queue/next_task.json'))['task_type']
print(f\"{t} {n.get(t,'')}\".strip())
" 2>/dev/null) || TASK="unknown task"

  bash scripts/run_cycle.sh
  rc=$?
  case "$rc" in
    0) consec_fail=0; consec_invalid=0 ;;
    # The agent ran and the gates rejected it: the token works, so this is not a hard
    # failure. run_cycle.sh escalates the per-task retries; this only counts the streak.
    2) consec_invalid=$((consec_invalid + 1)); consec_fail=0
       echo "cycle failed validation (${consec_invalid} in a row) — continuing" >&2 ;;
    *) consec_fail=$((consec_fail + 1))
       echo "run_cycle.sh died with rc=${rc} (${consec_fail} in a row) — continuing" >&2 ;;
  esac

  # Persist immediately so a killed runner never loses a validated cycle.
  git add -A
  CYCLE=$(python -c "import json;print(json.load(open('state/meta.json'))['cycle'])")
  case "$rc" in
    0) MSG="cycle ${CYCLE}: ${TASK}" ;;
    2) MSG="cycle ${CYCLE}: ${TASK} failed validation" ;;
    *) MSG="cycle ${CYCLE}: ${TASK} run failed, no state change" ;;
  esac
  if git commit -q -m "$MSG" >/dev/null 2>&1; then
    git push -q || { git pull --rebase -q && git push -q; }
    echo "pushed — ${MSG}"
  else
    echo "nothing to commit"
  fi

  # Fail loudly rather than burning the night on a broken setup: a silent success
  # here would look identical to a productive night for as long as it stayed broken.
  if [ "$consec_fail" -ge "$MAX_FAIL" ]; then
    echo "ABORT — ${consec_fail} consecutive hard failures. Check CLAUDE_CODE_OAUTH_TOKEN" >&2
    echo "(expired?) and the claude CLI install. Failing the job so a notification fires." >&2
    exit 1
  fi

  # Per-task escapes keep the queue moving, so a streak this long means nothing is
  # landing anywhere — the gates themselves or the state are broken, not one task.
  if [ "$consec_invalid" -ge "$MAX_INVALID" ]; then
    echo "ABORT — ${consec_invalid} consecutive cycles failed validation despite the" >&2
    echo "per-task escape hatch. State or gates need a human; see state/queue/escapes.json" >&2
    echo "and the newest logs/cycle-*.md." >&2
    exit 1
  fi

  # The next slot must *start* inside the window; a cycle is never begun late.
  NEXT=$((START + INTERVAL_SEC))
  if [ "$NEXT" -ge "$DEADLINE" ]; then
    echo "next slot falls outside the window — stopping after ${n} cycle(s)"
    break
  fi
  SLEEP=$((NEXT - $(date +%s)))
  if [ "$SLEEP" -gt 0 ]; then
    echo "sleeping ${SLEEP}s until the next slot"
    sleep "$SLEEP"
  fi
done

echo "night batch done — ${n} cycle(s) completed."
