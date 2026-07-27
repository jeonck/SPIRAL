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
cron(08:00 UTC = 03:00 CDT)
  → run_night.sh                                 # loops until 11:00 UTC (06:00 CDT)
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

The pacing lives in the job, not in cron: GitHub's scheduled events routinely fire
60–100 min late, so a fan-out of cron slots would drift out of the window. One
firing starts the night; `run_night.sh` owns the spacing and the hard stop. A late
firing shortens the night instead of running past it.

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

- Per-cycle cap: `--max-turns` (config: `budget.max_turns`); Actions job timeout 240 min.
- Nightly window: `schedule.cycle_interval_min` (start-to-start spacing, so the
  subscription quota refills between cycles) and `schedule.window_end_utc` (hard stop).
- Failsafe: `schedule.abort_after_consecutive_failures` fails the job when that many
  cycles die outright (expired `CLAUDE_CODE_OAUTH_TOKEN`, missing CLI), so a broken
  setup raises a notification instead of silently reporting a successful empty night.
  Validation failures do not trip it — those are the designed self-healing retry path.
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
