# SPIRAL Reference Implementation Notes (corresponds to paper §4)

Delivered as: spiral-repo.zip (v3.1 — includes the evaluation pipeline and English
documentation). Push to GitHub, register the `CLAUDE_CODE_OAUTH_TOKEN` secret, and it
is ready to run.

## Confirmed design decisions (to be written into the paper as-is)

0. **Pinned runtime (from cycle 7, 2026-07-28)**: `runtime.model: claude-opus-5` and
   `runtime.cli_version: "2.1.220"`, both stamped into `state/meta.json` every cycle so
   git history carries per-cycle provenance. Until cycle 6 the workflow installed
   `@anthropic-ai/claude-code` unpinned and passed no `--model`, so cycles 1–6 ran on an
   unrecorded, server-default model and **cannot be attributed retroactively** — treat
   that segment as a separate, unlabelled condition when analysing the accumulation
   curve. Pinning matters here specifically because RQ2/RQ3 measure change over weeks:
   a silent model upgrade mid-run would be confounded with the accumulation effect.
1. **LLM execution**: headless Claude Code CLI (`claude -p`) + an OAuth token
   (`claude setup-token`) = uses the personal subscription quota. The batch runs
   03:00–06:00 CDT, i.e. idle-quota hours → the marginal-cost-≈-0 argument matches
   the actual implementation. Cycles are spaced 10 min start-to-start so the quota
   refills between them rather than being drawn down in one burst.
2. **Scheduler/logic separation**: the scheduler provides only the timing. What to do
   is always decided by `state/queue/next_task.json`, committed by the previous cycle
   (trigger chaining). Portable to any scheduler.
   *Measured caveat:* GitHub's `schedule` events fired 77, 100 and 151 min late on the
   first three runs, so the nightly pacing was moved out of cron and into the job
   (`run_night.sh`), which loops to a wall-clock deadline. Cron only starts the night.
   The 151-min delay on 2026-07-28 cost all but 3 of that night's 18 cycles, so cron
   was moved 2h earlier (06:00 UTC) with the job holding until `window_start_utc` —
   delay is absorbed by the hold rather than deducted from the window. That recovered
   14 of 18 cycles on 07-29 against a 149-min delay; the residual 29 min was reclaimed
   by moving the firing to 05:30 UTC (2.5 h lead). Latency has been 77/100/151/149 min,
   i.e. it settled near 150 min rather than staying in the 60-100 range first observed.
   Worth reporting in the paper: on free CI, scheduled-trigger latency is a first-class
   variable the design must absorb, not an implementation detail — and it is large
   enough (≈2.5 h) to dominate a 3 h nightly window if ignored.
8. **The window end bounds finishing, not starting (fixed after cycle 92, 2026-08-06)**:
   the stop check compared the *nominal* next slot (`previous start + interval`) against
   the deadline. Once cycles began outrunning the 10-min interval — they now average
   ~15 min — the real start drifted past the nominal one, so cycles were begun after the
   window closed. Observed overrun grew with cycle length: −3, +2, +8, +22 min on
   08-01..08-04, i.e. research was still running at 06:22 local against an 06:00 promise.
   The check now uses the actual next start and additionally requires the longest cycle
   seen that night to fit before the deadline. Costs at most the final cycle — which is
   also, on three of five nights, the one that died on the exhausted quota anyway.
6. **Rollback covers agent death, not just gate rejection (fixed after cycle 31,
   2026-07-30)**: `run_cycle.sh` ran under `set -e`, so a `claude -p` that exited
   non-zero aborted the script *before* `validate_state.py` — skipping both the gates
   and the revert. Cycle 31 exhausted `budget.max_turns` and its partial edits (issue
   graph, knowledge index, four appended `key_claims`) were committed unvalidated,
   under a label that read "no state change". The content happened to be compliant, so
   nothing was corrupted, but the mechanism would have admitted an unchecked source URL
   or an append-only violation permanently. The agent exit code is now captured and a
   death takes the same rollback path as a gate rejection (exit 3 vs 2), which also
   feeds the per-task escape — so a task too large for the turn budget is abandoned
   after `max_task_attempts` instead of retried indefinitely. A failure that touched no
   research state is still classified as a hard failure, so token/CLI problems keep
   tripping the fast breaker.
5. **Bounded retries (added for the month-long run)**: at-least-once retry alone lets
   one stuck queue entry consume every slot indefinitely, because the T5 attempt
   penalty can only demote an issue on a cycle that actually reaches T5. After
   `schedule.max_task_attempts` the orchestrator abandons the entry and resumes at the
   next stage, logging it to `state/queue/escapes.json`. Two night-level breakers cover
   what that cannot: consecutive hard failures (token/CLI) and consecutive gate
   rejections. Both fail the job so a notification fires.
   *Commit labels are orchestrator-derived, not agent-derived:* `run_night.sh` reads the
   task type from the queue entry it is about to dispatch, so the history stays accurate
   even when a cycle dies before writing `last_completed_task.txt`. The alternative —
   gating on that file — was rejected: adding a gate changes the validation-failure
   rate, which is itself an RQ4 metric, and it would have bought nothing, since
   `## Task performed` in the (already gated) cycle log records the task authoritatively.
   The label is derived data; nothing is lost if it is wrong, so it does not warrant a
   measurement-perturbing gate.
3. **Four state components**: knowledge (K, append-only) / issue graph (I) /
   assessments (A, 0–5 rubric) / queue (q). All committed to git → the commit history
   is an auditable deployment log = the paper's evidence artifact.
4. **State machine**: T1 Collect → T2 Structure → T3 Investigate → T4 Assess → T5
   Select → (back to T3, or T1 every 7th cycle). T5 decides the next target via
   argmin(score) + tie-breaks (upstream issues first, penalty for recent attempts) —
   automated agenda-setting.
5. **Gate implementation**:
   - G1 (source): the validator mechanically checks new source URL liveness (HTTP
     < 400), append-only violations, and dangling evidence references.
   - G2 (retrospection): every cycle's prompt mandates "re-verify one prior
     conclusion at random"; the validator rejects the cycle if the log lacks a
     `## Retrospection` section.
   - G3 (contradiction): an issue with an unresolved contradiction is rejected if its
     score exceeds the demotion ceiling (5 − 2 = 3).
6. **Failure semantics**: on validator failure → revert `state/`, keep only the logs,
   increment attempt_count → the next cron retries the same task (at-least-once). The
   CI job is not marked as failed (the loop is self-healing).
7. **Budget caps**: `--max-turns 75` (raised from 50 on 2026-07-31 after three of that
   night's twelve cycles died on the budget), a 360-minute job timeout covering the
   pre-window hold plus the 3 h window, at most 5 new sources per cycle.

## Evaluation pipeline (added in v2, 2026-07-26)

- `eval/rubric.md` — the RQ1 scoring rubric across 5 dimensions (D1 Coverage / D2
  Depth / D3 Citation quality / D4 Issue discovery / D5 Synthesis), with 0–10 anchors.
  Adapted from the DeepResearch Bench / ResearchRubrics methodology. Judging panel:
  ≥2 LLM judges + a human spot-check (N=10 citation→claim pairs per report).
- `scripts/export_report.py` — converts the research state into a single markdown
  report (deterministic, no LLM). The `--blind` flag strips system-identifying
  metadata (for blind scoring). This report format is the comparison artifact for RQ1.
- `scripts/rubric_score.py` — the LLM-judge runner (headless `claude -p`, `--model` to
  swap judge models, `--dry-run` supported). Output: `eval/scores/<label>.<model>.json`.
- `scripts/measure_accumulation.py` — walks the git history to measure per-cycle
  snapshots: n_sources, n_issues, score_min/mean, open_contradictions, dangling_refs,
  citation_validity_rate (re-checked at measurement time, deliberately capturing both
  link rot and fabrication). Output: `eval/metrics.csv`. **This CSV is the raw data
  for the RQ2 degradation curve.**
- `eval/baselines/README.md` — the baseline protocol: B1–B3 (three commercial
  deep-research tools, single-shot), B4 (4 independent single-shot runs merged by an
  LLM = the strong baseline). Fairness rules: baselines receive only the topic.scope
  text (never the issue graph, since that is SPIRAL's own output); no iterative prompt
  refinement; run within Day 10–18 (contemporaneous tool versions).

Tested: on a simulated 3-cycle git history, generated `metrics.csv`, exported a blind
report, and dry-ran the judge prompt — all confirmed working (2026-07-26).

## Local test results (2026-07-26)

- YAML/bash syntax validation passed.
- Happy path: a simulated T1 cycle → validation OK.
- Violation detection: 5 injected violations (missing retrospection, source deletion,
  phantom evidence, unsupported high score, contradiction-ceiling breach) → all
  detected.
- Note: URL-liveness checking could not be tested in this sandbox due to a proxy
  block → added a `SPIRAL_SKIP_URL_CHECK=1` escape hatch. Expected to work normally on
  GitHub-hosted runners (verify on the first live deployment cycle).

## Setup procedure (action items for CK)

1. Create a GitHub repo, push the zip contents (public repo confirmed for review
   convenience).
2. Locally run `claude setup-token` → register the token as the repo secret
   `CLAUDE_CODE_OAUTH_TOKEN`.
3. Actions tab → research-cycle → Run workflow (one manual test run).
4. Confirm the cycle-001 commit, then leave it — the batch runs automatically every
   night, 03:00–06:00 CDT (up to 18 cycles per night).
5. Skim the logs about once a week (not intervening is actually favorable for the
   paper's argument — intervention count is the RQ4 metric).

## Seed topic

"Reliability assessment of AI-generated Cyber Threat Intelligence (CTI)" — the
reliability of IOC extraction, TTP mapping, and threat-report generation; failure
modes, measurement methods, and mitigation strategies. Out of scope: offensive
techniques, building new CTI tooling.

## Schedule

- A scheduled reminder is registered: **2026-08-09, 09:00 America/Chicago**, to kick
  off baseline execution in this Cowork session (trigger_id:
  `trig_012sFG51DzCcQBCjoXK3k44L`). If the actual deployment start (Day 0) slips, this
  should be rescheduled accordingly.
- **Day 0 = 2026-07-26** — repo pushed to `github.com/jeonck/SPIRAL` (public) and
  cycle-001 (T1 collect) ran the same day. Cycles 1–3 ran one-per-night under the
  original single-firing cron; the nightly batch (up to 18 cycles/night) starts
  2026-07-28.
- **Planned run: ~1 month, to ≈2026-08-26.** Not expected to terminate: reaching the
  T5 stop condition (all issues at 5) needs roughly 8+ nights at the mechanical rate,
  and T3 generates open questions as it closes them, so "all 5" behaves as an
  asymptote. The month is a deployment observation window, not a run-to-completion.
- No DST transition falls inside this window (US DST ends 2026-11-01), so the UTC cron
  holds at 03:00–06:00 local throughout.

## Next milestones (corresponds to outline §8 roadmap)

- [x] Record the deployment start date — Day 0 = 2026-07-26.
- [ ] ~Day 14: run baselines (B1–B4, per `eval/baselines/README.md`).
- [x] Rubric-scoring pipeline (included in v2).
- [x] Per-cycle error-accumulation measurement script (included in v2).

## Note on repository language

As of v3.1, the top-level README and all files under `docs/` are written in English,
since the paper targets international submission and the repository is public. The
original Korean-language notes exchanged during planning are preserved in this
session's conversation history and in the "논문" claude.ai project, but are not
duplicated inside this repository to avoid divergence between two maintained copies.
