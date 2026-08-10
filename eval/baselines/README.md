# Baseline protocol (RQ1) — run at ~Day 14 of the deployment

Same topic string for every run, verbatim from `state/meta.json` → `topic.scope`.

## Baselines

| id | what | how |
|---|---|---|
| B1–B3 | one-shot deep research, 3 commercial tools | run once each, export markdown, save as `eval/baselines/b1.md` … `b3.md` |
| B4 | merged single-shots (strong baseline) | run ONE tool N=4 times independently on the same prompt, then merge with a single LLM pass ("merge these reports, dedupe, keep all citations") → `b4.md` |

Record for each: date, tool + version/model, wall-clock time, cost (if metered).

## Blinding & scoring

1. Strip tool-identifying headers/footers from each report.
2. Export SPIRAL's report: `python scripts/export_report.py --blind -o eval/report_blind.md`
3. Score all reports with ≥2 judge models:
   `python scripts/rubric_score.py eval/baselines/b1.md --label b1 --model <m>`
4. Human spot-check: D3 citation→claim pairs, N=10 per report (see rubric.md).

## Fairness rules

- Baselines get the SAME topic scope text — not the issue graph (that's SPIRAL's output).
- Do not iterate on baseline prompts. First output counts.
- Run baselines within the deployment window (Day 10–18) so model/tool versions are
  contemporaneous with SPIRAL's cycles. The deployment ran 2026-07-26 to 08-09, so this
  window closed 2026-08-13; a later run must disclose the gap.
- **No baseline may be produced by an agent that has seen this repository's state.**
  Exposure to the issue graph, contradiction list or source index makes the resulting
  "one-shot" report a laundered copy of SPIRAL's accumulated output — it would inflate
  the baseline with exactly what the comparison is supposed to measure, inverting the
  result. This applies to a human operator working from the repo as much as to a model.
  A model-generated baseline is acceptable only in a context holding nothing but the
  scope string above, and is then its own labelled condition (B5+), never one of B1–B3.
