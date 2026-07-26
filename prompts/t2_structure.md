# T2 — Structure

Goal: update the issue graph (`state/issues/graph.json`) from the current knowledge base.

Steps:
1. Read ALL key_claims in `state/knowledge/index.json` and skim the `src-*.md` bodies
   added since the last T2 (check `added_cycle`).
2. Derive or refine issues: distinct, decision-relevant points of contention or open
   problems within the topic scope. Good issues are (a) answerable in principle,
   (b) supported by at least one source's claims, (c) non-overlapping.
3. For each issue: set `depends_on` edges where resolving one issue logically requires
   another; list `open_questions`; carry over or add `candidate_resolutions` with
   evidence source ids.
4. Keep the graph small and sharp — merge near-duplicates, but record the merge in the
   cycle log. 5–12 issues is the healthy range for one topic.
5. Do NOT score issues — that is T4 work.
