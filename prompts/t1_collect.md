# T1 — Collect

Goal: add foundational or gap-filling evidence to `state/knowledge/`.

Steps:
1. Read the topic (`state/meta.json`) and the queue instructions. If `target_issue` is
   set, collect specifically for that issue's open questions; otherwise collect for the
   topic broadly.
2. Web-search and fetch. Prefer primary sources: peer-reviewed papers, arXiv preprints,
   official benchmarks, vendor technical reports with data. Avoid SEO blog spam.
3. For each accepted source (max `budget.max_new_sources` from config.yml):
   - Assign the next `src-NNNN` id (check index.json for the highest existing).
   - Create `state/knowledge/src-NNNN.md` with frontmatter (url, title, type, accessed
     date from the environment, added_cycle) and a body containing: a faithful summary,
     1–3 key claims (verbatim-supported by the source), relevant quotes with locations,
     and explicit limitations of the source.
   - Add the entry to `state/knowledge/index.json`.
4. Do NOT restructure issues or change scores — that is T2/T4 work.

Quality bar: a future cycle must be able to use your key_claims without re-reading the
source. If a source turned out to be weak after fetching, drop it and say so in the log
rather than padding the knowledge base.
