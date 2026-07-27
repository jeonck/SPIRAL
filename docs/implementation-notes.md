# SPIRAL Reference Implementation Notes (corresponds to paper §4)

Delivered as: spiral-repo.zip (v3.1 — includes the evaluation pipeline and English
documentation). Push to GitHub, register the `CLAUDE_CODE_OAUTH_TOKEN` secret, and it
is ready to run.

## Confirmed design decisions (to be written into the paper as-is)

1. **LLM execution**: headless Claude Code CLI (`claude -p`) + an OAuth token
   (`claude setup-token`) = uses the personal subscription quota. The batch runs
   03:00–06:00 CDT, i.e. idle-quota hours → the marginal-cost-≈-0 argument matches
   the actual implementation. Cycles are spaced 10 min start-to-start so the quota
   refills between them rather than being drawn down in one burst.
2. **Scheduler/logic separation**: the scheduler provides only the timing. What to do
   is always decided by `state/queue/next_task.json`, committed by the previous cycle
   (trigger chaining). Portable to any scheduler.
   *Measured caveat:* GitHub's `schedule` events fired 77 and 100 min late in the
   first two runs, so the nightly pacing was moved out of cron and into the job
   (`run_night.sh`), which loops to a wall-clock deadline. Cron only starts the night.
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
7. **Budget caps**: `--max-turns 50`, a 30-minute job timeout, at most 5 new sources
   per cycle.

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
- Day 0 = the date of the repo push + first cycle run (not yet recorded).

## Next milestones (corresponds to outline §8 roadmap)

- [ ] Record the deployment start date (28 days = N in the paper).
- [ ] ~Day 14: run baselines (B1–B4, per `eval/baselines/README.md`).
- [x] Rubric-scoring pipeline (included in v2).
- [x] Per-cycle error-accumulation measurement script (included in v2).

## Note on repository language

As of v3.1, the top-level README and all files under `docs/` are written in English,
since the paper targets international submission and the repository is public. The
original Korean-language notes exchanged during planning are preserved in this
session's conversation history and in the "논문" claude.ai project, but are not
duplicated inside this repository to avoid divergence between two maintained copies.
