# Evaluation rubric (RQ1) — research report quality

Adapted from the rubric-based evaluation style of DeepResearch Bench / ResearchRubrics.
Applied identically to SPIRAL's exported report and every baseline report, blind
(reports are stripped of any system-identifying headers before judging).

Score each dimension 0–10 with the anchors below. Judges must cite specific passages
for any score ≥ 7 and for any score ≤ 3.

## D1 — Coverage (breadth)
How completely does the report map the topic's genuinely distinct sub-issues?
- 0–2: misses most major sub-issues a domain expert would list
- 5: covers the obvious sub-issues; misses non-obvious ones
- 8–10: includes sub-issues that require synthesis across sources to even notice

## D2 — Depth of evidence
Are claims supported by specific, primary evidence rather than generic statements?
- 0–2: assertions without evidence, or evidence is secondary commentary
- 5: key claims cite at least one primary source each
- 8–10: competing evidence weighed; strength of each source assessed explicitly

## D3 — Citation quality
- 0–2: citations missing, broken, or do not support the claims they're attached to
- 5: citations resolve and are topically relevant; occasional over-claiming
- 8–10: every checked citation supports its exact claim; primary sources dominate
(Spot-check protocol: verify N=10 randomly sampled citation→claim pairs per report.)

## D4 — Issue discovery
Count and quality of decision-relevant open problems the report surfaces.
- 0–2: no explicit open problems, or only generic ones ("more research needed")
- 5: several concrete open questions with context
- 8–10: open questions are prioritized, with dependencies between them made explicit

## D5 — Synthesis & contradiction handling
- 0–2: sources summarized in isolation; conflicts unnoticed or papered over
- 5: some cross-source comparison; conflicts noted but not adjudicated
- 8–10: conflicts surfaced, adjudicated with reasoning, residual disagreement stated

## Protocol notes
- ≥2 independent LLM judges (different model families) + 1 human spot-check pass.
- Judges see: rubric + blinded report. They do not see which system produced it.
- Report per-dimension scores and rationale; aggregate = unweighted mean.
- For RQ2 (error accumulation), D3's spot-check is additionally run per-cycle on
  SPIRAL's own state via scripts/measure_accumulation.py, not on the final report.
