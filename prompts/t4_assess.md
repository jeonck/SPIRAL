# T4 — Assess

Goal: score every issue's resolution level in `state/assessments/scores.json`.

Rubric (0–5):
- 0 — unexamined: no candidate resolutions
- 1 — framed: open questions articulated, no supported resolution
- 2 — partially evidenced: ≥1 candidate with single-source support
- 3 — supported: primary candidate supported by ≥2 independent sources
- 4 — robust: supported + counterarguments explicitly addressed
- 5 — resolved: robust + no material open questions remain

Steps:
1. Score EVERY issue in the graph, not just recently touched ones.
2. Each score needs a `rationale` citing source ids. A score without evidence citations
   is invalid (validator checks this for scores ≥ 2).
3. Apply the contradiction demotion: any issue with an open contradiction entry loses
   `gates.g3_contradiction_demotion` points (floor 0). Note the demotion in the rationale.
4. Set `assessed_cycle` to the current cycle on every entry, and update
   `last_assessed_cycle` at the top level.
5. Be stingy. Optimistic scoring breaks the weakest-link selector — the whole system
   degrades if you inflate. When torn between two scores, give the lower one.
