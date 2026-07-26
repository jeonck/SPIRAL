# Paper Outline (Draft v0.1)

**Working title (candidates)**

1. *Slow Autonomous Research: Time-Sliced Incremental Research Automation on Commodity Schedulers*
2. *Research While You Sleep, Sustainably: A Cron-Sliced Framework for Self-Accumulating Knowledge Research*
3. *SPIRAL: Scheduled Progressive Incremental Research Automation Loop* (if a system name is needed)

**Target**: a NeurIPS/ICLR/ICML agent-track workshop, or an arXiv (cs.AI, cs.DL)
preprint → expand after feedback. Length 4–8 pages (workshop scale).

**One-line positioning**: existing autonomous research systems are "one big, expensive
shot." We propose a "small, cheap, daily-accumulating" execution model, closed by a
weakest-link selection loop that decides for itself what to research next.

---

## Abstract (draft, ~180 words)

Autonomous research agents such as The AI Scientist and Agent Laboratory execute research as monolithic, compute-intensive runs. This makes sustained, long-horizon inquiry inaccessible to individual researchers and leaves unanswered the question these systems cannot yet address: deciding *what to research next*. We propose a framework that reframes autonomous research as a **time-sliced incremental process**: research is decomposed into small unit tasks executed by cron-triggered runs on commodity CI infrastructure (GitHub Actions) during off-peak hours, with each run persisting its full state to a versioned repository and emitting the trigger input for the next run. The loop is closed by a **weakest-link acquisition policy**: after each assessment cycle, the least-resolved issue is automatically selected as the next research target. Verification gates at every cycle bound error accumulation, which we measure explicitly. Over an N-week deployment on a case-study topic, we compare the accumulated output against one-shot deep-research baselines using established rubrics, and ablate the acquisition policy and verification gates. Results characterize when slow, scheduled accumulation outperforms single-pass depth — and at what error-accumulation cost.

## 1. Introduction

- Problem statement: the cost/accessibility asymmetry in autonomous research systems.
  Frontier labs get end-to-end automation ([Nature 2026](https://www.nature.com/articles/s41586-026-10265-5)); individual researchers get single-shot deep-research tools.
- Timeliness hook: the public resonance of Karpathy's autoresearch (March 2026) — "a
  research loop that runs overnight" — but limited to ML experiments with a numeric
  metric. Not applicable to open-ended knowledge research.
- Three core observations:
  1. An individual's AI usage/quota sits idle in the pre-dawn hours (the idle-quota
     observation).
  2. Knowledge research is inherently decomposable (a stage structure of
     collect → structure issues → investigate → assess → select).
  3. The bottleneck identified by the RSI survey ([arXiv:2607.07663](https://arxiv.org/html/2607.07663)) is research direction-setting → partially automatable via weakest-link selection.
- Contributions (4):
  C1. Formalization of the time-sliced research execution model (state machine +
      trigger-chaining semantics).
  C2. The weakest-link selection policy — formalizing automated agenda-setting as an
      active-learning acquisition function.
  C3. A GitHub-Actions-based reference implementation + an N-week deployment log
      (reproducible; total cost $X disclosed).
  C4. An evaluation protocol that explicitly measures error accumulation (a
      contribution in its own right).

## 2. Related Work

Directly reuses the four clusters from related-work-map.md:
2.1 End-to-end autonomous research (AI Scientist-v2, Agent Laboratory, autoresearch) — differences in execution model
2.2 Automated survey / deep research (STORM, AutoSurvey, benchmarks) — single-shot vs. accumulated
2.3 Self-evolving agents & RSI — the direction-setting bottleneck
2.4 Error dynamics in iterative loops — the objection we confront head-on

## 3. Framework: Time-Sliced Incremental Research

### 3.1 Research state (domain-neutral definition)

R_t = (K_t, I_t, A_t, q_t)
- **K_t**: knowledge base — collected evidence documents/sources (original links
  required, append-only)
- **I_t**: issue graph — issue nodes + dependency relations (each issue carries open
  questions and candidate resolutions)
- **A_t**: assessment vector — per-issue resolution-level scores (rubric-based,
  evidence citation required)
- **q_t**: next-task queue — the unit-task specification for the next run (this is
  the "pre-written next trigger")

The entire state is persisted in a git repository → every cycle survives as a commit,
making the process auditable. This auditability is the basis of our reproducibility
claim.

### 3.2 Unit task types (six types generalized from the CTI example)

T1 Collect (gather foundational theory/evidence) → T2 Structure (delineate issues,
update the issue graph) → T3 Investigate (examine issues and candidate resolutions) →
T4 Assess (rubric-score each issue's resolution level) → T5 Select (weakest-link
selection → generate q_{t+1}) → T6 Verify (verification gates: source liveness,
re-checking prior conclusions, contradiction detection)

Each run performs only {one unit task + T6} — capping tokens/time per run is the core
constraint of time-slicing.

### 3.3 Trigger-chaining semantics

run_k: (R_k, q_k) → (R_{k+1}, q_{k+1}). The current run commits the input for the next
run. The cron provides only the timing; *what* to do is always decided by the prior
state → a complete separation between the scheduler and the research logic (this
separation is what makes the system portable to any scheduler).

### 3.4 Weakest-link acquisition policy

select(A_t) = argmin_i score(A_t[i]) (+ tie-breaking: upstream issues in the
dependency graph first, a penalty on recent-attempt count to prevent infinite loops).
We describe the correspondence to active-learning acquisition functions (adopting the
frame from [arXiv:2502.11767](https://arxiv.org/html/2502.11767v1)). Ablation targets:
random / round-robin / weakest-link, three conditions compared.

### 3.5 Verification gates (bounding error accumulation)

- G1 source gate: every new claim requires an external source; URL liveness and
  content match are checked.
- G2 retrospection gate: one prior conclusion is re-verified at random every cycle
  (guards against self-consuming loops, grounded in
  [arXiv:2311.16822](https://arxiv.org/abs/2311.16822)).
- G3 contradiction gate: when the issue graph detects conflicting claims, the
  affected issue's score is automatically demoted → a self-correcting structure in
  which it resurfaces as a weak link.

## 4. Reference Implementation

- GitHub Actions cron (off-peak hours, e.g., `0 18 * * *` UTC = 03:00 KST); repo
  layout: `/knowledge`, `/issues`, `/assessments`, `/queue`, `/logs`.
- LLM invocation: uses the user's idle subscription-quota window (for a subscription
  plan, this grounds the marginal-cost-≈-0 argument).
- Per-run budget cap (tokens/minutes). We report measured GitHub Actions cron drift
  (a delay of minutes to hours) and note that this is harmless by design, since the
  design only requires "at least once per day," not exact timing.
- Failure recovery: on a failed run, q_t is left unchanged → the next cron retries the
  same task (at-least-once semantics).

## 5. Evaluation Design

### RQ1 — Accumulation vs. single-shot: does the N-week accumulated output beat one-shot deep research?

- Baselines: the same topic run once each on ~3 commercial deep-research tools, plus
  "N independent single-shot runs merged" (a strong baseline — omitting it will surely
  draw a reviewer objection)
- Scoring: rubrics in the style of [DeepResearch Bench](https://deepresearch-bench.github.io/) / [ResearchRubrics](https://openreview.net/forum?id=ErnvfmSX0P) (coverage, depth, citation quality, issue-discovery count) + blinded human evaluation (3 raters)

### RQ2 — Error accumulation: does quality degrade as cycles accumulate?

- Per-cycle measurements: citation validity rate, factuality of randomly sampled
  claims, contradiction rate (the degradation curve itself is a result)
- Ablation: confirm accelerated degradation with gates removed (no-G1/G2/G3) →
  demonstrates the gates' contribution

### RQ3 — Agenda-setting: is weakest-link selection actually better?

- weakest-link vs. random vs. round-robin, comparing final total score and minimum
  score (min score) at equal budget. Hypothesis: weakest-link maximizes the min score
  (a max-min improvement).

### RQ4 — Cost: total dollar cost, number of human interventions (target: 0), run
success rate.

### Statistical treatment
≥3 topics × repeated per condition — for workshop-scale length, 1–2 topics plus an
honest statement of limitations is also acceptable.

## 6. Case Study

Detailed narrative of one topic as an instance of the domain-neutral framework (CTI is
mentioned only as one candidate among several, per the domain-neutral design decision).
Includes the visual growth of the issue graph, the weakest-link selection history, and
excerpts from the actual commit log.

## 7. Limitations & Ethics

- State plainly that this is automation of investigation, organization, and
  evaluation — not genuine novelty generation ("early-stage research automation" — no
  overclaiming; this honesty should actually help at workshop review).
- The circularity problem of LLM evaluators (rubric scoring) — corrected via human
  evaluation.
- Compliance with copyright/robots rules and API ToS in automated collection.
- Potential for misuse: criteria for distinguishing this from mass low-quality content
  generation.

## 8. Roadmap (execution plan)

1. **Weeks 1–2**: implement the framework (repo skeleton + prompts + gates) — exactly
   the GitHub structure already envisioned.
2. **Weeks 3–6**: N=28-day deployment on 1–2 topics (this log is the heart of the
   paper).
3. **Concurrent with weeks 5–6**: run baselines + the rubric-scoring pipeline.
4. **Weeks 7–8**: writing. Work backward from the workshop deadline (agent-track
   workshops open continuously — recommend re-searching for calls ~3 months before the
   target deadline).

## Anticipated reviewer objections and defenses (prepared in advance)

| Anticipated objection | Defense |
|---|---|
| "How is this different from just running deep research multiple times?" | Direct comparison against RQ1's strong baseline (single-shot × N merged) + argue that state persistence and agenda-setting cannot be reproduced by merging |
| "Errors will compound over iterations" | Elevate RQ2 to a contribution — present the degradation curve and gate effects quantitatively |
| "How is this different from Karpathy's autoresearch?" | Open-ended knowledge research without a numeric metric + cron slicing + agenda-setting. Directly contrasted in §2.1 |
| "The novelty is engineering-level" | Cite the RSI survey's direction-setting bottleneck → argue weakest-link selection is a verifiable partial solution to that bottleneck |
| "One case study can't generalize" | Domain-neutral formalization (§3) + explicit limitations. Honest about workshop-paper scope |
