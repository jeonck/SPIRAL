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
  contemporaneous with SPIRAL's cycles.
