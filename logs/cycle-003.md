# Cycle 3 log

## Task performed

T3 — Investigate, target issue: `consistency-calibration-as-failure-mode`.

The issue was grounded only in abstract-level, qualitative claims from src-0001
(arXiv 2503.23175), with no per-model numeric consistency/calibration scores and no
named models. This cycle fetched the full text via the arXiv HTML render
(https://arxiv.org/html/2503.23175v1), which succeeded and yielded genuinely new
quantitative detail:

- Named the 3 tested LLMs: gpt4o, gemini-1.5-pro-latest, mistral-large-2.
- Consistency methodology (10-re-prompt bootstrapped confidence intervals) and
  numbers: tight for information-extraction (max CI width 0.02), wider for
  information-generation (max CI width 0.06).
- Calibration numbers (ECE/Brier score, gpt4o) across zero-shot -> fine-tuned, for
  5 entity/task combinations (Campaign, APT, CVE extraction; CVE, attack-vector
  generation).
- Accuracy tables (precision/recall) across zero-shot/few-shot/fine-tune for several
  entities and models.
- A sharpening finding: the abstract's "few-shot and fine-tuning only partially
  improve results" is more precisely characterized in the full text as fine-tuning
  (and sometimes few-shot) actively WORSENING accuracy and/or calibration on several
  sub-tasks (e.g. gpt4o APT-extraction P/R 0.87->0.68 after fine-tuning; CVE-generation
  ECE 0.15->0.91). This is a refinement of the existing key_claim, not a contradiction
  with it, so no G3 entry was opened -- it is the same source's own full text
  providing more resolution on a claim already in the base, not two supported claims
  in conflict.

Changes: appended 3 new key_claims to src-0001 in `state/knowledge/index.json`
(existing 3 untouched); appended an "## Additional findings (cycle 3)" section to the
end of `state/knowledge/src-0001.md` (existing sections untouched); added a second
candidate_resolution to `consistency-calibration-as-failure-mode` in
`state/issues/graph.json` (existing cycle-2 resolution untouched, still `supported`);
rewrote the issue's 4 open_questions to reflect what the full text answered vs. what
remains genuinely open (model-specific calibration generalization, cross-benchmark
model-list mismatch, cross-task applicability of the multi-dimensional framing, and
why fine-tuning sometimes regresses performance); appended `3` to the issue's
`attempts` array.

## Retrospection

Selected the cycle-2 candidate_resolution on `ttp-attack-mapping-reliability` /
`attribution-confident-wrong-gap`, which cites specific CTIBench (src-0002) numbers:
CTI-MCQ 71.0% / CTI-RCM 72.0% (GPT-4-turbo), CTI-ATE F1 0.6388 (GPT-4-turbo) and
0.1562 (LLAMA3-8B), and CTI-TAA correct/plausible 52%/86% (GPT-4-turbo) and 38%/74%
(Gemini-1.5).

Re-fetched https://arxiv.org/abs/2406.07599 (the URL on record in index.json) first —
the abstract page alone does not expose per-task numbers, only the summary claim that
"evaluation of several state-of-the-art models... provides insights into their
strengths and weaknesses." This is expected and matches src-0002.md's own documented
limitation (numbers were pulled from the HTML render, not the abstract page). To
actually re-verify the claim I then re-fetched
https://arxiv.org/html/2406.07599v3 (the HTML render src-0002.md cites as its
source) and asked it to quote Table 1 directly.

**Result: all specified numbers were confirmed exactly** — CTI-MCQ 71.0%, CTI-RCM
72.0%, CTI-ATE F1 0.6388 (GPT-4) and 0.1562 (LLAMA3-8B), CTI-TAA 52%/86% (GPT-4) and
38%/74% (Gemini-1.5), all cited as coming from "Table 1: Results of different LLMs on
the benchmark datasets." No contradiction found; this re-verification succeeded and no
contradiction entry was needed. Caveat carried forward: this is still a second
automated-summarization read of the same HTML render, not a human pixel-level check of
the PDF table, so full manual certainty is still not established -- but two
independent automated reads now agree.

## Changes made

- `state/knowledge/index.json`: appended 3 new key_claims to `src-0001` (models named,
  consistency numbers, calibration numbers + fine-tuning-regression finding). No
  existing entries modified or removed.
- `state/knowledge/src-0001.md`: appended `## Additional findings (cycle 3)` section
  at the end of the file with full detail, quotes/numbers, and a limitations note
  about automated-extraction confidence. No existing section modified or removed.
- `state/issues/graph.json`: `consistency-calibration-as-failure-mode` issue updated —
  added a second `candidate_resolution` (status `supported`, cites src-0001), rewrote
  `open_questions` (3 of 3 original questions were substantively answered and replaced
  with sharper follow-ons; 1 new question added about the fine-tuning-regression
  finding), appended `3` to `attempts`. No other issue, no contradictions array, and no
  `state/assessments/scores.json` were touched.

## Next task rationale

Per the state machine, T3 -> T4 (Assess) next. `state/assessments/scores.json` is
still at its initial empty state (`last_assessed_cycle: 0`, `scores: {}`) — no issue
in the graph has ever been scored, even though several now have multi-source,
numerically-supported candidate_resolutions (e.g. `ttp-attack-mapping-reliability`,
`ioc-extraction-reliability`, `attribution-confident-wrong-gap`, and now
`consistency-calibration-as-failure-mode` after this cycle's work). T4 requires
scoring EVERY issue in the graph (not just one), so `next_task.json` targets the full
graph rather than a single issue, with instructions to follow the 0-5 rubric in
`prompts/t4_assess.md` and to be stingy per that file's explicit guidance. This will
also produce the score data T5 (Select, the following cycle) needs to pick the
weakest-link issue for the next T3 investigation — `task-dependent-reliability-framing`
is the leading candidate for that, since its sole candidate_resolution is still
`status: proposed` (not `supported`) even though 4 of its dependencies now are.

## Budget

Approx. 5 WebFetch calls (1 retrospection abstract-page fetch, 1 retrospection HTML
re-verification fetch, 1 main-task PDF fetch, 1 main-task HTML fetch, 1 main-task
abstract-page fetch that returned little), ~4 file reads, 3 file edits, 1 file write.
No new sources added (src-0006+ not created, per instructions). Single turn, no
sub-agents spawned.
