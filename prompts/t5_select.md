# T5 — Select (weakest link)

Goal: choose the next research target and write the next task. This is the automated
agenda-setting step — the core of the system.

Selection policy (apply mechanically, show your work in the log):
1. Candidate set = all issues with score < 5.
2. Base priority = score (lower = higher priority).
3. Tie-breaks, in order:
   a. Upstream first: an issue that others `depend_on` outranks its dependents.
   b. Attempt penalty: +`scoring.tie_break_recent_attempt_penalty` to the effective
      score per attempt within the last 5 cycles (prevents thrashing on a stuck issue).
   c. Remaining ties: older `created_cycle` first.
4. Refresh rule: if `current_cycle % schedule.collect_refresh_every == 0`, the next task
   is `T1` targeting the selected issue (bring in fresh evidence) instead of `T3`.

Then:
- Write `state/queue/next_task.json` for T3 (or T1 per refresh rule) with the selected
  issue as `target_issue` and instructions that quote the issue's current open_questions.
- In the cycle log, record the full ranking table (issue id, score, penalties, final
  rank) so the selection is auditable — this table is evaluation data for the paper.
- If ALL issues score 5: write a `T2` task instructing a scope review (either the topic
  is done — say so in the log — or the issue graph is too coarse and needs splitting).
