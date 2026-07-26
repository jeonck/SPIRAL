#!/usr/bin/env bash
# SPIRAL orchestrator: runs exactly one research cycle.
set -euo pipefail
cd "$(dirname "$0")/.."

MAX_TURNS=$(python -c "import yaml;print(yaml.safe_load(open('config.yml'))['budget']['max_turns'])")
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

# Increment cycle counter (start of run; a failed run is still a numbered cycle)
python - <<'EOF'
import json, datetime
m = json.load(open('state/meta.json'))
m['cycle'] += 1
if not m.get('started'):
    m['started'] = datetime.date.today().isoformat()
json.dump(m, open('state/meta.json', 'w'), indent=2, ensure_ascii=False)
print(f"cycle {m['cycle']}, task {open('state/queue/next_task.json').read()[:120]}...")
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
claude -p "$PROMPT" \
  --max-turns "$MAX_TURNS" \
  --allowedTools "WebSearch,WebFetch,Read,Write,Edit,Glob,Grep" \
  --permission-mode acceptEdits \
  --output-format text \
  2>&1 | tee "logs/cycle-$(printf '%03d' "$CYCLE")-transcript.txt" | tail -20

# Verification gates (G1/G3 mechanical checks). On failure: revert state, keep logs,
# restore the queue so the next cron retries the same task (at-least-once semantics).
if ! python scripts/validate_state.py; then
  echo "VALIDATION FAILED — reverting state, keeping logs" >&2
  mkdir -p /tmp/spiral_logs && cp -r logs/* /tmp/spiral_logs/ 2>/dev/null || true
  git checkout "$PRE_SHA" -- state/
  # bump attempt_count on the (restored) queue entry
  python - <<'EOF'
import json
q = json.load(open('state/queue/next_task.json'))
q['attempt_count'] = q.get('attempt_count', 0) + 1
json.dump(q, open('state/queue/next_task.json', 'w'), indent=2, ensure_ascii=False)
EOF
  # cycle counter still advances (it did run), meta is re-applied
  python - <<EOF
import json
m = json.load(open('state/meta.json'))
m['cycle'] = ${CYCLE}
json.dump(m, open('state/meta.json','w'), indent=2, ensure_ascii=False)
EOF
  cp -r /tmp/spiral_logs/* logs/ 2>/dev/null || true
  echo "T${TASK_TYPE#T} failed validation (attempt bumped)" > state/queue/last_completed_task.txt
  exit 0   # not a CI failure: the loop self-heals next cron
fi

echo "Cycle ${CYCLE} (${TASK_TYPE}) completed and validated."
