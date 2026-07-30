#!/usr/bin/env bash
# SPIRAL orchestrator: runs exactly one research cycle.
# Exit codes: 0 = validated, 2 = ran but failed the gates (state reverted), other = hard failure.
set -euo pipefail
cd "$(dirname "$0")/.."

MAX_TURNS=$(python -c "import yaml;print(yaml.safe_load(open('config.yml'))['budget']['max_turns'])")
MODEL=$(python -c "import yaml;print(yaml.safe_load(open('config.yml'))['runtime']['model'])")
# Actual installed version, not the pinned string: if the pin ever fails to take, the
# per-cycle record shows what really ran rather than what was supposed to.
CLI_VERSION=$(claude --version 2>/dev/null | cut -d' ' -f1 || echo unknown)
MAX_ATTEMPTS=$(python -c "import yaml;print(int(yaml.safe_load(open('config.yml'))['schedule']['max_task_attempts']))")
TASK_TYPE=$(python -c "import json;print(json.load(open('state/queue/next_task.json'))['task_type'])")

# Map task type -> prompt file
case "$TASK_TYPE" in
  T1) TASK_PROMPT="prompts/t1_collect.md" ;;
  T2) TASK_PROMPT="prompts/t2_structure.md" ;;
  T3) TASK_PROMPT="prompts/t3_investigate.md" ;;
  T4) TASK_PROMPT="prompts/t4_assess.md" ;;
  T5) TASK_PROMPT="prompts/t5_select.md" ;;
  *) echo "Unknown task type: $TASK_TYPE" >&2; exit 1 ;;
esac

# Increment cycle counter (start of run; a failed run is still a numbered cycle) and
# stamp the runtime. meta.json is committed every cycle, so git history becomes the
# per-cycle provenance record without a separate file.
SPIRAL_MODEL="$MODEL" SPIRAL_CLI="$CLI_VERSION" python - <<'EOF'
import json, datetime, os
m = json.load(open('state/meta.json'))
m['cycle'] += 1
if not m.get('started'):
    m['started'] = datetime.date.today().isoformat()
m['runtime'] = {'model': os.environ['SPIRAL_MODEL'], 'cli_version': os.environ['SPIRAL_CLI']}
json.dump(m, open('state/meta.json', 'w'), indent=2, ensure_ascii=False)
print(f"cycle {m['cycle']} on {m['runtime']['model']} (cli {m['runtime']['cli_version']}), "
      f"task {open('state/queue/next_task.json').read()[:100]}...")
EOF
CYCLE=$(python -c "import json;print(json.load(open('state/meta.json'))['cycle'])")

# Snapshot state so the validator can revert agent damage but keep logs
git stash list >/dev/null 2>&1 || true
PRE_SHA=$(git rev-parse HEAD)
echo "$PRE_SHA" > /tmp/spiral_pre_sha

PROMPT="$(cat prompts/system.md)

---

$(cat "$TASK_PROMPT")

---

Current cycle number: ${CYCLE}
The queue entry you are executing is state/queue/next_task.json. Begin."

# Headless run. OAuth token comes from CLAUDE_CODE_OAUTH_TOKEN env (set by CI).
# The exit code is captured instead of being allowed to abort the script: under `set -e`
# a dead agent skipped the rollback below and its half-written state was committed.
set +e
claude -p "$PROMPT" \
  --model "$MODEL" \
  --max-turns "$MAX_TURNS" \
  --allowedTools "WebSearch,WebFetch,Read,Write,Edit,Glob,Grep" \
  --permission-mode acceptEdits \
  --output-format text \
  2>&1 | tee "logs/cycle-$(printf '%03d' "$CYCLE")-transcript.txt" | tail -20
AGENT_RC=${PIPESTATUS[0]}
set -e

# Tell "never started" apart from "died partway". If no research state was touched, the
# agent failed before doing anything — a bad token or a missing CLI — and there is
# nothing to roll back. Report it as a hard failure so run_night.sh trips the fast
# token/CLI breaker rather than the slower one meant for cycles that produced output.
if [ "$AGENT_RC" -ne 0 ] && \
   git diff --quiet "$PRE_SHA" -- state/issues state/knowledge state/assessments state/queue; then
  echo "AGENT FAILED TO START (rc=${AGENT_RC}) — no research state touched" >&2
  exit "$AGENT_RC"
fi

# Verification gates (G1/G3 mechanical checks). On failure: revert state, keep logs,
# restore the queue so the next cron retries the same task (at-least-once semantics).
# An agent that died mid-cycle (turn budget exhausted, API error) takes the same path:
# its partial edits never passed the gates, so committing them would put unverified
# content into the evidence artifact. Short-circuit order matters — the gates are not
# worth running, and their verdict not worth recording, when the agent never finished.
if [ "$AGENT_RC" -ne 0 ] || ! python scripts/validate_state.py; then
  if [ "$AGENT_RC" -ne 0 ]; then
    echo "AGENT ABORTED (rc=${AGENT_RC}) — reverting state, keeping logs" >&2
  else
    echo "VALIDATION FAILED — reverting state, keeping logs" >&2
  fi
  mkdir -p /tmp/spiral_logs && cp -r logs/* /tmp/spiral_logs/ 2>/dev/null || true
  git checkout "$PRE_SHA" -- state/
  # Bump attempt_count on the (restored) queue entry. Past max_task_attempts the entry
  # is abandoned and the queue advances to the next stage: retrying the same failing
  # task forever would otherwise consume every slot of an unattended deployment.
  SPIRAL_CYCLE="$CYCLE" SPIRAL_MAX_ATTEMPTS="$MAX_ATTEMPTS" python - <<'EOF'
import json, os, pathlib

CYCLE = int(os.environ['SPIRAL_CYCLE'])
MAX = int(os.environ['SPIRAL_MAX_ATTEMPTS'])
# Skip the stuck stage and resume the pipeline at the next one. T5 escapes to T4 so a
# broken selector re-assesses rather than inventing a target it could not choose.
NEXT_STAGE = {'T1': 'T4', 'T2': 'T4', 'T3': 'T4', 'T4': 'T5', 'T5': 'T4'}

q = json.load(open('state/queue/next_task.json'))
q['attempt_count'] = q.get('attempt_count', 0) + 1
stuck, issue, n = q.get('task_type'), q.get('target_issue'), q['attempt_count']

if n >= MAX:
    esc = NEXT_STAGE.get(stuck, 'T4')
    on_issue = f" on issue '{issue}'" if issue else ""
    if esc == 'T5':
        instr = (
            f"ESCAPE HATCH (cycle {CYCLE}): the queued {stuck} task{on_issue} failed "
            f"validation {n} times in a row and was abandoned by the orchestrator. "
            f"Run T5 (Select) per prompts/t5_select.md against the current state as-is. "
            f"Do not attempt the abandoned task's work. When ranking, treat"
            f"{on_issue or ' the abandoned target'} as recently attempted and apply the "
            f"attempt penalty, so the selector moves to a different target. Record the "
            f"abandonment in the cycle log."
        )
    else:
        instr = (
            f"ESCAPE HATCH (cycle {CYCLE}): the queued {stuck} task{on_issue} failed "
            f"validation {n} times in a row and was abandoned by the orchestrator. "
            f"Run T4 (Assess) per prompts/t4_assess.md against the current state as-is "
            f"— score every issue on the evidence that actually landed, without the "
            f"abandoned task's contribution. Do not attempt the abandoned task's work. "
            f"Record the abandonment in the cycle log."
        )
    # Audit trail: escapes are intervention-free recoveries, i.e. RQ4 evaluation data.
    p = pathlib.Path('state/queue/escapes.json')
    log = json.loads(p.read_text()) if p.exists() else {'escapes': []}
    log['escapes'].append({
        'cycle': CYCLE, 'abandoned_task': stuck, 'target_issue': issue,
        'attempts': n, 'escaped_to': esc,
    })
    p.write_text(json.dumps(log, indent=2, ensure_ascii=False) + "\n")
    q = {'cycle_created': CYCLE, 'task_type': esc, 'target_issue': None,
         'instructions': instr, 'attempt_count': 0}
    print(f"ESCAPE: {stuck} abandoned after {n} attempts -> {esc}")

json.dump(q, open('state/queue/next_task.json', 'w'), indent=2, ensure_ascii=False)
EOF
  # cycle counter still advances (it did run), meta is re-applied. The revert restored
  # meta.json from PRE_SHA, so re-stamp the runtime too — a rejected cycle still ran on
  # this model and must be attributable.
  SPIRAL_CYCLE="$CYCLE" SPIRAL_MODEL="$MODEL" SPIRAL_CLI="$CLI_VERSION" python - <<'EOF'
import json, os
m = json.load(open('state/meta.json'))
m['cycle'] = int(os.environ['SPIRAL_CYCLE'])
m['runtime'] = {'model': os.environ['SPIRAL_MODEL'], 'cli_version': os.environ['SPIRAL_CLI']}
json.dump(m, open('state/meta.json','w'), indent=2, ensure_ascii=False)
EOF
  cp -r /tmp/spiral_logs/* logs/ 2>/dev/null || true
  # Distinct exit codes so the night log and the commit label tell the two apart:
  # 2 = the agent finished and the gates rejected its output,
  # 3 = the agent never finished, so there was no output to judge.
  if [ "$AGENT_RC" -ne 0 ]; then
    echo "${TASK_TYPE} aborted mid-cycle, rc=${AGENT_RC} (attempt bumped)" > state/queue/last_completed_task.txt
    exit 3
  fi
  echo "${TASK_TYPE} failed validation (attempt bumped)" > state/queue/last_completed_task.txt
  exit 2
fi

echo "Cycle ${CYCLE} (${TASK_TYPE}) completed and validated."
