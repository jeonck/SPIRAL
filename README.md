# SPIRAL — Scheduled Progressive Incremental Research Automation Loop

A reference implementation of a cron-driven, time-sliced autonomous research loop.
Every day at dawn (default 03:00 KST), a GitHub Actions cron job executes **one
research unit task**, commits the full research state to git, and **leaves the next
task in the queue for the next run to pick up.**

Paper correspondence: this repository's commit history *is* the deployment log (§4)
and the auditable evidence artifact.

## How one cycle works

```
cron(03:00 KST)
  → run_cycle.sh
      1. Read state/queue/next_task.json        # the "next task" left by the previous cycle
      2. claude -p (headless, OAuth token)       # task prompt + state file paths passed in
         the agent edits state/ files directly
         and writes the next task to the queue
      3. validate_state.py                       # verification gates (G1/G3, mechanical)
         on failure → revert git state (log-only commit) → next cron retries the same task
      4. git commit + push                       # cycle complete
```

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
5. From then on, the cron runs automatically every day. Disable the workflow to stop it.

## Cost / budget constraints (paper RQ4)

- Per-run cap: `--max-turns` (config: `budget.max_turns`), Actions job timeout 30 min.
- OAuth token = uses the personal subscription quota → off-peak hours mean marginal
  cost ≈ 0 (the paper's idle-quota argument).
- Per-cycle usage is recorded in `logs/cycle-NNN.md` per the prompt instructions.

## Repository layout

```
.github/workflows/research-cycle.yml   # cron + manual trigger
prompts/system.md                      # shared rules (gates, file conventions, budget)
prompts/t1_collect.md … t5_select.md   # per-task-type prompts
scripts/run_cycle.sh                   # orchestrator
scripts/validate_state.py              # verification gates (G1/G3)
config.yml                             # schedule / budget / gate settings
docs/                                  # paper-facing documents (related work, outline, implementation notes)
eval/                                  # evaluation pipeline (rubric, baselines, accumulation metrics)
```
