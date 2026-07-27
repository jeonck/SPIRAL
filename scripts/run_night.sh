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
END_UTC=$(python -c "import yaml;print(yaml.safe_load(open('config.yml'))['schedule']['window_end_utc'])")

# Wall-clock deadline: today's window_end_utc. A late cron firing shortens the
# night rather than pushing it past the intended local end time.
DEADLINE=$(python - <<'EOF'
import datetime, yaml
end = str(yaml.safe_load(open('config.yml'))['schedule']['window_end_utc'])
h, m = (int(x) for x in end.split(':'))
now = datetime.datetime.now(datetime.timezone.utc)
print(int(now.replace(hour=h, minute=m, second=0, microsecond=0).timestamp()))
EOF
)

echo "SPIRAL night batch — start $(date -u +%FT%TZ), window ends ${END_UTC}Z, interval ${INTERVAL_SEC}s"

n=0
while true; do
  n=$((n + 1))
  START=$(date +%s)
  echo "════════ night cycle #${n} @ $(date -u +%T)Z ════════"

  bash scripts/run_cycle.sh \
    || echo "run_cycle.sh exited non-zero — state left as-is, continuing" >&2

  # Persist immediately so a killed runner never loses a validated cycle.
  git add -A
  CYCLE=$(python -c "import json;print(json.load(open('state/meta.json'))['cycle'])")
  MSG="cycle ${CYCLE}: $(cat state/queue/last_completed_task.txt 2>/dev/null || echo run)"
  if git commit -q -m "$MSG"; then
    git push -q || { git pull --rebase -q && git push -q; }
    echo "pushed — ${MSG}"
  else
    echo "nothing to commit"
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
