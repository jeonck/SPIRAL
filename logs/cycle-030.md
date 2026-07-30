# Cycle 30 — T5 (Select)

Topic: `cti-ai-reliability`. Task executed from `state/queue/next_task.json` (`cycle_created: 29`,
`task_type: T5`, `target_issue: null` by design).

I read `prompts/t5_select.md` myself before acting, as the queue entry instructed, and
re-derived the refresh rule from `config.yml` rather than trusting the handoff's arithmetic.
**The handoff's account of the prompt, the config, the scores and the dependency graph checked
out on every point I verified** — the second clean handoff in a row after five bad ones. The
items I verified independently: `prompts/t5_select.md` steps 1–4 verbatim;
`schedule.collect_refresh_every: 7` and `scoring.tie_break_recent_attempt_penalty: 1` in
`config.yml`; every issue's `score`, `created_cycle`, `attempts` and `depends_on` projected
straight out of `graph.json` and `scores.json` with `jq`.

## Task performed

**T5 — select the next research target and write the next task.**

Outcome, stated up front:

- **Selected issue: `ttp-attack-mapping-reliability`.** Next task is **T3 (investigate)** at
  cycle 31.
- **The refresh rule does not fire.** 30 mod 7 = 2 ≠ 0, so this is a T3 and not a T1.
  Re-derived from `config.yml` line 17 and `prompts/t5_select.md` step 4.
- **The prompt's tie-breaks ran out before the tier did, for the second time in four cycles.**
  The bottom tier reduced to a genuine two-way tie and I broke it on a criterion the prompt
  does not state. **I say so plainly below and record it for the human holding
  carry-forward [11].**
- **My G2 opened `ctr-0008`** against `attribution-confident-wrong-gap`. It does not bear on
  the selection — see "Retrospection" for why I am confident of that, since a T5 that
  discovered a finding and then selected the issue it landed on would be suspect.

### The refresh rule, re-derived rather than inherited

`config.yml` line 17: `collect_refresh_every: 7`. `prompts/t5_select.md` step 4: if
`current_cycle % schedule.collect_refresh_every == 0`, next task is T1 instead of T3.
**30 mod 7 = 2, so nothing fires and I write a T3.**

State machine positions (`T1→T2, T2→T3, T3→T4, T4→T5, T5→T3`), re-derived: 25 T3, 26 T4,
27 T5, 28 T3, 29 T4, **30 T5 (this cycle)**, **31 T3**. T5 thereafter on 33, 36, 39, **42**.
Of the multiples of 7 ahead, 35 is not a T5 cycle and 42 is, so **the next T1 is cycle 43 and
the next T2 is cycle 44** — unchanged from cycle 29's derivation, and I weighed its
consequence for selection (see below).

## Retrospection

**G2 target: `src-0007`** (arXiv 2603.09452, *CyberThreat-Eval*, Microsoft Research /
Microsoft / HKUST). Chosen by staleness per carry-forward [8]: its Table 4 **rubric rows** were
a single unreplicated pull from cycle 15, and that gap is the stated reason
`attribution-confident-wrong-gap`'s third candidate is still `proposed`. src-0007 sits in six of
the eight issues' evidence lists, so it was the highest-value target available.

**Conclusion re-checked:** `attribution-confident-wrong-gap`'s third `candidate_resolution`
(status `proposed`, evidence `[src-0007]`), and specifically the sentence its own text calls
load-bearing:

> "THE LOAD-BEARING PART IS THE WITHIN-TABLE CONTRAST, not the model gap: the same GPT-4o
> scores 3.686 / 3.458 / 3.612 on 'Content: Root Cause' in the same table, so its 1.140 on
> threat-actor attribution is a deficit specific to attribution rather than a general inability
> to draft."

**Method:** two fetches, two URL renderings (`arxiv.org/html/2603.09452v1` and
`arxiv.org/html/2603.09452`), both instructed to transcribe verbatim and to answer `ABSENT` or
`CANNOT READ` rather than infer. Per the eight-part methodological rule I asked for the whole
table (iv), the exact stored numbers (ii), **and the verbatim definition of the metric** (iii).

### Result: the numbers PASS, the metric definition FAILS

**PASSED — third independent pull.** All **34 data rows** of Table 4 returned identical to the
transcription in `state/knowledge/src-0007.md`, cell for cell, caption and column order
included. Every rubric cell the state cites is exact. The **GPT-4o (FT) anomaly** of
carry-forward [19] is **reproduced a third time** (3.964 / 3.655 / 3.165 / 4.752 / 4.731 /
2.967 against o3-mini's 3.964 / 3.656 / 3.165 / 4.753 / 4.731 / 2.968 — within 0.001 on all six
rows, across pulls at cycles 15, 21 and 30 on two URL forms). **As-printed, cause unknown, and
I did not guess.** The scale normalisation is re-confirmed **ABSENT**, so the existing
restriction to within-table contrasts stands.

**FAILED — "Attribution" is two different metrics inside one table.** Appendix C.2 prints
*separate* criteria blocks for Threat Actor content and Root Cause content, and the dimension
named `Attribution` is defined differently in each. Verbatim, all anchors:

*Threat Actor block:* "Attribution: • 1: Information is unverified or unattributed. • 2: Major
attribution issues; many details are not clearly linked. • 3: Moderately attributable; some
details lack clear source references. • 4: Mostly attributable; minor gaps in linking
information. • 5: Fully attributable; all details are clearly linked to the original article."

*Root Cause block:* "Attribution: • 1: Completely incorrect attribution. • 2: Significant
attribution errors; misidentified threat actor. • 3: Basic attribution; minor inaccuracies.
• 4: Mostly correct attribution. • 5: Perfect attribution; clearly identifies the threat
actor."

So in the Threat Actor block `Attribution` measures **source linking** — traceability of the
output to the input article — and **no anchor in that block mentions identifying a threat
actor**. In the Root Cause block it measures **threat-actor identification**, in three of five
anchors.

**The state's contrast differences two cells that are not the same measurement, and the labels
run opposite to the way the state reads them:** the cell treated as the threat-actor-attribution
deficit (1.140) is the one whose rubric is *not* about identifying an actor, while the cell used
as the drafting **control** (3.612) is the one that *is*.

**What survives, so the repair is not over-read as a demolition.** The **block-level** contrast
is untouched and is broader than the sentence it replaces: GPT-4o scores lower on **all six**
dimensions for Threat Actor content (1.547 / 1.528 / 1.145 / 2.019 / 1.734 / 1.140) than for
Root Cause content (3.686 / 3.458 / 3.362 / 3.932 / 3.753 / 3.612). "A deficit specific to the
threat-actor sub-task rather than a general inability to draft" therefore **remains supported —
by the whole block, not by the Attribution row.** Two limits travel with it: the two blocks'
anchors are themselves worded differently, and this is still an LLM-judged construct that
evidences **wrongness, not confidence**.

### Second finding from the same pull: the judge is GPT-4o, one of the four scored models

Never recorded anywhere in this state in twenty-one cycles. `state/knowledge/src-0007.md`
previously contained neither the word "judge" nor "criteria"; `graph.json` says only
"LLM-judged" and "as judged by the benchmark's scorer".

Verbatim, Section 4.1: "To evaluate narrative quality (threat actors and root causes), we
employ the LLM-as-Judge paradigm" and "This evaluation method provides the LLM judge with the
ground-truth article, candidate output, and a scoring rubric covering relevance, factual
accuracy, comprehensiveness, clarity, coherence, and attribution." Verbatim, Appendix C.2:
**"We evaluate the results using GPT-4o based on the criteria provided for each task (e.g.,
threat actor, root cause)."**

So the "2.6× model gap" between GPT-4o 1.140 and o3-mini 2.968 is a comparison **in which one
of the two compared models graded both outputs.**

**Recorded in both directions, per rule (vii).** In the source's favour, Section 4.1 verbatim:
"This calibration process yields an agreement rate between the LLM-as-Judge and human experts
exceeding 95%." And the obvious suspicion does **not** hold up — judge self-preference would
*inflate* GPT-4o's own scores, whereas GPT-4o is scored **lowest** by a factor of ~2.6, so
self-preference does not explain the deficit and arguably makes its direction more robust.
**I assert nothing beyond that.** What is required is that the instrument's identity be stated
wherever the model gap is cited.

### Verdict and action

**The conclusion FAILS re-verification, and `ctr-0008` is opened** against
`attribution-confident-wrong-gap` (the issue owning the defective candidate text), naming the
two issues that inherit the defect. This is a success of the mechanism, not a failure: the
defect had been invisible for fifteen cycles precisely because every cycle checked the
*numbers*, which are flawless.

**Filing test applied** (carry-forward [32]): the source's own legible text conflicts with the
stored claim, so it is filed — not merely unverifiable. This is the **tenth** source-check and
the **ninth** to produce a defect. The class gains a **ninth** shape: *same label, two
definitions inside one table* — a metric-identity defect, cousin to `ctr-0006`'s
Micro-vs-Macro-F1 but worse, because here both definitions are printed in full and simply
differ.

**Two issues inherit it and a T3 must not repair only one:**

1. **`task-dependent-reliability-framing` has the largest scoring exposure.** Its cycle-29 T4
   rationale rests the level-3 bar on legs it calls **immune** to the non-commensurable-scoring
   objection, naming first among them that "src-0007's rubric contrast (Content: Threat Actor
   1.140 against Content: Root Cause 3.612) is measured on ONE instrument within ONE table."
   One instrument and one table, yes; **one metric definition, no.** That leg is a **fifth**
   instance of the very objection the T4 listed four instances of, sitting *inside* the leg
   designated immune. **A T5 has no standing to rescore and I have not. The cycle-32 T4 must
   price this.**
2. **`extraction-vs-reasoning-ordinal-axis`** uses the same cell for a different purpose: its
   route 2 reads "GPT-4o's attribution rubric of 1.140/5 normalises to 0.228 or 0.035 against a
   derived TTP F1 of 0.2502 (at or below), while o3-mini's 2.968/5 normalises to 0.594 or 0.492
   against 0.2337 (above), under both defensible normalisations." It is treating a
   **source-linking** score as the attribution rung of an ordinal axis. The natural repair is
   the Threat Actor block's **Accuracy** row (GPT-4o 1.528, o3-mini 3.656), and **I record
   without asserting it** that the repair may not be cosmetic: 1.528/5 is 0.306 or 0.132, and
   0.306 sits *above* the 0.2502 comparand while 0.132 sits below, so "under both defensible
   normalisations" may not survive for GPT-4o. **That arithmetic is mine and is for a T3 to
   re-derive, not to copy.**

**Version check** (carry-forward [39], cheap secondary axis): not run this cycle. The two
renderings I used were `/html/…v1` and `/html/…` (unversioned, which serves the latest), and
they agreed cell for cell, which is weak evidence that no later version diverges — but I did
**not** fetch `/abs` to enumerate versions and **make no claim** that v1 is the only version.
Provenance labels (src-0013, src-0014, src-0015) also remain unchecked.

## Changes made

Four files touched. Every JSON edit validated with `jq -e` and read back with `jq -r`.

1. **`state/issues/graph.json`** — **`ctr-0008` opened** (`issue_id`
   `attribution-confident-wrong-gap`, `opened_cycle` 30, `resolved_cycle` null, ~10.2 KB
   description). Carries both verbatim rubric blocks, the judge sentences, the >95% agreement
   sentence, what survives, the two inheriting issues with their exact quoted text, and a
   five-step resolution path. Inserted at the head of `contradictions` using the safe-anchor
   pattern from carry-forward [9]; `ctr-0007` verified intact afterwards, all four required
   fields present on both. **Nothing else in the file was touched** — no issue, candidate,
   `open_question`, `attempts` or score. A T5 has no standing over any of those.
2. **`state/knowledge/index.json`** — **one key_claim appended** to src-0007 (now 6, was 5).
   Nothing deleted or rewritten; source count unchanged at 18.
3. **`state/knowledge/src-0007.md`** — **dated re-verification section appended** (348 lines,
   was 247), with both rubric blocks and all judge quotations verbatim. Repairing both places,
   per the pattern held since cycle 22.
4. **`state/queue/next_task.json`** and **`state/queue/last_completed_task.txt`** — rewritten
   per the finish order.

**Not changed, deliberately:** `state/assessments/scores.json`. A T5 does not score.
`ttp-attack-mapping-reliability` stays at 2 as cycle 29 set it, and
`attribution-confident-wrong-gap` stays at 2 despite now carrying an open contradiction again.

**G3 check on my own edit:** `attribution-confident-wrong-gap` had no open contradiction after
`ctr-0002` resolved at cycle 28; it has one again, so the `scripts/validate_state.py`
lines 144–156 ceiling of `scale_max − g3_contradiction_demotion` = 3 reapplies to it. It is
scored **2**, which is under the ceiling, so **nothing is capped and no state is broken.** The
graph now holds **seven open contradictions across four issues**: `ioc-extraction-reliability`
3, `consistency-calibration-as-failure-mode` 2, `ttp-attack-mapping-reliability` 1,
`attribution-confident-wrong-gap` 1.

## Next task rationale

### Step 1 — candidate set

All eight issues score < 5, so all eight are candidates. No issue scores 5, so the
all-resolved T2 branch does not apply.

### Step 2 — base priority = score

Score **2**: `ttp-attack-mapping-reliability`, `ioc-extraction-reliability`,
`consistency-calibration-as-failure-mode`, `attribution-confident-wrong-gap`,
`automated-triage-under-refusal`. Score **3**: `task-dependent-reliability-framing`,
`extraction-vs-reasoning-ordinal-axis`, `institutional-incident-real-world-impact`.

**The bottom tier is five issues wide** because cycle 29 demoted `ttp`. That makes the
tie-breaks fully load-bearing.

### Step 3b — my reading of the window, stated explicitly

Carry-forward [11](c): "within the last 5 cycles" has three defensible readings, and it decides
the tier. **I adopt cycles 25–29 inclusive** — the five cycles that have actually run before
this one.

**Reason.** Reading 26–30 spends one of its five slots on the current cycle, which by
construction cannot contain a completed attempt (a T5 does not attempt an issue), so it gives
an effective anti-thrash memory of **four** cycles. The penalty exists to prevent thrashing on
a stuck issue, so the reading that preserves a full five cycles of history is the one that
serves the mechanism. It is also the stricter reading. All five cycle numbers in 25–29 contain
real runs; cycle 24 died before writing anything and falls outside the window either way.

**Consequence:** `consistency-calibration-as-failure-mode` (attempt at 25) takes +1 and
`attribution-confident-wrong-gap` (attempt at 28) takes +1. Under the 26–30 reading, only
`attribution` would, and `consistency` would have joined the terminal tie. **My reading
therefore made the tie two-way rather than three-way, and I flag that it is doing real work.**

### The full ranking table

Penalty column is 3b under the 25–29 window. "Upstream?" is 3a: does any issue `depend_on` it?

| Rank | Issue | Score | 3a upstream? | 3b penalty | Effective | `created_cycle` | Last attempt | Disposition |
|---|---|---|---|---|---|---|---|---|
| **1** | **`ttp-attack-mapping-reliability`** | **2** | yes (`task-dependent`) | +0 | **2** | 2 | c16 | **SELECTED** — terminal tie broken extra-prompt |
| 2 | `ioc-extraction-reliability` | 2 | yes (`task-dependent`) | +0 | 2 | 2 | c21 | runner-up; tied with rank 1 through 3c |
| 3 | `consistency-calibration-as-failure-mode` | 2 | yes (`task-dependent`, `attribution`) | **+1** (c25) | 3 | 2 | c25 | out on 3b |
| 4 | `attribution-confident-wrong-gap` | 2 | yes (`task-dependent`) | **+1** (c28) | 3 | 2 | c28 | out on 3b; ranks 3/4 are themselves tied through 3c |
| 5 | `automated-triage-under-refusal` | 2 | **no** | +0 | 2 | 16 | never | out on 3a — **fifth consecutive loss** |
| 6 | `task-dependent-reliability-framing` | 3 | yes (`extraction-vs-reasoning`) | +0 | 3 | 2 | c16 | score tier |
| 7 | `institutional-incident-real-world-impact` | 3 | no | +0 | 3 | 2 | c12 | 3c above rank 8 |
| 8 | `extraction-vs-reasoning-ordinal-axis` | 3 | no | +0 | 3 | 16 | c18 | score tier |

**Two procedural notes for the paper, both instances of carry-forward [11]:**

- **[11](b) reproduced.** Ranks 3 and 4 have *effective* score 3, equal to the score-3 tier. A
  literal "effective score" ordering would interleave them with ranks 6–8. I applied 3b as a
  tie-break **within** a base-score tier, per the prompt's "base priority = score", so the
  tiers do not interleave. **This reading does not change the winner**, but the prompt permits
  both and should say which.
- **A second terminal tie.** Ranks 3 and 4 are also identical through 3c (both score 2, both
  upstream, both +1, both `created_cycle` 2). I ordered them arbitrarily; it affects nothing,
  but it means the prompt produced **two** unresolvable ties in one cycle, not one.

### Step 3c and the terminal tie

`ttp-attack-mapping-reliability` and `ioc-extraction-reliability` are identical on **score (2)**,
on **having dependents** (both are depended on by `task-dependent-reliability-framing` and
nothing else), on **3b penalty (0)**, and on **`created_cycle` (both 2)**. **The prompt is
exhausted. There is no 3d.** Carry-forward [11] predicted this exact pair, and it is the second
time in four cycles that the terminal residue has bound.

### Breaking it — explicitly extra-prompt, and labelled as such

**Primary criterion: extend 3b's own logic past its stated five-cycle horizon — most-recent-attempt
age.** `ttp` was last attempted at cycle **16** (14 cycles ago); `ioc` at cycle **21** (9 cycles
ago). **`ttp` is the staler by five cycles, so it wins.** I prefer this to a freshly invented
rule because it is a *continuation* of a criterion the prompt already states, in the same
direction, rather than an unrelated consideration: 3b's whole purpose is to push work away from
recently-worked issues, and it simply stops having an opinion at a five-cycle cliff.

**Three corroborating considerations, all pointing the same way.** I record them because a
single criterion chosen after the fact is easy to fit to a desired answer:

1. **Severity relative to what carries the score.** `ctr-0006` hollowed out `ttp`'s **first
   supported** candidate — cycle 29 found it "now carries nothing" — and compromised the
   second. `ioc`'s candidates 1 and 2 remain numerically intact; their defect is an
   independence *count*, not a refutation, and `ctr-0007` hits candidate 3, which is `proposed`
   and which cycle 29 explicitly said "never carried" the score. **`ttp`'s *supported* content
   is the more damaged of the two.** This is cycle 27's criterion ("repair refuted content
   before deepening thin content") sharpened — note that cycle 27's version alone does **not**
   separate this pair, since both issues carry open contradictions.
2. **Executability by a T3 in one cycle.** `ttp`'s path is a **single named, already-located
   file read**: `stage3_ti_drafting/ttp/` in the src-0017 repository via
   `raw.githubusercontent.com`, which returns whole files. `ioc`'s decisive need, per its own
   cycle-29 rationale, is "a second independent measurement of report-level IoC extraction, or
   a head-to-head on one corpus" — a search-and-collect job with low one-cycle success
   probability, and the next T1 is cycle 43.
3. **Cross-issue spillover, which partly serves the runner-up anyway.** That one fetch is the
   named next step for `ctr-0006` (`ttp`), for `ctr-0001`'s remaining path (`ioc`), for
   `ctr-0004`'s unread-scorer gap, and for carry-forward [34]'s route back to a 4 on
   `task-dependent-reliability-framing`. Cycle 29 judged it the highest-leverage single fetch
   in the graph and I agree.

**The honest counter-argument, stated rather than buried:** `ioc` carries **three** open
contradictions to `ttp`'s **one**, and a "most-contradicted-first" rule would select `ioc`.
Cycle 27 noted the same sensitivity — under lexicographic id one issue wins, under
longest-open-contradiction the other. **The criterion choice is doing real work here, and a
terminal tie-break must be written into the prompt.** For the human holding [11].

### Two things I weighed and want on the record

- **The structural discount.** The handoff asked whether I weighed that
  `consistency-calibration-as-failure-mode` and `attribution-confident-wrong-gap` buy less than
  their score suggests, because each bundles a well-evidenced conjunct with a poorly-evidenced
  one and **only a T2 can split an issue** (next T2: cycle 44). **I did, and it did not decide
  anything** — 3b removed both before the question arose. Had my window reading been 26–30,
  `consistency` would have been in the terminal tie and this would have been load-bearing.
  Recording it because the near-miss matters: **the selection machinery came within one
  window-reading of choosing an issue whose defining problem the selected task type cannot
  fix.** `ttp` has no such discount — `ctr-0006`'s path is fully executable by a T3.
- **I did not select the issue my own G2 landed on.** `ctr-0008` is filed against
  `attribution-confident-wrong-gap`, which 3b removed on a rule stated in the prompt, and its
  heaviest consequence falls on `task-dependent-reliability-framing`, which is in the score-3
  tier. **Neither `ttp` nor `ioc` is affected by `ctr-0008` at all**, so this cycle's finding
  had no influence on the tie either way. The `ctr-0008` repair work is instead written into
  the next task as a secondary instruction, since a T3 on `ttp` will be reading the same
  artefact family.

### `automated-triage-under-refusal` — a fifth consecutive loss, and 3a is again the mechanism

It sits at score 2 with `attempts: []`, and **3a eliminates it because it has no dependents** —
exactly as carry-forward [30] predicted for the fifth time. It holds the project's top
uncollected source (carry-forward [15], the curl/HackerOne case, judged highest-value by six
cycles now) and an observation bearing on its own central open question (carry-forward [27],
src-0015's `Reward` column, **ten** cycles unentered, and only a T3 targeting it has standing to
enter it). **I applied 3a as written and did not use "never attempted" as a tie-break in either
direction** — the prompt does not make it one, and cycle 19 was wrong to assert it did. **This
is a prompt defect for a human, and its cost is now five selections deep.**

### Next task

**T3 (investigate) on `ttp-attack-mapping-reliability`**, `attempt_count` 0, with the issue's
three `open_questions` quoted verbatim from `graph.json` as the prompt requires.

## Budget

- **Fetches: 3.** All `arxiv.org` renderings of src-0007 (`/html/…v1` ×2, `/html/…` ×1). No
  searches. No budget spent on any route recorded as blocked (`spiegel.de`, ENISA PDFs,
  OpenReview, ScienceDirect 403).
- **Reads: 6** (`next_task.json`, `meta.json`, `config.yml`, `scores.json`,
  `prompts/t5_select.md`, plus two windowed reads of `src-0007.md` / `index.json` /
  `graph.json`). **`graph.json` was read almost entirely through `jq -r` projections** — five
  candidate texts, the schema, all contradictions and the full dependency table — for a small
  fraction of what `Read` on a ~148 KB file would have cost. Carry-forward [24] keeps paying.
- **Bash calls: ~8**, three of them `jq -e` + `jq -r` validation pairs. One heredoc append.
- **Edits: 2** single-anchor `Edit`s, both correct on the first attempt using the
  carry-forward [9] patterns (safe insertion anchor = first line of the following element's
  body; single quotes for all internal quotation). **Two full `Write`s** (this log,
  `next_task.json`).
- **Turns: ~14 of 50.** Comfortably inside budget. The cycle was cheap because the ranking
  arithmetic is mechanical and the G2 was one paper read three ways.
- **Efficiency note for successors:** the finding that mattered cost **one extra fetch** — the
  one that asked for the metric's *definition* rather than its value. Rule (iii) has now
  produced `ctr-0002`, `ctr-0003`, `ctr-0004`, `ctr-0006`, half of `ctr-0007` and now
  `ctr-0008`. **It is the highest-yield question available for the price.**

## Carry-forward items

All items from `logs/cycle-029.md` reproduced **including those I could not act on**, with
cycle-30 updates. Discharged items stay marked rather than deleted. **One new item: [47].**
**[19]'s residue is partly discharged and partly deepened; [25] is REOPENED.**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis`. Still vindicated. Cited as the
precedent behind [37] and [45].

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK
metric at all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now in
its **nineteenth** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not accuracy**,
and does NOT discharge it. **[44] puts the 0.6388 itself in question.** *Cycle 30: this is the
single largest reason the issue I just selected cannot reach 4, and the T3 at cycle 31 cannot
fix it without a new source.*

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. See [30]. *Cycle 30: it has now
lost **five** consecutive selections, and 3a was the mechanism again.*

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 21 CYCLES.** The G3 gate is
specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35
comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The
enforced reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in
`logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside
this agent's output surface. **Until a human applies it, T4s must apply the ceiling.** *Cycle 30
is a T5 and does not score, so the gate did not bind on me; I checked only that my edit does not
create a breaking state, and it does not (`attribution-confident-wrong-gap` at 2 under a
reapplied ceiling of 3). **The per-issue-versus-per-contradiction question is now live on two
issues at once**, `ioc` with three open contradictions and `consistency` with two. Awaiting a
human, verbatim, with [11], [30] and [41].*

**[5] — DISCHARGED CYCLE 29, AND IT NEEDED NO PDF.** The src-0008 phase-label discrepancy is a
**self-contradiction in the source**, and our stored mapping is the **majority reading**.
Table 3 puts XOR at P5 and AES-256 at P6; two body sentences agree; one stray body sentence
disagrees. Probable cause: Table 3's row descriptions cross-reference level numbers shifted
**+1**. **No contradiction entry** on this limb per [32]'s test. *Standing lesson: an item
recorded as "blocked by an infrastructure limit" may only be blocked by the route the recording
cycle happened to try.*

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv
2506.11325; **third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal
baselines**; the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not
retry). **Forward-citation sweeps have FAILED on two arXiv ids.** **CTIArena is resolved and
dead for consistency/calibration purposes.** **SEvenLLM** uncollected and downgraded.
**AthenaBench** still has no URL. **No arXiv companion exists for src-0018.** Unavailable:
OpenReview, spiegel.de ([13]). **CTIBench's own released dataset/evaluation artefact has never
been sought** — cheapest route to `attribution-confident-wrong-gap`'s `open_question[1]` and to
[44]'s unstated ATT&CK correctness rule. *Cycle 30 spent nothing here.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT 22; ONE STEP ADVANCED AT 27.** `ctr-0001`'s
resolution path. **Done:** released-code route exhausted; **METRIC confound ELIMINATED**.
**Still open:** no head-to-head; the **CORPUS confound is completely untouched and is the
largest gap**. Remaining steps, cheapest first: src-0007's **TTP and rubric scorers** in the
src-0017 artefact (`stage3_ti_drafting/ttp/`, [34]);
`huggingface.co/datasets/xse/CyberThreat-Eval`; then corpus difficulty. *Cycle 30: **the cycle-31
T3 I just scheduled will execute the first of those steps**, and it serves this path even though
it targets `ttp`. Cycle 30 also adds a **rubric/judge scorer** to the list of things worth
reading in that repo — see [47].*

**[8] — UPDATED cycle 30. G2 COVERAGE COMPLETE; NOW TRACKED BY STALENESS.** src-0004 (c4, c12),
src-0003 (c5; c22 — provenance partial fail, [32]), src-0002 (c6; c23 — `ctr-0002`; c28 —
`ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, [39]), src-0006 (c8; c17 partial fail [21];
re-pulled c18), src-0005 (c9, c11; c26), src-0008 (c10; c29 — `ctr-0007`), src-0012 (c13),
src-0011 (c14), **src-0007 (c15; c21 Table 4 whole; c30 — rubric DEFINITION mismatch,
`ctr-0008`; judge identity recovered)**, src-0009/src-0010 (c16), src-0013 (c18), src-0014
(c19), src-0015 (c20), src-0016 (c21 — provenance partial fail, [31]), src-0017 (c27 —
`ctr-0004`), src-0018 (c28 — `ctr-0005`). *Next G2 should prefer by staleness: **src-0012**
(c13), then **src-0011** (c14), then **src-0009/src-0010** (c16). Both src-0012 and src-0011
belong to `institutional-incident-real-world-impact`, which is at 3 and where src-0011's
`proposed` candidate and its known prose-vs-table self-contradiction ([18]) are unexamined
since collection. Not recommended next: src-0007 (c30), src-0008 (c29), src-0002/src-0018
(c28), src-0017 (c27), src-0005 (c26), src-0001 (c25), src-0003/src-0016 (c21–22), src-0015
(c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25–30.** `python3` present but the
**permission layer** blocks it; compound commands rejected if any segment is unapproved (cycle
30 hit this on a `sed -n` chained after a `jq`). **No PDF text extraction exists** — prefer
`/html` always. `gh` not approved. `awk` refused. **`sed -n` and `cat >>` heredoc ARE
approved**; a heredoc append must be its **own** call. `jq -e . <file> > /dev/null` approved, as
is a compound `jq … && jq …` chain. Prefer **single-line `Edit` anchors**. `scores.json` and
`graph.json` are NOT protected by validator lines 105–107.
**`raw.githubusercontent.com` returns whole files.** *Cycle 30: all held; both insertion
patterns worked first time again, and **single-quoting every internal quotation** made a 10 KB
contradiction entry escape-free.*

**[10] — DISCHARGED CYCLE 26, AND THE ANSWER IS THAT IT WAS NEVER ACHIEVABLE.** src-0005's
per-model numbers do not exist in text at all — every per-model score is inside Figures 8, 9,
12–16. **Do not re-attempt without a new route.** See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND AT 27 AND AGAIN AT 30.** Tie-break 3a in
`prompts/t5_select.md` is under-specified and there is **no deterministic tie-break after 3c**.
For a human, in three parts: **(a)** a terminal tie **must** be written into the prompt;
**(b)** the prompt lists **3a before 3b**, but 3b is an addition *to the score*, so a literal
a-then-b ordering lets them return **opposite verdicts on the same pair**; **(c)** "within the
last 5 cycles" has three defensible readings. *Cycle 30, all three bound at once and this is the
richest single data point the item has:* **(a)** *the tier reduced to `ttp` vs `ioc`, identical
on score, dependents, penalty and `created_cycle` — [11](a) verbatim, twice in four cycles — and
**a second, independent terminal tie appeared simultaneously** at ranks 3/4 (`consistency` vs
`attribution`, also identical through 3c). **Two unresolvable ties in one cycle.** I broke the
decisive one on an **explicitly extra-prompt** criterion (most-recent-attempt age, chosen because
it extends 3b's own logic past its five-cycle cliff) and named the corroborating considerations
and the counter-argument.* **(b)** *reproduced concretely: ranks 3 and 4 have effective score 3,
equal to the score-3 tier, so a literal effective-score ordering would interleave the tiers. I
applied 3b within-tier per "base priority = score"; **the prompt permits both and must say
which**.* **(c)** *decided the tier width. I adopted **25–29** and stated why (a 26–30 window
spends a slot on a cycle that cannot contain an attempt, shortening anti-thrash memory to four
cycles). **Under 26–30 the tie would have been three-way and could have selected an issue only a
T2 can fix** — see [37]/[45]. The reading is load-bearing and it is undocumented.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with
standing to split an issue, add an issue, or reconcile the prompt/validator disagreement. The
claim that the loop "never returns to T2" is false; cycle 16 disproved it. *Cycle 30: **next T2
is cycle 44 at the earliest**, and [37] and [45] are both T2 jobs. New this cycle: the near-miss
in the ranking (see [11](c)) means the selection machinery can be **one window-reading away**
from handing a T3 an issue whose defining problem no T3 can fix. That is a second, independent
argument for widening the path to T2.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is
the upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
route is also closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own
writeup is the only remaining route known. OpenReview joins this category ([6]).

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level
and UNVERIFIABLE at document level here. **Do not re-spend budget.** *Caution from [5]:
"blocked by an infrastructure limit" deserves one re-test by a **different route** before being
treated as permanent. This one has had several.*

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, AND DEFERRED A SIXTH
TIME.** The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated
"slop" reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling
from ~15% to under 5%) is an `open_question` on `automated-triage-under-refusal`. **It is a
question, not evidence — no curl source exists in `index.json` and G1 forbids inventing one.**
Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26–30 all judge it the highest-value uncollected source. *Cycle 30: the T3 I
scheduled targets `ttp`, so the earliest realistic route is now **cycle 43's T1** unless a T5
between now and then breaks a tie the other way.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question. Verbatim from `https://gptzero.me/investigations/ey`: an "automated pipeline
to search for vibe citations by finding and scanning public reports from major consulting
firms". A T1 should chase `gptzero.me/news/tag/investigations`. Caveats: commercial
AI-detection vendor; no *rate* published; the scorecard widget renders as "0 of N" to automated
fetch. **Still the only route any cycle has found to a base rate**, the binding constraint on
`institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16.
Structural finding for the paper: the only task type that can restructure the issue graph fires
when a T5 coincides with a multiple of 7 — under a clean three-cycle loop, **once every 21
cycles**.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly (NeurIPS "391 papers" in text
vs 391 invalid citations across 308 papers in Table 3). No claim in our base repeats the error;
**no G3 entry was opened**. Quote src-0011's *counts* from Table 3. *Cycle 30: the
self-contradiction class grows again. Sources in this base that contradict themselves: src-0011
(prose vs table), src-0002 (Micro-F1 text vs Macro-F1 header, [44]), src-0008 twice (phase
labels [5]; metric definitions [46]), **and now src-0007 — the same rubric dimension name
defined two different ways in two Appendix C.2 blocks ([47])**. **Four sources, five
instances.** Ours is load-bearing in two cases now (src-0002 and src-0007), which is [32]'s test
for whether to file.*

**[19] — FULLY DISCHARGED CYCLE 21; RESIDUE PARTLY DISCHARGED CYCLE 30.** src-0007's Table 4
pulled **whole and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall
(Accepted) **0.9091–1.0000**. *Cycle 30 discharged the replication half: **the rubric rows are
no longer single-pull** — a third independent pull returned all 34 rows identical, so the stated
reason `attribution-confident-wrong-gap`'s third candidate stays `proposed` is **gone**, and a
T3 must now decide that status on the metric-definition ground instead ([47]).* **THE ANOMALY
ITSELF IS UNRESOLVED AND NOW REPRODUCED THREE TIMES:** GPT-4o (FT) tracks o3-mini to within
0.001 on **all six** `Content: Threat Actor` rubric rows, identically at c15, c21 and c30, on
two URL forms. **As-printed, cause unknown, do not guess.** *Cycle 30 adds one datum that does
not explain it: the judge is GPT-4o ([47]), which is suggestive but explains nothing, since the
anomaly is between the **o3-mini** and **GPT-4o (FT)** columns and not the GPT-4o one.*

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014
(c19), src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy **narrowed but not closed** —
quote 33.9% and 16.9%→83.2% only with their scopes named. Gemini's 0.161 → 0.721 was **not**
re-checked. **Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are still
body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs
0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak
is **G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly
0.20–0.90" against a true span of **0.286–0.882**. Cycle 18 appended a corrective key_claim to
`index.json`; **`src-0006.md` itself is still untouched and still contains the wrong sentence —
it is the only known source file still carrying an uncorrected sentence, and it is a cheap
fix.** *The repair-both-places pattern now holds for cycles 22, 23, 25–30.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are
**strictly monotone decreasing across all eight general-purpose columns in exactly the printed
column order**; four are in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis`
depends on. One row matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320.
**Not a fetch artefact.** **Any finding resting on that table must carry a robustness check
excluding those rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.** Mean between-**model** range
within a task (0.272) and mean between-**task** range within a model (0.263) are equal to within
0.009. This does **NOT** negate `task-dependent-reliability-framing`'s supported claim — cycles
19, 22, 26 and 29 all tested it — it qualifies the implication that sub-task is the *privileged*
explanatory variable. A T2 should annotate rather than re-scope. No contradiction: both facts
hold.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–23 AND 25–30. `jq` IS INSTALLED AND APPROVED.**
**Every cycle from 9 to 17 recorded that this agent cannot validate JSON and must check "by
construction". That advice is wrong and it is expensive** — cycle 17 lost its entire `state/`
output. **Every JSON edit should be followed by `jq -e`** *and* by a `jq -r` read-back of the
fields added. The permission layer is **not uniform** — probe once. The `Grep` **tool** works on
the big JSON files where Bash `grep -n` does not. Cheapest append-only pattern: **`Grep` →
`Read` with `offset`/`limit` → `Edit` → `jq -e` → `jq -r` read-back.** *Cycle 30 used `jq -r`
projections as the primary **reading** tool for `graph.json` again — five candidate texts, the
schema, the contradiction list and the whole dependency table, for a fraction of `Read`'s cost.
A `jq`-based consumer search (`select(.summary|test("1\\.140|3\\.612"))`) found all three
affected candidates in one call; **that is the cheapest way to scope a contradiction's blast
radius** and successors should use it.*

**[25] — DISCHARGED CYCLE 21; REOPENED AND ENLARGED CYCLE 30.** `src-0007.md` contains the
`Content: Threat Actor` rubric block in full, and the two caveats keep travelling: the rubric's
**absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a
normalisation the paper never states, **re-confirmed ABSENT at c30**), so **only within-table
contrasts may be cited**; and the GPT-4o (FT) column is suspect per [19]. **WHAT CYCLE 30
REOPENS: those two caveats were never sufficient.** Having the rubric block's *values* is not
having its *definition*, and the definition was in **Appendix C.2** all along — unpulled for
fifteen cycles. **A third caveat is now required: the `Attribution` dimension means SOURCE
LINKING in the Threat Actor block and ACTOR IDENTIFICATION in the Root Cause block, so
within-table contrasts across those two blocks are NOT automatically safe either.** See [47].
*Standing lesson: "the table is captured verbatim" and "the metric is understood" are different
claims, and this base conflated them for fifteen cycles.*

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** Suggested harness fix for a human: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before reverting,
and `git stash` the rejected `state/` diff. The mechanism is fine for **crashes** (cycle 24
worked); it is blind to **validator rejections**.

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER TEN CYCLES.** src-0015's Table 1 has a
**`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5 **2.37**,
Gemini 3 2.61, DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the
lowest reward.** Bears on `automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward
composition unstated; n=40 per model, no CIs; association not strictly monotone. An observation
about an **already-collected** source, so **no new citation is needed**. Cycles 22, 26, 29 and 30
recorded it in a `rationale` or log, but **a rationale is not the graph**. Still unentered — that
issue has now lost five selections, so still nobody with standing.

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–30.** The state machine is T1→T2, T2→T3,
T3→T4, T4→T5, T5→T3. Cycle 24's T3 died before writing anything and cycle 25 re-ran it, shifting
the phase by one. Positions: **cycle 30 = T5 (this one, as predicted), cycle 31 = T3**, T5
thereafter on 33, 36, 39, **42**. The refresh fires only when a T5 **runs on** a multiple-of-7
cycle. *Cycle 30 re-derived from `config.yml`: 30 mod 7 = 2, nothing fires. Of 35 and 42, only
**42** is a T5 cycle, so **the next T1 is cycle 43** and the next T2 is **cycle 44**.* *The
single most consequential structural fact in this project: **one infrastructure failure, costing
one cycle, pushed the next collection cycle back by eight***. **Re-derive rather than trusting
this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21, 25 AND 30.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018, which
broke a blocker standing since cycle 3. **Standing lesson: read the task's own prompt file, not
only the queue entry's description of it.** *Cycle 30 read `prompts/t5_select.md` itself and
found the queue entry's account of it accurate on every point checked — **two clean handoffs in
a row** after five bad ones. The habit is still correct: the check is cheap and its failure mode
is expensive.*

**[30] — NEW cycle 20; PREDICTION CORRECT FIVE TIMES.** `automated-triage-under-refusal`, the
only issue never worked on (`attempts: []`, created cycle 16), has **lost five consecutive
selections**. **"Never attempted" is not a tie-break in `prompts/t5_select.md`**, and cycle 19's
rationale wrongly asserted it was. **This is a prompt change for a human.** Note the interaction
with [11]: **both** readings of 3a bury it — it has no dependents, so 3a eliminates it outright,
and the fallback mechanism is `created_cycle`, so **the newest issues in a graph are structurally
disadvantaged forever, with no expiry**. *Cycle 30 applied 3a as written and used "never
attempted" in **neither** direction. It sits at 2 in a five-wide bottom tier, holds the project's
top uncollected source ([15]) and an unentered observation bearing on its own central question
([27], now ten cycles old). **The cost of this defect is five selections deep and belongs in the
paper.***

**[31] — NEW cycle 21, EXTENDED cycles 22, 23, 25–30. THE VERBATIM CHECK HAS NOW RUN ON TEN
SOURCE-CHECKS; NINE PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim" quotation
**does not exist on the page**. (b) **src-0003** (c22): quotations passed, stored *numbers*
76/72/86 are **figure-image-only**. (c) **src-0002** (c23): all 25 numbers exact,
**interpretation contradicted by the paper's own metric definition**; `ctr-0002`. (d)
**src-0001** (c25): numbers exact, protocol *stronger* than recorded, **calibration gloss
contradicted by the full table**; `ctr-0003`. (e) **src-0005** (c26): all claims and quotations
**PASS** — but stored with no task format, metric definition, sample counts, limitations or
numbers. (f) **src-0017** (c27): every stored string **PASSES**, the **DOWNSTREAM PARAPHRASE**
dropped the hedges; `ctr-0004`. (g) **src-0018** (c28): every stored quotation **PASSES** — the
stored **SCOPE** is wrong, and wrong by being **TOO RESTRICTIVE**; `ctr-0005`. (h) **src-0002
again** (c28): two more glosses, one **FALSE against the printed table**, plus a
self-contradiction in the source; `ctr-0006`. (i) **src-0008** (c29): every stored quotation and
number **PASSES**, and one claim is **OVER-GENERAL** — quantified over "current LLMs" when the
paper's own fifth model refutes it; `ctr-0007`. **(j) NEW — src-0007 (c30): all 34 table rows
PASS on a third pull, and the state's reading of one row fails because THE METRIC IS DEFINED
TWICE UNDER ONE NAME. The stored numbers, quotations, scope and quantifier were all fine;
nobody had ever pulled the rubric's DEFINITION. `ctr-0008`.** **The defect class is now
nine-way: spliced quotations, unverifiable numbers, unsupported interpretive glosses, partial
table capture, correct-but-hollow entries, correct-source-corrupted-downstream,
over-restriction, over-generalisation — and now METRIC-IDENTITY (same label, two definitions).**
*Standing lesson, upgraded: **verifying a value does not verify what the value measures.**
String-matching numbers and quotations cannot catch this class at all, and neither can checking
the quantifier or the scope. **Ask what the metric is defined as, in the source's own words,
every time — and check whether the same name is defined more than once.***

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline F1
values are figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not
text-verified.** Also unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction
when the source's own legible text conflicts with the stored claim; do not file when the stored
claim is merely unverifiable.** *Cycle 30 applied it and filed `ctr-0008`: Appendix C.2 is
legible text and it conflicts with the state's reading. The rule is working and should be kept.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.**
src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted
candidate set**, not free-form extraction — *"We assume a total of 1,789 candidate indicators,
extracted using IoC Searcher"*; Figure 9's caption "… on IoC Classification." **A difference in
task format, stated by the paper.** **Companion finding: src-0003 NEVER STATES ITS MATCHING
RULE.** *Sources in this base with an unstated scoring rule: src-0003 (IoC matching), src-0007
(ATT&CK/TTP task), src-0002 (ATT&CK correctness). **Three** — and cycle 30 partially removes
src-0007's rubric from that list, since Appendix C.2 **does** state the drafting rubric's
anchors in full; what remains unstated for src-0007 is the **ATT&CK/TTP** rule, which the
cycle-31 T3 is scheduled to look for.*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE.** **A within-study design holds team, corpus, models and harness constant but does
NOT hold the scoring rule constant.** A cross-sub-task score spread is a task-difficulty fact
only if the sub-tasks are scored comparably. **The scoring rule for src-0007's ATT&CK task has
STILL never been pulled**, and neither have src-0006's per-task metric definitions. **What
restores the 4:** read `stage3_ti_drafting/ttp/` in the src-0017 repo and src-0006's metric
definitions, then state and answer the objection. `raw.githubusercontent.com` makes this a
**one-fetch job**. *Cycle 30: **the cycle-31 T3 is scheduled to execute exactly this fetch**, and
it is the reason I broke the terminal tie toward `ttp`. **And this item just got significantly
stronger:** cycle 30 found a **fifth** instance of the objection, and it is **inside the very leg
the cycle-29 T4 called immune** — the 1.140-vs-3.612 rubric contrast differences two different
metric definitions ([47]). Known non-commensurable instances: src-0017/`ctr-0004` (IoC matcher),
src-0003 (classification vs extraction), src-0005 (multi-select MCQ), src-0002 (`ctr-0006`), and
now **src-0007's own rubric against itself**. **The cycle-32 T4 must price the fifth.***

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible`
columns are **nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements
(incorrect = 100 − Plausible = **14 / 38 / 26 / 20 / 64%**) are in the graph **with their
derivation stated**; `ctr-0002` CLOSED.

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all three
steps executed. **The consequences did not stay inside the issue: see `ctr-0006` and [44].**
*Cycle 30 adds a second consequence that did not stay inside the issue: `ctr-0002`'s removal of
src-0004 left the third candidate carrying more weight, which is why cycle 29 flagged its
single-pull provenance, which is why I picked src-0007 for G2, which is how `ctr-0008` was
found. **The G2 staleness heuristic and the scoring rationales are working as a pipeline.***

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28, 29 AND 30. THE ISSUE ASKS TWO QUESTIONS AND
THE EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks
about **consistency** *and* **calibration**. Consistency-on-CTI rests on **two independent
sources** (src-0001 + src-0018, **both at temperature 0**), calibration-on-CTI on **one**
(src-0001, gpt4o only), and `ctr-0003` sits on the calibration half alone. Natural cut:
`consistency-under-repeated-query` vs `confidence-calibration-on-CTI`. **Only a T2 can split an
issue** ([12]); **next T2 is cycle 44 at the earliest.** *Cycle 30: the issue ranked **3rd** and
was removed by 3b, not by any judgement about its merit — **and under the other defensible
reading of 3b's window it would have been in the terminal tie**, i.e. one interpretive coin-flip
away from being handed to a T3 that structurally cannot fix it. Fourteen more cycles of
under-expressiveness.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27, TWICE AT 28, AND AT 30. A SINGLE FETCH'S "ABSENT" IS
NOT EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an ABSENT verdict
must be confirmed against a second URL form.** Before recording an absence check **(1)** the
abstract, **(2)** a different URL rendering, **(3)** that you fetched the file the claim actually
cites, **(4)** that the **VERSION** you fetched contains the material at all — an arXiv paper's
task list can change between versions (src-0002 v2 has no CTI-ATE task).
`raw.githubusercontent.com/<owner>/<repo>/main/<path>` returns whole files. *Cycle 30 used two
`/html` renderings and they agreed. **A refinement worth carrying: the rule should also apply to
a PARAPHRASED verdict, not just an ABSENT one.** My first fetch returned the rubric definition
as a **summary** ("1 = lowest quality") rather than verbatim anchors; only re-asking, then
re-asking again on a second rendering for **both blocks with every numbered anchor**, exposed
that the two blocks define `Attribution` differently. **A summarised PRESENT is as untrustworthy
as a bare ABSENT.***

**[39] — NEW cycle 25, SECOND INSTANCE 26, THIRD PARTIALLY CLOSED 27, VERSION AXIS ADDED 28,
FIRST VERSION CHECK RUN 29. PROVENANCE LABELS IN THIS BASE WERE SET AT COLLECTION TIME AND ARE
MOSTLY STILL UNCHECKED.** src-0001 **is peer-reviewed** — ARES 2025, Springer, DOI
`10.1007/978-3-032-00627-1_17` — and this base called it a preprint for 24 cycles. src-0005 goes
the other way: **an unreviewed preprint** whose CrowdStrike/Meta attribution rests on
recognising two author names. src-0017's `[TMLR '25]` badge against a March 2026 arXiv submission
is **unresolved and probably permanently so**. Still unchecked: src-0013 ("ICSME 2026 Research
Track"), src-0014 ("v1 preprint, no stated venue"), src-0015 ("single-author preprint").
*Cycle 29 ran the **version** check on src-0008 (`/abs` lists v1 only). **Cycle 30 did NOT run
either axis on src-0007** and says so rather than implying coverage: the two renderings it used
agreed cell for cell, which is weak evidence against version drift, but `/abs` was not fetched
and **no claim is made about src-0007's version count**. Cheap and still worth running on every
arXiv source at its next G2.*

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS,
AND THIS BASE CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "the share of
questions for which the system selects all correct options and only the correct options." 609
malware-analysis cases; 588 threat-intel-reasoning pairs from 45 reports supplied "via a set of
images". Questions **generated by Llama 3.2 90B and Llama 4 Maverick**, then human-validated;
the paper concedes both that multiple choice "does not provide a perfect proxy" and that there is
"performance bias … where the model under test is the same, or has similarities with the set of
models that were used in synthetic data generation pipelines". **(a)** Its percentages are not
commensurable with src-0002's F1 or src-0007's precision/recall. **(b)** It reports **no ATT&CK
metric at all**. **(c)** 23–34% (MA) against 43–53% (TIR) is a within-paper cross-task spread but
**NOT a controlled contrast**. **Anyone using it must state those three confounds.** *Cycle 30
notes the family resemblance to [47]: src-0005's questions were generated by models related to
those under test, and src-0007's rubric was **scored by a model under test**. **Two of the
eighteen sources have an evaluator/evaluatee entanglement, and neither was recorded at
collection time.***

**[41] — NEW cycle 26, REINFORCED 27, 28, ANSWERED IN PART BY 29, EXTENDED BY 30. THE G3 CEILING
BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS.** An honest, stingy T4 demotes
issues carrying open contradictions, which moves them *away* from the ceiling. **So the
validator's G3 check is very nearly dead code, while the prompt's subtraction rule — which every
T4 has correctly refused to apply — would fire on multiple issues today and drive them toward 0
without tripping anything.** *Cycle 29's answer: a contradiction whose content **strengthens**
the issue must not be scored as a demotion. **Cycle 30 adds a FOURTH shape.** `ctr-0008`'s
content is **neither undermining nor strengthening nor two-directional**: it **relocates** the
support (the finding survives at block level, and the specific sentence carrying it does not),
and it **discharges a separate blocker in the same stroke** (the single-pull provenance that kept
the candidate at `proposed` is now gone, per [19]). A gate keyed only to "an open contradiction
exists" cannot see any of this. **Four shapes of contradiction, one binary gate.** Cycle 30 also
notes the gate is now **reapplied** to `attribution-confident-wrong-gap` two cycles after
`ctr-0002` lifted it — so an issue can cycle in and out of a ceiling on grounds unrelated to its
merit.*

**[42] — NEW cycle 27. src-0007's RELEASED IoC MATCHER IS ONE-DIRECTIONAL, NOT TWO; `ctr-0004`
OPENED; REPAIRED BY APPEND.** The executing code is
`any(pred.lower() in gt.lower() for gt in gt_set)` — **a prediction must be a SUBSTRING OF a
ground-truth entry**. The two-directional and exact-match variants are **inside triple-quoted
string literals and never run**. **Consequence — the bias is ASYMMETRIC:** lenient toward
short/fragmentary predictions, **strict against verbose predictions**, which is the
characteristic free-form-LLM failure mode. **"Substring-permissive, inflates true positives" is
half right and must not be repeated unqualified.** **The T4 half was discharged at cycle 29.**
**The T3 half is still open: a T3 on `ioc-extraction-reliability` should rewrite the cycle-21
`open_question` and decide whether the asymmetry changes cycle 18's arithmetic on `ctr-0001`'s
METRIC confound.** *Still unread in that repo: the **ATT&CK/TTP scorer**
(`stage3_ti_drafting/ttp/`) and any **drafting-rubric/judge scorer** — the cycle-31 T3 is
scheduled to read the first and, per [47], should look for the second while it is there.*

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005`
OPENED; REPAIRED BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images —
**confirmed a third time, and that ban stands.** But the page states in plain text: a **41
min/report human-analyst baseline** against ~**3.3 min**; **17 metrics each a ratio 0–1**; and,
most importantly, **"the LLM temperature parameter was set to 0"**. **The temperature-0 fact
strengthens `consistency-calibration-as-failure-mode`** and was fenced off for three cycles by an
over-broad hedge. The page has **ten** figures, not four. **Standing lesson: a hedge is a claim
and must be scoped as precisely as an assertion.**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC; `ctr-0006` OPENED
AGAINST `ttp-attack-mapping-reliability`; REPAIRED BY APPEND IN BOTH PLACES.** **(a)** Section
4.2 says *"We adopt the **Micro-F1** score as the evaluation metric for the CTI-ATE task"*;
Table 1's header reads **"CTI-ATE (Macro-F1)"**. **0.6388's metric is ambiguous by the paper's
own text.** **(b)** The cross-task difficulty comparison is **ours** — `task difficulty` ABSENT,
`most challenging` ABSENT — and it subtracts multi-class **accuracy** from multi-label **F1**.
**(c)** key_claims[2] ("no evaluated model exceeded ~72% on any single task") is **FALSE against
Table 1** (CTI-TAA Plausible: 86 / 80 / 74). **(d)** The **ATT&CK correctness rule is never
stated**. **(e)** **arXiv v2 has NO CTI-ATE task at all** — always fetch v3 or the latest render.
*Cycle 29 priced it: that issue fell 3 → 2. **Cycle 30 selected that issue, and the T3 job named
here — rewrite the first supported candidate — is step 1 of the task I just wrote.** It is the
most concrete score-restoring action in the graph.*

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29.** `attribution-confident-wrong-gap`
**bundles a well-evidenced question with an unevidenced one, and only a T2 can fix it.** The
**error-rate** half is well grounded (src-0002's derived 14–64% incorrect bucket on 50
alias-tolerant real reports, corroborated in direction by src-0007's within-table rubric
contrast). The **confidence** half has **no evidence at all**. Natural cut:
`attribution-error-rate` vs `attribution-confidence-calibration`, the second probably merging
into whatever [37] produces. **Next T2 is cycle 44 at the earliest.** *Cycle 30 weakens the
parenthesis above and successors must not quote it unqualified: **the "within-table rubric
contrast" as stated differences two different metric definitions** ([47]). The direction survives
at block level, so the error-rate half is still the better-evidenced conjunct — but its
corroborating leg is thinner than this item has claimed since cycle 28. The cut is unchanged and
still needs a T2.*

**[46] — NEW cycle 29. src-0008 CONTAINS TWO SELF-CONTRADICTIONS AND ITS PER-PHASE NUMBERS ARE
IMAGE-LOCKED; `ctr-0007` OPENED; REPAIRED BY APPEND IN BOTH PLACES.** **(a) THE STORED CLAIM IS
OVER-GENERAL.** The paper evaluates **five** models; *"Cohere, however, shows progressive
degradation: 1% missed detections in P1, 2% in P2, 5% in P3, and in P4, 65% misses plus 35%
explicit 'Don't Know' responses"* — and **P1–P4 contain no cryptography**. So plain-text IoC
recovery is **not** near-free "for current LLMs", and **encryption is not the boundary**. The
finding **cuts both ways** and cycle 29 asserted neither direction. **(b) IT DEFINES ITS METRICS
TWICE, INCOMPATIBLY** — body *"the proportion of samples in which the model correctly identifies
the presence of an IoC"* against Table 6's caption *"ratio of YES an answers"*. **(c) PHASE
LABELS** — see [5], resolved in our favour. **(d) PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE
2**, so "roughly 0–1%" and "~95%+ misses" are **figure-derived, not text-verified**. **(e) TABLE
6 IS READABLE AND WAS NEVER CAPTURED** — DR 38.5 / 38.6 / 38.5 / 35 / 22.8%, aggregates over all
thirteen phases, **never per-phase**. **(f) PASSED:** Table 7's hallucination rates
text-confirmed exactly and the abstract verbatim. **ACTION STILL OPEN: a T3 on
`ioc-extraction-reliability` should rewrite the third candidate_resolution to state Cohere's
P1–P4 degradation, decide whether model-side variance under syntactic noise supports or undercuts
the scaffolding hypothesis, and relabel the figure-derived percentages.** *Cycle 30: that issue
was the **runner-up** in a terminal tie and this work is undone. If a future T5 faces the same
pair, this item is the strongest argument on `ioc`'s side.*

**[47] — NEW cycle 30. src-0007's "ATTRIBUTION" RUBRIC IS TWO DIFFERENT METRICS UNDER ONE NAME;
THE JUDGE IS A MODEL UNDER TEST; `ctr-0008` OPENED AGAINST `attribution-confident-wrong-gap`;
REPAIRED BY APPEND IN BOTH PLACES.** **(a) THE DEFECT.** Appendix C.2 prints separate criteria
blocks for Threat Actor and Root Cause content. In the **Threat Actor** block, *"Attribution: •
1: Information is unverified or unattributed. … • 5: Fully attributable; all details are clearly
linked to the original article."* — **source linking, and no anchor mentions identifying an
actor.** In the **Root Cause** block, *"Attribution: • 1: Completely incorrect attribution. • 2:
Significant attribution errors; misidentified threat actor. … • 5: Perfect attribution; clearly
identifies the threat actor."* — **actor identification.** **So the state's load-bearing
"within-table contrast" (1.140 against 3.612) differences two different metrics, and the labels
run OPPOSITE to how the state read them: the cell taken as the actor-attribution deficit is the
one that is not about identifying an actor.** Confirmed on two URL renderings with all anchors.
**(b) WHAT SURVIVES:** the **block-level** contrast — GPT-4o lower on **all six** dimensions for
Threat Actor content (1.547 / 1.528 / 1.145 / 2.019 / 1.734 / 1.140) than Root Cause
(3.686 / 3.458 / 3.362 / 3.932 / 3.753 / 3.612) — so "a sub-task-specific deficit, not a general
inability to draft" holds, **via the block, not the row**, with the caveat that the two blocks'
anchors are worded differently. **(c) THE JUDGE IS GPT-4o**, one of the four scored models:
Appendix C.2, *"We evaluate the results using GPT-4o based on the criteria provided for each
task"*; Section 4.1, *"we employ the LLM-as-Judge paradigm"*. **In the source's favour**, Section
4.1: *"an agreement rate between the LLM-as-Judge and human experts exceeding 95%"*. **Direction
matters and cuts against the easy reading**: self-preference would inflate GPT-4o's own scores,
and GPT-4o scores **lowest**, so it does not explain the deficit. **Any citation of the
GPT-4o-vs-o3-mini gap must state that GPT-4o was the judge.** **(d) THREE CANDIDATES AFFECTED,
found with one `jq` `test()` query:** `attribution-confident-wrong-gap`'s third (the direct
subject); **`task-dependent-reliability-framing`'s** level-3 leg that the cycle-29 T4 called
**immune** to the non-commensurability objection ([34]) — **the largest scoring exposure, for the
cycle-32 T4**; and **`extraction-vs-reasoning-ordinal-axis`'s route 2**, which uses 1.140 as an
*attribution-rung* score. **(e) A LIVE STATUS QUESTION:** the third candidate's stated reason for
being `proposed` was the single unreplicated cycle-15 pull, and **that is now discharged** ([19]),
so a T3 must decide its status on the metric-definition ground instead. **(f) ACTION — a T3
should:** rewrite the third candidate to the block-level formulation; carry the correction into
the other two issues rather than only this one; record the judge identity with its >95%
calibration wherever the model gap appears; and, while reading `stage3_ti_drafting/ttp/` for
[34]/`ctr-0006`, **look for a drafting-rubric or judge scorer in the same artefact** — it is the
one thing that would show whether the two `Attribution` dimensions are implemented as
differently as they are documented.
