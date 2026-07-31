# Cycle 040 — T4 (Assess)

## Task performed

Ran **T4 — Assess** per `prompts/t4_assess.md`, which I read myself rather than relying on the
queue entry's account of it. Step 1 requires scoring **every** issue in the graph, not only recently
touched ones, so this task carries no `target_issue`.

**Phase verification before acting** (standing lesson from cycles 31–32 and 38). Checked all three
signals and disbelieved the commit message: `state/queue/next_task.json` held a T4 created at cycle
39; `state/queue/last_completed_task.txt` read `T3 investigate`; `git show --stat HEAD` showed cycle
39 touching `logs/cycle-039.md`, `state/issues/graph.json`, `state/knowledge/index.json`,
`state/meta.json` and both queue files — consistent with a completed T3. `state/meta.json` reads
cycle 40. Phase confirmed: **cycle 40 = T4**.

**Schedule re-derived from source**, not inherited. `config.yml` line 17 sets
`collect_refresh_every: 7`; `prompts/t5_select.md` step 4 puts the test
`current_cycle % schedule.collect_refresh_every == 0` **inside the T5 prompt**, so it fires only when
a T5 cycle is itself a multiple of 7. Post-abort the T5 cycles are 41, 44, 47, 50, 53, 56 …; the
first multiple of 7 among them is 56, so **the next T1 is cycle 57** and the next T2 is cycle 58,
assuming no further aborts. Consequence recorded in every rationale that needs it: a T3 is the only
route to new evidence for roughly the next sixteen cycles.

**Result: all eight issues scored. No score moved.** Seven issues at 2, one at 3.

| issue | score | prev | assessed_cycle | open contradictions | G3 ceiling | bound? |
|---|---|---|---|---|---|---|
| ttp-attack-mapping-reliability | 2 | 2 | 40 | — | n/a | n/a |
| ioc-extraction-reliability | 2 | 2 | 40 | ctr-0001, ctr-0004, ctr-0010 | 3 | no |
| consistency-calibration-as-failure-mode | 2 | 2 | 40 | ctr-0011 | 3 | no |
| attribution-confident-wrong-gap | 2 | 2 | 40 | ctr-0008 | 3 | no |
| task-dependent-reliability-framing | 2 | 2 | 40 | ctr-0009 | 3 | no |
| extraction-vs-reasoning-ordinal-axis | 2 | 2 | 40 | — | n/a | n/a |
| institutional-incident-real-world-impact | **3** | 3 | 40 | **ctr-0012 (opened by me)** | **3** | **no — but now exactly at it** |
| automated-triage-under-refusal | 2 | 2 | 40 | — | n/a | n/a |

Rationale blocks were **appended** to each entry; no prior text was rewritten. `last_assessed_cycle`
is 40.

### The one score I had to think hard about

`institutional-incident-real-world-impact` is the only issue above 2, and my G2 landed on it and
opened a contradiction against it. I held it at **3** on merit and I record the reasoning so a
successor can disagree.

The title asks two things — have AI-generated CTI failures reached production at real institutions,
and how do institutions respond when caught. On `consistency-calibration-as-failure-mode` and
`attribution-confident-wrong-gap` the weaker conjunct governs, because only one conjunct has
multi-source support. **Here both conjuncts have it**: candidate 1 cites src-0009 and src-0010
(ENISA's own publication pages, verbatim revision notices) corroborating the Der Spiegel/heise chain
independently, and candidate 2 cites src-0012 and src-0004 — two incidents, two institution types,
two mutually independent investigations. All three limbs of ctr-0012 leave that untouched.

I also considered demoting to 2 by designating candidate 0 (src-0004 alone, and the carrier of two
of ctr-0012's three limbs) as primary, and rejected it: candidate 0 is the cycle-2 original,
superseded on the existence claim by candidates 1 and 2 which were added at cycle 12 precisely to
break its single-source dependence, and candidate 1 says so in its own text. Designating a
superseded candidate primary to force a demotion is the mirror image of the move cycles 33, 35 and
36 refused when it would have forced a *promotion*. The rule has to run in both directions or it is
not a rule, so I refused it here and refused its promotion-direction twin on
`consistency-calibration-as-failure-mode` and `ioc-extraction-reliability` in the same cycle.

### The G3 gate is load-bearing for the first time in forty cycles

Because ctr-0012 is open and the issue scores 3, it now sits **exactly at the ceiling**
(`scale_max − g3_contradiction_demotion = 3`; the validator errors only on `> 3`). Every prior
application in this project sat at merit 2 with a slack of one, so the gate has never actually
constrained anything before. **While ctr-0012 is open, any T4 that raises this issue to 4 will fail
the validator and have its entire cycle reverted.** The route to 4 now runs through a T3 executing
ctr-0012's resolution path first. This is passed forward in capitals.

### One sub-question of carry-forward [4] settled, at source

Cycles 33, 35 and 36 each wrote that "nobody has ever specified whether the gate is PER-ISSUE or
PER-CONTRADICTION". For the **enforced** rule the answer is readable off the code and no cycle had
stated it: `scripts/validate_state.py` line 146 builds `open_contra` as a **set comprehension** over
`c["issue_id"]`, so duplicate issue ids collapse and the loop at line 150 visits each affected issue
exactly once regardless of how many contradictions it carries. **The enforced gate is per-issue by
construction and cannot be per-contradiction.** `ioc-extraction-reliability`'s three open
contradictions therefore cost it exactly what one would — the case a per-contradiction gate would
bite hardest, now settled.

This does **not** settle carry-forward [4] itself. The substance of [4] is that
`prompts/t4_assess.md` step 3 and `config.yml` line 35 prescribe a *subtraction* while the validator
implements a *ceiling*, and that conflict is untouched. I applied the ceiling and refused the
subtraction, as cycle 16 ruled and every T4 since has done. Thirty-second cycle awaiting a human.

### What cycle 39's work did to `consistency-calibration-as-failure-mode`

I re-read the graph rather than the handoff, and the handoff was accurate on every item I checked.
Net G3 effect of cycle 39 on that issue is **zero**, not headroom: it closed ctr-0003 and ctr-0005
and opened ctr-0011 against the same issue, so the issue still carries one open contradiction and
its ceiling is still 3.

The finding that moved my weighting is cycle 39's Brier re-derivation, and it moves it **downward**.
ctr-0003's four ECE means reproduce exactly, but no prior cycle had averaged the **Brier** column
printed beside ECE in the same table, and src-0001 defines both identically as "two measures of
calibration that quantify the deviation from perfect calibration". On Brier the
extraction-vs-generation gap is 0.0065 at zero-shot (nil) and **reverses** at few-shot (extraction
0.3225 worse than generation 0.294). So the calibration leg is not merely single-source and
single-model — it is **internally inconsistent between the two metrics its one source reports on the
same nine rows**. That is a materially worse position than cycle 36 recorded, and it is the fourth
instance of the rule (iv) partial-capture class: ctr-0003 was itself a partial capture, having
averaged one column of a two-column table.

Against that, cycle 39's genuine strengthening on the consistency leg is real and I credited it:
src-0018's temperature-0 protocol is now recorded, so src-0001 and src-0018 both measure residual
non-determinism **under** a determinism setting, on disjoint model sets a generation apart. It does
not change the arithmetic of which conjunct is two-source, and ruling two still sets the score at 2.

---

## Retrospection

**G2 target: `src-0004`** — heise online (English), *"EU cyber agency secretly uses AI for reports –
and gets caught"*, byline Niklas Jan Engelking, 11 Jan 2026.
`https://www.heise.de/en/news/EU-cyber-agency-secretly-uses-AI-for-reports-and-gets-caught-11136978.html`

**Why this one.** It was the only source in the base that had **never had a G2 at all** — untouched
since collection at cycle 1, eighteen cycles staler than any other candidate — and it is the sole or
primary support for four of the five candidate_resolutions on
`institutional-incident-real-world-impact`, the only issue in the graph scored above 2. Cycle 39
named it the largest unexamined risk in the base. I am the T4 that scores that issue, so the check
and the score land in the same cycle. Note for the record: **after this cycle every source in the
base has had at least one G2**; that gap is now closed.

### Verdict: the source PASSES on every number and every quotation. The defects are in the state.

Methodological rule (vi) for the third time in this project (ctr-0008, ctr-0011, now ctr-0012).

**Rule (v) paid off on the first move, and cheaply.** The first fetch of the canonical stored URL
returned **CANNOT READ** — the article is now behind a heise+ paywall, with only headline, byline,
date and a teaser visible. A second URL form (`.../-11136978.html`, id only) returned **HTTP 404**.
Appending **`?seite=all`** to the identical canonical URL returned the **complete article body**.
Had I stopped at the first fetch I would have recorded a spurious "source unreadable" against the
highest-scored issue in the graph and would very likely have demoted it. This is the **sixth**
instance of the single-fetch-negative rule. **Always fetch src-0004 as `…11136978.html?seite=all`.**

Note what this means for the validator: `validate_state.py` lines 125–127 check G1 URL liveness for
**new sources only**, and src-0004's URL still returns HTTP 200. It would pass any liveness check
while serving a page containing none of the content the state cites. This is exactly the gap G2
exists to cover.

**Everything stored reproduces verbatim.** Checked as exact strings against the full body:
"26 out of 492 footnotes in one of the reports were incorrect"; "researchers from Westfälische
Hochschule"; "The reports in question were published last October and November, respectively";
"a link to a Microsoft page about the Russian hacker group APT29 also contained this name – but
Microsoft itself refers to the group as Midnight Blizzard"; "the LLM-typical errors were striking
about the incorrect links"; Christian Dietrich's "All it would have taken was one click"; Linus
Neumann's "embarrassing"; ENISA's "human errors" and "minor editorial revisions". All **PRESENT**
and exact. The 26/492 figure was additionally corroborated by an independent outlet
(restofworld.org), which also traces it to Der Spiegel.

### Three defects found, all in this base's account of the source → **ctr-0012 opened**

**Limb (1), the material one — an omitted subordinate clause.** The article's full account of
ENISA's response reads:

> Enisa, which has an annual budget of around 27 million euros, admitted the errors when asked by
> Der Spiegel magazine, speaking of "deficiencies" for which it takes responsibility. "Human errors"
> had occurred and the AI had been allowed to make "minor editorial revisions."

The clause **"speaking of 'deficiencies' for which it takes responsibility" appears nowhere in this
state** — not in `index.json` src-0004 `key_claims[2]`, not in `state/knowledge/src-0004.md`, not in
`candidate_resolutions[0]`, not in `candidate_resolutions[3]`. Every rendering in this base keeps
the two phrases that make ENISA look deflecting and drops the admission sitting in the same
sentence.

The narrow reading survives and I did not over-correct: ENISA **did** attribute cause to human error
and **did** confine the AI's role to "minor editorial revisions", so "did not fully acknowledge AI
*attribution*" is literally true. What does not survive is the unqualified gloss "institutional
under-acknowledgment", and candidate 3's contrast setting EY Canada (withdrew, accountability
statement) against ENISA (retained, "human errors") as *diverging institutional responses*. On the
source's own words **both institutions publicly accepted responsibility**; the divergence actually
established is over **remedy** (withdrawal vs. link correction) and over **causal attribution** (AI
acknowledged vs. human error).

This is a new sub-shape of the rule (iv) partial-capture class. Until now that class had bitten on
unpulled **rows** (ctr-0003) and unpulled **columns** (cycle 39's Brier finding). This is the first
time the omitted material is a **subordinate clause of the very sentence being quoted**. Rule (iv)
is amended in the handoff accordingly: *quote the whole sentence*.

It is also a clean counterexample to rule (viii)'s sufficiency. Every stored string in src-0004
matched exactly. **String-matching found nothing, because the defect was entirely in what was not
stored.**

**Limb (2) — over-attribution of report titles.** `key_claims[0]` opens "Two ENISA 'Threat Landscape
2025' reports (published Oct/Nov 2025)…". The article **names neither report**; it says only "Two
reports from the EU cybersecurity agency Enisa". The titles are recoverable from src-0009 and
src-0010, which candidate 1 correctly does — but the key_claim attributes to src-0004 a
specification src-0004 does not make, and the plural is wrong in substance because src-0010 is
*ENISA Sectorial Threat Landscape: Public Administration*, not a "Threat Landscape 2025" report.
Non-load-bearing, because candidate 1 establishes both identities independently, but recorded.

**Limb (3) — a precision drift that runs against the state's own interest.** `key_claims[1]` and
candidate 0 both render the hallucination fingerprint as a **prose attribution** ("a passage
attributed the name 'APT29' to Microsoft's own naming convention"). The source describes a
**fabricated hyperlink**: a dead URL whose path string contains "APT29" where a real Microsoft URL
would carry "Midnight Blizzard". That is a hallucinated *citation target*, not a factual naming
error in body text. The corrected reading is **stronger** evidence of LLM fabrication than the
state's version, so no candidate is weakened — but the two are different findings and the state's is
not what the source says.

**Provenance, recorded for the first time.** The article attributes its load-bearing facts to Der
Spiegel in three separate places ("according to Der Spiegel magazine"; "admitted the errors when
asked by Der Spiegel magazine"; "Der Spiegel quotes Neumann"). src-0004 is confirmed at source as a
**three-layer chain** — researchers → Der Spiegel → heise — with only the Dietrich quotation not
explicitly Spiegel-attributed. This **hardens** rather than revises the limit already in scores.json
that the ENISA AI-causation leg is "reported-but-not-primary". spiegel.de remains unreachable to
this agent.

**Reported plainly, as required: this is the eleventh defect in nineteen source-checks, and the
defect class is now eleven-way** — spliced quotations, unverifiable numbers, unsupported
interpretive glosses, partial table capture, correct-but-hollow entries,
correct-source-corrupted-downstream, over-restriction, over-generalisation, metric-identity,
false-positive correction, and new here: **omitted subordinate clause**.

**I did not act on rule (xiii) carelessly.** Before opening ctr-0012 I had the artefact verbatim from
a rendering that reproduced the full body with paragraph structure and section headings, and the
key response sentence was independently reproduced by a second, unrelated retrieval. This is not a
contradiction opened on the strength of a summary.

---

## Changes made

**`state/assessments/scores.json`**
- `last_assessed_cycle`: 36 → **40**.
- `assessed_cycle`: 36 → **40** on all eight entries.
- A `[CYCLE-40 T4 …]` block **appended** to all eight rationales. No prior text rewritten, no
  evidence array altered. All eight retain non-empty `evidence` (validator line 138).
- **No score changed.** Seven at 2, one at 3.

**`state/issues/graph.json`**
- **ctr-0012 opened** against `institutional-incident-real-world-impact` (7,903 chars), the first
  contradiction ever filed against that issue. Three limbs plus a four-step resolution path, plus the
  `?seite=all` fetching hazard and the three-layer provenance finding. Nothing else in the file was
  touched; no candidate, open_question or attempts array was modified — a T4 has no standing to
  rewrite candidates, and ctr-0012's repairs are explicitly assigned to a T3.

**`state/knowledge/`** — untouched. A T4 adds no source and appends no key_claim.

**Queue files** — `next_task.json` rewritten for a T5; `last_completed_task.txt` set to `T4 assess`.

Every JSON edit was validated with `jq -e . <file> > /dev/null` and then read back with `jq -r` on
the specific fields added. Post-edit G3 check run explicitly: the five issues carrying open
contradictions score 2, 2, 2, 2 and 3 — all `≤ 3`, so no validator error.

---

## Next task rationale

State machine T4 → **T5 (select)**, `attempt_count` 0, `target_issue` null (T5 chooses one).

The refresh rule does **not** fire for cycle 41 (41 % 7 = 6), so the T5 must queue a **T3**, not a
T1. I gave it the full score table with `created_cycle`, `attempts` and `depends_on` for all eight
issues, since `prompts/t5_select.md` step 3 requires it to show tie-break arithmetic and step 20
requires a ranking table in its log — and I told it to re-read both files rather than trust my copy.

Tie-break reminders passed on, with the warning that cycle 37 found its *own* handoff had misstated
them: (a) upstream first, (b) attempt penalty of +1 per attempt within the last 5 cycles, (c) older
`created_cycle` first. At cycle 41 the only issue taking penalty (b) is
`consistency-calibration-as-failure-mode` (attempt at 39, two cycles old);
`ioc-extraction-reliability`'s cycle-35 attempt is six cycles old and falls outside the window. I
told the T5 to re-derive the window itself rather than copy that.

I flagged the degeneracy plainly, because it is evaluation data: seven issues at 2 and one at 3 means
**the tie-break is the selector**. And I restated the starvation proof at full strength —
`automated-triage-under-refusal` has `attempts []` in its 24th cycle of existence, has lost seven
consecutive selections, and cycle 34 proved it can never be selected under tie-break (c) while the
`created_cycle=2` issues stay tied. A T5 must apply the policy as written and must not invent an
anti-starvation rule; carry-forward [30] and [55] await a human. But the arithmetic must be recorded
so the exclusion stays auditable.

For the T5's own G2 I recommended **src-0006**, which is now the stalest source in the base (cycle
18) and whose never-read per-task scoring definitions are load-bearing for *two* issues at once —
`task-dependent-reliability-framing`'s candidate 0 and `extraction-vs-reasoning-ordinal-axis`'s route
1. Reading them would either secure or destroy the only surviving support on both. That makes it the
single highest-value fetch available anywhere in this project.

---

## Budget

- Fetches: 3 (src-0004 canonical → CANNOT READ/paywall; id-only URL form → HTTP 404;
  `?seite=all` → full body).
- Searches: 2 (independent corroboration of 26/492 and of ENISA's response wording).
- Reads: 6 file reads (`next_task.json`, `meta.json`, `config.yml`, `t4_assess.md`, `t5_select.md`,
  `src-0004.md`, plus one partial `scores.json` that hit the 25,000-token cap and two targeted
  `graph.json` slices).
- `jq` projections: ~12 — the cheap route. `jq -r .scores["<id>"].rationale` prints one rationale
  without triggering the Read cap; recorded in the handoff.
- Edits: 10 (8 rationale appends + `last_assessed_cycle` + `assessed_cycle` replace_all), 1 graph
  append, 2 queue writes, 1 log write.
- Turns used: roughly 30 of 50. No retries, no failed Edit anchors — the `jq -r … | .[-90:]` tail
  projection worked for all eight anchors, as it did at cycle 39.

---

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
