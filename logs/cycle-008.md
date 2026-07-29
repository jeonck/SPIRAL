# Cycle 008 — T5 (Select)

## Task performed

T5 Select, per `prompts/t5_select.md`. Chose the research target for cycle 9 and wrote
the next queue entry. No research on the selected issue was performed this cycle (that
is cycle 9's unit of work). No edits to `state/knowledge/` or `state/issues/graph.json`.

## Retrospection

**Target chosen:** the cycle-6 `candidate_resolution` (status: `supported`) on
`task-dependent-reliability-framing` — the second candidate, which asserts that
task-dependence itself is supported while the specific extraction-vs-reasoning ordinal
axis is positively in doubt. Selected because src-0006 is the only source in the base
never re-verified by a G2 pass (cycle 4 → src-0004, cycle 5 → src-0003, cycle 6 →
src-0002, cycle 7 → src-0001), and because this conclusion carries the largest score
movement in the project so far (1 → 3 in cycle 7), so an unverified basis would be
costly.

**Method:** re-fetched `https://arxiv.org/abs/2509.23573` (abstract) and
`https://arxiv.org/html/2509.23573` + `.../2509.23573v5` (full HTML render), checking
the three load-bearing assertions and the numeric details recorded in
`state/knowledge/src-0006.md`.

**Result: PASSES.** Confirmed live:

- Title, author list (Meng, Tang, Yu, Jia, Yan, Yang, Xi) — match.
- The three failure patterns (spurious correlations from surface metadata,
  contradictory knowledge from conflicting sources, constrained generalization to
  emerging threats) — match, abstract verbatim.
- The four pipeline stages — confirmed verbatim as "❶Contextualization ❷Attribution
  ❸Prediction ❹Mitigation".
- **The key claim that the failure patterns cut across ALL four stages** — confirmed at
  table level, not just prose: Table 5 marks vulnerability subtypes with stage spans,
  e.g. "Co-mention bias (Type 1.1) — ❶❷❸❹". This is the assertion that put the
  extraction-vs-reasoning ordinal axis in doubt in cycle 7, so it is the single most
  consequential thing verified this cycle, and it holds.
- Source Reliability Scoring AUC 0.912 (G5) vs 0.547 (LLY) — both confirmed in the
  Table 2 row.
- Infrastructure Reuse F1 0.688 (general) vs 0.754 (specialized) — confirmed.
- Threat Actor Linking mitigation gain +0.055 for a Claude model — confirmed as
  "CLD: .055" in Table 6.
- Event Timeline Construction ~+0.08 (range .075–.095) and False Flag Detection +0.115
  (Mixtral) — confirmed.

**No contradiction opened.** `contradictions` in `state/issues/graph.json` remains `[]`.

**Process note worth recording, because it nearly produced a false positive.** My first
HTML fetch appeared to refute two stored figures: it returned "specialized cyber agent
best: 0.738 (not 0.547)" and "Threat Actor Linking: +0.018 to +0.065 (not exactly
+0.055)". Both were artifacts of how I asked, not errors in the state — I had asked
whether a value was the *best* for a model class, and the fast-model summariser answered
that narrower question. A targeted re-fetch demanding the *full row verbatim, every
model column* showed 0.547 present (LLY) and .055 present (CLD). Had I stopped at the
first fetch I would have opened a spurious contradiction, which under
`gates.g3_contradiction_demotion: 2` would have demoted `task-dependent-reliability-framing`
from 3 to 1 and changed this cycle's selection. **Rule for future G2 passes: when
re-verifying a numeric claim against a table, ask for the entire row verbatim across all
columns; never accept a summarised "the value is/isn't X" answer as refutation.**

## Changes made

- `logs/cycle-008.md` (this file).
- `state/queue/next_task.json` — replaced with the T3 entry described below.
- `state/queue/last_completed_task.txt` — set to `T5 select`.

No other state files touched. In particular the G2 pass produced no new claims, so
nothing was appended to `state/knowledge/`.

### Selection: full ranking table (auditable)

Candidate set = all issues with `score < 5` → all six issues qualify.
Base priority = score (lower = higher priority). Penalty = +1 per attempt within the
last 5 cycles (`scoring.tie_break_recent_attempt_penalty: 1`).

| # | issue | score | downstream dependents | attempts | penalty | effective | rank |
|---|-------|-------|----------------------|----------|---------|-----------|------|
| 1 | `ioc-extraction-reliability` | 2 | 1 (task-dependent) | [] | +0 | **2** | **1 (SELECTED)** |
| 2 | `institutional-incident-real-world-impact` | 2 | 0 | [] | +0 | 2 | 2 |
| 3 | `consistency-calibration-as-failure-mode` | 2 | 2 (attribution, task-dependent) | [3] | +1 | 3 | 3 |
| 4 | `ttp-attack-mapping-reliability` | 3 | 1 (task-dependent) | [] | +0 | 3 | 4 |
| 5 | `attribution-confident-wrong-gap` | 3 | 1 (task-dependent) | [] | +0 | 3 | 5 |
| 6 | `task-dependent-reliability-framing` | 3 | 0 | [6] | +1 | 4 | 6 |

### Boundary calls made, stated so later cycles do not re-litigate them

**(1) "Within the last 5 cycles" is inclusive of `current_cycle - 5`.** An attempt at
cycle `c` counts against an issue iff `current_cycle - c <= 5`. As of cycle 8 that means
attempts in cycles 3–8 count. So `consistency-calibration-as-failure-mode`'s
`attempts: [3]` **does** incur +1 (cycle 7's queue entry flagged this as exactly the
boundary case). Chosen because the penalty exists to prevent thrashing, and the
inclusive reading is the conservative one for that purpose. Consequence: this penalty is
decisive — it is the only thing that moved consistency-calibration out of the top slot,
and it expires next cycle (at cycle 9, `9 - 3 = 6 > 5`), so consistency-calibration
returns to effective 2 in cycle 9 unless a new attempt lands on it.

**(2) Tie-break (a) "upstream first" is a pairwise relation and is a no-op among
non-related issues.** The policy says "an issue that others `depend_on` outranks its
dependents". Among the three issues tied at score 2, no pair stands in a `depend_on`
relation to another, so (a) separated none of them and I moved to (b). I did **not**
read (a) as a global sort by dependent-count; had I done so, `consistency-calibration`
(2 dependents) would have won outright at step (a) and the attempt penalty at step (b)
would never have applied — which would defeat the anti-thrashing mechanism the ordering
of tie-breaks exists to enforce. Recording this because the two readings give different
winners.

**(3) Residual tie needs a rule the policy does not supply.** After (b),
`ioc-extraction-reliability` and `institutional-incident-real-world-impact` were both at
effective 2, and tie-break (c) `created_cycle` did not separate them either — both were
created in cycle 2. The policy runs out here. I resolved it by falling back to the
*generalized* form of (a) (dependent count: ioc = 1, institutional = 0), on the grounds
that "upstream first" is the policy's stated intent and a substantive rule beats an
arbitrary one like alphabetical order. **Later cycles: use dependent-count descending as
the documented residual tie-break.** The substantive case agrees: `ioc-extraction`
feeds `task-dependent-reliability-framing`, whose `open_questions[2]` is explicitly
blocked on exactly this issue ("would the task-dependence conclusion survive an
independent replication showing a smaller IoC-extraction advantage?"), so resolving
ioc-extraction unblocks the topic's synthesis issue; `institutional-incident` is a leaf
whose own candidate already disclaims frequency and so is capped below 4 regardless.

### Refresh rule: evaluated explicitly, does NOT fire

The rule is `current_cycle % schedule.collect_refresh_every == 0`. Here `8 % 7 = 1 ≠ 0`,
so the next task is **T3, not T1**.

Cycle 7's queue entry argued the opposite, on a "cycles since the last T1" reading
(the only T1 ran in cycle 1; 8 − 1 = 7 ≥ 7). I am rejecting that reading and applying
the literal modulo rule, for two reasons. First, the modulo rule is what `config.yml`
and the prompt actually specify, and T5's job is mechanical application. Second, the
elapsed-since-T1 reading is not vacuously blocked as cycle 7 implied: the modulo rule
next comes up at cycle 14, and the T3→T4→T5 cadence puts T5 on cycles 5, 8, 11, 14, so
cycle 14 is a T5 and the refresh will genuinely fire there. The rule is live, not dead
— it simply missed its cycle-7 window because cycle 7 was a T4, and the correct response
to that is to let it fire at 14, not to fire it early on a different reading.

**But cycle 7's underlying concern is correct and I am addressing it inside the T3
rather than by overriding the rule.** The concern: all three issues stuck at 2 are stuck
because each rests on exactly one source, and a T3 that merely re-reads the source
already held cannot lift them — cycle 3 is the proof case (a full-text pass on src-0001
added substantial numeric detail and consistency-calibration did not move off 2). A T3
scheduled to re-read src-0003 would therefore be a task known in advance to be incapable
of changing the score. The resolution is that **T3 investigate is not restricted to
already-held sources** — cycle 6's T3 added src-0006 to the knowledge base
opportunistically. So the T3 written below is instructed to spend its budget on finding
an independent second source, with re-reading src-0003 explicitly deprioritized. This is
rule-compliant and capable of moving the score; no refresh override is needed.

### Carry-forward: split recommendation (T5 has no standing to act)

Cycle 7's assessment recommended splitting `task-dependent-reliability-framing`, because
one score is currently averaging over two claims of very different strength: the NARROW
claim (reliability varies by sub-task), genuinely supported by three independent
within-study sources (src-0001, src-0002, src-0006) and worth 3; and the SPECIFIC
ordinal axis (`mechanical extraction < classification < attribution < generation`),
which this cycle's G2 pass just re-confirmed is positively in doubt via src-0006's
Table 5 all-stages finding, and which would score 1 on its own.

T5's remit is selection plus writing the queue entry; editing the issue graph is T2's
job. So I am not splitting it. I have propagated the recommendation into the T3
instructions as an explicit carry-forward so it survives to a cycle that can act on it,
rather than leaving it to be recovered from a log nobody reads.

## Next task rationale

**T3 investigate, `target_issue: ioc-extraction-reliability`.** Selected as rank 1 above.
The task type follows the state machine (T5 → T3) and the refresh rule not firing.

The instructions direct cycle 9 at `open_questions[0]` — independent reproducibility of
LANCE's 97.6% F1 — because that is the specific blocker identified by both cycle 4 and
cycle 7: the score is capped at 2 purely by single-source support, and src-0003 is the
benchmark's own authors evaluating their own system, a conflict-of-interest risk
src-0003 itself flags. Cycle 6 already searched for a LANCE/PRISM replication and found
none, so the instructions tell cycle 9 to widen the search to *any* independent
IoC-extraction evaluation that can corroborate or undercut the mechanical-extraction-is-
reliable finding, rather than repeating cycle 6's narrower query and returning the same
empty result. A negative result is explicitly acceptable and should be recorded as such
— but it must be a *wider* negative than the one already on file, or the cycle adds
nothing.

## Budget

- Fetches: 3 (arXiv abstract page ×1, arXiv HTML render ×2 — the second HTML fetch was
  the targeted re-check that prevented a false-positive contradiction).
- Searches: 0.
- File reads: 7 (`meta.json`, `config.yml`, `next_task.json`, `scores.json`,
  `graph.json`, `knowledge/index.json`, `src-0006.md`) + 1 directory listing.
- Writes: 3.
- Turns: ~7. Well under `budget.max_turns: 50`.
