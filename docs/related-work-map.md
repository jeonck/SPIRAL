# Related Work Map — Time-Sliced Incremental Research Automation

> Purpose: a survey of prior work to verify the novelty claim of a paper on "a system
> that autonomously accumulates research on personal infrastructure via a cron-driven,
> time-sliced execution model closed by a weakest-link selection loop."
> Summary: all four clusters below are active areas, but no prior work combines
> **(a) time-sliced asynchronous execution, (b) low-cost commodity-scheduler
> infrastructure (GitHub Actions), and (c) weakest-link-driven automated agenda
> setting** into a single framework. Point (c) in particular is explicitly identified
> by a 2026 RSI survey as the field's "most consequential open question."

---

## Cluster 1 — End-to-end autonomous research systems (synchronous, high-cost)

| Work | What it does | Why it differs from ours |
|---|---|---|
| **The AI Scientist-v2** (Sakana AI, [arXiv:2504.08066](https://arxiv.org/abs/2504.08066)) | Generates end-to-end from idea → experiment → paper via agentic tree search; has had workshop papers accepted | A single large synchronous run. No notion of scheduling, multi-day accumulation, or personal resource constraints |
| **Agent Laboratory** ([arXiv:2501.04227](https://arxiv.org/pdf/2501.04227)) | Multi-agent pipeline for literature review → experiments → report, with human-in-the-loop support | Executes per-session. Does not address state persistence or resumption across runs |
| **Towards end-to-end automation of AI research** ([Nature 2026](https://www.nature.com/articles/s41586-026-10265-5)) | Empirical demonstration of end-to-end AI research automation (frontier-lab scale) | Assumes frontier-scale compute. "Accessibility for individual researchers" is out of scope |
| **Karpathy's autoresearch** ([GitHub](https://github.com/karpathy/autoresearch), March 2026) | Autonomously iterates single-GPU nanochat training experiments overnight (~630 LoC, 50+ experiments in one night) | **The closest popular precedent.** However: (i) built exclusively for ML experiments with a numeric metric, (ii) a continuous shell run, not cron-sliced, (iii) not applicable to open-ended knowledge research (literature, issues, argumentation). The community generalization attempt, [autoresearch-skill](https://github.com/wjgoarxiv/autoresearch-skill), is likewise restricted to "a numeric target + an evaluation script" and has no research-gap-selection capability |

**Implication**: the claim "AI performs research" is by itself saturated. Our
contribution must be clearly located in the *execution model* (time-sliced,
asynchronous, low-cost) and the *agenda-setting loop*. Karpathy's autoresearch should
be cited and directly contrasted in the introduction (both for timeliness and to
sharpen the differentiation).

## Cluster 2 — Automated literature survey / deep research (knowledge-research automation)

| Work | What it does | Why it differs |
|---|---|---|
| **STORM** (Shao et al., NAACL 2024, [arXiv:2402.14207](https://arxiv.org/abs/2402.14207)) | Multi-perspective question generation → retrieval → outline → Wikipedia-style synthesis | A single-shot run. No repeated cycles or state accumulation |
| **AutoSurvey** (NeurIPS 2024, [OpenReview](https://openreview.net/forum?id=FExX8pMrdT)) / **AutoSurvey2** ([arXiv:2510.26012](https://arxiv.org/html/2510.26012)) | Automated LLM survey writing; v2 adds an iterative refinement workflow | Iteration exists but within a single session. No time-axis slicing or scheduling |
| **Deep Literature Survey Automation with an Iterative Workflow** ([arXiv:2510.21900](https://arxiv.org/html/2510.21900)) | Iterative-workflow-based literature survey | Same limitation as above |
| **DeepResearch Bench** ([site](https://deepresearch-bench.github.io/), [GitHub](https://github.com/Ayanami0730/deep_research_bench)), **ResearchRubrics** ([OpenReview](https://openreview.net/forum?id=ErnvfmSX0P)), **ReportBench** ([arXiv:2508.15804](https://arxiv.org/html/2508.15804)) | Evaluation benchmarks/rubrics for deep-research agents | **Used as a tool in our own evaluation design** — we adopt their rubric scoring and use one-shot deep research as our baseline |

**Implication**: our evaluation section can directly adopt these benchmarks' rubric
methodology to compare "one-shot deep research vs. N-day accumulated execution." A
major advantage: we can use an evaluation frame reviewers already recognize.

## Cluster 3 — Self-evolving agents & recursive self-improvement (theoretical backdrop for self-accumulation)

| Work | What it does | Why it differs |
|---|---|---|
| **A Survey of Self-Evolving Agents** ([arXiv:2507.21046](https://arxiv.org/abs/2507.21046)) | Classifies self-evolving agents along what/when/how/where axes | Provides a taxonomy. No perspective on execution infrastructure or scheduling |
| **EvolveR** ([arXiv:2510.16079](https://arxiv.org/abs/2510.16079)) | Agent self-evolution via an experience-driven lifecycle | Experience accumulation serves policy improvement, not accumulation of research output |
| **Rethinking Continual Experience Internalization** ([arXiv:2606.04703](https://arxiv.org/html/2606.04703v1)) | Reconsiders experience internalization for self-evolving agents | Same as above |
| **Recursive Self-Improvement in AI: From Bounded Self-Refinement to Autonomous Research Loops** ([arXiv:2607.07663](https://arxiv.org/html/2607.07663), July 2026 survey analyzing 1,250 papers) | Organizes the RSI literature along two axes: what is being improved × degree of loop closure | **Our key supporting citation.** This survey explicitly states: (i) no literature covers cron/batch-style time-sliced execution, (ii) low-cost personal-infrastructure implementation patterns are not covered, and (iii) **"research direction-setting" — deciding which problems to solve — remains the bottleneck where humans are still required, and is "the field's most consequential open question."** Our weakest-link selection loop targets exactly this point |
| **Agent Memory: Stateful Long-Horizon Workloads** ([arXiv:2606.06448](https://arxiv.org/html/2606.06448v1)) | Systems-level characterization of stateful long-horizon agent workloads | A systems-characterization study. No concrete design such as git-persisted research state |

**Implication**: this is the anchor of our novelty claim. In the introduction, cite the
"direction-setting bottleneck" from [arXiv:2607.07663] and connect it to: "we propose a
low-cost, verifiable partial solution to this bottleneck (weakest-link selection)."

## Cluster 4 — Error accumulation in iterative loops (the objection we must confront head-on)

| Work | Finding | How we use it |
|---|---|---|
| **Security Degradation in Iterative AI Code Generation** (IEEE-ISTAS 2025, [arXiv:2506.11022](https://arxiv.org/html/2506.11022)) | Empirically demonstrates quality (security) degradation across iterative generation | Cited as empirical evidence of iterative-loop risk |
| **Self-Correction as Feedback Control** ([arXiv:2604.22273](https://arxiv.org/html/2604.22273v2)) | Analyzes the error dynamics and stability thresholds of self-correction | Theoretical frame for our verification-gate design |
| **Self-Consuming Training Loop** ([arXiv:2311.16822](https://arxiv.org/abs/2311.16822)) | Degradation from loops that re-consume their own output | Grounds our design of cross-cycle source isolation (prioritizing external evidence) |
| **Uncertainty as a Control Signal** ([arXiv:2509.02401](https://arxiv.org/html/2509.02401v1)), **A Survey of LLM-based Active Learning** ([arXiv:2502.11767](https://arxiv.org/html/2502.11767v1)) | Uses uncertainty as a control signal to select the next sample/action | Grounds formalizing weakest-link selection as an active-learning acquisition function |

**Implication**: "a self-accumulating loop compounds its errors" is the anticipated
objection #1. Elevating per-cycle verification gates and explicit error-accumulation
measurement to **a contribution in their own right** turns this defense into an
offense.

---

## Gap Statement (draft novelty claim)

> Existing autonomous research systems execute as monolithic, synchronous, compute-intensive runs. No prior work, to our knowledge, (1) decomposes open-ended knowledge research into schedulable unit tasks chained across cron-triggered runs on commodity CI infrastructure, (2) persists the full research state as a versioned artifact enabling auditable multi-week accumulation, or (3) closes the loop with a weakest-link acquisition policy that automatically sets the next research agenda — the very bottleneck the 2026 RSI survey identifies as the field's most consequential open question. We contribute such a framework, a reference implementation on GitHub Actions, and an evaluation protocol that measures both output quality against one-shot deep research and error accumulation across cycles.

## Remaining verification items (required before submission)

- Re-scan for new literature from late 2026 (this area moves on a monthly cadence —
  especially keywords "scheduled agent," "incremental research").
- Check whether any academic papers have followed up on Karpathy's autoresearch (only
  blog/repo-level coverage confirmed so far).
- If CTI is retained as the case study, a separate scan of CTI × LLM automation
  literature is still needed (not yet done — deferred per the domain-neutral design
  decision).
