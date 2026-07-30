# SPIRAL — Scheduled Progressive Incremental Research Automation Loop

A reference implementation of a cron-driven, time-sliced autonomous research loop.
Each night (default 03:00–06:00 CDT), a GitHub Actions job executes **one research
unit task at a time**, commits the full research state to git after each one, and
**leaves the next task in the queue for the following cycle to pick up.** A cycle
takes ~4–5 min, so the nightly window fits up to 18 of them.

Paper correspondence: this repository's commit history *is* the deployment log (§4)
and the auditable evidence artifact.

## How one cycle works

```
cron(05:30 UTC, early on purpose)
  → run_night.sh                                 # holds until 08:00 UTC (03:00 CDT),
                                                 # then loops until 11:00 UTC (06:00 CDT)
    └─ per slot, spaced 10 min start-to-start:
       → run_cycle.sh
          1. Read state/queue/next_task.json     # the "next task" left by the previous cycle
          2. claude -p (headless, OAuth token)   # task prompt + state file paths passed in
             the agent edits state/ files directly
             and writes the next task to the queue
          3. validate_state.py                   # verification gates (G1/G3, mechanical)
             on failure → revert state (log-only commit) → next slot retries the same task
       → git commit + push                       # cycle durable before the next one starts
```

The pacing lives in the job, not in cron: GitHub's scheduled events fired 77, 100, 151
and 149 min late on the runs here, so a fan-out of cron slots would drift out of the
window. One firing starts the night; `run_night.sh` owns the spacing and the hard stop.

Cron therefore fires 2.5 h *before* the window opens and the job waits out the gap.
Delay is absorbed instead of being deducted from the night, while an on-time firing
still begins at the intended local hour. The lead time is sized from the observed
delays, which have settled near 150 min:

| cron | 2026-07-28 (151 min late) | 2026-07-29 (149 min late) |
|---|---|---|
| 08:00 (none) | 3 of 18 cycles | — |
| 06:00 (2 h lead) | — | 14 of 18 cycles |
| 05:30 (2.5 h lead) | \>18 expected | 18 expected |

The window end stays a hard stop, so a delay beyond the lead time still shortens the
night rather than running past 06:00 local.

## Research state R_t = (K, I, A, q)

| Path | Role | Paper notation |
|---|---|---|
| `state/knowledge/` | Collected evidence (one file per source, append-only) | K_t |
| `state/issues/graph.json` | Issue graph (issues, dependencies, open questions, candidate resolutions) | I_t |
| `state/assessments/scores.json` | Per-issue resolution-level scores (0–5, evidence citation required) | A_t |
| `state/queue/next_task.json` | Unit-task specification for the next run | q_t |
| `state/meta.json` | Cycle counter, topic definition | — |
| `logs/cycle-NNN.md` | Per-cycle execution summary | Deployment log |

## Unit-task state machine

```
T1 Collect ──→ T2 Structure ──→ T3 Investigate ──→ T4 Assess ──→ T5 Select ──┐
    ↑                                ↑                                        │
    │                                └── (to the weakest-link issue) ←────────┘
    └── once every 7 cycles, fresh collection targeting the weakest issue (T5 decides)
```

- **T5 Select (weakest-link selection)**: `argmin(score)` + tie-breaks (upstream issues
  in the dependency graph first, penalty for recent attempts). Decides the target issue
  for the next T3 — the core of automated agenda-setting.
- **G2 retrospection gate**: every task prompt includes an instruction to "re-verify one
  prior conclusion at random."
- **G1 source gate / G3 contradiction gate**: mechanically checked by `validate_state.py`
  (URL liveness, schema, append-only violations, score demotion when a contradiction
  flag is open).

## Setup

1. Push this repository to GitHub (public or private).
2. Locally run `claude setup-token` → register the issued token as the repo secret
   `CLAUDE_CODE_OAUTH_TOKEN` (Settings → Secrets → Actions).
3. Check/edit the `topic` in `state/meta.json` (currently seeded with a CTI topic).
4. From the Actions tab, manually run the `research-cycle` workflow
   (`workflow_dispatch`) once to test a single cycle.
5. From then on, the nightly batch runs automatically. Disable the workflow to stop it.

## Cost / budget constraints (paper RQ4)

- Pinned runtime: `runtime.model` and `runtime.cli_version`. Both are stamped into
  `state/meta.json` every cycle, so git history records which model produced which
  conclusion. An unpinned model is an uncontrolled variable in a study that measures
  accumulation over weeks — a mid-run upgrade would be indistinguishable from an
  accumulation effect. Cycles 1–6 predate the pin and are unattributable.
- Per-cycle cap: `--max-turns` (config: `budget.max_turns`); Actions job timeout 330 min.
- Nightly window: `schedule.cycle_interval_min` (start-to-start spacing, so the
  subscription quota refills between cycles) and `schedule.window_end_utc` (hard stop).

## Circuit breakers (unattended-run safety)

A month-long deployment has to fail loudly rather than spin. Three limits, all in
`config.yml` under `schedule`:

| Setting | Trips on | Effect |
|---|---|---|
| `max_task_attempts` | one queue entry failing the gates N times | abandon it, resume the pipeline at the next stage (T1/T2/T3→T4, T4→T5, T5→T4) |
| `abort_after_consecutive_failures` | cycles dying outright (expired `CLAUDE_CODE_OAUTH_TOKEN`, missing CLI) | fail the job → GitHub notification |
| `abort_after_consecutive_invalid` | cycles running but failing the gates, despite escapes | fail the job → GitHub notification |

`run_cycle.sh` signals these apart by exit code: `0` validated, `2` ran but was
rejected by the gates, anything else a hard failure. Without the first limit a single
stuck task would consume every slot of every night indefinitely; without the other two
a broken token or a broken gate would report success on an empty night.

Escapes are recorded in `state/queue/escapes.json` (cycle, abandoned task, target
issue, attempts, escaped-to). They are intervention-free recoveries, so the file is
RQ4 evaluation data — check it before reading a quiet month as a healthy one.
- OAuth token = uses the personal subscription quota → off-peak hours mean marginal
  cost ≈ 0 (the paper's idle-quota argument).
- Per-cycle usage is recorded in `logs/cycle-NNN.md` per the prompt instructions.

## Repository layout

```
.github/workflows/research-cycle.yml   # cron + manual trigger
prompts/system.md                      # shared rules (gates, file conventions, budget)
prompts/t1_collect.md … t5_select.md   # per-task-type prompts
scripts/run_night.sh                   # nightly batch: paces cycles within the window
scripts/run_cycle.sh                   # orchestrator for exactly one cycle
scripts/validate_state.py              # verification gates (G1/G3)
config.yml                             # schedule / budget / gate settings
docs/                                  # paper-facing documents (related work, outline, implementation notes)
eval/                                  # evaluation pipeline (rubric, baselines, accumulation metrics)
```
