# Cycle 007 — T4 Assess

## Task performed

T4 (Assess) per `prompts/t4_assess.md`, on all 6 issues in `state/issues/graph.json`.
`last_assessed_cycle` moved 4 → 7. Every issue was re-scored live against the current
graph and knowledge index rather than carried forward, per the queue instructions.

Result: five of six scores unchanged, one raised.

| issue | cycle 4 | cycle 7 | change |
|---|---|---|---|
| ttp-attack-mapping-reliability | 3 | 3 | — |
| ioc-extraction-reliability | 2 | 2 | — |
| consistency-calibration-as-failure-mode | 2 | 2 | — |
| attribution-confident-wrong-gap | 3 | 3 | — |
| task-dependent-reliability-framing | 1 | **3** | +2 |
| institutional-incident-real-world-impact | 2 | 2 | — |

`state/issues/graph.json` has `contradictions: []`, confirmed again this cycle, so the
`gates.g3_contradiction_demotion` of 2 points applies nowhere.

### The one change, and why it is not inflation

`task-dependent-reliability-framing` rose 1 → 3. The move was scored on evidence, not on
the `status: "supported"` label that cycle 6's T3 attached to its own new candidate —
deliberately mirroring cycle 4, which refused to let `ioc-extraction-reliability`'s
self-assigned `supported` label lift its score above single-source 2.

On evidence, the *narrow* claim (CTI reliability varies sharply by sub-task rather than
being one uniform property) now has three mutually independent **within-study**
demonstrations, which is the thing it previously lacked:

- src-0006 — one consistent design across multiple CTI sub-tasks, F1/AUC ~0.20–0.90.
- src-0002 — one benchmark, one model set: CTI-MCQ/CTI-RCM 71–72% vs CTI-ATE F1 0.64.
- src-0001 — one study: extraction max CI width 0.02 vs generation 0.06, plus markedly
  worse generation calibration.

Cycle 4's score of 1 was right at the time: the only candidate was explicitly `proposed`
and self-described as "a synthesis … not itself directly measured by any single source."
src-0006 changed that fact, not just the label.

Capped hard at 3, and the cap carries a caveat worth restating: the claim that got
support is **narrower than this issue as titled**. The distinguishing content of the
issue — the `mechanical extraction < classification < attribution < generation` ordinal
axis — is not merely unverified but positively in doubt, since src-0006 found its three
failure patterns cut across all four of its pipeline stages including
contextualization/extraction-type tasks. Scored on that axis alone the issue would still
be a 1. One number is currently averaging over a supported claim and a questioned one;
the rationale flags that a future cycle should consider splitting the issue.

### Candidate raises considered and rejected

Being explicit about the rises I did *not* make, since T4's failure mode is optimism:

- **ttp-attack-mapping-reliability 3 → 4?** No. src-0006 is not a third source here —
  its own limitations state it does not test ATT&CK-technique mapping in the CTI-ATE
  form, so it cannot touch `open_questions[0]`. No counterargument has been engaged.
- **consistency-calibration-as-failure-mode 2 → 3?** No. The tempting move is to count
  src-0006 as corroboration. It is not: src-0006 measures cross-task performance
  variation and uses a "counterfactual consistency check" as an internal validation
  device, but reports no repeated-query output-consistency measure and no calibration
  metric (ECE/Brier) — precisely the two properties this issue is about. Still src-0001
  alone.
- **attribution-confident-wrong-gap 3 → 4?** No. src-0006 has attribution-adjacent tasks
  (Threat Actor Linking, False Flag Detection) but reports mitigation deltas, not a
  plausible-vs-correct split. `open_questions[2]` remains articulated but unargued.
- **ioc-extraction / institutional-incident 2 → 3?** No. Both are still single-source
  (src-0003, src-0004). Both were re-verified by live re-fetch in earlier cycles (5 and
  4 respectively), which raises confidence in the source but adds no second source. A
  re-fetch is not a replication.

## Retrospection

Picked `consistency-calibration-as-failure-mode`'s cycle-3 candidate_resolution
(evidence: src-0001) — the most numerically detailed conclusion in the state, and the
only issue not yet retrospected in cycles 3–6 (which covered src-0002, src-0004,
src-0003, src-0002 again). Re-fetched the live URL `https://arxiv.org/html/2503.23175v1`
and asked for each figure back explicitly, with instructions to answer NOT FOUND rather
than infer.

**Result: passes. Every checked figure re-confirmed.**

- 3 models: gpt4o, gemini-1.5-pro-latest, mistral-large-2 — confirmed.
- 350 real-world reports (avg. 3,009 words) — confirmed.
- Consistency method: ten re-prompts at temperature=0 with the same seed, bootstrapped
  CIs; max CI width 0.02 for information extraction, 0.06 for information generation —
  confirmed.
- Table 6 gpt4o calibration, zero-shot → fine-tuned, all ten values re-confirmed
  exactly: Campaign extraction ECE 0.25→0.48 / BS 0.26→0.48; APT extraction ECE
  0.16→0.25 / BS 0.15→0.23; CVE extraction ECE 0.28→0.18 / BS 0.32→0.21; CVE generation
  ECE 0.15→0.91 / BS 0.29→0.98; attack-vector generation ECE 0.47→0.87 / BS 0.43→1.00.
- Degradation percentages: few-shot −7.87% and fine-tuning −21.84% on APT extraction —
  confirmed.

No contradiction opened. One immaterial attribution detail worth recording rather than
acting on: `src-0001.md` attributes the 21.84% fine-tuning drop to "gpt4o/mistral", while
this re-fetch attributed it to gpt4o. Both fetches are automated-summarizer reads of the
same HTML render, the figure itself is identical, and nothing in the state depends on
which model carried it — so this is a provenance wobble in our own note-taking, not two
sources in conflict, and it does not meet the bar for a G3 contradiction entry. Flagged
here so a later cycle doing a manual PDF read can settle it.

This retrospection is load-bearing for this cycle's scoring in two directions: it
freshly re-confirms src-0001, which is one of the three within-study pillars under
`task-dependent-reliability-framing`'s rise to 3, and it simultaneously does *not* move
`consistency-calibration-as-failure-mode` off 2, because re-verifying one source is not
acquiring a second.

## Changes made

- `state/assessments/scores.json` — rewrote all 6 entries with cycle-7 rationales,
  `assessed_cycle: 7` on every entry, `last_assessed_cycle: 4 → 7`. One score changed
  (`task-dependent-reliability-framing` 1 → 3); five held with re-justification. Its
  `evidence` array was set to the three within-study sources actually carrying the score
  (src-0001, src-0002, src-0006) rather than copying the candidate's full six-source
  list, since the other three sources back the dependency issues' claims individually
  rather than this issue's own cross-cutting claim.
- `state/queue/next_task.json` — T5 (Select) for cycle 8.
- `state/queue/last_completed_task.txt` — `T4 assess`.
- `logs/cycle-007.md` — this file.
- No change to `state/issues/graph.json` (T4 does not edit the graph; no contradiction
  arose) and no change to `state/knowledge/` (append-only; nothing to append).

## Next task rationale

State machine says T4 → T5, so cycle 8 selects the next issue to work.

The selection landscape T5 inherits: three issues are tied at the floor of 2
(`ioc-extraction-reliability`, `consistency-calibration-as-failure-mode`,
`institutional-incident-real-world-impact`), and all three are stuck for the *same*
structural reason — each rests on exactly one source, and in each case the missing thing
is an independent second source, not deeper reading of the source already held. This
matters for T5's choice of follow-on task type: another T3 investigate that re-reads the
same paper cannot lift any of them past 2. Cycle 3 already demonstrated this on
`consistency-calibration-as-failure-mode` — a full-text pass added real numeric detail
and the score did not move.

Two facts T5 needs and should not have to re-derive:

1. **`collect_refresh_every: 7` is live.** The only T1 collect ran in cycle 1. Cycle 8
   is seven cycles later, so the config's periodic-refresh rule plausibly fires now.
   The one source added since (src-0006, cycle 6) came in opportunistically during a T3,
   not via a T1.
2. **`tie_break_recent_attempt_penalty: 1` per attempt within the last 5 cycles.** Of the
   three tied issues, only `consistency-calibration-as-failure-mode` has any attempt
   (`attempts: [3]`); the other two have `attempts: []`. Whether cycle 3 still counts as
   "within the last 5 cycles" at cycle 8 is a boundary call (3 is 5 back from 8) that T5
   must make and state, not leave implicit.

I have deliberately not made the selection here — that is T5's unit of work, and the
loop's discipline is that a cycle does one task.

## Budget

1 web fetch (arXiv HTML re-fetch for retrospection), 0 web searches, 8 file reads,
3 file writes, ~10 turns. Well under `budget.max_turns: 50`. No new sources added, so
`budget.max_new_sources` is not engaged (T4 does not collect).
