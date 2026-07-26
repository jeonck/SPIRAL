# Cycle 002

## Task performed

T2 — Structure. Read all 5 sources in full (`state/knowledge/src-0001.md` through
`src-0005.md`, plus `state/knowledge/index.json`'s key_claims) and built the issue graph
at `state/issues/graph.json`, which was empty at the start of this cycle. Created 6
issues:

- **ttp-attack-mapping-reliability** — MITRE ATT&CK technique extraction/mapping
  reliability. Grounded in src-0002 (CTI-ATE F1 ceiling 0.64) and src-0005 (scaling
  helps generally, but test-time-scaling "reasoning" gains don't transfer to CTI tasks).
- **ioc-extraction-reliability** — mechanical IoC (IP/domain/URL/hash) extraction.
  Grounded in src-0003's LANCE/PRISM result (97.6% F1), flagged as single-study/COI-risk
  in its open questions.
- **consistency-calibration-as-failure-mode** — accuracy vs. consistency vs. confidence
  calibration as distinct axes. Grounded in src-0001, currently qualitative-only (no
  per-model numbers captured yet) — flagged as the weakest-evidenced issue.
- **attribution-confident-wrong-gap** — plausible-vs-correct threat-actor attribution
  gap. Grounded in src-0002's CTI-TAA numbers, cross-linked to src-0004's ENISA
  naming-hallucination incident as a production-setting instance of the same
  confident-but-wrong pattern. Set `depends_on: [consistency-calibration-as-failure-mode]`
  since the plausible/correct gap is fundamentally an overconfidence/calibration
  phenomenon.
- **task-dependent-reliability-framing** — synthesis issue: is CTI reliability one
  property or highly task-dependent (mechanical extraction vs. open-ended reasoning)?
  Depends on the four task-specific issues above; status `proposed` (not yet directly
  measured by any single source — it's my synthesis across sources, flagged as such).
- **institutional-incident-real-world-impact** — real-world production failure
  (ENISA). Grounded in src-0004; kept independent (no depends_on) since it's a
  standalone empirical data point rather than something requiring another issue's
  resolution first.

No issues were merged (all 5 sources mapped cleanly to distinct, non-overlapping
issues plus one synthesis issue), so there is no merge to log this cycle.

**Contradiction check**: examined src-0002 (2024-era models, scaling plateaus ~72%,
CTI-ATE hard) against src-0005 (2025-era models, "larger, more modern LLMs tend to
perform better, confirming scaling laws") for a possible conflict on whether scale
helps. Concluded these are NOT contradictory — they are differently scoped (different
model generations, and src-0005 doesn't report a directly comparable ATT&CK-extraction
metric to compare against src-0002's specific ceiling), so no contradiction entry was
opened. Recorded this reasoning as an open question under
`ttp-attack-mapping-reliability` and `task-dependent-reliability-framing` instead of
forcing a false resolution.

## Retrospection

Not applicable, reported plainly (as cycle 1 also had to report plainly). Before this
cycle began, `state/issues/graph.json` had zero issues and `state/assessments/scores.json`
had zero scores (`last_assessed_cycle: 0`) — there was no supported candidate_resolution
or scored assessment from any *previous* cycle to re-check. This cycle is the first to
produce candidate_resolutions at all, so G2 retrospection has no target yet. It should
become meaningfully applicable starting cycle 3, once this cycle's candidate_resolutions
exist as prior-cycle output to spot-check.

## Changes made

- Modified: `state/issues/graph.json` — populated `issues[]` with 6 entries (see above),
  `contradictions[]` left empty (none found).
- Modified: `state/queue/next_task.json` — set to T3, targeting
  `consistency-calibration-as-failure-mode` (see rationale below), with detailed
  self-contained instructions including fallback behavior if the source fetch fails.
- Modified: `state/queue/last_completed_task.txt` — now reads `T2 structure`.
- Added: `logs/cycle-002.md` (this file).
- No changes to `state/knowledge/index.json`, any `src-*.md` file, or
  `state/assessments/scores.json` — T2 scope is graph structuring only; no new sources
  were added and scoring is T4 work.

## Next task rationale

Per the state machine, T2 → T3. Among the 6 issues, `consistency-calibration-as-failure-mode`
has the weakest evidence base: its candidate_resolution is qualitative only ("inconsistent
and overconfident") with no per-model numeric consistency/calibration scores and not even
the tested models' names, whereas every other issue already has concrete percentages or
F1 figures. This makes it the highest-value target for a T3 deepening pass: fetching the
full text of src-0001's paper (arXiv 2503.23175) could convert a vague qualitative claim
into a precisely-evidenced one, or, if the fetch fails, at least sharpen the open
questions. Instructions were written to be self-contained (specific extraction targets,
explicit append-only constraints referencing the existing 3 key_claims, and an explicit
fallback path if the source is unreachable) so the next cycle does not need this cycle's
context to proceed.

## Budget

Re-read 5 existing source files in full (~1 read pass each, already-fetched content, no
new network calls), 1 read of `config.yml`, 1 read of `scores.json`, 1 read of prior
cycle log for format reference. No WebSearch/WebFetch calls this cycle (T2 is a pure
reorganization task over already-collected knowledge; no new sources were fetched, per
task rules). 3 file writes (`graph.json`, `next_task.json`, `last_completed_task.txt`)
plus this log. Well within `max_turns: 50`.
