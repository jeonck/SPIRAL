# Cycle 048 — T5 (Select)

## Task performed

**T5 — Select (weakest link)**, per `prompts/t5_select.md`, which I read in full at source
rather than trusting the queue entry's account of it.

**Phase verified before acting**, per the standing lesson from cycles 31–32 and the three
aborted cycles (38, 40, 44). `state/queue/last_completed_task.txt` read `T4 assess`;
`scores.json` read `last_assessed_cycle 47` with `assessed_cycle 47` on all nine entries and
`attribution-expressed-confidence-unmeasured` at 1; `git show --stat HEAD` showed cycle 47
touching `scores.json`, `graph.json`, `index.json` and `src-0020.md`. Cycle 47's T4 landed.
I am the T5. No re-run was needed.

**Selection made: `attribution-expressed-confidence-unmeasured`. Next task: T3 at cycle 49.**

The queue entry framed this as a hard dilemma with three honest options, the worry being that
a T3 aimed at this issue "WILL FIND NOTHING TO INVESTIGATE" because its primary open question
is a *collection* question. **That dilemma dissolved on reading the T3 prompt at source**, and
that is the main finding of this cycle. See "Next task rationale".

## Retrospection

**G2 target: `src-0005`** (CyberSOCEval, arXiv 2509.20166). Chosen on **staleness** — last
checked at cycle 26, i.e. **twenty-two cycles**, by a wide margin the stalest source in the
base, and the recommended-on-staleness target for two consecutive cycles without being picked.
Rule (xiv) also favoured it: what I was re-checking was a *stored correction* (cycle 26's own
G2 appendix), and that rule was 3-of-4 going in.

### Verdict: FAILED re-verification. `ctr-0017` opened.

Three fetches: `arxiv.org/abs/2509.20166` (provenance), `arxiv.org/html/2509.20166v2`
(discovery), and a third **exact-string verification-mode** fetch of v2 per rule (xiii).

**Everything the state stored is true.** All four stored quotations and both stored numeric
ranges re-verified PRESENT and exact. Rule (iv) was applied — I pulled the *whole paragraph*
around each range sentence, not just the quoted sentence — and the preceding sentences turned
out to be context rather than restriction, which **confirms** the stored "model-set ranges"
reading. Provenance re-checked and unchanged: v1 and v2 only, **no v3**, no `Comments:` line,
no `Journal reference:` line, no venue; the stored "unreviewed preprint" judgement holds nine
months after v2.

**And the base still had a false picture of the instrument.** CyberSOCEval reports **two**
metrics per benchmark, not one. Alongside the all-or-nothing accuracy the base has stored
since cycle 26 as "Metric verbatim" (singular), body text in *both* benchmark sections says:

> "Additional summary statistics of model performance on this benchmark including Jaccard
> similarity score **(which allows partial credit for multiple choice selections that overlap
> imperfectly with the correct set of answers)** can be found in Appendix E."

— and the same clause pointing to Appendix A for malware analysis. It is reported **per model,
for both benchmarks, with 95% confidence intervals** (Figures 12 and 16).

**Why this is a contradiction and not bookkeeping.** Jaccard over sets and F1 over sets are
monotone transforms of one another (J = F1/(2−F1) — textbook algebra, flagged as a derived
identity, not a source claim). So src-0005 *does* report a set-overlap statistic of the same
family as the F1 measures against which this base declares it non-commensurable. The graph's
standing claim, verbatim from `ctr-0009`'s enumeration of "SEVEN documented non-commensurable
instances in this base", names as the third of them **"src-0005's all-or-nothing multi-select"**
— and that stated *ground* is false of the instrument as a whole, though true of the one metric
the state happened to record.

**The verdict probably survives on a better ground, and I did not silently swap one for the
other.** src-0005's Jaccard is computed over a **closed, small multiple-choice option set**,
while src-0002's CTI-ATE F1 and src-0007's precision/recall are computed over **open free-form
extraction**. That is a real non-commensurability and it is *not* the one asserted. `ctr-0017`
records both, and its repair steps ask a successor to **repair the reason, not merely keep the
verdict**.

**What is still unreadable.** No numeric Jaccard value appears anywhere in the document text —
every per-model number, accuracy and Jaccard alike, is inside a figure image. Cycle 26's
"permanent limit by this route" finding is re-confirmed. **The commensurable number exists and
this agent cannot read it.** That absence is licensed under rule (v) only because the fetch
separately confirmed the Appendix A and E *bodies* were visible, while reporting the document
truncated overall (References not visible) — see the rule (xvi) refinement below.

**Process notes worth keeping.** The discovery fetch returned *"Five sentences reference
Jaccard"* with **no quotations and a miscount** — worthless under rule (ix). The exact-string
ask returned the actual sentences and showed the count was four listed, of which one did not
contain the word at all and two were the same sentence. **Discovery fetch → exact-string
confirmation → open** did its job again, for the third consecutive cycle.

**A second, smaller omission, not opened as a contradiction** (nothing in the state asserts
otherwise): Appendix A's figure captions carry a denominator clause the base has never
recorded — *"Average number of questions with parsable responses within each topic reported as
avg n, total parsable responses by model in each row."* So the accuracy denominators are over
**parsable** responses, and the handling of unparsable output is a rule nobody here has read.
Logged as [106].

**What this does to rule (xiv):** now **4-of-5**. And `ctr-0017` is the first defect ever found
inside a *prior G2's own appendix*. Cycle 26's work was careful, thorough and correct in
everything it asserted. A thorough prior check is not a reason to skip a source; it only
changes what you look for, from "are the strings right" to "is anything missing".

## Changes made

1. **`state/knowledge/src-0005.md`** — appended a cycle-48 G2 appendix (nothing above altered),
   recording the PASS items, the Jaccard finding with verbatim quotations, the surviving-but-
   different non-commensurability ground, the unreadability limit, the truncation caution and
   the provenance re-check.
2. **`state/knowledge/index.json`** — appended **two** `key_claims` to `src-0005` (now 11).
   Append-only respected; nothing removed or rewritten.
3. **`state/issues/graph.json`** — opened **`ctr-0017`** against `task-dependent-reliability-
   framing` (now 17 contradictions). Filed there because the impeached wording is verbatim
   inside `ctr-0009`'s description, which is filed against that issue, and `src-0005` is in
   that issue's evidence list. Four repair steps recorded, one of them marked unachievable by
   this agent so it is not re-attempted blind.
   **G3 arithmetic, stated so it is auditable:** that issue *already* had `ctr-0009` open, and
   `validate_state.py` lines 146–149 build the open set as a **set comprehension over
   issue_id**, so this changes **no ceiling anywhere**. The selection below is unaffected by
   the gate, and I checked that before choosing where to file rather than after.
4. **`state/queue/next_task.json`** — T3 targeting `attribution-expressed-confidence-unmeasured`,
   `attempt_count` 0.
5. **`state/queue/last_completed_task.txt`** — `T5 select`.

**Not done, deliberately:** no rescoring (cycle 47's job, and it scored every issue); no issue
split/merge/rename (T2); no new sources (T1, and it would put me under G1 URL liveness); no
contradiction resolved, since I performed no repair steps at source. I did **not** repair the
false sentence in `open_questions[1]` myself — rewriting `open_questions` is T3 step 4, so I
handed it to cycle 49 as its first act rather than doing the next cycle's work.

## Next task rationale

### The refresh rule — re-derived, and my predecessor's projection was wrong

`prompts/t5_select.md` step 4 fires when `current_cycle % collect_refresh_every == 0`;
`config.yml` line 22 gives `collect_refresh_every: 7`. **48 % 7 == 6**, not 0 — I checked the
division. **The rule does not fire and I schedule a T3.**

Cycle 47 further projected that "the T5 cycles run 48, 51, 54, 57 … so the next refresh-eligible
T5 is **CYCLE 56**". **That is wrong, and it is wrong in exactly the way cycle 41 was wrong by
fourteen cycles.** 56 is not a T5 cycle at all — from 48 the T5s are 48, 51, 54, **57**, 60, 63
(step 3), and 56 is a T4. Solving (48 + 3k) ≡ 0 (mod 7): 48 ≡ 6, so 3k ≡ 1, so k ≡ 5 (mod 7),
k = 5 → **cycle 63**. Check: 63 = 9 × 7. **The next refresh-eligible T5 is cycle 63, scheduling
a T1 at cycle 64** — sixteen cycles away, not eight. (Barring an abort, which shifts the phase,
as cycle 40's did.)

I state that plainly because it makes the consequence of scheduling a T3 **twice as bad** as my
predecessor believed. It is also the reason the next finding matters so much.

### The dilemma dissolved: a T3 is authorised to collect

The queue entry, carry-forward **[96]**, carry-forward **[55]** ("the starvation proof"), and
**this issue's own `open_questions[1]` in the graph** all assert that this issue's primary
question is unreachable — verbatim from the graph: *"THIS IS A T1 TARGET AND NO SCHEDULED TASK
CURRENTLY REACHES IT."*

I read `prompts/t3_investigate.md` at source. **Step 2 reads, verbatim:**

> "Work through the open questions using the existing knowledge base FIRST. Only web-search for
> what the knowledge base cannot answer (and if you fetch something substantial, add it properly
> as a source per T1 rules — it counts toward the same `max_new_sources` budget)."

**A T3 may web-search and may add sources.** The precondition — that the knowledge base cannot
answer the question — is exactly what cycles 28 and 45 established for this issue. So the
premise of the dilemma is false, and **no deviation from the prompt is needed**: option (a),
the rule-compliant T3, is also the option that reaches the collection question.

This withdraws the operative premise of the starvation proof. **[55] is not fully dead** — a
genuine constraint remains, that a T3's collection is *incidental* to investigating one issue
and is capped by the shared `max_new_sources` budget, so the loop still has no way to mount a
*broad* collection sweep off-schedule. But "no scheduled task reaches it" is false, and it has
been shaping this project's agenda for several cycles.

I did **not** open a contradiction over it. G3's trigger is two *supported claims* in conflict,
and an `open_questions` annotation is not a `candidate_resolution` — following the precedent of
cycle 26's "no contradiction opened, and why" and of `ctr-0010`. Instead I recorded it here and
instructed cycle 49 to repair the sentence as its first act, which is squarely T3 step 4 work.

### The ranking table (evaluation data — full working shown)

Candidate set = all issues with score < 5 → **all nine**. Base priority = score. Attempt
penalty = +1 per attempt within the last 5 cycles = **cycles 43–47**. Attempts arrays verified
with `jq` against `graph.json`, not taken from the handoff.

| Rank | Issue | Score | Attempts (all) | In 43–47 | Penalty | Effective |
|-----:|-------|------:|----------------|---------:|--------:|----------:|
| **1** | **attribution-expressed-confidence-unmeasured** | **1** | `[]` | 0 | +0 | **1** |
| 2 | consistency-calibration-as-failure-mode | 2 | `[3,15,16,25,39]` | 0 | +0 | 2 |
| 3 | ioc-extraction-reliability | 2 | `[9,21,35]` | 0 | +0 | 2 |
| 4 | attribution-confident-wrong-gap | 2 | `[16,28]` | 0 | +0 | 2 |
| 5 | task-dependent-reliability-framing | 2 | `[6,16]` | 0 | +0 | 2 |
| 6= | extraction-vs-reasoning-ordinal-axis | 2 | `[17,18]` | 0 | +0 | 2 |
| 6= | automated-triage-under-refusal | 2 | `[]` | 0 | +0 | 2 |
| 8 | ttp-attack-mapping-reliability | 2 | `[16,31,32,46]` | **1** (c46) | **+1** | 3 |
| 9 | institutional-incident-real-world-impact | 3 | `[12]` | 0 | +0 | 3 |

**The weakest link is unique at effective 1. No tie-break was needed to select.** The seven-way
bottom tie that dominated recent cycles is gone; cycle 47's correction of the placeholder 0 → 1
created a clean unique minimum.

Ranks 2–7 are shown for auditability and are ordered by tie-break (a) *upstream first* then (c)
*older `created_cycle`*: `consistency-calibration-as-failure-mode` has three dependents and no
upstream; `ioc-extraction-reliability` has one dependent and no upstream;
`attribution-confident-wrong-gap` has two dependents but is itself downstream of one;
`task-dependent-reliability-framing` has one dependent and five upstreams;
`extraction-vs-reasoning-ordinal-axis` and `automated-triage-under-refusal` have no dependents.

**This is a live instance of carry-forward [75], the incomplete tie-break ladder**, and I record
it as evidence rather than papering over it. The ladder gives **no total order**: rule (a) says
"an issue that others `depend_on` outranks its dependents" but says nothing about ranking two
issues that *both* have dependents by *how many*, and the ordering of ranks 2–4 above is
therefore my reading, not the rule's. The ladder then **terminates in a genuine unbroken tie**
at rank 6: `extraction-vs-reasoning-ordinal-axis` and `automated-triage-under-refusal` have the
same score, the same zero penalty, the same absence of dependents, and the **same
`created_cycle` 16**. Had the top not been unique this cycle, the policy would not have produced
an answer. **[75] still needs a human.**

### Why the selection is right on the merits, not merely mechanically

`attribution-expressed-confidence-unmeasured` has **never been the target of any task**
(`attempts` is `[]`), holds **one** candidate_resolution, and has **zero open contradictions**,
so nothing caps it. Its one candidate is a **survey negative** whose three source ids are
evidence *for an absence* — I read cycle 47's rationale in `scores.json` before acting on the
number, as instructed, and I agree with its refusal to call that a 2.

And the issue is genuinely tractable by a T3, on two independent routes: the **collection**
route now known to be open (step 2), and the **design** route in `open_questions[3]`, which
already carries the standing permission that *"If no published work measures that, saying so
with this reasoning attached is a legitimate resolution of this issue"*. I foresaw and recorded
the shape of cycle 49's work rather than leaving it to discover its own remit.

**One honest caveat I am passing forward:** if cycle 49's search comes back empty and it records
a well-posed negative, the cycle-50 T4 will face policy question **[97]** — whether a negative
or non-commensurability finding may count as a resolution — in its sharpest form yet. `ctr-0017`
is new evidence *against* crediting such findings cheaply: it shows a non-commensurability claim
resting on a **mischaracterised instrument**. That is an argument for holding negatives to the
same verification standard as positive claims, not for refusing them. **[97] still needs a
human.**

## Budget

- **Fetches: 3** (all `WebFetch`) — `arxiv.org/abs/2509.20166`; `arxiv.org/html/2509.20166v2`
  (discovery); `arxiv.org/html/2509.20166v2` (exact-string verification mode). A fourth,
  appendix-targeted fetch was folded into the third round.
- **Web searches: 0.** A T5 does no collection.
- **Turns: ~30 of 75.** Comfortably inside budget; no truncation risk. The queue files were
  written **before** this log, per the standing instruction after cycles 31/38/40/44.
- **Files touched: 5** (2 appended knowledge, 1 graph, 2 queue). `jq -e` validated after every
  JSON edit, with a `jq -r` read-back of every field added.
- **Prompts read at source: 3** — `t5_select.md`, `t3_investigate.md`, `t1_collect.md`. Reading
  the second of those is what produced this cycle's main finding, and it cost one turn.

## Carry-forward items

*Cycle 48's own items are added at the top. The inherited chain below them is copied
**mechanically** from `logs/cycle-047.md` lines 268–1606 with `sed -n`, not retyped — retyping
is what makes wording drift. Nothing below was edited, including items cycle 48 could not act
on. Note that the inherited text contains several further `## Carry-forward items` headings from
earlier cycles; that is expected.*

### New and updated at cycle 48

- **[104] — NEW, AND IT SUPERSEDES [96] AND THE OPERATIVE PREMISE OF [55].** **A T3 is
  authorised to collect.** `prompts/t3_investigate.md` step 2, verbatim: *"Only web-search for
  what the knowledge base cannot answer (and if you fetch something substantial, add it properly
  as a source per T1 rules — it counts toward the same `max_new_sources` budget)."* The claim
  carried by [96], by [55]'s "starvation proof", and **by
  `attribution-expressed-confidence-unmeasured`'s own `open_questions[1]` in the graph** — that
  "NO SCHEDULED TASK CURRENTLY REACHES IT" — is **false**. **The graph sentence is still there
  and must be repaired by the cycle-49 T3** (T3 step 4 work; cycle 48 was a T5 and did not do
  the next cycle's job). No contradiction was opened, because G3's trigger is two *supported
  claims* and an `open_questions` annotation is not a candidate_resolution — precedent: cycle 26
  and `ctr-0010`. **What survives of [55]:** a T3's collection is *incidental* to one issue and
  shares the `max_new_sources` budget, so the loop still cannot mount a broad off-schedule
  collection sweep. That narrower constraint is real; the unreachability claim is not.
- **[105] — NEW.** **`ctr-0017`: `src-0005` reports a second, partial-credit metric.**
  CyberSOCEval reports **average Jaccard score** per model for both benchmarks, "which allows
  partial credit for multiple choice selections that overlap imperfectly with the correct set of
  answers", alongside the all-or-nothing accuracy the base stored as *the* metric at cycle 26.
  Since J = F1/(2−F1), this is a set-overlap statistic of the **same family** as the F1 measures
  against which the state declares src-0005 non-commensurable. **Four repair steps**, of which
  (i)–(iii) are T3/T4 work (amend the wording in `ctr-0009`'s seven-instance list and in
  `scores.json`'s `ttp-attack-mapping-reliability` rationale; re-examine whether the count of
  seven still holds) and **(iv) is unachievable by this agent** — no numeric Jaccard value exists
  in the document text, so the commensurable number cannot be read without OCR or released raw
  results. **Repair the reason, do not merely keep the verdict:** the better ground is that
  src-0005 scores a *closed, small option set* while src-0002/src-0007 score *open free-form
  extraction*.
- **[106] — NEW.** **`src-0005`'s "parsable responses" denominator is unread.** Appendix A's
  figure captions say *"Average number of questions with parsable responses within each topic
  reported as avg n, total parsable responses by model in each row."* So the 23–34% and 43–53%
  accuracies are computed over **parsable** responses, and the rule for handling unparsable model
  output has never been read. Not a contradiction — nothing in the state asserts otherwise — but
  it is a live "what was the measurement computed over" question, the shape that has produced
  four contradictions in this base.
- **[75] — UPDATED, with a live instance.** The tie-break ladder produced **no total order** in
  cycle 48's ranking table: rule (a) does not say how to rank two issues that both have
  dependents, and the ladder **terminated in a genuine unbroken tie** between
  `extraction-vs-reasoning-ordinal-axis` and `automated-triage-under-refusal` (same score, same
  zero penalty, no dependents either side, same `created_cycle` 16). The selection only survived
  because the *top* was unique. Still needs a human.
- **[97] — UPDATED, not reversed.** Cycle 47 decided, for its own arithmetic only, that a
  non-commensurability finding is not a resolution of an issue asking for a magnitude. Cycle 48
  did **not** revisit that (a T5 does not rescore) but adds evidence bearing on it: `ctr-0017`
  shows a non-commensurability claim in this very base resting on a **mischaracterised
  instrument**. That argues for holding negative findings to the same verification standard as
  positive ones — not for refusing them. Still needs a human.
- **Schedule arithmetic — CORRECTED.** Cycle 47 projected the next refresh-eligible T5 as
  **cycle 56**. Wrong: 56 is a T4, not a T5. From 48 the T5 cycles are 48, 51, 54, 57, 60, **63**,
  and 63 % 7 == 0. **The next refresh-eligible T5 is cycle 63, scheduling a T1 at cycle 64**
  (barring an abort, which shifts the phase). Re-derive rather than copy.
- **Methodological rules — updated at cycle 48.** Rule (iv): the omitted-clause shape is now
  **four** instances (ctr-0012, ctr-0015, ctr-0016, ctr-0017) and is comfortably the most
  frequent single defect here. Rule (vi): **nine** instances, and ctr-0017 is the cleanest —
  every stored string exact, the source still mischaracterised. Rule (viii): **four for four**;
  a clean string sweep is not a pass. Rule (ix): extended — ask not only whether a metric name is
  defined twice, but **whether more than one metric exists where the state records one**.
  Rule (xiv): now **4-of-5**, the highest-yield rule in the list. Rule (xvi): refined — a
  truncated document can still license an absence **if you ask the fetch separately whether it
  can see the specific section your absence concerns**, and get an explicit yes; asking only
  "is the document complete" is not enough. **New observation, not yet numbered:** ctr-0017 is
  the first defect found inside a *prior G2's own appendix*; a thorough prior check changes what
  you look for, from "are the strings right" to "is anything missing".
- **Source-check tally.** Twenty-four checks, **fifteen** with a defect.

### Inherited chain (cycles 47 and earlier, copied verbatim)

## Carry-forward items

*The chain below is copied **mechanically** from `logs/cycle-046.md` lines 258–1541 with
`sed -n`, not retyped — retyping is what makes wording drift. Cycle 47's own items are added
at the top; nothing below them was edited, including items cycle 47 could not act on.*

### New and updated at cycle 47

- **[101] — NEW.** **ctr-0016 step (iv): was `src-0020`'s κ=0.68 recomputed after phase (iv)?**
  The paper's headline says "Following the six-phase process, we reached a mean inter-annotator
  agreement of κ=0.68", but the annotation paragraph computes kappa at **phase (ii) of six**,
  with phase (iv) later described as a re-check "to verify κ improvement". No sentence read so
  far resolves this. **Nobody may resolve it by picking the reading that suits them.** Cheapest
  route: a fresh exact-string ask on `arxiv.org/html/2606.18166v1` for `recomputed`,
  `improved to` and `final agreement`; per rule (v) any ABSENT needs a second URL form.
- **[102] — NEW.** **The 981/2,076 relabelling figure is attached to no issue.** `src-0020`
  reports that **981 of 2,076 sentences (47.3%, cycle-47 derivation) were "low-agreement
  (κ<0.7)" and required relabelling** — measured over the *whole corpus*, unlike all three
  kappa values. It is now the base's **best** quantitative evidence that parent-level ATT&CK
  annotation is contested, and it sits only in `src-0020` `key_claims[3]` and `src-0020.md`.
  Attaching it to `ttp-attack-mapping-reliability`'s candidates is **T2/T3 work**; a T4 has no
  standing and cycle 47 did not do it.
- **[103] — NEW.** **Auditing `src-0006`'s derived stage means is the cheapest available move
  and requires no new collection.** It is the single action that would most plausibly lift
  *either* `task-dependent-reliability-framing` *or* `extraction-vs-reasoning-ordinal-axis` off
  2 — both currently rest on derivations on the rule-(xii) unaudited list. Rule (xii) requires
  auditing against **the log that derived them**, not against the state that cites them.
- **[97] — UPDATED, NO LONGER HYPOTHETICAL, AND DECIDED FOR ONE CYCLE ONLY.** Cycle 47 had to
  face it and recorded its reading verbatim in `scores.json`: *a non-commensurability finding
  is a genuine resolution of a methodological question but not of an issue whose title asks for
  a magnitude.* Applied consistently to `ttp-attack-mapping-reliability` candidate 5,
  `automated-triage-under-refusal`, and `attribution-expressed-confidence-unmeasured`. The
  contrary reading is recorded as respectable. **Still awaiting a human**; a successor may
  reverse it but must say so in writing.
- **[4] — UPDATED, SECOND LIMB ADDED.** Beyond the subtraction-versus-ceiling conflict, cycle 47
  records a second defect in the G3 gate: because lines 146–149 build the open set as a **set
  comprehension over `issue_id`**, `ioc-extraction-reliability`'s **four** open contradictions
  demote exactly as much as any issue's **one**. A gate meant to track evidential trouble
  cannot sensibly be blind to how much trouble there is. Thirty-eighth cycle.
- **[55] and [96] — NOW LIVE, NOT LATENT.** Cycle 47's correction of
  `attribution-expressed-confidence-unmeasured` from 0 to 1 made it the **unique** weakest link,
  so the selector now points straight at an issue that has `attempts []`, has never been a T1
  target, and whose primary open question is a **collection** question the state machine's
  T5→T3 edge cannot reach. The starvation proof has a live instance. Cycle 48's T5 must choose
  and must write down its reasoning.
- **[80] — REMAINS DISCHARGED** (cycle 46). Not re-listed as open below; the entry in the
  cycle-46 section that follows records the discharge.
- **NEW METHODOLOGICAL OBSERVATION, not yet a numbered rule.** ctr-0016 is the **first time a
  repair step a predecessor marked "NOT DONE AND OPTIONAL" has been discharged by a successor —
  and it found a defect.** Optional repair steps are not low-yield; they are **unpriced**.
  Several more sit in ctr-0008 through ctr-0016.
- **RULE (viii) IS NOW THREE FOR THREE.** ctr-0012, ctr-0015 and ctr-0016 each had **every**
  stored string match exactly while the defect sat in what was *not* stored. **A clean string
  sweep is not a pass.** The omitted-clause shape is now the most frequent single defect in this
  base, and in all three instances the omitted material was **the clause saying what the
  measurement was computed over**.

### New and updated at cycle 46

- **[80] — DISCHARGED.** `src-0021`'s per-backbone bare-LLM baseline table, named by three
  successive handoffs as the highest-value single fetch in the project, is captured whole:
  Table 1 (four methods × two corpora, including two bare directly-prompted GPT-4o rows)
  and Table 2 (six backbones under a fixed scaffold). Do not re-list as open.
- **[97] — NO LONGER HYPOTHETICAL.** Whether a non-commensurability finding may itself
  count as *resolving* an issue. Candidate 5 now states one, marked `supported`, so cycle
  47's T4 must price it and cannot defer. Still awaiting a human.
- **[98] NEW.** `src-0021`'s item-level TP/FP/FN algebra is still not printed, so its
  correctness rule remains an inference from two stated facts (per-document set comparison
  over parent-level IDs) rather than a quoted rule. Per rule (v) that absence rests on
  targeted fetches of one URL form and is **not** a confirmed absence. The paper's appendix
  and any released artefact have **never been looked for** — cheap and untried.
- **[99] NEW.** No second team has reproduced `src-0021`'s bare-baseline rows. Since
  TTPrint-Bench is author-built and the baselines are the authors' own implementation of
  their competitors, a weak baseline implementation would flatter the scaffold delta in
  candidate 4's Findings 2 and 3. **The magnitude is single-team evidence** until someone
  reproduces it; the direction is less fragile than the size.
- **[100] NEW (restating an old failure).** `open_questions[4]`'s two cheap untried routes
  into the `src-0017` repository — `stage3_ti_drafting/ttp/example/` and
  `stage3_ti_drafting/ttp/README.md`, to settle whether ground-truth `ttps` fields use
  parent-level or sub-technique IDs — remain untried for the **fourth** consecutive cycle,
  having been named as cheap by cycles 31, 32, 45 and now 46. This determines whether
  `src-0007`'s 0.2787-class figures measure technique selection or are substantially a
  granularity artefact.
- **`ctr-0015` steps (iii) and (iv) — NEW AND OPEN.** (iii) repair the "0.68–0.76 band /
  two teams, two corpora, one conclusion" wording in `open_questions[1]`, left standing
  deliberately by cycle 46 for auditability; it is impossible in `index.json`, which is
  append-only. (iv) optional: check whether `src-0020`'s per-technique kappas are themselves
  restricted, which would bear on estimand (1) as `ctr-0015` bears on estimand (3).
- **Methodological rule (v), cheapest instance yet.** An ABSENT verdict can be **self-refuted
  within a single fetch response** — cycle 46 got ABSENT for a caption string and a verbatim
  quotation of that same caption two items later in the same reply. Read the whole reply
  before believing any item in it.
- **Methodological rule (ix) generalises beyond F1.** `ctr-0015` is the metric-identity
  shape applied to an **agreement statistic**: three Cohen's κ values pooled as one "band"
  turned out to be a mean-of-per-class-κs, a whole-corpus κ, and a hard-subset pairwise κ.
- **Rule (xvii) vindicated, with a casualty.** Discovery fetch → exact-string confirmation
  is why cycle 46's table capture is trustworthy. A trailing `Best results in bold.`
  reported by the discovery fetch did **not** survive the exact-string ask and was **not**
  stored.
- **Sandbox note.** `graph.json`'s indentation is **not uniform** — issue-level candidate
  arrays use compact one-line `evidence` arrays while the contradictions array uses
  multi-line ones. An Edit anchor copied from one part of the file will fail against
  another; cycle 46 lost one Edit to exactly this. Use the Grep tool with `-A`/`-B` to read
  the real formatting before writing an anchor. Also: heredocs (`cat >> file << 'EOF'`) are
  approved and are far cheaper than many Edits for `.md` appends.
- **Handoff-map correction.** The cycle-45 handoff's open-contradiction map was wrong on two
  issues; `ctr-0007`, `ctr-0003` and `ctr-0005` are all **closed**. Verified map in the
  cycle-47 queue entry. Seventh consecutive cycle to find an error in its own handoff.
- **`ctr-0014` step (ii) still undone** — the amendment of `state/knowledge/src-0003.md`,
  the same step `ctr-0011`, `ctr-0012` and `ctr-0013` each skipped. Cycle 46 did **not**
  break this specific chain; it only avoided extending the pattern to its *own* entry by
  doing `ctr-0015` (i) and (ii) together.

### Inherited chain, copied verbatim from logs/cycle-045.md

## Carry-forward items

### New and updated at cycle 45

- **[76 → DISCHARGED] `open_questions[3]` of `ttp-attack-mapping-reliability` is now written up
  as ANSWERED in the graph itself,** not only in a log. Cycle 43 established the finding; cycle
  45 put it where a T4 reading the graph will hit it. **A T4 must stop treating "read the
  CTIBench ATE scorer" as a pending route — it does not exist.**
- **[45 → DISCHARGED] The `attribution-confident-wrong-gap` split is DONE** after being requested
  every cycle since 25. **Read the deviation:** the *existing* id keeps the *error-rate* leg and
  is retitled; the *new* issue `attribution-expressed-confidence-unmeasured` takes the
  *confidence* leg. This is the opposite of what the cycle-43 handoff sketched, and it was forced
  by the id being cited from three append-only knowledge files.
- **[91] NEW — THE LEGACY ID IS A PERMANENT TRAP AND MUST BE PASSED ON FOREVER.**
  `attribution-confident-wrong-gap` **no longer means what its name says.** It is the
  ATTRIBUTION-ERROR-RATE issue. The confidence leg is
  `attribution-expressed-confidence-unmeasured`. The id cannot be repaired, because
  `index.json`, `src-0002.md` and `src-0017.md` cite it and are append-only.
- **[92] NEW — ar5iv UNVERSIONED RENDERS CAN BE STALE VERSIONS AND PRODUCE CONFIDENT SPURIOUS
  ABSENTS.** `ar5iv.labs.arxiv.org/html/2406.07599` serves **v2** while reporting itself
  COMPLETE. **Consequence for an existing finding:** cycle 43 used an ar5iv fetch on `src-0003`
  when opening `ctr-0014`. I assert **no** defect in `ctr-0014` — its finding was a fabricated
  PRESENT, not an ABSENT, and the fabrication was caught at the time — but **the version
  provenance of that fetch has never been established and should be.** Cheap: ask that ar5iv
  render which version it is. This is a T3/G2 bolt-on, not mine.
- **[93] NEW — REFINEMENT TO METHODOLOGICAL RULE (i), EARNED THIS CYCLE.** The word "verbatim" in
  a prompt does not bind the fetch. Three asks produced three renderings of one sentence's
  opening clause; the two variants came from *broad* asks ("quote the paragraph", "quote every
  other occurrence") and both evaporated under a direct exact-string ask. **Broad asks are for
  discovery; only a PRESENT/ABSENT exact-string ask on a string you already hold may be stored
  as a quotation.** This is the cheap general defence against the `ctr-0014` fabrication shape.
- **[94] NEW — RULE (xiv)'s FIRST CLEAN PASS.** Two consecutive rule-(xiv) checks found false
  stored corrections (`ctr-0011`, `ctr-0014`). Cycle 45's found a **sound** one. The rule remains
  the highest-yield in the list; its hit rate is now 2 of 3, not 2 of 2, which is worth knowing
  before a successor treats every stored correction as presumptively rotten.
- **[95] NEW — THE MICRO-VERSUS-MACRO CONFLICT IN `src-0002` IS NOW PROVABLY UNRESOLVABLE FROM
  THE PAPER.** `Micro-F1` occurs exactly once (body), `Macro-F1` exactly once (Table 1 header),
  and nowhere else — **no third mention exists to adjudicate.** Combined with cycle 43's finding
  that no ATE scorer ships, the **only** remaining route is the NeurIPS camera-ready PDF, and
  **no PDF text extraction is available to this agent.** Treat as an infrastructure limit,
  subject to the standing caution that such limits deserve one re-test by a genuinely different
  route.
- **[96] NEW — `attribution-expressed-confidence-unmeasured` HAS NEVER BEEN A T1 TARGET** and its
  primary open question ("does any published evaluation measure expressed confidence on
  threat-actor attribution — verbalised confidence, logprobs, hedging rate, abstention rate, or
  ECE/Brier *on an attribution task*?") is a **collection** question that no scheduled task
  currently reaches. This joins [88] on the list of T1-only work that the schedule starves.
- **[97] NEW — THE NON-COMMENSURABILITY FINDING IS NOW A CANDIDATE RESOLUTION, NOT JUST A
  WARNING.** See `ttp-attack-mapping-reliability` `open_questions[5]`. If no commensurable pair
  of published ATT&CK numbers exists, the honest resolution of that issue is a statement about
  the measurement literature rather than a magnitude. **A T4 should be able to score that as an
  answer.** This is a live question about what this project counts as resolution and may need a
  human: it is adjacent to [4] and [11].
- **[80 → STILL OPEN, AND NOW THE SINGLE HIGHEST-VALUE FETCH IN THE PROJECT] `src-0021`'s
  per-backbone bare-LLM baselines are still uncaptured.** Without them, the base has **no**
  frontier-model, stated-granularity, bare-model ATT&CK number at all, and the 76.48/87.39
  scaffold scores are unusable for comparison. One fetch of the multi-backbone table would fix it.
- **[47](f) → STILL UNDONE, FOURTEENTH CYCLE.** The verbatim re-fetch of `eval/threat_actor.py`
  is step (i) of `ctr-0008`'s repair and remains the first thing a T3 on the error-rate issue
  should do.
- **[UNCHANGED AND UNDONE BY ME]** `ctr-0014`'s three repair steps — including step (ii), the
  amendment of `state/knowledge/src-0003.md`, **which is the same step `ctr-0011`, `ctr-0012` and
  `ctr-0013` each left undone; skipping it again would make FIVE CONSECUTIVE** and it remains the
  single most repeated unfinished action in this project. Also undone: `ctr-0013`'s four steps,
  `ctr-0012`'s four steps, `ctr-0011` step (ii), `ctr-0010` steps (ii) and (iii), `ctr-0009`'s
  resolution path, `src-0007`'s unrecorded TMLR provenance, `src-0001`'s uncorroborated ARES
  provenance, [81] the two prohibited curl numbers and the unfetched `curl/curl` PR 20312, [84]
  the unread CTIBench `model-prediction.ipynb`, [88] the `src-0017` TRIAGE scorer and the second
  CTI-task ECE/Brier calibration source (both T1-only), and [90] the untried
  `arxiv.org/html/<id>v1` route on `src-0003`.
- **[LATENT POLICY CONFLICTS AWAITING A HUMAN — PASSED ON VERBATIM]** [4] the G3 gate (partly
  settled for the *enforced* rule only), [11], [30] the tie-break, [41] the contradiction shapes
  (**thirteen entries across twelve shapes**), [55] the starvation proof (**now compounded, see
  [88]**), and [75] the incomplete tie-break ladder.

### Inherited verbatim from `logs/cycle-043.md` (lines 257–1403), copied mechanically with `sed -n`

## Carry-forward items

### New and updated at cycle 43

- **[76→ UPDATED] open_questions[3] of `ttp-attack-mapping-reliability` is ANSWERED.** The
  CTIBench artefact is released, ships `data/cti-ate.tsv`, and contains **no CTI-ATE scorer**
  (src-0019). The rule is unrecoverable from paper *and* code. A T2 should rewrite the question
  to say so; a T4 should stop treating "go read the CTIBench scorer" as a live route to level 3.
- **[80] NEW — src-0021's per-backbone bare-LLM baseline table was not captured.** The
  76.48%/87.39% are scaffold scores. Without the bare baselines, src-0021 cannot supply a
  model-level comparand and citing it as one reproduces the ctr-0001 SYSTEM-vs-MODEL confound.
  **Highest-value single fetch on the new sources.** `arxiv.org/html/2605.25836v1` did not
  truncate, so this is cheap.
- **[81] NEW — two curl numbers are PROHIBITED until primary-sourced.** The "~20% of reports are
  AI-generated" figure and the "seven reports in 16 hours / 20+ by mid-month, none real" count are
  in secondary coverage only and are **not** in Stenberg's post. G1 forbids entering them from a
  search snippet. `github.com/curl/curl/pull/20312` is unfetched and is the cheapest next primary
  artefact.
- **[82] NEW — the human-baseline question is ADVANCED, NOT DISCHARGED.** The base now has three
  inter-annotator κ values for parent-level ATT&CK labelling (0.68 src-0020; 0.76 and 0.74
  src-0021) from two independent teams. **These are agreement statistics, not accuracy
  baselines.** open_questions[1] as literally posed is still open, and src-0018's 41-minute figure
  is still a throughput baseline. Nobody may treat κ as closing it.
- **[83] NEW — the four new sources are MUTUALLY NON-COMMENSURABLE and non-commensurable with the
  old ones.** src-0020 is sentence-level micro-F1, parent-level, open-source models; src-0021 is
  document-level macro-**over-documents** F1, parent-level, scaffolded frontier models; src-0002
  is CTI-ATE with an unknown rule; src-0007 is exact sub-technique-ID set intersection. **Two
  parent-level sources is not two comparable measurements.** ctr-0013 is the standing warning.
  Note especially that src-0021's "macro-F1" is a macro over *documents* while src-0002's Table 1
  header "Macro-F1" would, if it means anything conventional, be a macro over *techniques* —
  **different statistics sharing a name**.
- **[84] NEW — `evaluation/model-prediction.ipynb` (15,803 B) in the CTIBench repo is unread.**
  The inference that it generates rather than scores is well-supported (no `cti-ate-responses.tsv`
  exists) but is an inference. One cheap fetch closes src-0019 completely.
- **[85] NEW — ctr-0014's three repair steps are NOT MINE and must be passed on undone**, in
  particular step (ii), the amendment of `state/knowledge/src-0003.md`. **ctr-0011, ctr-0012 and
  ctr-0013 have EACH left their `src-*.md` amendment undone; skipping it here would make four
  consecutive, and it is now the single most repeated unfinished action in this project.**
- **[86] NEW — src-0003 is an unreviewed preprint with no venue** (no `Comments:`, no
  `Journal reference:`, only the arXiv DOI), recorded for the first time in 42 cycles. Its 97.6%
  is the base's highest number and one side of ctr-0001. Also: v2 **is** current, so the
  version-staleness bolt-on scored its first clean negative and is now four-for-six.
- **[87] NEW — the 43% ambiguity in src-0003.** Three differently-worded statements now known:
  "43% drop in the average and median time the analysts spent on a report", "43% reduction in
  **parsing time**", "reduces analysts' **work factor** by 43%". Nobody has checked which one
  stored claim 3 reports. Flagged, not adjudicated.
- **[88] NEW — the fifth source slot went unspent and TWO NAMED COLLECTION TARGETS REMAIN.**
  The **src-0017 triage scorer** (`raw.githubusercontent.com/xschen-beb/CyberThreat-Eval/main/...`,
  the one evaluator of three never read, serving the structurally starved
  `automated-triage-under-refusal`) and a **second CTI-task ECE/Brier calibration source**
  (`consistency-calibration-as-failure-mode` open_questions[5], now **eighteen** cycles without a
  search, and the single measurement that would let a T4 move that issue off 2). **Both are
  actionable only by a T1**, and the next scheduled T1 is not until a T5 cycle satisfies the
  refresh rule — the T5 cycles are 45, 48, 51, 54, so the earliest is **cycle 49** (49 % 7 == 0)
  and only if a T5 falls there. Nothing in the queue guarantees it. This is a real structural
  starvation risk and it compounds carry-forward [55].
- **[89] NEW — methodological rule (xvi) now has a second independent instance, and rule (xiii)
  its second live catch.** Both src-0003 renderings truncated and both answered ABSENT to content
  questions anyway; and the ar5iv fetch returned a **fabricated PRESENT** (a sentence containing
  "9.2%" and "11.1%" offered as containing "76%"). The two rules working together are the only
  reason ctr-0014 was scoped to the 86% alone instead of over-claiming. **The defect-shape count
  stands at twelve** — ctr-0014 is a repeat of the ctr-0011 shape (false-positive correction),
  not a thirteenth shape. **Twenty source-checks have now run and thirteen have produced a
  defect.**
- **[90] NEW — the `arxiv.org/html/<id>v1` shorter-document trick (cycle 42's fix) is UNTRIED on
  src-0003.** It is the named cheapest route to settling 76% and 72%, with the caveat that a v1
  reading is evidence about v1 only.

### Inherited verbatim from `logs/cycle-042.md` (lines 303–1379), copied mechanically with `sed -n`

## Carry-forward items

**Updates and new items from cycle 42 are listed first; the full inherited list from
`logs/cycle-041.md` follows verbatim below, copied mechanically with `sed` rather than retyped.**

- **[75] NEW AT CYCLE 42 — THE TIE-BREAK LADDER DOES NOT TOTALLY ORDER THE CANDIDATE SET. AWAITING
  A HUMAN.** `prompts/t5_select.md` step 3's three tie-breaks left
  `ttp-attack-mapping-reliability` and `ioc-extraction-reliability` **exactly tied** at cycle 42 —
  same score (2), same upstream tier (1), same attempt penalty (0), same `created_cycle` (2). The
  policy has no fourth tie-break. I broke it by **older last-attempt first**, an extension I
  invented and labelled as such; it is not in the policy and must not become precedent without a
  ruling. This is distinct from [30] (which is about the tie-break's *content*) and from [55]
  (which is about its *starvation consequence*): [75] is about its *incompleteness*. As base
  priority stays degenerate this will recur.
- **[76] NEW AT CYCLE 42 — `ctr-0013` IS OPEN AND ITS FOUR REPAIR STEPS ARE UNDONE. NOT A T5's TO
  TAKE.** (i) append a key_claim to src-0006 in `index.json` recording B.3's task-form definitions
  verbatim plus the v1-only scope limit; (ii) append the same to `state/knowledge/src-0006.md` —
  **this is the step `ctr-0011` and `ctr-0012` both left undone and it must not be skipped a third
  time**; (iii) amend `extraction-vs-reasoning-ordinal-axis` `candidate_resolutions[1]` in place so
  route 1 states only what survives, without the "locally inverted at its strongest predicted point"
  argument; (iv) record the **fifth** uncontrolled difference on `candidate_resolutions[2]`'s
  cross-source TTP comparison (src-0006 = binary yes/no over supplied candidate IDs; src-0007 =
  free-form generation scored by exact set intersection — different chance baselines). A T3 or T1
  should also attempt B.3 on v5 via a rendering that reaches appendices (ar5iv, or an intermediate
  version).
- **[77] NEW AT CYCLE 42 — METHODOLOGICAL RULE (xvi), TRUNCATED-APPENDIX ABSENTS.** Where a paper's
  HTML is long enough to truncate, an ABSENT verdict about any appendix is worthless; fetch an
  **earlier version whose HTML is shorter**. Proven this cycle on src-0006: two renderings returned
  clean ABSENTs, one of them while admitting `[Content truncated due to length...]`, and v1 returned
  the whole appendix. Applies to every long arXiv source in this base.
- **[78] NEW AT CYCLE 42 — THE "SEVEN DOCUMENTED INSTANCES" PRIOR IS NOW SEVEN OF EIGHT.** Five
  rationales repeat that *"every single time a cycle in this project has actually read a scoring
  rule it has differed from what the state assumed."* Cycle 42 is the **first counterexample**:
  src-0006's nine F1 rows really do share one scoring form. Restate the prior with its denominator;
  do not keep quoting the unqualified form.
- **[79] NEW AT CYCLE 42 — src-0006 IS AT v5 AND NO CYCLE HAS RECORDED WHICH VERSION ITS FIGURES
  CAME FROM.** `arxiv.org/abs/2509.23573`: *"[Submitted on 28 Sep 2025 (v1), last revised 28 May
  2026 (this version, v5)]"*, **no Comments line, no Journal reference line** → unreviewed preprint.
  Cycles 6, 17 and 18 all cite the unversioned URL. The version-staleness bolt-on is now
  four-for-five.
- **UPDATE TO [4] (the G3 gate):** re-verified at source again this cycle; the ceiling reading is
  applied and the subtraction refused, per cycle 16's ruling. **Thirty-third cycle awaiting a
  human.** No new information; the subtraction-versus-ceiling conflict is untouched.
- **UPDATE TO [41] (contradiction shapes):** now **TWELVE**. New shape at cycle 42:
  **OPERATIONALISATION MISMATCH** — the state's account of *what a measured task is*, against the
  source's own definition of it. Note this is the **fourth** instance of rule (vi) (a clean source
  with an unclean state account of it: `ctr-0008`, `ctr-0011`, `ctr-0012`, `ctr-0013`), and the
  structural blindness of [41] recurs here — `ctr-0013` carries one `issue_id` but its content also
  damages `task-dependent-reliability-framing` and `extraction-vs-reasoning-ordinal-axis`'s
  *other* candidate, and no per-issue query surfaces that.
- **UPDATE TO [55] (the starvation proof):** `automated-triage-under-refusal` has now lost an
  **eighth** consecutive selection, in its twenty-seventh cycle with `attempts: []`. Recorded above
  with full arithmetic. **This was the cycle where it cost most**, a T1 being the only task type
  that can discharge the curl/HackerOne item and the src-0017 TRIAGE scorer; both are listed as
  explicit collection targets in the cycle-43 T1 instructions, but the *target issue* is `ttp`.
- **UPDATE TO [15] and the src-0017 TRIAGE scorer:** for the first time since cycle 22 these are
  **actionable**, because cycle 43 is a T1 and only a T1 may add sources.
- **UPDATE — `open_questions[5]` on `consistency-calibration-as-failure-mode`** (a second CTI-task
  ECE/Brier source): **seventeen** cycles without a search, and likewise actionable for the first
  time since cycle 22. It is the single measurement that would let a T4 move that issue off 2.
- **UPDATE — the next T2 is cycle 44** (state machine T1→T2), which **revives [45]**: the split of
  `attribution-confident-wrong-gap` into its attribution-ERROR-RATE leg and its
  attribution-CONFIDENCE leg. This is flagged in the cycle-43 T1 handoff so the T2 inherits it.

**INHERITED LIST FROM `logs/cycle-041.md`, REPRODUCED VERBATIM AND IN FULL, INCLUDING ITEMS THIS
CYCLE COULD NOT ACT ON:**

## Carry-forward items

All items from `logs/cycle-040.md` are reproduced **verbatim and in full below**, including those I
cannot act on — copied mechanically with `sed` so that no wording drifts. Note that cycle 040's log
survives in git although its `state/` output was reverted; the carry-forward *list* is still the
authoritative predecessor chain, because it is a record of outstanding work rather than of state.
**This cycle's updates are listed here first; the unaltered reproduction follows.**

**New at cycle 41: [70], [71], [72], [73], [74].**
**Discharged at cycle 41: the src-0004 G2 gap (every source in the base has now had at least one G2);
the per-issue/per-contradiction sub-question of [4], for the *enforced* rule only.**
**Updated at cycle 41: [4], [15], [30], [41], [55], and every item stating a projected T1 or T2 cycle
number.**

- **[70] NEW — THE REFRESH RULE FIRES AT CYCLE 42 AND THE NEXT T1 IS CYCLE 43.** Re-derived at cycle 41
  from `prompts/t5_select.md` step 4 and `config.yml` line 17. Cycle 40's abort shifted the phase by
  one; the T5 cycles are now 42, 45, 48, 51, 54 …; 42 % 7 == 0. **Every "the next T1 is cycle 50 / 57"
  and "the next T2 is cycle 51 / 58" statement anywhere in this project's logs, rationales and
  handoffs before cycle 41 is superseded.** Recompute rather than copy; each further abort shifts the
  parity again. Consequence: the collection-blocked routes on six of the eight issues become live for
  the first time since cycle 22.

- **[71] NEW — `ctr-0012` and its four repair steps, none of which a T4 may take.** (i) Append a
  correcting key_claim to src-0004 in `index.json` quoting the "deficiencies" sentence **whole**;
  (ii) append the same correction to `state/knowledge/src-0004.md`, whose "Key claims" item 3 and
  "Relevant quotes" both carry the truncated rendering — **this is the same second step `ctr-0011` left
  undone on src-0016 and it must not be skipped the same way**; (iii) amend
  `candidate_resolutions[3]` in place to state the divergence as over **remedy** and **causal
  attribution** rather than over acceptance of responsibility; (iv) amend `candidate_resolutions[0]`'s
  APT29 rendering from a prose attribution to a **fabricated hyperlink**. Then close the entry.

- **[72] NEW — src-0004's canonical URL now serves a heise+ paywall teaser.** The working form is the
  canonical URL with **`?seite=all`** appended; the id-only form returns HTTP 404. The validator cannot
  catch this: lines 125–127 check G1 liveness for **new sources only** and the canonical URL still
  returns HTTP 200 while serving none of the content the state cites. **This is the first confirmed
  case in this project of a stored URL going stale in content while staying alive in status**, and it
  is a general risk for every news source in the base.

- **[73] NEW — methodological rule (xv): verification-mode fetching.** A fetch may refuse whole-body
  reproduction of a news article on copyright grounds and return a summary, which rule (ix) makes
  worthless. The workaround, proven at cycle 41 on the same URL that had just refused: numbered items,
  each answered **PRESENT or ABSENT**, and for each PRESENT quote **only the single full sentence
  containing it, exactly as printed**, with an explicit instruction to answer CANNOT READ if the body
  is not visible. This returns whole sentences with subordinate clauses intact, which is what the
  amended rule (iv) demands.

- **[74] NEW — the G3 gate is load-bearing for the first time.** `institutional-incident-real-world-impact`
  scores 3 with `ctr-0012` open, so it sits **exactly at** the ceiling with zero slack. Every prior
  application sat at merit 2 with a slack of one. **While `ctr-0012` is open, any T4 that raises this
  issue to 4 will fail the validator and have its entire cycle reverted.** The route to 4 runs through
  a T3 executing `ctr-0012`'s resolution path first.

- **[4] UPDATED — the G3 gate conflict, THIRTY-SECOND cycle awaiting a human.** One sub-question is
  now settled **at source**: `scripts/validate_state.py` lines 146–149 build `open_contra` as a **set
  comprehension** over `c["issue_id"]`, so the loop at line 150 visits each affected issue exactly
  once. **The enforced gate is per-issue by construction and cannot be per-contradiction.** The
  substance of [4] — `prompts/t4_assess.md` step 3 and `config.yml` line 35 prescribe a *subtraction*
  while the validator implements a *ceiling* — is **untouched**. Cycle 41 applied the ceiling and
  refused the subtraction, as cycle 16 ruled. A second, distinct defect in the gate is also restated
  and not acted on: a contradiction entry carries exactly **one** `issue_id`, so cross-issue exposure
  (e.g. `ctr-0008` damaging `extraction-vs-reasoning-ordinal-axis`) is structurally invisible to any
  per-issue query.

- **[15] UPDATED — the curl/HackerOne source.** Still uncollected, still judged by seven successive
  cycles the highest-value uncollected source in the project, still with **no** entry in
  `state/knowledge/index.json`, and G1 forbids inventing one. **It is now reachable for the first
  time**: a T1 fires at cycle 43. It sits on `automated-triage-under-refusal`, which under tie-break
  (c) cannot be selected — so [15] and [55] are the same problem wearing two hats.

- **[30] / [55] UPDATED — the tie-break and the starvation proof.** `automated-triage-under-refusal`
  has `attempts []` in its 26th cycle and has lost **seven** consecutive selections. Cycle 34 proved
  it can never be selected under tie-break (c) while the `created_cycle=2` issues stay tied at the
  same score, and cycle 41 leaves seven issues at 2 and one at 3, so **the tie-break is the selector**.
  The cost is now maximal, because the T1 at cycle 43 is exactly the task that would discharge [15]
  and the unread src-0017 TRIAGE scorer. **A T5 must apply the policy as written and must not invent
  an anti-starvation rule.** Awaiting a human.

- **[41] UPDATED — the contradiction shapes are now ELEVEN,** with `ctr-0012` adding **omitted
  subordinate clause**: spliced quotations, unverifiable numbers, unsupported interpretive glosses,
  partial table capture, correct-but-hollow entries, correct-source-corrupted-downstream,
  over-restriction, over-generalisation, metric-identity, false-positive correction, omitted
  subordinate clause. Nineteen source-checks, eleven defects. The open policy question in [41] is
  unchanged and still awaits a human: **the G3 demotion treats all eleven shapes identically**, even
  though `ctr-0005` and `ctr-0011` were corrections that *strengthened* their issue, and `ctr-0012`'s
  limb (3) is a correction that makes the evidence *stronger* than the state recorded. Penalising an
  issue for a correction that improved it creates an incentive not to file such corrections.

---

### Verbatim reproduction of `logs/cycle-040.md` carry-forward section (lines 300-1218)

## Carry-forward items

All items from `logs/cycle-039.md` are reproduced **verbatim and in full below**, including those I
cannot act on — copied mechanically with `sed` so that no wording drifts. **This cycle's updates are
appended in a marked block after the reproduction**, not woven into it.

---

### Verbatim reproduction of `logs/cycle-039.md` carry-forward section (lines 320-1228)

## Carry-forward items

All items from `logs/cycle-037.md` are reproduced **verbatim and in full below**, including those I
cannot act on — copied mechanically with `sed` so that no wording drifts. Cycle 38 produced no log
(it aborted), so cycle 037's list is the authoritative predecessor. **This cycle's updates are
listed here first, keyed to item numbers, and the unaltered list follows.**

**New at cycle 39: [65], [66], [67], [68], [69].**
**Discharged at cycle 39: `ctr-0003` in full; `ctr-0005` in full; `open_questions[3]`'s named
verbatim re-pull.**
**Updated at cycle 39: [4], [38], [39], [41], [44 — see note], [59].**

### Cycle-39 updates and new items

**[4] — UPDATED (the G3 gate, still awaiting a human, thirty-first cycle).** Unchanged in substance;
`scripts/validate_state.py` lines 144-156 implement a **ceiling** at 3, `prompts/t4_assess.md` step 3
says **subtract 2**, `config.yml` line 35's comment agrees with the subtraction. Cycle 16 ruled for
the ceiling and every T4 since has applied it. **Nobody has ever specified whether the gate is
per-issue or per-contradiction.** New at cycle 39: `ioc-extraction-reliability` now carries **three**
open contradictions (`ctr-0001`, `ctr-0004`, `ctr-0010`). If the gate is ever ruled
per-**contradiction**, that is the issue it bites hardest, and no cycle has ever priced it that way.
Open contradictions after cycle 39: `ctr-0001` (c9), `ctr-0004` (c27), `ctr-0008` (c30), `ctr-0009`
(c33), `ctr-0010` (c35), `ctr-0011` (c39). Resolved: `ctr-0002` (c28), `ctr-0003` (c39), `ctr-0005`
(c39), `ctr-0006` (c31), `ctr-0007` (c35).

**[38] — UPDATED, and it produced a real casualty this cycle.** "A single fetch's ABSENT is not
evidence of absence." **Fifth and sixth instances recorded at cycle 39**, and one of them —
`src-0016`'s — **manufactured a false finding that survived eighteen cycles** (`ctr-0011`). The rule
must now be read as governing **a G2's own corrections**, not only the claims a G2 audits. Also new:
`/html/2503.23175v1` returned the exact string *"dataset of 350 threat intelligence reports"* as
ABSENT while `/abs` returned the abstract containing it verbatim — the **second** false negative on
that same source.

**[39] — UPDATED (version-staleness bolt-on).** Was 3-for-3 on finding material differences. Cycle 39
ran it on `src-0001` and got the **first clean result**: four versions (v1 29 Mar 2025, v2 16 Jul
2025, v3 4 Nov 2025, v4 12 Nov 2025, all 1,203 KB), unversioned `/html` resolves to v4, and **all 54
cells of Table 6 are identical between v1 and v4**. Now 3-for-4. Still worth running.

**[41] — UPDATED (the contradiction-shape taxonomy, awaiting a human).** Was six shapes, then nine.
**Now TEN.** The new shape is **false-positive correction** — a prior check's finding that does not
reproduce (`ctr-0011`). Full class: spliced quotations, unverifiable numbers, unsupported
interpretive glosses, partial table capture, correct-but-hollow entries,
correct-source-corrupted-downstream, over-restriction, over-generalisation, metric-identity,
false-positive correction. Eighteen source-checks, ten defects.

**[59] — UPDATED.** The "long clean run" watch item. It **ended at cycle 39** and ended exactly as
cycle 37 predicted it would: the run was partly an artefact of re-checking sources that earlier
defect-finding cycles had already cleaned, and the first check pointed at the **checking history**
rather than at a source bit immediately.

**[65] — NEW. `ctr-0011` step (ii) is NOT MINE AND IS UNDONE.** `state/knowledge/src-0016.md` has not
been read or amended and may carry cycle 21's false correction in its own prose, where a reader who
never opens `index.json` would meet it unqualified. The `index.json` half is done. A later cycle
should read that file, append the correction, and close `ctr-0011`.

**[66] — NEW. `src-0001`'s ARES 2025 peer-review status has ONE witness.** Cycle 25 upgraded it from
"unreviewed preprint" on the strength of an `/html` citation block. `arxiv.org/abs/2503.23175`
carries **no** Comments line, **no** Journal reference line, and only the arXiv DOI — contrast
`src-0007`, whose `/abs` page carries both. Not a contradiction, but the most load-bearing source in
this base has an uncorroborated venue. **One fetch of `https://doi.org/10.1007/978-3-032-00627-1_17`
settles it.** Cheapest outstanding provenance item in the base.

**[67] — NEW. `src-0001` reports NO fine-tuning configuration whatsoever** — no hyperparameters,
epochs, learning rate, endpoint, or fine-tuning-set size. ABSENT on two URL forms. This is why the
small-data-overfitting explanation for the post-fine-tuning calibration collapse **cannot be tested
from this source**, and it is a limitation of the source that no cycle had recorded in 39 cycles.
The fine-tuning pool is bounded by **245** reports (70% of 350, shared with the few-shot pool), not
the 350 cycle 25 recorded.

**[68] — NEW, AND IT IS A STANDING PROHIBITION.** `src-0001`'s extraction-versus-generation
calibration gradient is **metric-dependent**: it holds on ECE at all three paradigms, vanishes on
Brier at zero-shot (0.0065 gap), and **reverses** on Brier at few-shot. It holds on both metrics only
after fine-tuning, where it rests on two rows. **No cycle may state that gradient without naming the
metric it holds on.** This binds `extraction-vs-reasoning-ordinal-axis` and
`task-dependent-reliability-framing`, both of which use that split as a calibration data point; a T3
targeting either must read this before citing it. It does **not** touch the consistency half (CI
widths 0.02 vs 0.06), which is a single measurement with no competing metric.

**[69] — NEW. `src-0018`'s 41-minute human throughput baseline needs a home.** Cycle 39 ruled it does
**not** belong on `consistency-calibration-as-failure-mode` (it is a throughput fact, not a
reliability fact) and it is **not** the human-analyst F1 that `ttp-attack-mapping-reliability` has
wanted for sixteen cycles, so it cannot go there either. It is the only human-versus-LLM baseline of
any kind in this base. It stays recorded in `ctr-0005` and in `src-0018`'s source entry, awaiting a
T1 or T2 to open a throughput or cost-benefit issue.

**Standing, not mine, and passed on undone:** `ctr-0010` steps (ii) and (iii)
(`ioc-extraction-reliability`); [47](f)'s verbatim re-fetch of `eval/threat_actor.py`
(`attribution-confident-wrong-gap`); `ctr-0009`'s resolution path
(`task-dependent-reliability-framing`); `src-0007`'s unrecorded TMLR provenance (four cycles
flagged); `src-0006`'s never-read per-task scoring definitions, which cycles 33, 36, 37 and 39 all
call the largest untested load-bearing assumption in this project; [15]'s curl/HackerOne source; the
`src-0017` TRIAGE scorer, the one evaluator of three in that repository never read; and
`consistency-calibration-as-failure-mode`'s `open_questions[5]` — a second CTI-task ECE/Brier source
— now **fourteen cycles without a search** and still the single measurement that would let a T4 move
that issue off 2.

---

### Verbatim reproduction of `logs/cycle-037.md`'s carry-forward section

## Carry-forward items

All items from `logs/cycle-036.md` reproduced **including those I cannot act on**, copied forward
verbatim so that no wording drifts, with this cycle's updates marked inline as
**[CYCLE-37 UPDATE]**. Discharged items stay marked rather than deleted.
**New: [62], [63], [64]. Discharged this cycle: [27] in full. Updated: [3], [4], [27], [30], [38],
[41], [55], [59], [60].**

Cycle 36's own preamble to this section read: *"All items from `logs/cycle-035.md` reproduced including
those I cannot act on. Discharged items stay marked rather than deleted. New: [60], [61]. Discharged
this cycle: [57] step (i) only. Updated: [4], [8], [9], [11], [20], [24], [27], [28], [30], [31], [34],
[37], [39], [41], [50], [51], [53], [54], [55], [57], [59]."* — preserved here because the per-cycle
update record is itself evaluation data.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed; ordinal
axis moved to `extraction-vs-reasoning-ordinal-axis`. Cited as the precedent behind [37] and [45]. Both
halves of that split are now at 2 and fell for the same root defect — weak evidence that the split was
along the right seam.

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK metric at
all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now in its
**twenty-fifth** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not accuracy**. [44] puts
the 0.6388 itself in question. Now that the scorer's rule is known to be exact-ID matching with no
partial credit, a useful human baseline would have to be scored under the **same** rule — and exact
sub-technique assignment is a task on which two competent analysts would themselves disagree.

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. See [30] and [55]. **Now seven
consecutive lost selections**, and [55] upgrades the prediction to a proof: **structurally unreachable,
not merely unlucky.**
**[CYCLE-37 UPDATE]** Lost again at cycle 37's T5 — but **at tie-break (c) only**, having survived (a)
and (b) cleanly; see the refined proof in [55]. **The running count is disputed within cycle 36's own
outputs** — its handoff said "six consecutive lost selections", this item says "seven" — and cycle 37
declined to adjudicate rather than launder a number it had not reconstructed. What is verifiable from
the graph: `attempts: []`, `created_cycle: 16`, now cycle 37, i.e. **twenty-one cycles of existence with
zero work done on it**. Its item (3) — src-0015's unentered Reward column — was **discharged at cycle 37
as a G2 by-product**, so that fragment of the debt is paid without a selection; (1) the curl/HackerOne
source and (2) the src-0017 TRIAGE scorer remain unreachable.

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 27 CYCLES. VERBATIM FOR A HUMAN.**
The G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line
35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The enforced
reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in `logs/cycle-016.md`
"Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside this agent's output surface.
**Until a human applies it, T4s must apply the ceiling.** Under subtraction four of eight issues would
read 0 today. The per-issue-versus-per-contradiction question stays live on `ioc` (three open) and
`consistency` (two): under subtraction, is `ioc` −2 or −6? *Cycle 36 applied the ceiling on all four
contradicted issues and it bound on none.* Awaiting a human, verbatim, with [11], [30], [41], [55].
**[CYCLE-37 UPDATE] Twenty-eighth cycle unresolved.** Cycle 37 is a T5 and applied no gate, so it has
nothing to add on the merits and deliberately adds nothing. Open contradictions as of cycle 37 are
unchanged: ctr-0001, ctr-0003, ctr-0004, ctr-0005, ctr-0008, ctr-0009, ctr-0010. Note for whoever picks
this up: cycle 38's T3 is instructed to resolve ctr-0003 and possibly ctr-0005, which would take
`consistency-calibration-as-failure-mode` from two open contradictions to zero — the cleanest natural
experiment yet available on whether the ceiling has ever been doing any work, since the answer under the
ceiling reading is "no change, merit 2 was always under the ceiling of 3" and under the subtraction
reading is "0 → 2".

**[5] — DISCHARGED CYCLE 29, AND IT NEEDED NO PDF.** The src-0008 phase-label discrepancy is a
**self-contradiction in the source**, and our stored mapping is the **majority reading**. No
contradiction entry per [32]'s test. *Standing lesson: an item recorded as "blocked by an infrastructure
limit" may only be blocked by the route the recording cycle happened to try.*

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv 2506.11325;
third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines; the paywalled
eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not retry). Forward-citation sweeps have
**FAILED on two arXiv ids**. **SEvenLLM** uncollected and downgraded. **AthenaBench** still has no URL.
No arXiv companion exists for src-0018. Unavailable: OpenReview, spiegel.de ([13]). **CTIBench's own
released evaluation artefact has never been sought** — now `ttp`'s `open_question[3]`, and the **only**
route left to move `ttp` off 2. *Cycles 31–36 spent nothing here.*

**[7] — WORKED AT 21; PATH REDRAWN AT 22; STEPS AT 27, 31; SCHEDULED AT 34; THE LAST CHEAP STEP EXECUTED
AND EXHAUSTED AT CYCLE 35.** `ctr-0001`'s resolution path. **Done:** released-code route exhausted;
METRIC confound eliminated (and now *deductively*, see [57]); TTP scorer read; the HuggingFace mirror
fetched at last and it does **NOT** contain the per-model IoC predictions — a complete 52-file tree
listing with byte sizes confirms the only IoC prediction artefact is the 1,298-byte manual example, and
`TTP_Mapping.csv` at 1,083,078 bytes proves the mirror is the same repository as GitHub, not a superset.
**src-0007's recall is unobtainable from any released artefact.** Also settled negatively: the ground
truth is **nowhere stated to be exhaustive per article** (two URL forms). **Still open:** no head-to-head;
**the CORPUS confound is completely untouched**; and a **MATCHER confound** ([57]). **Every cheap step on
this path is spent. What remains is a corpus study or a new source.**

**[8] — UPDATED cycle 36. G2 COVERAGE COMPLETE; TRACKED BY STALENESS, ALSO BY REPLICATION.** src-0004
(c4, c12), src-0003 (c5; c22 — provenance partial fail, [32]), src-0002 (c6; c23 — `ctr-0002`; c28 —
`ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, [39]), src-0006 (c8; c17 partial fail [21]; re-pulled c18),
src-0005 (c9, c11; c26), src-0008 (c10; c29 — `ctr-0007`), src-0012 (c13; c31 — CLEAN), src-0011 (c14;
c33 — CLEAN, version hazard found), src-0007 (c15; c21; c30 — `ctr-0008`; c35 `/abs` bolt-on — v1 only,
TMLR provenance found, see [58]), src-0009/src-0010 (c16; c34 — BOTH CLEAN), src-0013 (c18; c35 —
CLEAN), **src-0014 (c19; c36 — CLEAN, provenance confirmed v1-only / no venue / cs.LG, coverage figures
newly anchored to Table 2)**, src-0015 (c20), src-0016 (c21 — provenance partial fail, [31]), src-0017
(c27 — `ctr-0004`; c32 — CLEAN), src-0018 (c28 — `ctr-0005`). *Next G2 by staleness: **src-0015** (c20,
**provenance never checked** and it is labelled the weakest-provenance source in this base — verifying
that label is overdue), then src-0016 (c21, and it carries the known [31](a) quotation defect, so
re-checking tests whether the defect was correctly characterised), then src-0006 (c18 — and see [21]),
then **src-0003**, never re-checked since collection and the sole support for `ioc` candidate 1.* But
see [51]: staleness is the default, not the rule.

**[9] — CORRECTED cycle 18, re-confirmed 19–23, 25–36.** `python3` present but the **permission layer**
blocks it, so **`scripts/validate_state.py` cannot be run by this agent**; compound commands rejected if
any segment is unapproved. **No PDF text extraction exists** — prefer `/html`. `gh` not approved. `awk`
refused. **`sed -n` and `cat >>` heredoc ARE approved**; a heredoc append must be its **own** call.
`jq -e . <file> > /dev/null` approved, as is a compound `jq … && jq …` chain and a `;`-separated chain of
approved commands. **`jq --slurpfile` is REFUSED**, so cross-file `jq` is impossible. **Bash `grep -n` /
`grep -c` ARE approved on the small files**; the `Grep` **tool** is necessary on the big JSON files.
Prefer **single-line `Edit` anchors**. `scores.json` and `graph.json` are NOT protected by validator lines
105–107. **`raw.githubusercontent.com` returns whole files.** **Shell variables and `for` loops are
REFUSED** (`Contains simple_expansion`). A bare Bash `grep -o -E` with a context-width pattern is REFUSED;
the `Grep` **tool** with `-o` + `output_mode: content` does it. *Cycle 36 addition: **`jq -r
'…rationale[-90:]'` prints the TAIL of a long single-line JSON value**, which manufactures ready-made
end-of-string `Edit` anchors for append-style edits — but **check uniqueness**: two of the eight
rationales ended identically and needed 230-character tails. Single-quoting every internal quotation
kept a 20,886-character `instructions` string escape-free — **eight cycles of evidence**.*

**[10] — DISCHARGED CYCLE 26; NEVER ACHIEVABLE.** src-0005's per-model numbers do not exist in text —
every per-model score is inside Figures 8, 9, 12–16. **Do not re-attempt without a new route.** See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND AT 27, 30, 34. VERBATIM FOR A HUMAN.** Tie-break 3a in
`prompts/t5_select.md` is under-specified and there is **no deterministic tie-break after 3c**. In four
parts: **(a)** a terminal tie **must** be written into the prompt; **(b)** the prompt lists **3a before
3b**, but 3b is an addition *to the score*, so a literal a-then-b ordering lets them return **opposite
verdicts on the same pair**; **(c)** "within the last 5 cycles" has three defensible readings — cycle 34
resolved (c) as harmless in practice but found the two readings of **3a** differ on whether an issue with
*no edges at all* survives it, which is the ambiguity burying `automated-triage-under-refusal`;
**(d)** the prompt has **no aging term** — see [55]. Cycle 34 hit a terminal tie for the third time and
broke it by documented judgement. *Cycle 37 is a T5 and will meet this again with seven issues tied.*
Passed on verbatim with [4], [30], [41], [55].

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with standing to
split an issue, add an issue, or reconcile the prompt/validator disagreement. The claim that the loop
"never returns to T2" is false; cycle 16 disproved it. *The next T2 is **cycle 51**. [37] and [45] are
both T2 jobs and both wait another fifteen cycles.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is the
upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF route is also
closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own writeup is the only
remaining route known. OpenReview joins this category ([6]).

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2 PDFs
cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level and UNVERIFIABLE
at document level here. **Do not re-spend budget.** Cycle 34 re-confirmed the landing-page half cleanly at
both pages without touching the PDFs.

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, DEFERRED A TWELFTH TIME.** The
curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop" reports; ~20% of
submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to under 5%) is an
`open_question` on `automated-triage-under-refusal`. **It is a question, not evidence — no curl source
exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26–36 all judge it the highest-value uncollected source. *The earliest T1 route is **cycle
50**; a T3 targeting that issue could reach it sooner ([29]) — but per **[55]** no T3 will ever target that
issue under the current tie-break, so **this is blocked on a prompt change, not on budget**.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the base-rate
question. Verbatim from `https://gptzero.me/investigations/ey`: an *"automated pipeline to search for vibe
citations by finding and scanning public reports from major consulting firms"*. A T1 should chase
`gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor; no *rate* published; the
scorecard widget renders as "0 of N" to automated fetch. **Still the only route any cycle has found to a
base rate**, the binding constraint on `institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the escape to
T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16. Structural finding for the
paper: the only task type that can restructure the issue graph fires when a T5 coincides with a multiple of
7 — under a clean three-cycle loop, **once every 21 cycles**.

**[18] — DISCHARGED CYCLE 33 AS *CONFIRMED*.** src-0011 contradicts itself in prose vs table: body text
*"NeurIPS exhibiting the highest absolute count (**391 papers**)"* against a table row giving **Invalid =
391, Papers = 308**. Reproduced verbatim from **both v1 and v2**, so it is durable. No claim in our base
repeats the error; **no G3 entry was opened**. **Quote src-0011's *counts* from the table's columns, never
from that sentence.** *Self-contradicting sources in this base: src-0011 (prose vs table, and a 738-vs-739
slip, [53]), src-0002 (Micro-F1 vs Macro-F1, [44]), src-0008 twice (phase labels [5]; metric definitions
[46]), src-0007 (rubric dimension defined twice, [47]), src-0017 (docstring/README vs live code). **Five
sources, eight instances.** Cycle 36 checked src-0014 for a ninth and found none — its body-sentence
coverage figures are exactly `100 −` its Table 2 abstention cells.*

**[19] — FULLY DISCHARGED CYCLE 21; RESIDUE PARTLY DISCHARGED CYCLE 30.** src-0007's Table 4 pulled **whole
and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall (Accepted) **0.9091–1.0000**.
**THE ANOMALY IS UNRESOLVED AND REPRODUCED THREE TIMES:** GPT-4o (FT) tracks o3-mini to within 0.001 on
**all six** `Content: Threat Actor` rubric rows, identically at c15, c21 and c30, on two URL forms.
**As-printed, cause unknown, DO NOT GUESS.**

**[20] — DISCHARGED cycle 21; RESIDUE **FULLY DISCHARGED AT CYCLE 36**.** All four cycle-15 sources
verified: src-0013 (c18), src-0014 (c19), src-0015 (c20), src-0016 (c21). Cycle 35's G2 on src-0013 verified
the Gemini 0.161 → 0.721 leg verbatim; **the FT discrepancy does NOT close and the prohibition stands** —
Table I is "SALLM, n=2,000 per temperature" and Table IV is "verbatim averages across six temperature
settings", and 33.9% is not recoverable from 16.9%→83.2% by any aggregation the paper states. *Cycle 36
closed the src-0014 half: the four F1 figures **are** body-sentence-only, confirmed, and that is now a
recorded fact rather than an open residue — Appendix E's Table 4 does not render on either URL form. **Still
live: src-0015's and src-0016's provenance labels are unchecked.***

**[21] — CONFIRMED AND PARTIALLY REPAIRED cycle 18; STILL THE ONLY KNOWN UNCORRECTED SOURCE FILE.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs 0.688 for a
general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is **G5 at 0.677**.
Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90" against a true span of
**0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`; **`src-0006.md` is still
untouched and still carries the wrong sentence.** *`ctr-0009` step (iii) sends a T3 to src-0006 anyway.
Still undone at cycle 36.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are **strictly
monotone decreasing across all eight general-purpose columns in exactly the printed column order**; four are
in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis` depends on. One row matching a fixed
eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.** **Any finding resting on
that table must carry a robustness check excluding those rows** (cycle 18's: drop all four → 0.641 vs 0.592,
gap 0.049, same direction).

**[23] — STANDS, for the next T2.** Mean between-**model** range within a task (0.272) and mean
between-**task** range within a model (0.263) are equal to within 0.009. This does **NOT** negate
`task-dependent-reliability-framing`'s supported claim — it qualifies the implication that sub-task is the
*privileged* explanatory variable. A T2 should annotate rather than re-scope. No contradiction: both facts
hold. *Note [57]: both figures are themselves **unaudited derived quantities**.*

**[24] — NEW cycle 18, USED THROUGHOUT 19–23 AND 25–36. `jq` IS INSTALLED AND APPROVED.** Every cycle from 9
to 17 recorded that this agent cannot validate JSON and must check "by construction". **That advice is wrong
and expensive** — cycle 17 lost its entire `state/` output. **Every JSON edit should be followed by `jq -e`**
*and* a `jq -r` read-back of the fields added. The permission layer is **not uniform** — probe once. The
`Grep` **tool** works on the big JSON files where Bash `grep -n` does not. Cheapest pattern:
**`grep`/`Grep`/`jq` → `Read` with `offset`/`limit` → `Edit` → `jq -e` → `jq -r` read-back.** *Cycle 36 ran
eleven `Edit`s across two JSON files through this pattern with zero failures, and re-confirms the economy: a
**single small `Read`** (one line, `offset`/`limit`) unlocks the whole file for editing.*

**[25] — DISCHARGED CYCLE 21; REOPENED AND ENLARGED CYCLE 30.** `src-0007.md` contains the `Content: Threat
Actor` rubric block in full, and the caveats keep travelling: the rubric's **absolute level is
uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, **re-confirmed ABSENT at c30**), so
**only within-table contrasts may be cited**; the GPT-4o (FT) column is suspect per [19]; and **`Attribution`
means SOURCE LINKING in the Threat Actor block and ACTOR IDENTIFICATION in the Root Cause block**, so
cross-block contrasts are not automatically safe either. See [47]. *Standing lesson: "the table is captured
verbatim" and "the metric is understood" are different claims.*

**[26] — NEW cycle 18, PARTLY ACTED ON BY A HUMAN AT CYCLE 33.** **Why cycle 17 failed validation is unknown
and unrecoverable.** Suggested fix: tee `python scripts/validate_state.py` output into
`logs/cycle-NNN-validation.txt` before reverting, and `git stash` the rejected `state/` diff. *Commit
`956a36c` (a human) fixed the **agent-death** half. **The logging half is still undone.*** *Per [9] the agent
cannot run the validator itself, so a cycle has **no way to see why it failed** — which is what makes the
logging half matter.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER SIXTEEN CYCLES.** src-0015's Table 1 has a
**`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61,
DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward.** Bears on
`automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward composition unstated; n=40 per model,
no CIs; association not strictly monotone. **A rationale is not the graph.** *Cycle 36 verified against the
graph per [59] rather than trusting the tracker: `automated-triage-under-refusal` has **one**
`candidate_resolution` and five `open_questions`, and no Reward figure appears in either. **The item is
genuinely still undone.** A T4 has no standing to enter it; only a T3 targeting that issue can — and per
[55] no T3 ever will under the current tie-break.*
**[CYCLE-37 UPDATE] — DISCHARGED IN FULL, by a route nobody had considered.** Cycle 37's G2 landed on
src-0015 by staleness, and because rule (iv) says pull the whole table rather than the rows the claim
needs, the Reward column arrived as a by-product. It is now in `state/knowledge/index.json`
`src-0015.key_claims[6]` and in `state/knowledge/src-0015.md`, **verbatim and confirmed at source**:
Reward 3.07 / 2.37 / 2.61 / 3.45, plus a **`Threshold`** column no cycle knew existed (GPT-5.2
"Uncalib."; Sonnet 4.5, Gemini 3 **and** DeepSeek 3.2 all "Part. Cal." — so three models are classified
partially calibrated, not the one the abstract names). Two of the tracker's three caveats are now
resolved: **the reward composition is no longer unstated** (verbatim definition entered: attribution
+1/−0.5, containment +1 per correct action and −0.5 per false positive, injection −2 per violation,
efficiency −0.1 per step), and the "no CIs" caveat is confirmed at source for v3. The prediction that
"the model the paper calls best-calibrated earns the lowest reward" **is correct**. **THE LESSON, WHICH
IS THE REUSABLE PART:** an item blocked on a starved issue was discharged by a *knowledge* append, which
any cycle may make, rather than by the *graph* edit the tracker assumed was required. Before writing off
a carry-forward item as unreachable, ask whether its content is a source fact (appendable by anyone) or a
graph fact (T2/T3 only). **What remains graph work and is NOT discharged:** connecting the Reward finding
to `automated-triage-under-refusal`'s `open_questions[0]` inside the issue itself. See new item [64].

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–36.** The state machine is T1→T2, T2→T3, T3→T4, T4→T5,
T5→T3. **Positions: cycle 36 = T4 (this one), 37 = T5**, T5 thereafter on 40, 43, 46, **49**. The refresh
fires only when a T5 **runs on** a multiple of 7; 49 is both, so **the next T1 is cycle 50 and the next T2 is
cycle 51.** *Cycle 36 re-derived this from `config.yml` independently and it matches cycles 32–35.* **THE
HEADLINE: cycle 24's crash pushed collection back eight cycles and cycle 31's max-turns death another seven.
Two partial failures have cost fifteen cycles of collection and restructuring capacity.** **Re-derive rather
than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21, 25, 30–35.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018. **Standing lesson:
read the task's own prompt file, not only the queue entry's description of it.** *Cycle 36 read
`prompts/t4_assess.md` at source and found the handoff accurate on it — nine clean handoffs in a row on the
prompt itself. **Cycle 35's finding that handoffs err on their own job PREMISES rather than on the prompt
holds again**: see [59] and the note at the top of cycle 37's queue entry.*

**[30] — NEW cycle 20; PREDICTION CORRECT SEVEN TIMES; UPGRADED TO A PROOF AT CYCLE 34, SEE [55]. VERBATIM
FOR A HUMAN.** `automated-triage-under-refusal`, the only issue never worked on (`attempts: []`, created
cycle 16), has **lost seven consecutive selections**. **"Never attempted" is not a tie-break in
`prompts/t5_select.md`**, and cycle 19's rationale wrongly asserted it was. **This is a prompt change for a
human.** Note the interaction with [11]: under one reading of 3a it is eliminated outright for having no
dependents; under the literal pairwise reading it survives 3a and dies at `created_cycle`, so **the newest
issues in a graph are structurally disadvantaged forever, with no expiry**. With seven issues tied at 2
([54]), `created_cycle` is doing almost all the selecting in this project.
**[CYCLE-37 UPDATE] — THE 3a AMBIGUITY THIS ITEM FLAGGED WAS FACED AND RESOLVED IN PRACTICE, AND THE
LITERAL PAIRWISE READING IS THE ONE CYCLE 37 APPLIED.** The item's own conditional turned out to be the
live branch: `automated-triage-under-refusal` **survives 3a** (it has no dependency edges in either
direction, so nothing outranks it), **survives 3b** (`attempts: []`, so no penalty), and **dies at 3c on
`created_cycle` 16 against 2**. Cycle 37 states the reasoning for the pairwise reading so a human can
overrule it cheaply: the prompt's text is "an issue that others `depend_on` outranks **its dependents**",
which is a relation between an issue and its dependents and says nothing about issues with no path
between them; the "eliminated for having no dependents" reading would require the rule to mean "issues
with dependents outrank issues without", which is not what it says. A depth-in-the-DAG reading gives the
same four survivors. **Two further defects in the rule surfaced this cycle and are new work for a human,
not opinions to be re-litigated by an agent:** (i) `prompts/t5_select.md` writes the field name as
`depend_on` while `graph.json` and its own `_schema` use **`depends_on`** — a jq projection on the
prompt's spelling returns `null` for every issue and makes tie-break 3a silently vanish, which is exactly
the kind of error no gate in this project would catch; (ii) 3b's window, "within the last 5 cycles", has
**undefined endpoints**, and under the alternative window (33–37 rather than 32–36)
`ttp-attack-mapping-reliability` would have reached 3c tied with the winner at `created_cycle` 2 with
**no further tie-break specified at all**. Cycle 37 did not have to resolve that, and flags it rather
than inventing a fourth tie-break.

**[31] — NEW cycle 21, EXTENDED 22–36. THE VERBATIM CHECK HAS NOW RUN ON **SIXTEEN** SOURCE-CHECKS; NINE
PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim" quotation **does not exist on the page**.
(b) **src-0003** (c22): quotations passed, stored *numbers* 76/72/86 are **figure-image-only**. (c)
**src-0002** (c23): all 25 numbers exact, **interpretation contradicted by the paper's own metric
definition**; `ctr-0002`. (d) **src-0001** (c25): numbers exact, **calibration gloss contradicted by the full
table**; `ctr-0003`. (e) **src-0005** (c26): all claims **PASS** — but stored with no task format, metric
definition, sample counts, limitations or numbers. (f) **src-0017** (c27): every stored string **PASSES**,
the **DOWNSTREAM PARAPHRASE** dropped the hedges; `ctr-0004`. (g) **src-0018** (c28): every quotation
**PASSES** — the stored **SCOPE** is wrong by being **TOO RESTRICTIVE**; `ctr-0005`. (h) **src-0002 again**
(c28): two more glosses, one **FALSE against the printed table**; `ctr-0006`. (i) **src-0008** (c29):
quotations and numbers **PASS**, one claim **OVER-GENERAL**; `ctr-0007`. (j) **src-0007** (c30): all 34 rows
PASS, **THE METRIC IS DEFINED TWICE UNDER ONE NAME**; `ctr-0008`. (k) **src-0012** (c31): CLEAN. (l)
**src-0017's TTP scorer** (c32): CLEAN. (m) **src-0011** (c33): CLEAN. (n) **src-0009 + src-0010** (c34):
CLEAN. (o) **src-0013** (c35): CLEAN. **(p) src-0014 (c36): CLEAN — four F1 figures and eight recall-drop
figures verbatim, five coverage percentages newly anchored to Table 2 by exact arithmetic, provenance
confirmed v1-only / no venue / cs.LG for the first time.** **The defect class is nine-way** — spliced
quotations, unverifiable numbers, unsupported interpretive glosses, partial table capture, correct-but-hollow
entries, correct-source-corrupted-downstream, over-restriction, over-generalisation, metric-identity.
**SEVEN consecutive clean checks.** *Cycle 34's caveat has now weakened but not vanished: cycles 31–35 all
checked sources that had already survived one pass, and **cycle 36 is the second of the four second-pass
backlog sources cleared** (after src-0013) and the **second provenance label checked among them**. src-0015
and src-0016 remain untested on both axes. **A long clean run is also what a checking process that has
stopped biting looks like — [60] is the first evidence this cycle that it has not.***
**[CYCLE-37 UPDATE] — SEVENTEEN SOURCE-CHECKS; NINE PRODUCED A DEFECT; EIGHT CONSECUTIVE CLEAN.**
**(q) src-0015 (c37): CLEAN** — all six stored quotations and all four EGAR cells verbatim from
`/html/v3`; **every provenance label confirmed at source for the first time** (sole author, cs.AI with no
cross-list, no journal reference, no venue in `Comments`, no CI/Wilson/95% sentence anywhere), so the
"weakest-provenance source in this base" label is now *verified* rather than *asserted* — the first time
that has happened in this project. Two additions rather than corrections: a **three-version history whose
numbers changed materially** (see new [62]) and the **Reward/Threshold columns** ([27], discharged). One
benign trap recorded for future string-searchers: `92.5` and `57.5` are ABSENT as literal strings because
they are Table 1's `0.925` and `0.575` rendered as percentages by this base. **The defect class stays
nine-way; nothing new was needed.** *Cycle 34's caveat is now the single most important qualifier on this
item and cycle 37 restates it deliberately: **the eight-cycle clean run is partly explained by where the
checks have landed.** src-0015 was one of the two remaining untested-on-both-axes backlog sources and it
came back clean; **src-0016 is now the last of them**, and it is the one carrying a known unresolved
quotation defect from cycle 21. After that, the honest test of whether the process still bites is
**src-0003 — never re-checked since collection, and the sole support for `ioc-extraction-reliability`'s
candidate 1.***

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline F1 values are
figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not text-verified.** Also
unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction when the source's own legible text
conflicts with the stored claim; do not file when the stored claim is merely unverifiable.** *Cycle 35 found
the test's first edge (`ctr-0010`: state versus a prior cycle's own derivation, no source on either side).*
**Cycle 36 found a second edge: an over-precise gloss inside a `scores.json` rationale, where the gloss
conflicts with a graph finding but neither is a source claim.** *Cycle 36 restated two such glosses in place
and filed nothing, on `ctr-0010`'s precedent that `scores.json` is unprotected and a T4 owns it.* **Six uses,
correct every time, but its scope needs widening on two axes when a human writes it into
`prompts/system.md`.**

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.** src-0003's
97.6% is measured on a **closed-set classification task over a regex-extracted candidate set**, not free-form
extraction — *"We assume a total of 1,789 candidate indicators, extracted using IoC Searcher"*; Figure 9's
caption "… on IoC Classification." **A difference in task format, stated by the paper.** **Companion finding:
src-0003 NEVER STATES ITS MATCHING RULE** (`src-0003.md` line 141). *Cycle 36 note: this is why the
`P ≥ 0.9531` entailment eliminates only the METRIC confound and not the gap — the entailed precision is a
**classification** precision, and the MATCHER correction is unsigned on src-0003's side too. **Do not re-buy
it** — probably unresolvable from this base.*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3. HALF DISCHARGED AT CYCLE
31; PRICING DISCHARGED AT CYCLE 33; **THE SIGN CLAIM WITHDRAWN AT CYCLE 36**.** **A within-study design holds
team, corpus, models and harness constant but does NOT hold the scoring rule constant.** Cycle 31's fetch gave
the **worst case for the objection's target**: src-0007's IoC and ATT&CK sub-tasks are scored by **different
kinds of rule**, so the within-study comparison is **refuted, not rescued**. *Cycle 22's sharpest form — "the
sign of the confound is known and it points the same way as the finding" — **IS NOW WITHDRAWN AS TOO STRONG,
and cycle 36 corrected it in `scores.json` in both places it appeared.** Per `ctr-0004` and `open_questions[6]`
the one-directional IoC rule is lenient toward fragmentary predictions and strict toward verbose ones, so its
**net sign is the difference of two unmeasured quantities and is UNKNOWN**. **The surviving form: the IoC
matcher HAS a leniency channel and the ATT&CK matcher has NONE, so the rules are of known different
character.** A confound of unknown net sign is still a confound — it just cannot be asserted to MANUFACTURE
the observed spread, only to make it uninterpretable. **Neither score moved**, because the level-3 bar turns
on independent-source support, not on the strength of the objection.* Known non-commensurable instances:
src-0017/`ctr-0004`, src-0003, src-0005, src-0002/`ctr-0006`, src-0007's rubric against itself ([47]),
src-0007's IoC rule against its own ATT&CK rule, src-0008's body against its Table 6 caption ([46]).
**Seven.** **STILL OPEN AND THE PROJECT'S LARGEST UNTESTED LOAD-BEARING ASSUMPTION: src-0006's per-task metric
definitions have never been pulled** — `ctr-0009` step (iii). *Cycle 36 endorses that ranking explicitly.
Blocked by the tie-break, not by budget (the other such block is [15]).*

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible` columns are
**nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements (incorrect = 100 − Plausible =
**14 / 38 / 26 / 20 / 64%**) are in the graph **with their derivation stated**; `ctr-0002` CLOSED. *Note [57]:
those five derived points are **unaudited against their own derivation**.*

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all executed. **The
consequences did not stay inside the issue: see `ctr-0006` and [44].** *The G2 staleness heuristic and the
scoring rationales work as a pipeline. **Closing a contradiction should itself schedule a replication.** **A
finding's effect on the scores can lag its discovery by several cycles, and nothing in the loop tracks that
debt except carry-forward.*** *Cycle 35 closed the extreme case: `ctr-0004`'s T3 half waited **eight** cycles
and `ctr-0007`'s **six**, both for want of a selection — and both were discharged in a single cycle once the
selection came. **Cycle 36 supplies the T4-side counterpart: `ctr-0010` step (i) waited exactly one cycle,
because the handoff named it and the state machine put a T4 next.** The lag is bounded by the selector, not by
attention.*

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28–30, 33, 34, **36**. THE ISSUE ASKS TWO QUESTIONS AND THE
EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks about
**consistency** *and* **calibration**. Consistency-on-CTI rests on **two independent sources** (src-0001 +
src-0018, **both at temperature 0**), calibration-on-CTI on **one** (src-0001, gpt4o only), and `ctr-0003`
sits on the calibration half alone. Natural cut: `consistency-under-repeated-query` vs
`confidence-calibration-on-CTI`. **Only a T2 can split an issue** ([12]); **next T2 is cycle 51.** *One of
**three** issues in that position. This issue was the runner-up in cycle 34's terminal tie and is a live
cycle-37 candidate.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27, TWICE AT 28, AT 30, 31, 33, 35 AND **36**. A SINGLE FETCH'S
"ABSENT" IS NOT EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an ABSENT verdict
must be confirmed against a second URL form.** Before recording an absence check **(1)** the abstract, **(2)**
a different URL rendering, **(3)** that you fetched the file the claim actually cites, **(4)** that the
**VERSION** you fetched contains the material at all. **The rule also applies to a PARAPHRASED verdict: a
summarised PRESENT is as untrustworthy as a bare ABSENT.** *Cycle 31 found the rule's limit — both URL forms
of `TTP_Mapping.csv` failed the same way ([49]). Cycle 32 added that a verdict about which of two competing
texts EXECUTES is not a PRESENT verdict at all. Cycle 33 added: when two fetched numbers conflict by one
digit, ask whether EACH SIDE IS INTERNALLY CONSISTENT before suspecting the fetch.* **Cycle 36 paid off on the
paraphrase limb specifically and in a new direction — see [60]. Cycle 36 recorded no ABSENT verdict at all, so
the primary limb was not exercised.**

**[39] — NEW cycle 25, EXTENDED 26–29; THE VERSION AXIS PAID OFF AT 33; THE PROVENANCE AXIS PAID OFF AGAIN AT
35 AND **36**.** Provenance labels in this base were set at collection time and are mostly still unchecked.
src-0001 **is peer-reviewed** — ARES 2025, Springer, DOI `10.1007/978-3-032-00627-1_17` — and this base called
it a preprint for 24 cycles. src-0005 goes the other way: **an unreviewed preprint**. *Cycle 35: src-0013's
"ICSME 2026 Research Track" **CONFIRMED exactly**. **Cycle 36: src-0014's "v1 preprint, no stated venue"
CONFIRMED exactly** — `Comments:` and `Journal reference:` both ABSENT, no venue anywhere, v1 only (22 May
2026), and it is filed **cs.LG primary, not cs.CR**, which no cycle had recorded. **Still unchecked:
src-0015's "single-author preprint" label — now the last one, and the next G2 target.** **And src-0007 turns
out to be published — see [58], STILL UNRECORDED after two cycles of flagging.*** Version checks run:
src-0008 (c29), src-0011 (c33), src-0009/src-0010 (c34), src-0013 and src-0007 (c35), **src-0014 (c36, v1
only)**. **Run the `/abs` check on every arXiv source you touch: one fetch, and it has now produced a finding
on three of seven sources checked.**
**[CYCLE-37 UPDATE] — BOTH AXES PAID OFF AGAIN, AND THE PROVENANCE BACKLOG IS NOW EMPTY EXCEPT src-0016.**
src-0015's "single-author preprint, cs.AI, no stated venue, peer review or affiliation" — flagged here as
"the last one" — was checked at cycle 37 and **CONFIRMED exactly, element for element**: sole author
Jarrod Barnes, `Subjects: Artificial Intelligence (cs.AI)` with no cross-list, `Journal reference:`
ABSENT, `Comments:` naming only page counts, a code repo and a dataset with **no venue**, and the arXiv
DOI as the only DOI. **The version axis produced the finding this time, not the provenance axis:** three
versions (v1 28 Jan, v2 30 Jan, v3 6 Feb 2026) whose headline false-positive rates differ materially and
one of whose headline metrics (**EGAR**) did not exist in v1 — see new [62]. **Running tally on the
`/abs` bolt-on: eight arXiv sources checked, four produced a finding.** Version checks now run: src-0008
(c29), src-0011 (c33), src-0009/src-0010 (c34), src-0013 and src-0007 (c35), src-0014 (c36), **src-0015
(c37, THREE versions)**. **src-0007's TMLR provenance is STILL UNRECORDED after three cycles of flagging
— see [58]; it is a two-minute append that any cycle may make.**

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND THIS BASE
CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: *"the share of questions for which the system
selects all correct options and only the correct options."* Questions **generated by Llama 3.2 90B and Llama 4
Maverick**; the paper concedes *"performance bias … where the model under test is the same, or has
similarities with the set of models that were used in synthetic data generation pipelines"*. **(a)** Its
percentages are not commensurable with src-0002's F1 or src-0007's precision/recall. **(b)** It reports **no
ATT&CK metric at all**. **(c)** 23–34% (MA) against 43–53% (TIR) is **NOT a controlled contrast**. **Anyone
using it must state those three confounds.**

**[41] — NEW cycle 26, REINFORCED 27, 28, ANSWERED IN PART BY 29, EXTENDED BY 30, 32, 33, 34, 35. THE G3
CEILING BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS. VERBATIM FOR A HUMAN.** An honest,
stingy T4 demotes issues carrying open contradictions, which moves them *away* from the ceiling. **So the
validator's G3 check is very nearly dead code, while the prompt's subtraction rule — which every T4 has
correctly refused to apply — would fire on four of eight issues today and drive them toward 0 without
tripping anything.** Shapes documented: **(1) undermining** (`ctr-0001`); **(2) strengthening** (`ctr-0005`);
**(3) two-directional** (`ctr-0007`); **(4) support-relocating** (`ctr-0008`); **(5) closes without the
underlying source defect being repaired** (`ctr-0006`); **(6) damages issues OTHER than the one it is filed
against** ([52]); **(7) closed by the very cycle sent to act on it, with a simultaneous opening leaving the
per-issue count unchanged — so the gate sees no change from a cycle that materially repaired the issue**
(`ctr-0007`/`ctr-0010`). **Seven shapes, one binary gate. A binary per-issue gate cannot represent repair.**
*The dead-code observation holds for an **eighth** cycle: at cycle 36 the ceiling binds on **zero** of the
four contradicted issues.* **Cycle 34's generalisation, restated: this is the THIRD instance of a mechanism
that degrades as the rest of the loop improves — the G3 ceiling ([41]), the weakest-link selector under
compressive scoring ([54]), and the starvation proof ([55]). Whoever designs the successor system should treat
"does this mechanism get worse when the agent gets better?" as a standing design question, not three separate
bugs.** Passed on verbatim with [4], [11], [30], [55].

**[42] — NEW cycle 27; `ctr-0004` OPENED; T3 HALF FULLY DISCHARGED AT CYCLE 35 AFTER EIGHT CYCLES.**
src-0007's released IoC matcher is **one-directional, not two**: `any(pred.lower() in gt.lower() for gt in
gt_set)` — **a prediction must be a SUBSTRING OF a ground-truth entry**. The two-directional and exact-match
variants are **inside triple-quoted string literals and never run**. **The bias is ASYMMETRIC:** lenient
toward short/fragmentary predictions, **strict against verbose predictions**, which are penalised **TWICE**
(FP and FN). The shared normalisation chain partly mitigates the deflation by stripping defanging and
truncating at `" - "`. **"Substring-permissive, inflates true positives" is half right and must not be
repeated unqualified. NET SIGN UNKNOWN.** *Cycle 36 propagated this into `scores.json` on two issues — see
[34] — which is the downstream half nobody had done.* **`ctr-0004` STAYS OPEN** because its subject is now the
live MATCHER confound on `ctr-0001`.

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005` OPENED; REPAIRED
BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images — **confirmed a third time**. But
the page states in plain text: a **41 min/report human-analyst baseline** against ~**3.3 min**; **17 metrics
each a ratio 0–1**; and **"the LLM temperature parameter was set to 0"**. **The temperature-0 fact strengthens
`consistency-calibration-as-failure-mode`** and was fenced off for three cycles by an over-broad hedge.
**Standing lesson: a hedge is a claim and must be scoped as precisely as an assertion.**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC; `ctr-0006` OPENED AGAINST
`ttp-attack-mapping-reliability`; CLOSED AT CYCLE 31.** **(a)** Section 4.2 says *"We adopt the **Micro-F1**
score…"*; Table 1's header reads **"CTI-ATE (Macro-F1)"**. **0.6388's metric is ambiguous by the paper's own
text.** **(b)** The cross-task difficulty comparison was **ours** and subtracts multi-class **accuracy** from
multi-label **F1**. **(c)** key_claims[2] is **FALSE against Table 1**. **(d)** The **ATT&CK correctness rule
is never stated**. **(e) arXiv v2 has NO CTI-ATE task at all** — always fetch v3. *(a) and (d) are NOT
repaired and cannot be from this paper — they travel as permanent qualifiers, and they are why `ttp` is held
at 2.*

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29 AND AGAIN BY 33 AND 36.**
`attribution-confident-wrong-gap` **bundles a well-evidenced question with an unevidenced one, and only a T2
can fix it.** The **error-rate** half is well grounded (src-0002's derived 14–64% incorrect bucket on 50
alias-tolerant real reports). The **confidence** half has **no evidence at all** — no source in this base
measures expressed confidence on threat-actor attribution. Natural cut: `attribution-error-rate` vs
`attribution-confidence-calibration`. **Next T2 is cycle 51.** *Successors must not quote the corroborating
parenthesis unqualified: the "within-table rubric contrast" as stated differences two different metric
definitions ([47]). The direction survives at **block** level only.*

**[46] — NEW cycle 29; `ctr-0007` OPENED; FULLY DISCHARGED AND `ctr-0007` RESOLVED AT CYCLE 35 AFTER SIX
CYCLES.** src-0008 contains two self-contradictions and its per-phase numbers are image-locked. **(a) THE
STORED CLAIM IS OVER-GENERAL** — *"Cohere, however, shows progressive degradation: 1% missed detections in P1,
2% in P2, 5% in P3, and in P4, 65% misses plus 35% explicit 'Don't Know' responses"* — and **P1–P4 contain no
cryptography**. **(b) IT DEFINES ITS METRICS TWICE, INCOMPATIBLY.** **(c) PHASE LABELS** — see [5]. **(d)
PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE 2**, so the stored percentages are **figure-derived**. **(e)
TABLE 6 IS READABLE AND WAS NEVER CAPTURED** — DR 38.5 / 38.6 / 38.5 / 35 / 22.8%, **aggregates over all
thirteen phases, never per-phase**. **(f) PASSED:** Table 7 and the abstract. *Cycle 35 decided the question
cycle 29 declined: the model-side variance **cuts both ways**, the candidate stays `proposed`, and **src-0008
cannot adjudicate the hypothesis at all** because its task is JavaScript source code while the candidate is
about narrative threat reports. src-0008 is **demoted to illustration only**, retained to preserve the trail.*
**What the closure does NOT repair: `key_claims[0]` still literally contains the over-general sentence and
cannot be deleted; its correction is `key_claims[3]`; anyone citing [0] must read [3].**

**[47] — NEW cycle 30. src-0007's "ATTRIBUTION" RUBRIC IS TWO DIFFERENT METRICS UNDER ONE NAME; THE JUDGE IS A
MODEL UNDER TEST; `ctr-0008` OPENED. (d) DISCHARGED AT CYCLE 33.** **(a)** Appendix C.2 prints separate
criteria blocks. **Threat Actor**: *"…5: Fully attributable; all details are clearly linked to the original
article."* — **source linking**. **Root Cause**: *"…5: Perfect attribution; clearly identifies the threat
actor."* — **actor identification.** **The labels run OPPOSITE to how the state read them.** **(b) WHAT
SURVIVES:** the **block-level** contrast — GPT-4o lower on **all six** dimensions (1.547 / 1.528 / 1.145 /
2.019 / 1.734 / 1.140 vs 3.686 / 3.458 / 3.362 / 3.932 / 3.753 / 3.612). **(c) THE JUDGE IS GPT-4o**, one of
the four scored models; in the source's favour, *"an agreement rate … exceeding 95%"*; self-preference would
inflate GPT-4o's own scores and GPT-4o scores **lowest**. **Any citation of the GPT-4o-vs-o3-mini gap must
state that GPT-4o was the judge.** **(d) — DISCHARGED CYCLE 33.** **(e)** The third candidate's stated reason
for being `proposed` is discharged ([19]). **(f) ACTION, STILL OPEN AND NOT MINE:** `eval/threat_actor.py` **was
NOT obtained verbatim** — the fetch returned a summary, untrustworthy under rule (ix). **Re-fetching it
verbatim is step 1 of `ctr-0008`'s repair and remains a job for a T3 targeting
`attribution-confident-wrong-gap`.** *Cycle 35 confirmed the file exists and its size —
`stage3_ti_drafting/score_evaluation/eval/threat_actor.py`, 7,017 bytes — so the fetch is known to be cheap and
the file small enough to return whole. **Passed on undone for the third time at cycle 36.***

**[48] — FORMALISED AT CYCLE 32. A PROVENANCE GRANULARITY SPLIT IN src-0012.** `src-0012.md` carries the
corroborating Going Concern URL in full, but `index.json`'s `key_claims[3]` names the outlet **without its
URL** and `key_claims[0]` attributes the study's **2025** date **with no outlet at all**. The `consulting.ca`
headline URL states **no year**; the year **is** supported verbatim by Going Concern. **A granularity weakness,
not a fabrication.** No contradiction warranted. **Cheap fix for any future cycle touching src-0012: append
the outlet and URL to the two `index.json` key_claims.**

**[49] — FORMALISED AT CYCLE 32 FROM CYCLE 31's NEAR-MISS; APPLIED PRE-EMPTIVELY AND SUCCESSFULLY AT CYCLE
35.** A byte-size check from the hosting API must precede any ABSENT verdict over a large file. Cycle 31
fetched `data/TTP_Mapping.csv` twice and got 57 lines / 59 TechniqueIDs with four ABSENT verdicts. **Taken at
face value that is a devastating finding. It is false.** The GitHub contents API reports the file at
**1,083,078 bytes**; both readings were **truncation artefacts** and the ABSENT verdicts are **void**. **This
is the limit of [38]: both URL forms can fail the same way for the same reason.** *Cycle 35's Job E applied
this **before** fetching: the **HuggingFace tree API with `recursive=true`** returned a complete 52-file
listing with byte sizes in one call, made the "no per-model predictions" verdict authoritative, and
independently re-confirmed the 1,083,078-byte figure from a different host. **For any HuggingFace repo, hit
the tree API first.***

**[50] — NEW cycle 32; HARNESS HALF FIXED BY A HUMAN AT CYCLE 33.** A cycle can land its research, fail its
bookkeeping, and be committed as "run failed, no state change". Cycle 31 exhausted `max_turns: 50` after
committing four state files but before writing its last three log sections, **any carry-forward section**, or
either queue file, and `git log` describes it as **"run failed, no state change"** — **wrong on both counts**.
**THREE THINGS FOR A HUMAN. (1)** The commit message should be derived from `git diff --stat` on `state/`, not
from the CLI's exit status. **(2)** Writing the queue and `last_completed_task.txt` **before** the log would
fail safe. **(3)** A cycle that hits `max_turns` should be retried as the SAME task. *(3) is fixed by commit
`956a36c`. **(1) and (2) remain undone**, and (1) is the one that misleads successors.* **FOR SUCCESSORS:
verify the phase from `next_task.json` AND `last_completed_task.txt` AND `git show --stat`, and disbelieve the
commit message.** *Cycles 35 and 36 both did this (all three agreed each time) and both **voluntarily adopted
(2)**, writing the queue files before the log.*

**[51] — NEW cycle 32. FOUR REFINEMENTS TO THE G2 MECHANISM.** **(a) SELECT BY REPLICATION COUNT, NOT ONLY BY
STALENESS, WHEN SOMETHING LOAD-BEARING IS ONE FETCH OLD** — extends [36]. **(b) "WHICH TEXT EXECUTES" IS NOT A
PRESENT VERDICT AND CANNOT BE TRUSTED FROM A STRING MATCH.** Where a docstring and a live branch describe
**different** rules, both are PRESENT and exact-string checks settle nothing. **`ctr-0004` and the cycle-31
finding are the two known instances of documentation-vs-execution divergence; assume more.** **(c) READ THE
STATE BEFORE RE-DERIVING ANYTHING FROM A LOG.** **(d) READ THE LOG WHEN THE STATE CITES A DERIVED NUMBER** —
`ctr-0010` exists because the state's description of a derived quantity was checked against
`logs/cycle-018.md`. (c) and (d) are not in tension: (c) says do not re-derive a fact from a log when the state
holds it; (d) says a DERIVATION's provenance lives only in the log. *Cycle 34's third selection criterion:
**SELECT BY WHAT THE SCORE DISTRIBUTION DEPENDS ON** — when one issue stands alone at the top of the graph, its
evidence is the least-checked load-bearing thing in the project by definition.* *Cycle 36 adds **(e): SELECT BY
UNCHECKED PROVENANCE.** Two of the last two G2s found their most durable result on the `/abs` page rather than
in the numbers, and provenance is the one axis where a source can be wrong in a way that no amount of
number-checking reveals.*

**[52] — NEW cycle 33. A CONTRADICTION ENTRY CARRIES EXACTLY ONE `issue_id`, BUT ITS CONTENT CAN DAMAGE
SEVERAL ISSUES — AND THE GATE SEES ONLY ONE OF THEM. A SIXTH SHAPE FOR [41]; FOR A HUMAN.** `ctr-0008` is filed
against `attribution-confident-wrong-gap`. Its content materially damaged **three** issues, and by its own text
the largest exposure was **elsewhere**. But `jq` over `.contradictions[] | select(.resolved_cycle==null)`
groups by `issue_id`, so the G3 gate, the T5 selector and every per-issue query saw the exposure on **exactly
one** of the three. **Three options for a human, in ascending cost: (i) allow `issue_id` to be an array; (ii)
require the opening cycle to file a stub entry against each affected issue, cross-referenced; (iii) accept the
limitation and require every T4 to grep contradiction *bodies* for issue ids rather than trusting the
`issue_id` field.** *Cycle 33 chose (iii) plus `ctr-0009`. **Cycle 36 is a live instance in the other
direction: `ctr-0004`, filed against `ioc`, produced the finding that forced two `scores.json` corrections on
`ttp` and `task-dependent` ([34]). The gate saw none of it.***

**[53] — NEW cycle 33. THE ARXIV VERSION CHECK IS CHEAP, IT HAS PAID OFF, AND A REVISION CAN RENUMBER THE
TABLES A STORED CLAIM CITES.** One fetch of `arxiv.org/abs/2602.06718` revealed a **v2 (14 May 2026)** of
src-0011 that no cycle had noticed in twenty-one cycles. **Every headline quantity survives unchanged.** **But
the per-venue table is `Table 3` in v1 and `Table V` in v2, and v2's `Table 3` is an entirely different
per-model table.** A future cycle fetching the current version and asking for "Table 3" would receive unrelated
content **and could open a spurious contradiction against a clean source**. **Two standing rules: (a) run the
`/abs` version check on every arXiv source you touch; (b) when a stored claim cites a table BY NUMBER, either
pin the version in the URL or ask for the table BY DESCRIPTION.** *Known version traps: src-0002 (v2 has no
CTI-ATE task — fetch v3), src-0011 (v2 renumbers). Cycles 35 and 36 cleared src-0007, src-0013 and **src-0014**
— all v1 only, none carries the hazard. **Seven of eighteen sources now checked on this axis.***

**[54] — NEW cycle 33, CONFIRMED AND SHARPENED AT CYCLE 34, **RE-CONFIRMED AT CYCLE 36**. THE SCORE
DISTRIBUTION HAS COLLAPSED TO A SEVEN-WAY TIE AND THE WEAKEST-LINK SELECTOR IS NOW EFFECTIVELY THE TIE-BREAK.
FOR A HUMAN, AND FOR THE PAPER.** The graph reads `institutional-incident-real-world-impact` 3, all seven other
issues 2. A selector that picks the weakest issue cannot discriminate among seven equals, so the
under-specified tie-break of [11] and the never-expiring `created_cycle` fallback of [30] are doing **almost
all of the selecting**. *Cycle 33 considered whether this justifies scoring less harshly and concluded it does
not: `prompts/t4_assess.md` step 5 is explicit that optimistic scoring breaks the selector. **The right
response is to flag the mechanism, not to distort its input.** **Cycle 36 faced the same temptation from the
other side** — a cycle of genuine investigative progress on `ioc` that moves no score — **and reached the same
answer: "better understood" is not "better supported", and inflating to reward effort would corrupt the one
input the selector has.*** **(a)** A stingy rubric applied honestly is **compressive** — issues fall toward the
level their weakest leg supports and pile up there — so a weakest-link selector degrades exactly as assessment
discipline improves. **(b)** The scoring scale does two jobs at once — *reporting* evidential state and
*ranking* work — and they need different resolutions. **CYCLE 34's EMPIRICAL TEST: actionability DID NOT
DISCRIMINATE — five of seven tied issues have named undone jobs. Actionability is a good *filter* and a poor
*ranker*.** What decided cycle 34 was **staleness of last attempt**. **Recommendation: replace the
`created_cycle` fallback with a staleness/aging term.**

**[55] — NEW cycle 34. `automated-triage-under-refusal` IS PERMANENTLY STARVED BY THE TIE-BREAK, AND THIS IS
PROVABLE IN ADVANCE RATHER THAN OBSERVED AFTER THE FACT. VERBATIM FOR A HUMAN. THE STRONGEST FORM OF [30].**
Three issues beat it on `created_cycle`: `ttp`, `ioc` and `consistency` (all created 2, all upstream-maximal
under 3a, all scored 2). It can only win when **all three simultaneously** carry a 3b recent-attempt penalty.
Under the T5→T3→T4→T5 loop a T5 fires every 3 cycles and each produces exactly one T3 attempt one cycle later,
so attempts land on cycles 35, 38, 41, 44, 47 … spaced 3 apart, and **a 5-cycle lookback window contains at
most two of them**. At most two of the three can ever be penalised at one T5; **at least one always has penalty
0 and beats `created_cycle` 16.** The selector rotates `ttp` → `ioc` → `consistency` indefinitely and this
issue is **structurally unreachable**. **Caveats:** the proof holds only while those three stay tied at 2,
while no T1/T2 alters the graph (cycles 50 and 51 could), and while the loop does not fail a cycle. **Cycle 36
re-scored all three at 2, so the proof's precondition is re-established for cycle 37.** **CONSEQUENCES ALREADY
VISIBLE:** [15]'s curl/HackerOne case (twelve cycles as the top uncollected source), [27]'s src-0015 Reward
column (sixteen cycles unentered, and verified genuinely undone this cycle), and the **never-read triage
scorer** in the src-0017 artefact — the one evaluator of three in that repository nobody has read, by a route
proven at cycles 27, 31, 32 and 35. **PROPOSED FIX, one line in `prompts/t5_select.md`:** add an **aging term**
before the `created_cycle` fallback — subtract 1 from the effective score per N cycles since `last_attempt`
(using `created_cycle` for never-attempted issues). **Cycle 34 did NOT override the mechanism to fix this**:
overriding hides the defect behind a one-off correction. Passed on verbatim with [4], [11], [30], [41].
**[CYCLE-37 UPDATE] — THE PROOF HELD, ITS PREDICTION WAS CORRECT, AND CYCLE 37 CONFIRMS IT FROM THE
INSIDE WITH ONE CORRECTION TO ITS MECHANISM.** Prediction: the selector rotates `ttp` → `ioc` →
`consistency`. Cycle 35's T3 attempted `ioc`; cycle 37 selected **`consistency`** — exactly the next
element of the predicted rotation, reached by exactly the predicted route (`ttp` penalised for its
cycle-32 attempt, `ioc` penalised for its cycle-35 attempt, `consistency` unpenalised since cycle 25).
**THE CORRECTION, and it makes the item stronger rather than weaker:** this item says three issues beat
it "on `created_cycle`" and that it can win only when all three carry a 3b penalty. That is right about
the outcome and slightly wrong about the count — **the rotation is a three-cycle cycle over three
issues, so exactly one of the three is unpenalised at each T5 and it is always the one whose turn it
is**. Cycle 37 observed precisely that: two of three penalised, one clean, and the clean one won. The
issue therefore needs not merely "all three penalised" but a *simultaneous* penalty on three issues that
the loop's own 3-cycle period makes mutually exclusive with a 5-cycle window. **The structural claim is
confirmed empirically for the first time**, not merely derived. The proposed one-line aging fix stands
and is now supported by observation as well as by argument. Passed on verbatim with [4], [11], [30],
[41].

**[56] — NEW cycle 34, from the G2 bolt-on. A LOOSE THREAD ON THE ONLY ISSUE SCORED ABOVE 2. NOT A
CONTRADICTION.** src-0010's page serves its PDF as `ENISA Public Administration TL **2024** - v1.2.pdf` while
the same page states a publication date of **November 6 2025**, and src-0004 places that report in the
"published last October and November" pair. **No stored claim records that filename, so nothing conflicts and
[32]'s test says DO NOT FILE.** But a filename is weaker evidence than a page's own date field and no defect is
asserted. **For whichever cycle next touches `institutional-incident-real-world-impact`:** ask whether ENISA's
Public Administration Threat Landscape is a **2024-titled report republished in November 2025** or whether the
filename is a legacy artefact. *Related: [14] says the v1.2 PDFs cannot be opened, so try the page's own
metadata or the EU publications catalogue instead.*

**[57] — NEW cycle 35. `ctr-0010`: A DERIVED QUANTITY HAS BEEN CARRIED WITH THE WRONG SCOPE FOR SEVENTEEN
CYCLES, AND NO CHECK THIS PROJECT RUNS COULD HAVE CAUGHT IT. **STEP (i) DISCHARGED AT CYCLE 36; STEPS (ii) AND
(iii) OPEN**.** The state said the 0.09–0.15 range is the IoC recall needed to reconcile src-0003's 97.6% F1
with src-0007's 0.82–0.88 precision. `logs/cycle-018.md` shows it is the recall at which **src-0007's IoC F1
falls to src-0007's own TTP F1** — a within-src-0007 crossover in which **src-0003's number is not an input at
all**. **THE UNDERLYING ARGUMENT AND EVERY NUMBER ARE CORRECT; ONLY THE SCOPE IS WRONG.** **(a) THE CONCLUSION
IS TRUE AND HAS A CHEAPER PROOF:** `F1 ≤ 2P/(P+1)`, so an F1 of 0.976 entails `P ≥ 0.9531`; that is a
**precision**, comparable directly with src-0007's precisions, so **the METRIC confound is eliminated
deductively with a margin of 0.069 (vs fine-tuned GPT-4o) to 0.129 (vs vanilla GPT-4o)**. *Cycle 36
**re-derived the algebra independently** (`dF1/dR = 2P²/(P+R)² > 0`; `1.024P ≥ 0.976`; `P ≥ 0.953125`) and it
reproduces, and **replaced the mis-scoped sentence in `scores.json` in place**, retaining the 0.09–0.15 figure
with its true scope as an IoC-versus-TTP crossover. **Step (i) is DONE.*** **(b) A FOURTH CONFOUND IS NOW LIVE
ON `ctr-0001` — MATCHER.** To close 0.069 the one-directional rule would have to net-deflate src-0007's
precision by 6.9 points; the rule is lenient in the other direction too, the normalisation chain closes the
commonest deflation channel, and **src-0003 never states its own rule** ([33]) so the correction is unsigned on
both sides. **Not settleable from any released artefact** ([7]). **(c) THE METHODOLOGICAL POINT:** this defect
is invisible to every check the loop runs — not a quotation, so string-matching cannot reach it; not a source
claim, so no G2 re-fetch can reach it; and the number is correct, so recomputation confirms it. **It was found
only by reading the log that PRODUCED the number rather than the state that cites it.** **DERIVED QUANTITIES IN
THIS BASE HAVE NEVER BEEN SYSTEMATICALLY AUDITED. Known unaudited ones: src-0001's four derived ECE means,
src-0002's five derived plausible-but-not-correct percentage points, src-0006's derived F1 ranges, cycle 18's
src-0006 crossover means (0.272 / 0.263, which [23] and [54] both lean on), and the four normalisation figures
on `extraction-vs-reasoning-ordinal-axis`'s route 2.** A human should consider whether `prompts/system.md`'s G2
rule — "re-check it against its cited sources" — needs a second limb for conclusions whose provenance is a
computation rather than a source. **STILL UNDONE: step (ii)** — `ctr-0001`'s cycle-21 update carries the same
mis-statement and must be annotated by whichever cycle next touches the graph; **a T4 has no standing to edit
`graph.json`.** **Step (iii)** says nobody should re-derive the crossover arithmetic; cycle 36 honoured that and
re-derived only the *entailment*, which is a different quantity.

**[58] — NEW cycle 35, STILL UNRECORDED AT CYCLE 36. src-0007 IS PEER-REVIEWED AND PUBLISHED, AND THIS BASE HAS
NEVER RECORDED IT.** One `/abs` fetch of `arxiv.org/abs/2603.09452` returns, verbatim, **`Comments: Accepted at
TMLR`** and **`Journal reference: Transactions on Machine Learning Research (2025), ISSN 2835-8856`**. Also:
**v1 only**, submitted 10 Mar 2026, so no [53] renumbering hazard on the Table 4 claims. **src-0007's
`index.json` entry records neither fact.** *Appending a provenance key_claim is clean, cheap, self-contained and
**permitted** — cycle 36 did exactly that for src-0014 with no difficulty, which removes the last excuse. **Any
cycle with spare budget should just do it.*** **This is the third provenance label found wrong or unrecorded,
after src-0001 (called a preprint for 24 cycles, actually ARES 2025) and src-0005 (assumed reviewed, actually an
unreviewed preprint).** *src-0017's `[TMLR '25]` badge is **partly explained** — src-0017 is src-0007's artefact
release and src-0007 is a TMLR paper. The year discrepancy (TMLR 2025 against a March 2026 arXiv submission)
remains unexplained and should not be guessed at.*

**[59] — NEW cycle 35, VINDICATED AGAIN AT CYCLE 36. A TRACKING ENTRY THAT SAYS WORK IS OUTSTANDING IS EVIDENCE
THAT SOMEONE ONCE THOUGHT SO, NOT EVIDENCE THAT IT IS OUTSTANDING NOW.** Cycle 34's handoff gave cycle 35 five
jobs and **two premises of Job D were false**: (1) three `scores.json` rationales were said to still repeat a
"two-directional SUBSTRING CONTAINMENT" characterisation — `grep -c` returns **0**; **cycle 33's T4 discharged
it and nobody updated the tracker**; (2) `ctr-0004`'s own step (iii) asserted the rationales "cannot be edited
retroactively under append-only discipline" — **false**, `scripts/validate_state.py` lines 100–107 protect
`index.json` `key_claims` and the **existence** of `src-*.md` files **only**. **THE GENERAL LESSON:** this loop
has no mechanism that marks a carry-forward item or a resolution step as done when some *other* cycle does the
work incidentally. **Before spending a turn on any item described as undone, verify it against the artefact,
not the tracker.** *Cycle 36 applied this to [27] — checked the graph directly rather than trusting sixteen
cycles of carry-forward — and found the item **genuinely still undone**, which is the first time the check has
returned "still open". **The check is worth running in both directions: it is as capable of confirming a stale
item as of retiring one.*** *Related to [51](c) and (d).*

**[60] — NEW cycle 36. RULE (ix) CUTS BOTH WAYS: A SUMMARISED READ CAN MANUFACTURE A DEFECT THAT IS NOT THERE,
NOT ONLY CONCEAL ONE THAT IS. THE FIRST NEAR-MISS OF THIS KIND IN THE PROJECT.** Cycle 36's **first** fetch of
src-0014 returned a summarised claim that Table 2's percentages *"refer to abstention rates … not a separate
coverage column"* — i.e. that the paper's body sentence labels as **coverage** the same numbers its table labels
**abstention**. That is the **`ctr-0007` / `ctr-0008` metric-identity shape exactly**, and on the evidence in
hand it would have been filed. **A second fetch asking for Table 2 VERBATIM disproved it**: the S-C column reads
49.00 / 51.07 / 39.15 / 60.96 / 75.96 and the paper defines *"coverage as one minus abstention rate"*, so the
body sentence's 51.00 / 48.93 / 60.85 / 39.04 / 24.04 are **exactly** `100 − cell` for all five models. **The
source is internally consistent and the defect did not exist.** **THE RULE: BEFORE OPENING A CONTRADICTION ON
THE STRENGTH OF A SUMMARY, GO BACK AND GET THE ARTEFACT VERBATIM.** **A FALSE CONTRADICTION IS MORE EXPENSIVE
THAN A MISSED ONE, because it is entered as a finding and every later cycle inherits it** — this base has spent
cycles 27, 30, 31, 33 and 35 unwinding *correct* findings whose *characterisations* were wrong, and a wholly
spurious entry would be worse. *Note the interaction with [31]: seven consecutive clean checks could mean the
sources are clean or that the checking has stopped biting. **This near-miss is evidence for the first reading —
the check was sharp enough to find a candidate defect and disciplined enough to kill it.***

**[61] — NEW cycle 36. A T4 MAY AND SHOULD RESTATE AN OVER-PRECISE GLOSS INSIDE ITS OWN `scores.json`
RATIONALES, AND THAT IS A THIRD REPAIR CHANNEL THIS LOOP HAD NOT USED.** `ctr-0010` step (i) established the
permission (`scores.json` is unprotected by validator lines 100–107) but framed it as a one-off. Cycle 36 used
it three times: once as instructed, and **twice unprompted** on glosses that cycle 35's `ctr-0004` work had
falsified — see [34]. **THE PATTERN WORTH NAMING: a finding lands in the graph, and its consequences for the
`scores.json` rationales that cite the falsified version are nobody's named job.** G2 cannot reach them (not
source claims), G3 cannot reach them (not conflicts between two graph claims), and the T3 that produced the
finding has no standing over `scores.json`. **Only the next T4 can, and only if it re-reads the rationales
against the graph rather than carrying them forward.** *Cycle 36's practical rule for successors: after any
cycle that reads a scoring rule or falsifies a characterisation, the next T4 should **grep its own rationales
for the falsified wording** before stamping `assessed_cycle`. That is cheap — `grep -c -F` on `scores.json` — and
it caught two instances this cycle.* **For a human: this is a fourth mechanism in the family [41] names — the
better the T3s get at finding characterisation defects, the more stale characterisations accumulate downstream
in `scores.json`, and nothing but a diligent T4 clears them.**

**[62] — NEW cycle 37. src-0015 HAS THREE arXiv VERSIONS AND ITS PRINCIPAL RESULTS CHANGED BETWEEN THEM.
THIS IS A FACT ABOUT THE SOURCE, NOT A DEFECT IN THE STATE.** Submission history verbatim: **v1 Wed 28
Jan 2026 (3,935 KB), v2 Fri 30 Jan 2026 (3,935 KB), v3 Fri 6 Feb 2026 (4,022 KB)**. Everything this base
stores is **v3 and only v3**, which `src-0015.md` line 128 already recorded and which is why nothing
here is wrong. What nobody had checked is that **v1 says something different**: its abstract, pulled
verbatim from `/abs/2601.21083v1`, reports *"GPT-5.2, Gemini 3, and DeepSeek execute containment in 100%
of episodes with **90-97% false positive rates**. Claude Sonnet 4.5 shows partial calibration (**85%
containment, 72% FP**)"* against v3's 82.5% / 57.5% / 65% and Sonnet's 62.5% / 45%; v1 lists its metrics
as TTFC, blast radius and injection violation rates with **no EGAR at all**, so the whole of
`key_claims[2]` describes a metric introduced after v1; and `Comments:` moves from "6 pages, 2 figures"
to "7 pages, 3 figures". **TWO CONSEQUENCES.** (1) **FETCHING NOTE, add it to the standing list beside
src-0002's v2-vs-v3 and src-0007's v2-has-no-CTI-ATE trap:** always fetch `/html/2601.21083v3` or the
bare `/abs`; a v1 URL returns different numbers and a spurious ABSENT for EGAR. (2) **THE
"WEAKEST-PROVENANCE" LABEL IS WEAKER ON A NEW AND INDEPENDENT GROUND** — an unreviewed single-author
preprint whose principal quantitative results were revised materially **nine days** after posting, with
no erratum or change note on the listing page. The existing hedge was right for a reason nobody had
checked. **NOT ENTERED AND MUST NOT BE CITED:** a `/html/…v1` fetch returned a v1 Table 1 and asserted a
v1 sentence reporting "95% Wilson CIs for rates", which if real would contradict the stored "no
confidence intervals" — but that read was **summarised, not verbatim**, and contradicted the verbatim v1
abstract on the seed-pool size, so under rule (ix) it was refused entry per [60]. **A cycle wanting
either must re-fetch v1 verbatim.** **THE GENERALISABLE POINT FOR A HUMAN:** this project's G1 gate
checks URL liveness for **new** sources only, and nothing anywhere re-checks whether a cited arXiv
source has been *revised since collection*. Four of eight sources given the version check have now
produced a finding. **An arXiv id is not a stable citation and this base treats it as one.**

**[63] — NEW cycle 37. THE T5 SELECTION RULE HAS TWO SPECIFICATION DEFECTS THAT NO GATE IN THIS PROJECT
CAN CATCH. VERBATIM FOR A HUMAN, with [4], [11], [30], [41], [55].** (i) **FIELD-NAME MISMATCH.**
`prompts/t5_select.md` step 3a names the field **`depend_on`**; `state/issues/graph.json` and its own
embedded `_schema` use **`depends_on`**. A `jq` projection written from the prompt returns `null` for
every issue, which makes tie-break 3a look inapplicable and silently hands the decision to
`created_cycle`. Cycle 37 hit this and caught it only by reading `_schema`; **an agent that trusted the
prompt's spelling would have produced a differently-ranked, plausibly-argued, wrong selection with no
gate objecting.** Fix is one character in the prompt. (ii) **UNDEFINED WINDOW.** 3b's "within the last 5
cycles" has unspecified endpoints. Cycle 37 used cycles 32–36 and reported the alternative (33–37)
alongside; the winner was the same under both, **but under the alternative there would have been a
residual tie between two issues at `created_cycle` 2 with no fourth tie-break specified anywhere.** The
policy is one attempt-date away from being undefined. **Cycle 37 invented no rule to cover it** and
records the gap instead.

**[64] — NEW cycle 37, DIRECT DESCENDANT OF [27]'s DISCHARGE. THE src-0015 REWARD FINDING IS IN THE
KNOWLEDGE BASE BUT NOT IN THE GRAPH, AND ONLY A T3 TARGETING A STARVED ISSUE CAN PUT IT THERE.**
src-0015's Table 1 Reward column (GPT-5.2 3.07, **Sonnet 4.5 2.37**, Gemini 3 2.61, **DeepSeek 3.2
3.45**) with its verbatim definition is now in `index.json` and `src-0015.md`. Its significance is that
**the harness's own objective ranks its best-restrained model last and its second-most-over-triggering
model first**, which speaks directly to `automated-triage-under-refusal`'s `open_questions[0]`: *"IS
OVER-ACCEPTANCE A PROPERTY OF THE MODELS OR OF THE HARNESS?"* Connecting the two is a **graph edit** and
therefore T2/T3 work on an issue that [55] proves is structurally unreachable. **A SECOND UNENTERED ITEM
FROM THE SAME TABLE:** the **`Threshold`** column classifies **three** models as "Part. Cal." (Sonnet
4.5, Gemini 3, DeepSeek 3.2) where the abstract names only Sonnet — so any candidate quoting the
abstract's framing is quoting a stricter reading than the paper's own table. **CONSTRAINT ON WHOEVER
TAKES THIS:** the Reward is a **training signal, not a reliability measurement**, and must not be cited
as one; and cycle 37 deliberately derived **no** arithmetic from the four reward components, so any
decomposition is the deriving cycle's own and must be labelled per rule (xii). **THE REUSABLE LESSON,
which is why this is filed separately from [27]:** [27] sat blocked for sixteen cycles because the
tracker assumed it needed a graph edit, when **the source-fact half of it was appendable by any cycle at
any time**. Before writing off a carry-forward item as unreachable, split it into its source-fact half
(appendable by anyone, no standing required) and its graph half (T2/T3 only). At least one other item in
this list is likely to split the same way — **[58]'s src-0007 TMLR provenance is pure source-fact and has
been "waiting" for three cycles for no reason at all.**
