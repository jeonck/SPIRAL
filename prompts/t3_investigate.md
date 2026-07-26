# T3 — Investigate

Goal: deepen ONE issue — the `target_issue` in the queue.

Steps:
1. Read the target issue's open_questions and existing candidate_resolutions.
2. Work through the open questions using the existing knowledge base FIRST. Only
   web-search for what the knowledge base cannot answer (and if you fetch something
   substantial, add it properly as a source per T1 rules — it counts toward the same
   max_new_sources budget).
3. Update the issue's `candidate_resolutions`: promote to `supported` only with cited
   evidence from ≥1 source (≥2 independent sources for strong claims); mark `rejected`
   with the reason; add new candidates found.
4. Rewrite the issue's `open_questions` to reflect what genuinely remains open.
5. Append this cycle number to the issue's `attempts` array.
6. If the investigation surfaced claims conflicting with another issue's supported
   resolutions, open a contradiction entry (G3).
