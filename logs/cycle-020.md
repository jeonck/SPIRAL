# Cycle 020 — T5 (Select)

## Task performed

T5 per `prompts/t5_select.md`: apply the selection policy mechanically to the eight scored
issues, record an auditable ranking, and write the next task.

**Outcome: `ioc-extraction-reliability` is selected, and the next task is a T3.**

This **overturns the expectation set by cycle 19**, which asserted in `scores.json` that
`automated-triage-under-refusal` "is the unique weakest link" on the configured tie-break,
and by the queue entry I was handed, which framed the choice as a tie I would have to break
on my own judgement. Neither is right: the tie **is** broken deterministically, by the
prompt's own rule 3c, and it resolves the other way. Cycle 19 stopped at rule 3b and never
reached 3c. Details and the correction are below; I am reporting it plainly rather than
deferring to the handoff, because the handoff explicitly told me not to spend budget
re-deriving what it had settled, and re-deriving it is what caught this.

---

## Retrospection (G2)

**Target: src-0015** (`OpenSec: Measuring Incident Response Agent Calibration Under
Adversarial Evidence`), the recommended target from the handoff and one of only two sources
under the graph's weakest-scored issue. **Never previously G2-verified** (coverage list,
carry-forward [8]).

**Result: PASSED, with strengthening. No contradiction opened.**

Per the methodological rule ([2] in the handoff / the standing verbatim rule), I issued a
single fetch to `https://arxiv.org/html/2601.21083v3` carrying **both** a whole-table
transcription request **and** a nine-string verbatim search list, with an explicit
instruction to answer `ABSENT` / `CANNOT READ TABLE` rather than infer. One call, both
jobs — the cycle-19 economy, and it worked again.

Table 1 returned whole, cell for cell:

| Model | Reward | Cont. | FP | EGAR | TTFC | Threshold |
|---|---|---|---|---|---|---|
| GPT-5.2 | 3.07 | 1.00 | 0.825 | 0.375 | 4.1 | Uncalib. |
| Sonnet 4.5 | 2.37 | 0.625 | 0.45 | 0.392 | 10.6 | Part. Cal. |
| Gemini 3 | 2.61 | 0.75 | 0.575 | 0.429 | 8.6 | Part. Cal. |
| DeepSeek 3.2 | 3.45 | 0.925 | 0.65 | 0.542 | 9.0 | Part. Cal. |

Every figure the handoff asked me to check is **exact**: false-positive rates 82.5 / 65 /
57.5 / 45 %, containment 100 / 92.5 / 75 / 62.5 %, EGAR 0.375 / 0.392 / 0.429 / 0.542. All
nine verbatim strings returned PRESENT with their full sentences, including the mechanism
quote ("the calibration gap is not in detection but in restraint"), the EGAR definition, the
uncalibrated/partial-calibration classifications, and the seed counts (160 training / 60
evaluation, 20 trivial / 20 easy / 20 standard). Title and sole authorship (Jarrod Barnes)
confirmed; **affiliation ABSENT**, confirming the provenance caveat recorded at collection
rather than merely repeating it.

**Correction to the handoff, minor and in the source's favour.** The queue entry and
carry-forward [8] both state that src-0015's figures "rest on a single abstract-page fetch"
because its index URL is an `/abs` page. That is not what `state/knowledge/src-0015.md`
says: its Table 1 block is explicitly attributed to a fetch of `/html/2601.21083v3` at
collection time. So this was a second independent pull of that table, not a first — which
is a *stronger* verification result than the one that was asked for, since two pulls on
different cycles returned identical cells.

**New material this pull produced, not previously in the state.** The stored Table 1
reproduction omits two columns that exist in the printed table: **`Reward`** and
**`Threshold`**. The Threshold column simply restates the calibration classification. The
Reward column is substantive and nobody has recorded it:

- Sonnet 4.5, the model the paper itself singles out as the best-calibrated of the four
  (lowest FP at 0.45, longest TTFC at 10.6), earns the **lowest reward in the table**, 2.37.
- The two highest-containment models take the two highest rewards (DeepSeek 3.2 at 0.925
  containment → 3.45; GPT-5.2 at 1.00 → 3.07), and the two lowest-containment models take
  the two lowest (Gemini 3 → 2.61; Sonnet 4.5 → 2.37). The ordering is not strictly monotone
  in containment — DeepSeek outscores GPT-5.2 — but the rank association is strong and the
  direction is unambiguous.

**Why this matters beyond bookkeeping, and what I am deliberately NOT doing with it.** This
bears directly on `automated-triage-under-refusal`'s `open_questions[0]` — the issue's
stated central unknown, whether over-acceptance is a property of the **models** or of the
**harness**. A reward function under which the model that shows restraint finishes last is
evidence on the harness side of exactly that question, from the very source the issue rests
on. But: the fetched material does not state the reward's composition, n is 40 episodes per
model with no confidence intervals, and adjacent-model differences are already flagged as
unresolved at collection. And **a T5 has no standing to enter claims into the state.** So it
is recorded here and carried forward as **[27]** for the cycle that works that issue, not
written into the graph. It is an observation about an already-collected source, so no new
citation is required when a future cycle does use it.

---

## Changes made

Selection work only. No edits to `state/knowledge/` or `state/issues/`; per the T5 prompt,
this step selects and does not do the T3's work.

- `logs/cycle-020.md` (this file).
- `state/queue/next_task.json` — T3 targeting `ioc-extraction-reliability`, `attempt_count`
  0. Validated with `jq -e`.
- `state/queue/last_completed_task.txt` — `T5 select`.

---

## Next task rationale

### Step 0 — refresh rule

`config.yml` sets `collect_refresh_every: 7`. `20 % 7 = 6 ≠ 0`, so the refresh rule does not
fire and **the next task is a T3**, not a T1. This matches the handoff and I did not
re-derive the phase.

**But the handoff's forward projection is wrong and I am not propagating it.** Both the
queue entry and carry-forward [17] state that "cycle 21's T5 is the next refresh" and that
"the next T2 is due cycle 23". Cycle 21 is **not** a T5. The state machine is T5→T3, so
cycle 21 is the T3 I am writing, cycle 22 is a T4, and cycle 23 is the next T5 — and
`23 % 7 = 2`, so the refresh does not fire there either. Running the three-cycle T3/T4/T5
loop forward, T5 lands on cycles 20, 23, 26, 29, 32, 35 — and the next multiple of 7 among
them is **cycle 35**. Carried forward as **[28]**, because the consequence is not small:
under a clean loop the next T1 (and therefore, via [17], the next T2) is roughly fifteen
cycles away, and the two highest-value uncollected items in the project (the curl/HackerOne
case, [15]; the human-analyst ATT&CK baseline, [10]) both need a T1. This projection is
itself contingent — a failed-validation retry shifts the phase by one, which is exactly how
the phase reached its current position (cycle 17's T3 failed and was retried at 18).

### Step 1 — candidate set

All eight issues score < 5. No issue is excluded.

### Step 2 — ruling on rule 3a, which I had to make before I could rank

Carry-forward [11] flags that rule 3a ("an issue that others `depend_on` outranks its
dependents") admits a **strict pairwise** reading and an **in-degree** reading. It binds
this cycle, and it is not cosmetic: the three issues tied at the bottom score have in-degrees
of 2 (`consistency-calibration-as-failure-mode`), 1 (`ioc-extraction-reliability`) and 0
(`automated-triage-under-refusal`), so under the in-degree reading
`consistency-calibration-as-failure-mode` would win 3a outright and be selected **before the
attempt penalty is ever consulted** — the opposite of what cycles 16 and 19 both assumed.

**I rule for the strict pairwise reading**, on two grounds:

1. **Textual.** The rule says an issue outranks *its* dependents — a possessive, relational
   construction. It orders an issue against the issues that actually depend on it. It does
   not say "an issue with more dependents outranks an issue with fewer", which is what the
   in-degree reading requires it to mean.
2. **Coherence.** `consistency-calibration-as-failure-mode` has the graph's highest
   in-degree. Under the in-degree reading it would win essentially every tie it ever enters,
   permanently, and rule 3b — the anti-thrashing attempt penalty — could never reach it.
   That issue has three attempts, two inside the penalty window. A reading that renders the
   anti-thrashing rule inoperative on the most-attempted issue in the graph cannot be the
   intended one.

Under this reading, none of the three tied issues depends on another (all three have
`depends_on: []`), so **3a is silent within the tied set** and ranking passes to 3b.

### Step 3 — the ranking table

Penalty window at cycle 20 = cycles 15–19 inclusive, at
`tie_break_recent_attempt_penalty: 1` per attempt inside it. All inputs read from
`state/issues/graph.json` and `state/assessments/scores.json` via `jq`, not from the
handoff's summary.

| Rank | Issue | Score | 3a (pairwise) | Attempts | 3b penalty | 3c created | Result |
|---|---|---|---|---|---|---|---|
| **1** | **ioc-extraction-reliability** | **2** | silent | [9] | **0** | **2** | **SELECTED — wins on 3c** |
| 2 | automated-triage-under-refusal | 2 | silent | [] | 0 | 16 | lost on 3c (created 16 > 2) |
| 3 | consistency-calibration-as-failure-mode | 2 | silent | [3,15,16] | 2 | 2 | eliminated at 3b |
| 4 | institutional-incident-real-world-impact | 3 | silent | [12] | 0 | 2 | tier not reached |
| 5= | ttp-attack-mapping-reliability | 3 | silent | [16] | 1 | 2 | tier not reached; **3c ties** |
| 5= | attribution-confident-wrong-gap | 3 | silent | [16] | 1 | 2 | tier not reached; **3c ties** |
| 7 | extraction-vs-reasoning-ordinal-axis | 3 | silent | [17,18] | 2 | 16 | tier not reached |
| 8 | task-dependent-reliability-framing | 4 | silent | [6,16] | 1 | 2 | tier not reached |

Notes on the table, for the paper's evaluation data:

- **The selection is decided entirely within the score-2 tier**; tiers 3 and 4 are ranked
  above only for completeness and were never reachable.
- **Rule 3c decided this cycle, and it decided cleanly.** After 3b eliminates
  `consistency-calibration-as-failure-mode` (penalty 2 against 0), the remaining pair is
  `ioc-extraction-reliability` (created cycle 2) and `automated-triage-under-refusal`
  (created cycle 16). "Older `created_cycle` first" is unambiguous: **2 < 16**. The proposed
  rule 3d from [11] never fires, and the handoff's prediction that I would "reach 3c
  undecided" is simply not what happens.
- **This is a correction to cycle 19's `scores.json`, which I am recording rather than
  softening.** Both new-score rationales written at cycle 19 close with a "SELECTOR NOTE"
  asserting that `automated-triage-under-refusal` is "the unique weakest link" "on the
  configured tie-break". It is not: those notes reason from score and attempt penalty and
  never apply rule 3c, which is the rule that actually resolves the pair. The observation
  that motivated them — that this is the only issue in the graph that has never received a
  single cycle of work — is **true and important**, but it is not a tie-break the policy
  contains. Reading a genuine asymmetry back into the rules is a subtle failure mode and
  worth naming as such. No state edit is needed: rationales are historical records and the
  append-only discipline applies; the number itself (2) is not in dispute.
- **Rank 5 is a genuine unbroken tie** and demonstrates that [11]'s gap is real even though
  it did not bind here: `ttp-attack-mapping-reliability` and `attribution-confident-wrong-gap`
  match on score (3), 3a (silent), 3b (1 each) and 3c (both created cycle 2). Had the
  selection reached that tier it would have exhausted the policy. Under [11]'s suggested 3d
  (longest since new evidence, then fewest attempts) both last received evidence at cycle 16
  and both have one attempt, so **even 3d would not break it** — a stronger statement of the
  gap than [11] currently records. Folded into [11].

### Step 4 — why the selected issue is a good target on the merits, not merely by rule

I checked that the mechanical answer is not a perverse one, and it is not.
`ioc-extraction-reliability` carries **`ctr-0001`, the graph's only open contradiction**,
opened at cycle 9 and now **eleven cycles old**. Per carry-forward [7] and cycle 19's [A],
that single contradiction is the sole reason the G3 ceiling apparatus is exercised in this
project at all — and per the same entries the G3 specification is itself three-ways
inconsistent ([4]) and its divergence is *silent* precisely because this issue's merit score
sits below the ceiling. Resolving or dissolving `ctr-0001` retires that whole apparatus.
The issue is also ten cycles stale (last attempt cycle 9, the longest gap of any issue in
the graph), and cycle 18 left it with a **sharpened, near-testable hypothesis**: the metric
confound would require an IoC recall of 0.09–0.15 that no source reports, so the **system**
confound (LANCE's regex + LLM + human-validation scaffolding versus src-0007's Table 4
headed "Vanilla LLMs") is the live explanation, and `ctr-0001` is more likely to **dissolve**
into the third candidate than to be a real disagreement. That is a well-posed target, not a
fishing expedition.

`automated-triage-under-refusal` is the clear runner-up and I have written it into the T3's
handoff as the next target, along with the G2 finding above ([27]) that materially advances
its central open question.

### Step 5 — a correction that changes what the next T3 may do

**The queue entry I was handed states, in capitals, "A T3 may not add sources." That is
wrong.** `prompts/t3_investigate.md` step 2 reads: "Only web-search for what the knowledge
base cannot answer (and if you fetch something substantial, add it properly as a source per
T1 rules — it counts toward the same `max_new_sources` budget)." A T3 **may** add sources,
subject to T1 rules and the `max_new_sources: 5` budget.

This is not a technicality — it is decisive for the task I am writing. `ctr-0001`'s
resolution path ([7]) is *recover recall/F1 from src-0007's released code on
GitHub/HuggingFace, or find a head-to-head*. Under the handoff's false constraint that path
would be closed to a T3 and the task would be near-pointless; under the actual rule it is
open. Carried forward as **[29]**. Fifth handoff defect of this kind in the project's
history, which is the pattern [8]/[26] and the carry-forward section exist to catch.

---

## Budget

- Fetches: **1** (the G2 pull of `arxiv.org/html/2601.21083v3`, carrying both the whole-table
  transcription and the nine-string verbatim search in one call).
- Web searches: **0**.
- `jq` invocations: 5 (issue attempts/created/depends_on; contradictions; source URLs;
  two issue dumps) plus validation of the written JSON.
- File reads: 8 (`next_task.json`, `meta.json`, `config.yml`, `scores.json`, `src-0015.md`,
  `prompts/t3_investigate.md`, and two slices of `logs/cycle-019.md`).
- Turns: roughly 12 of the 50 budgeted. Well under; the single-fetch G2 pattern and reading
  the graph through `jq` rather than whole-file Reads are where the saving comes from.
- One bash call was refused for compounding an unapproved segment (`awk`), re-run as `Grep`.
  Consistent with [24]: the permission layer is not uniform by command class.

---

## Carry-forward items

All items from `logs/cycle-019.md` reproduced **including those I could not act on**, with
cycle-20 updates. Discharged items stay marked rather than deleted. **Four handoffs have now
lost or corrupted state** (cycle 11 dropped [8] and [9]; cycle 14 found [12]'s central claim
factually wrong; cycle 17's entire `state/` output was reverted) — **and this cycle found two
more defects in the handoff it was given, [28] and [29]**, so this section is load-bearing,
not a formality.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim
stayed; ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2
candidate moved verbatim. Vindicated numerically at cycle 19 (4 and 3 respectively — two
numbers no single score could express).

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`. The
graph now records a three-team claim. It did **not** move the score; the blocker is
`open_question[1]`, the missing human-analyst baseline. See [10].

**[3] — DISCHARGED cycle 16.** New issue `automated-triage-under-refusal`. First-scored at
cycle 19 (2). *Cycle 20 note: it is the **runner-up**, not the selection — see the ranking
table and [30].*

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED.** The G3 gate is specified three ways:
`prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35 comment
(**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3 under current
config). The enforced reading is in the minority. Cycle 16 ruled for the **CEILING**;
replacement text is in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`,
`config.yml`, `scripts/` are outside this agent's output surface. **Until a human applies it,
T4s must keep applying the ceiling.** *Cycle 20 note: the divergence stays silent only while
`ioc-extraction-reliability` scores below the ceiling. **The T3 I just scheduled targets
exactly that issue**, so if it raises the score toward 3 the two readings begin to diverge
observably — and if it closes `ctr-0001` the gate stops applying at all. This item is closer
to mattering than it has been in ten cycles.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6,
the paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no
contradiction opened. Needs a PDF-level check, blocked by [14]. Its per-phase percentages
exist ONLY as pie charts (Figure 2); its Table 7 hallucination rates (Anthropic 0.11%,
ChatGPT 0.23%, Gemini 4.8%, Grok 0, Cohere 0) are verified exact and their "approximate"
caveat can be lifted. *Cycle 20 note: src-0008 is one of the three sources under the
selected issue's scaffolding candidate; the T3 may touch it.*

**[6]** Unfinished search directions, open since cycle 9: citation-graph sweep of arXiv
2506.11325; third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal
baselines; the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no
preprint located). **Forward-citation sweeps have FAILED on two different arXiv ids —
unavailable infrastructure, not an unsearched direction.** Cycle 17's three topical leads
stand and are **unclaimed**: **SEvenLLM** (`arxiv.org/pdf/2405.03446`, 28 CTI tasks split 13
understanding / 15 generation), **AthenaBench** (no URL captured), **CTIArena** (no URL
captured). Leads, NOT sources; none is in `index.json` and none may be cited. *Cycle 20
note: the first two directions here are squarely on the selected issue and are now live work,
not backlog.*

**[7] — NOW THE ACTIVE TASK.** `ctr-0001` RESOLUTION PATH: recover recall/F1 from src-0007's
released code (GitHub/HuggingFace per its abstract), and/or find a source running an
unscaffolded LLM against PRISM or a LANCE-style pipeline against CyberThreat-Eval. Cycle 15's
full Table 4 pull confirmed there is no recall or F1 row for IoC Extraction anywhere in that
table — **do not re-pull it hoping for one.** Cycle 18: an IoC recall low enough to reconcile
the two sources by metric artefact alone would be 0.09–0.15, so **the metric confound is
weaker than the system confound**. *Cycle 20 note: this is the only open contradiction in the
graph, it is **eleven** cycles old, and cycle 20's T5 selected its issue. **[29] establishes
that a T3 MAY add sources**, so the code-release route is open to the cycle-21 T3 — under the
handoff's mistaken reading it would have been closed.*

**[8] — UPDATED cycle 20.** G2 RE-VERIFICATION COVERAGE: src-0004 (c4, c12), src-0003 (c5),
src-0002 (c6), src-0001 (c7), src-0006 (c8; c17 PARTIAL FAIL, see [21]; re-pulled c18),
src-0005 (c9 substance-only, c11 verbatim), src-0008 (c10), src-0012 (c13), src-0011 (c14),
src-0007 (c15 — PASSED), src-0009 and src-0010 (c16 — PASSED), src-0013 (c18 — PASSED),
src-0014 (c19 — PASSED), **src-0015 (c20 — PASSED, with strengthening; see Retrospection —
Table 1 returned identical to the collection-time pull, all figures exact, plus two
previously uncaptured columns)**. **Never verified: src-0016 only** (`snyk.io` blog, the base's
only non-arXiv, non-institutional technical source — and the only one whose publisher sells a
product in the domain it measures). **src-0016 is now the priority for the next G2.**
*Correction to this item as inherited: it claimed src-0015's figures rested on "a single
abstract-page fetch". `src-0015.md` attributes its Table 1 to `/html/2601.21083v3` at
collection, so cycle 20 was a second independent pull, not a first.* Not recommended next:
src-0015 (c20), src-0014 (c19), src-0013 and src-0006 (c18).

**[9] — CORRECTED cycle 18, re-confirmed cycles 19 and 20.** `python3` is present at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks
every invocation; compound/piped commands are rejected if any segment is unapproved (cycle 20
lost one call by compounding `awk`). **No PDF text extraction exists** — poppler-utils,
`mutool`, `gs`, `qpdf` all absent; `WebFetch` returns PDF bytes undecoded. **See [24]: `jq` IS
available and approved**; keep its arguments inside the repo.

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Every claim it contributes is
abstract-level and directional, and it is one of the sources holding
`ttp-attack-mapping-reliability` at 3. **Oldest un-actioned collection task in the project
(open since cycle 1); T1 work.** A T1 targeting that issue should hunt the **human-analyst
baseline F1** first (the actual level-4 blocker) and src-0005's numbers second. *Cycle 20
note: needs a T1, and per [28] the next T1 may be ~15 cycles away.*

**[11] — APPLIED AND EXTENDED cycle 20.** TIE-BREAK 3a IN `prompts/t5_select.md` IS
UNDER-SPECIFIED, with no deterministic tie-break after 3c. *Cycle 20 ruled for the **strict
pairwise** reading, on textual grounds ("its dependents" is relational, not a count) and
coherence grounds (the in-degree reading would let the highest-in-degree issue win every tie
forever and would render the anti-thrashing rule 3b inoperative on the most-attempted issue in
the graph). **Applied as reasoning, not written into `prompts/`**, per cycles 11/14/16.* The
suggested fix for a cycle with standing remains: add "**3d. longest time since the issue last
received new evidence; then fewest total attempts**" — note that ordering. **New cycle-20
finding: 3d as proposed is not sufficient.** `ttp-attack-mapping-reliability` and
`attribution-confident-wrong-gap` tie on score, 3a, 3b **and** 3c, and they also tie on *both*
limbs of the proposed 3d (both last received evidence at cycle 16, both have one attempt). A
terminal deterministic tie-break — e.g. lexicographic issue id — is needed for closure. Same
class as [4].

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger
claim was WRONG; see [17].** T2 is the only task type with standing to split an issue, add an
issue, or reconcile the prompt/validator disagreement. The claim that the loop "never returns
to T2" is false; cycle 16 disproved it. *Cycle 20 note: but see [28] — the correct projection
makes the path narrower than cycle 19 believed, not wider.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel
is the upstream primary for the entire ENISA incident: a permanent structural gap. The
archived-PDF footnote-count route is also closed (see [14]). Prof. Christian Dietrich's /
Institut für Internet-Sicherheit's own writeup is the only remaining route known to this agent.

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA
v1.2 PDFs cannot be opened. **Consequence: "ENISA never disclosed the AI use" is established at
landing-page level and UNVERIFIABLE at document level here**, and was treated as *unestablished
rather than pending* at cycle 19. That leg **cannot strengthen**. **Do not re-spend budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET.** The curl/HackerOne
case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop" reports; ~20% of
submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to under 5%)
is an **open_question on `automated-triage-under-refusal`**. **It is a question, not evidence —
no curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycle 19 judged it **the highest-value uncollected source in the project**. *Cycle 20 note: two
changes. (a) Per [29] a **T3 may add sources**, so the cycle-21 T3 could in principle collect
it — but its target issue is `ioc-extraction-reliability`, and a T3 must serve its own target,
so it should not. (b) Per [28] the next scheduled T1 may be ~15 cycles out. If a human wants
this collected soon, the queue is the lever.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question any cycle has found. Verbatim from `https://gptzero.me/investigations/ey`:
an "automated pipeline to search for vibe citations by finding and scanning public reports from
major consulting firms", releasing findings "one report at a time", having already investigated
"a government publication, two different Deloitte reports, and prestigious machine learning /
artificial intelligence conferences like NeurIPS and ICLR". A T1 should chase
`gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor reporting on its
own product's value; no *rate* published; the scorecard widget renders as "0 of N" to automated
fetch — read body text, not the widget. **Still the only route any cycle has found to a base
rate**, the binding constraint on `institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** THE REFRESH RULE IS THE
ESCAPE TO T2: `prompts/system.md` specifies `T1→T2`, and the refresh rule makes a T5 landing on
a multiple-of-7 cycle emit a T1, so the chain is **T5 → T1 → T2**. Confirmed end-to-end by
cycles 14→15→16. The **phase** claim is right (the T5 that *runs on* a multiple-of-7 cycle
emits the T1). **The forward projection appended at cycle 19 is wrong**: it asserted "cycle
21's T5" and "next T2 due cycle 23", but cycle 21 is a **T3**. Structural finding for the paper
stands and is now sharper: the only task type that can restructure the issue graph fires when a
T5 coincides with a multiple of 7, which under a clean three-cycle loop is **once every 21
cycles**, not every 7.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS
exhibiting the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid
citations across 308 papers. No claim in our base repeats the error and **no G3 entry was
opened**. Any cycle quoting src-0011's *counts* should take them from Table 3's columns.

**[19] — DISCHARGED cycle 16, BUT ITS RESIDUE IS LOAD-BEARING.** src-0007's Table 4 Content:
Threat Actor rubric block attached to `attribution-confident-wrong-gap` as a **`proposed`**
candidate. **The FT-column anomaly is preserved as a re-pull instruction**: GPT-4o (FT)
3.964/3.655/2.967 tracks o3-mini 3.964/3.656/2.968 to within 0.001 on all three rows. Still
uncaptured from that table: the Deep Search URLs-Extraction block (GPT-4o 6.22 avg URLs vs
GPT-4o-mini-FT 1.25) and **the full Triage pass-rate/bias rows** — the single most valuable
uncaptured table block in the base, since the 0.27–0.40 vs 0.90–1.00 asymmetry carrying
`automated-triage-under-refusal`'s score has never itself been through a verbatim table pull.
*Cycle 20 note: still uncaptured. The cycle-21 T3 targets a different issue but **will be
fetching src-0007 anyway** for the recall/F1 question, so the T3 instructions ask it to pull
the Triage rows opportunistically in the same call — a near-free discharge if it happens, and
explicitly not a requirement.*

**[20] — DISCHARGED FOR src-0013 (c18), src-0014 (c19) AND src-0015 (c20); ONE REMAINS.** Of
the four sources added at cycle 15, only src-0015 had a table pulled whole at collection —
**and cycle 20 has now re-pulled it independently and identically, so it is doubly confirmed**,
with two previously uncaptured columns recovered ([27]). src-0013 is confirmed at table level;
its FT discrepancy is **narrowed but not closed** — 33.9% is TABLE II's per-model aggregate,
16.9% → 83.2% is the SALLM-to-repository comparison; different scopes, not arithmetically
reconcilable, so **quote them only with their scopes named**. Gemini's 0.161 → 0.721 was **not**
re-checked. **Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are still
body-sentence-only.** **src-0016 has never been verified — it is the last one.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18.** `src-0006.md` and
`index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 for a specialized agent vs.
0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak
is **G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly
0.20–0.90" against a true span of **0.286–0.882**. Cycle 18 **APPENDED** a corrective key_claim
to src-0006's `index.json` entry — permitted, since `scripts/validate_state.py` lines 105–107
error only on *removal* and the URL liveness check at line 125 runs only for sources absent from
the previous index. `src-0006.md` itself is still untouched and still contains the wrong
sentence. **Column split: 8 general (G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC,
CB0, ZYS, LLY, CBS, SPT, DHT).**

**[22] — REPRODUCED A THIRD TIME cycle 18.** AN UNEXPLAINED REGULARITY IN src-0006's TABLE 2:
eleven of twenty-eight rows are **strictly monotone decreasing across all eight general-purpose
columns in exactly the printed column order**, with smooth decrements. Four are in the nine-row
F1 subset `extraction-vs-reasoning-ordinal-axis` depends on. For independent measurements one
row matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch
artefact** — three pulls across two URL forms return identical cells. Cause unknown; do not
speculate. **Any finding resting on src-0006's Table 2 must carry a robustness check excluding
these rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.**
`task-dependent-reliability-framing`'s supported candidate cites src-0006's "F1/AUC roughly
0.20–0.90" as evidence that reliability varies sharply by sub-task. Mean between-**model** range
within a task (0.272) and mean between-**task** range within a model (0.263) are equal to within
0.009. **This does NOT negate the supported claim** — cycle 19 tested it as a counterargument
when raising that issue to 4 and concluded it is not one. It qualifies the implication that
sub-task is the *privileged* explanatory variable, which lives in the child issue. A T2 should
annotate the parent's candidate rather than re-scope it. No contradiction entry: both facts hold
simultaneously.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19 and 20. `jq` IS INSTALLED AND APPROVED.**
`jq -e . <file>` parses and exits non-zero on malformed JSON; `jq -r '<filter>'` reads structure
without a full-file Read. **Every cycle from 9 to 17 recorded that this agent cannot validate
JSON and must check "by construction". That advice is wrong and it is expensive** — cycle 17
made five blind edits to a 57 KB JSON file and had its entire `state/` output reverted. **Every
JSON edit should be followed by a `jq -e` check.** The permission layer is **not uniform**:
`grep -n` refused at cycle 18; `jq` on `/dev/null` refused at cycle 19 as a **path** violation
while approved on every repo file; a compound call containing `awk` refused at cycle 20. **Probe
once; don't infer from class.** *Cycle 20 note: reading the issue graph through `jq -r` filters
instead of Reading the 57 KB file is also the main reason this cycle used ~12 turns of 50.*

**[25] — NEW cycle 18, STANDS.** `state/knowledge/src-0007.md` DOES NOT CONTAIN THE RUBRIC
VALUES **THREE** ISSUES NOW DEPEND ON. Its Table 4 reproduction stops before the Content: Threat
Actor rubric block and records those rows only as "existing, not summarised". The values (GPT-4o
1.547/1.528/**1.140**, o3-mini 3.964/3.656/**2.968**) live only in `logs/cycle-015.md` line 157
and in issue prose. Correctly attributed and double-checked at cycle 16, so not a G1 violation —
but a source file omitting numbers its dependents rely on is a real gap, same shape as [21]. The
rubric's **absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs
(x−1)/4, a normalisation the paper never states), so only *within-table contrasts* may be cited;
fold that into any append. *Cycle 20 note: the cycle-21 T3 is fetching src-0007 and is asked to
append opportunistically if the block returns — [29] confirms it has standing to write to the
knowledge base.*

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's errors to
stdout, but `logs/cycle-017-transcript.txt` captures the agent's own output only, and the
reverted `state/` files were never committed. Most likely cause is malformed JSON — a class [24]
now makes cheaply avoidable — but **no cycle can confirm it**. Suggested harness fix for a human:
have `run_cycle.sh` tee `python scripts/validate_state.py` output into
`logs/cycle-NNN-validation.txt` before reverting, and `git stash` the rejected `state/` diff
rather than discarding it. Without that, a failed cycle destroys the evidence needed to stop it
recurring, and `max_task_attempts: 3` means the third such failure abandons the task outright.

**[27] — NEW cycle 20, from this cycle's G2.** src-0015's Table 1 has a **`Reward`** column that
no cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61, DeepSeek 3.2 **3.45**.
**The model the paper itself calls best-calibrated earns the lowest reward in the table**, and
the two highest-containment models take the two highest rewards. This bears directly on
`automated-triage-under-refusal`'s `open_questions[0]` — models versus harness — because a reward
signal that pays for acting is evidence on the harness side, from the issue's own load-bearing
corroborator. **Caveats that must travel with it:** the fetched material does not state the
reward's composition; n = 40 episodes per model with no CIs; the association is not strictly
monotone (DeepSeek outscores GPT-5.2 at lower containment); and per src-0015's own limitations,
adjacent-model differences are unresolved. **Not entered into the state — a T5 has no standing.**
It is an observation about an already-collected source, so **no new citation is needed** when a
cycle working that issue uses it. Also uncaptured: the `Threshold` column (it merely restates the
calibration classification).

**[28] — NEW cycle 20. THE INHERITED SCHEDULE PROJECTION WAS WRONG.** Cycle 19's queue entry and
[17] both stated "cycle 21's T5 is the next refresh" and "next T2 due cycle 23". **Cycle 21 is a
T3** — the state machine is T5→T3. Running it forward, T5 lands on cycles 20, 23, 26, 29, 32,
**35**, and 35 is the next multiple of 7 among them, so **the next T1 is ~15 cycles away and the
next T2 after that**. Contingent: a failed-validation retry shifts the phase by one, which is how
the phase reached its current position (cycle 17's T3 failed, retried at 18). **Consequence for a
human:** the two highest-value uncollected items in the project ([15] curl/HackerOne, [10] the
human-analyst ATT&CK baseline) both need a T1 and neither will get one on the current schedule
for a long time. If that is not intended, either `collect_refresh_every` or the refresh rule's
phrasing needs a human's attention.

**[29] — NEW cycle 20. A T3 *MAY* ADD SOURCES; the inherited queue entry said in capitals that it
may not.** `prompts/t3_investigate.md` step 2: "Only web-search for what the knowledge base cannot
answer (and if you fetch something substantial, add it properly as a source per T1 rules — it
counts toward the same `max_new_sources` budget)." Adding is permitted, subject to T1 rules, G1,
and `max_new_sources: 5`. **This is decisive, not pedantic:** `ctr-0001`'s resolution path ([7])
*requires* fetching src-0007's released code or a head-to-head study, which the false constraint
would have forbidden. Fifth handoff defect in the project's history. **Standing lesson: read the
task's own prompt file, not only the queue entry's description of it.**

**[30] — NEW cycle 20. RUNNER-UP, for the T5 at cycle 23.** `automated-triage-under-refusal`
(score 2, `created_cycle` 16, **attempts `[]` — the only issue in the graph never worked on**)
lost this cycle's selection to `ioc-extraction-reliability` **only on rule 3c**, older
`created_cycle` (2 vs 16). It will lose 3c again at every future tie unless its score drops below
2 or the selected issue's score rises — which the cycle-21 T3 may well cause. **Two things now
sit ready for it:** [27]'s reward-column finding, which is direct evidence on its stated central
open question; and [19]'s Triage pass-rate/bias rows, the uncaptured verbatim pull its whole score
rests on. Note also the structural asymmetry the policy does **not** encode: "never attempted" is
not a tie-break in `prompts/t5_select.md`, and cycle 19's `scores.json` rationale wrongly asserted
it was ("the unique weakest link ... on the configured tie-break"). If a human thinks never-worked
issues should be favoured, that is a prompt change, not a reading of the current rules.
