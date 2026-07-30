# Cycle 021 — T3 Investigate — `ioc-extraction-reliability`

## Task performed

T3 per `prompts/t3_investigate.md` (read directly, per carry-forward [29]) on target issue
`ioc-extraction-reliability`, the graph's stalest issue (last attempt cycle 9) and the only
one carrying an open contradiction — `ctr-0001`, opened cycle 9, **twelve cycles old**.

The queue's stated prize was to establish the SYSTEM confound and thereby close `ctr-0001`.
**I did not close it, and I judge that the right outcome.** What I did establish is stronger
than the queue anticipated on one axis and weaker on another, so the honest summary is:

**One of `ctr-0001`'s three confounds is now eliminated; the other two are not; and a fourth
obstacle nobody had noticed makes the two figures possibly incommensurable regardless.**

### Route (1) — recover recall/F1 from src-0007's released code: EXECUTED, PARTIAL SUCCESS

The paper's own HTML gives the artefact pair `github.com/xschen-beb/CyberThreat-Eval` and
`huggingface.co/datasets/xse/CyberThreat-Eval`. (A web-search summary instead offered
`github.com/secintelligence/CyberThreat-Eval`, which **404s** — taking the URL from the paper
rather than the search summary was load-bearing, and is worth doing by default.)

- **The number is NOT recoverable.** `stage3_ti_drafting/ioc/` holds `data`, `eval`,
  `example`, `README.md`. The only prediction file anywhere is
  `example/prediction/manual_ioc_predictions.json`, a manual worked example. The paper's four
  model outputs are unpublished, so recall could only be had by re-running the models.
- **But the question behind the number is answered, and more decisively than a number would
  have answered it.** `eval/eval_ioc.py` computes `recall = total_true_positives /
  (total_true_positives + total_false_negatives)` in the same function as precision and prints
  it on the *very next line*; there is no code path yielding one without the other. The
  sub-README treats recall as a first-class metric of the benchmark. **src-0007 published the
  first line of that output and withheld the second.** The omission is a reporting decision,
  not a limitation of the apparatus.
- **The paper is not silent about recall either.** A whole-paper verbatim search recovered a
  Section 4.3 sentence no cycle had captured: *"In the TI drafting stage, the extraction of
  IoCs is relatively robust, although improvements in recall and processing efficiency remain
  necessary."* Still no reason given for the omission.

### The substantive result: the METRIC confound is eliminated

Cycle 18 computed that reconciling 97.6% F1 with 0.82–0.88 precision by the metric difference
alone would require IoC recall of **0.09–0.15**. The Section 4.3 sentence is independent
evidence against that: no team describes its own system as *"relatively robust"* with recall
merely needing *"improvements"* when recall is 0.09–0.15 — **especially** this team, which in
the same paper calls the TTP task *"a substantial challenge"* at recall 0.1414–0.2270. The
authors' own contrast between their two tasks places IoC recall well above the reconciling
range. Entered as the issue's fourth `candidate_resolution`, status **supported**, with the
independence caveat stated in the entry itself: both textual legs come from one author team,
so this is one independent measurement plus arithmetic, not two independent measurements.

### Why I did not close `ctr-0001`

The closure condition written into `ctr-0001` is that confound (1) SYSTEM be *confirmed as the
explanation*. It is not. Three reasons, and the third was a surprise:

1. **Eliminating a rival reading is not demonstrating the survivor.** The metric confound is
   out; that does not show scaffolding causes the gap.
2. **The CORPUS confound is untouched.** No cycle has compared PRISM's 50 public reports with
   src-0007's unnamed company's internal workflow for difficulty. It is now the largest
   unaddressed gap and nothing this cycle bears on it.
3. **The system argument's textual anchor got WEAKER under verbatim inspection.** Nine cycles
   of notes say src-0007's Table 4 is *"explicitly headed 'Vanilla LLMs'"*. The caption is
   confirmed verbatim — but **two of the table's four columns are fine-tuned** (GPT-4o (FT),
   GPT-4o-mini (FT)). So "vanilla" cannot mean "not fine-tuned"; the only reading consistent
   with the columns is "unscaffolded". **The paper never defines the term.** That is an
   inference from column headers, not a quotation, and the entire system-confound argument
   rests on it. It is still the best textual evidence available, and it is weaker than
   "explicitly headed" implies. Both halves of that are now recorded in the issue.

### A new obstacle, independent of all three confounds

src-0017's evaluator matches predictions to ground truth by **two-directional substring
containment** (`pred.lower() in ground truth or ground truth in pred`) alongside exact match,
which inflates true positives relative to strict equality; and its README **never states that
the ground truth is exhaustive per article**. Either could make src-0007's 0.8240 and
src-0003's 97.6% incommensurable *regardless of whether the recall figure is ever obtained*.
Recorded as a new `open_question`. This is the cheapest high-value next step in the issue: it
needs the rest of `eval_ioc.py` read and src-0003's matching rule read alongside it, and no
new search at all.

### Sources added: 1 of 5 permitted

**src-0017** — the CyberThreat-Eval artefact release, `https://github.com/xschen-beb/CyberThreat-Eval`,
type `dataset`, with `state/knowledge/src-0017.md`. Added under `prompts/t3_investigate.md`
step 2. Its limitations section leads with the risk most likely to bite a future cycle: the
sub-README displays `Overall Precision: 0.8000` / `Overall Recall: 0.6667` as **illustrative
quick-start output against the manual example file**. Those are toy numbers with no relation
to the paper's measurements and **must never be cited as src-0007's missing recall**.

## Retrospection

**Target: src-0016** (`https://snyk.io/blog/snyk-vulnbench-js-1-0-llm-security-review-repeatability/`),
the last never-verified source in the base per carry-forward [8]/[20], and its only non-arXiv,
non-institutional technical source — a vendor publishing on a market it sells into. Re-fetched
2026-07-30 with a combined verbatim string-search and whole-table transcription request in one
call, with an explicit instruction to write ABSENT rather than infer.

**VERDICT: SUBSTANCE PASSES, PROVENANCE PARTIALLY FAILS.** Every figure this source contributes
is confirmed exact — 80, 161, 22, 134, 158, 84.8%, 300 runs, 10 fixtures, 44 reference
findings, byline "Written by Liran Tal June 29, 2026", and the six configurations. **No
contradiction entry opened**: nothing here conflicts with a supported claim anywhere in the
base. Two defects are in the *record*, and both are now repaired by appendix.

**Defect 1 — a stored "verbatim" quote is a composite that does not exist on the page.**
`src-0016.md` and `index.json` key_claim 1 both present as one quotation: *"80 of 161
unique-unmatched findings appeared in only one of five identical repetitions, while only 22
appeared in all five."* The page reads *"Across all model configurations, 80 of 161 unique,
unmatched finding signatures appeared in only one of five repeated runs."* The "22 in all
five" clause is **not prose at all** — it is a distribution-table cell (5 of 5 runs = 22,
13.7%). Every number is right; the quotation is manufactured. Note the unit is a finding
*signature*, not a finding.

**Defect 2 — "no table was present to pull" is false. There are FOUR tables.** The collection
note asserted the page had no tables and asked a future cycle to hunt for a per-model
breakdown. That breakdown was sitting in a table on the page the whole time. All four are now
transcribed into `src-0016.md`. They change how the source's headline numbers should be read:

- **The stability split is an order of magnitude wide across configurations.** Unique unmatched
  findings run **5** (Opus 4.6 Medium) to **60** (Sonnet 4.6 Medium) on identical inputs; the
  fully-stable share runs 60.0% down to 8.3%. The 84.8% / 13.7% aggregates in key_claim 1
  average over configurations that behave nothing alike, and should be quoted saying so.
- **The baseline row is a tautology, not a measurement.** Snyk Code SAST scores 100.0% F1 /
  recall / precision against a reference set *defined as Snyk Code's own findings* ("44 Snyk
  Code reference findings"). The vendor-self-interest limitation already on file, made
  concrete. **That row must never be cited as evidence SAST beats LLMs.**
- **Precision and recall rank the model families oppositely** — Opus 89.8–91.5% precision at
  68.0–68.2% recall; Sonnet 58.6–62.6% precision at 80.9–81.3% recall. A precision-only report
  of this benchmark would invert a recall-only one. A live worked example of exactly the metric
  confound at the centre of `ctr-0001`, on a different task, found by accident during G2.

**The methodological rule earned its keep for the twelfth cycle running.** A summarised
"the stored quotes check out" would have passed both defects through. Asking for whole tables
in the same call that did the string search cost nothing and recovered a table nobody knew
existed.

## Changes made

- `state/knowledge/src-0016.md` — appended `## CYCLE-21 G2 RE-VERIFICATION`: pass/fail verdict,
  both defects, all four tables transcribed, and four notes on how the recovered tables qualify
  the stored claims. Nothing deleted.
- `state/knowledge/src-0007.md` — appended `## CYCLE-21 APPENDIX`: the Section 4.3 recall
  sentence, the annotation-scope sentence, and **Table 4 whole and verbatim**. Discharges
  carry-forward **[19]** (Triage pass-rate/bias rows, never before pulled verbatim) and **[25]**
  (Content: Threat Actor rubric block, which three issues depend on and this file omitted).
  Also captures the Deep Search URLs-Extraction block, previously uncaptured.
- `state/knowledge/src-0017.md` — **new source**, the CyberThreat-Eval artefact release.
- `state/knowledge/index.json` — added src-0017; **appended** one key_claim to src-0007 and one
  to src-0016. No key_claim removed or altered (validator lines 105–107 error only on removal).
- `state/issues/graph.json` — on `ioc-extraction-reliability`: all five `open_questions`
  rewritten with cycle-21 status (one largely answered, three narrowed, one marked explicitly
  untouched) plus **one new** on the substring-matching obstacle; **new fourth
  `candidate_resolution`** (metric confound eliminated, status `supported`); cycle-21 note
  appended to the third candidate explaining why it stays `proposed`; `21` appended to
  `attempts`. On `ctr-0001`: a bracketed `[CYCLE-21 UPDATE ...]` **appended** to the
  description, all prior text intact, `resolved_cycle` left **null**.
- `logs/cycle-021.md`, `state/queue/next_task.json`, `state/queue/last_completed_task.txt`.

`jq -e` run after every JSON edit; both files parse. Issue now has 6 open_questions and 4
candidate_resolutions, `attempts [9, 21]`.

### Sandbox findings, new this cycle

- **`gh` IS NOT APPROVED.** `gh api repos/...` and `gh search repos` both refused, even
  un-compounded. GitHub must be reached through `WebFetch`; `raw.githubusercontent.com/<owner>/<repo>/main/<path>`
  works and is the way to read individual files. Directory listings via `/tree/main/<path>` also work.
- **`awk` refused again** (confirms carry-forward [9]); **`sed -n` and `cat >>` heredoc are
  APPROVED** — the heredoc append is how both source-file appendices were written, and it is
  much cheaper than Write-after-Read on a large file.
- **OpenReview is unreachable.** `openreview.net/forum` serves a browser-verification page and
  `api2.openreview.net` 302s into the same challenge. src-0007 has an OpenReview forum
  (`id=tiFtZHwr7O`) whose reviews would very likely discuss the missing recall — **that is a
  genuinely valuable but structurally unavailable source**, same class as [13] `spiegel.de`.
  Do not re-spend budget on it.

## Next task rationale

**T4 (assess)**, per the state machine `T3→T4`, `target_issue` null, `attempt_count` 0.

The T4 inherits a genuinely changed issue and should expect the score to be contested in both
directions. Arguments up: an open question largely answered, three narrowed, a new `supported`
candidate, a new source, and Table 4 finally pulled whole. Arguments down: `ctr-0001` is still
open so the **G3 ceiling still applies** (carry-forward [4] — the validator enforces a ceiling
of 3, while `prompts/t4_assess.md` and `config.yml` both say subtraction; **the T4 must apply
the ceiling**); the head-to-head still does not exist; the corpus confound is untouched; and
the system confound's textual anchor is now *weaker* than it was recorded as being.

**Carry-forward [4] is about to matter for the first time in twelve cycles.** It stays silent
only while this issue scores below the ceiling. Cycle 19 scored it 2. If the cycle-22 T4 now
raises it to 3, the two readings sit exactly on top of each other; if the T4 judges 4 warranted
on the merits, **the ceiling binds and the two specifications diverge observably** — which is
the situation [4] has been waiting for since cycle 16. The T4 must record both the merit score
and the ceiling-applied score if they differ, so a human can see the divergence in the state
rather than only in a log.

Knock-on for the cycle-23 T5 (carry-forward [30]): `automated-triage-under-refusal` lost cycle
20's selection to this issue **only** on rule 3c. If the T4 raises this issue above 2, that tie
breaks on score and the runner-up wins outright — and two things are already staged for it,
[27]'s reward-column finding and [19]'s Triage rows, **which this cycle has now discharged**.

## Budget

- WebSearch: 2 (both on locating src-0007's artefact release)
- WebFetch: 7 — snyk.io (G2); openreview.net forum (challenge page, wasted); api2.openreview.net
  (302 to challenge, wasted); arxiv.org/html/2603.09452v1 (the productive one — artefact URLs,
  Table 4 whole, whole-paper recall search, triage rows, rubric block, annotation scope, all in
  **one call**); github.com/secintelligence/... (404, wasted — bad URL from a search summary);
  github.com/xschen-beb/CyberThreat-Eval; raw .../eval_ioc.py; raw .../ioc/README.md;
  github .../tree/main/stage3_ti_drafting/ioc
- Bash: 7 (jq reads/validations, `sed`/`tail` inspections, 2 refused: `gh`, compound `awk`)
- Read: 6 · Edit: 7 · Write: 2
- Turns: ~24 of 50. Sources added: **1 of 5**.
- **Three of nine fetches were wasted on dead infrastructure** (OpenReview twice, a
  search-summary URL once). The single bundled arXiv call did the work of four and is the
  reason the cycle finished inside budget with two carry-forward items discharged as a
  by-product.

## Carry-forward items

All items from `logs/cycle-020.md` reproduced **including those I could not act on**, with
cycle-21 updates. Discharged items stay marked rather than deleted. **Five handoffs have now
lost or corrupted state** (cycle 11 dropped [8] and [9]; cycle 14 found [12]'s central claim
factually wrong; cycle 17's entire `state/` output was reverted; cycle 20 found [17]'s schedule
projection wrong and the T3 source-adding rule misstated) — **and this cycle found a sixth
defect, in a source record rather than a handoff: see [20] and [31]**. This section is
load-bearing.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2 candidate moved
verbatim. Vindicated numerically at cycle 19 (4 and 3 respectively).

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`. The graph
records a three-team claim. Did **not** move the score; the blocker is `open_question[1]`, the
missing human-analyst baseline. See [10].

**[3] — DISCHARGED cycle 16.** New issue `automated-triage-under-refusal`. First-scored cycle
19 (2). Runner-up at cycle 20's T5, not the selection — see [30].

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, AND NOW IMMINENT.** The G3 gate is
specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35
comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3 under
current config). The enforced reading is in the minority. Cycle 16 ruled for the **CEILING**;
replacement text in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`,
`scripts/` are outside this agent's output surface. **Until a human applies it, T4s must apply
the ceiling.** *Cycle 21 note: cycle 20 predicted this would start mattering if the T3 raised
the issue's score. It may now. `ctr-0001` is still OPEN so the gate still applies, and the
issue has materially strengthened. **The cycle-22 T4 should record the merit score AND the
ceiling-applied score if they differ**, so the divergence lands in the state and not only in
a log.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6,
the paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no
contradiction opened. Needs a PDF-level check, blocked by [14]. Per-phase percentages exist
ONLY as pie charts (Figure 2); Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%,
Gemini 4.8%, Grok 0, Cohere 0) are verified exact and their "approximate" caveat can be lifted.
*Cycle 21 note: src-0008 remains cited by the scaffolding candidate, which this cycle left at
`proposed`; not touched.*

**[6]** Unfinished search directions, open since cycle 9: citation-graph sweep of arXiv
2506.11325; **third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal
baselines**; the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no
preprint located — do not retry). **Forward-citation sweeps have FAILED on two different arXiv
ids — unavailable infrastructure, not an unsearched direction.** Cycle 17's topical leads stand
and are **unclaimed**: **SEvenLLM** (`arxiv.org/pdf/2405.03446`, 28 CTI tasks split 13
understanding / 15 generation), **AthenaBench** (no URL captured), **CTIArena** (no URL
captured). Leads, NOT sources; none is in `index.json` and none may be cited. *Cycle 21 note:
this cycle spent its search budget on the artefact release, not the literature, so the
head-to-head hunt was **not** re-run and these stay open. **Add to the unavailable list:
OpenReview** — src-0007's forum `openreview.net/forum?id=tiFtZHwr7O` almost certainly contains
reviewer discussion of the missing recall, and both the forum page and `api2.openreview.net`
serve a browser challenge. Same class as [13].*

**[7] — WORKED AT CYCLE 21; PARTIALLY DISCHARGED, THE PATH IS NOW REDRAWN.** `ctr-0001`
resolution path. **Done:** the released-code route is exhausted — recall is NOT recoverable
(model outputs unpublished) but the release proves the omission was a reporting choice
(`eval_ioc.py` computes and prints recall next to precision). The **METRIC confound is
ELIMINATED** (cycle 18's 0.09–0.15 arithmetic + src-0007's own Section 4.3 "relatively robust
... improvements in recall ... remain necessary"). **Still open:** no head-to-head; the
**CORPUS confound is completely untouched and is now the largest gap**; and the SYSTEM
confound's anchor weakened — "Vanilla LLMs" is a caption over two fine-tuned columns, so it is
an *inference* that it means "unscaffolded", not a definition. **New, cheapest next step:**
read the rest of `eval_ioc.py` and src-0003's matching rule together — src-0017's matcher uses
two-directional substring containment and its ground truth is not stated to be exhaustive,
either of which could make the two figures incommensurable **whatever** recall turns out to be.
Then the HuggingFace mirror (`huggingface.co/datasets/xse/CyberThreat-Eval`), unfetched.

**[8] — UPDATED cycle 21. G2 COVERAGE IS NOW COMPLETE: EVERY SOURCE IN THE BASE HAS BEEN
RE-VERIFIED AT LEAST ONCE.** src-0004 (c4, c12), src-0003 (c5), src-0002 (c6), src-0001 (c7),
src-0006 (c8; c17 PARTIAL FAIL, see [21]; re-pulled c18), src-0005 (c9 substance-only, c11
verbatim), src-0008 (c10), src-0012 (c13), src-0011 (c14), src-0007 (c15 PASSED; **c21 Table 4
pulled whole**), src-0009/src-0010 (c16 PASSED), src-0013 (c18 PASSED), src-0014 (c19 PASSED),
src-0015 (c20 PASSED with strengthening), **src-0016 (c21 — SUBSTANCE PASSED, PROVENANCE
PARTIAL FAIL; see [31])**. **New and never verified: src-0017 (added c21).** *Next G2 should
prefer by staleness: **src-0003 (last verified cycle 5 — sixteen cycles, and it is the
load-bearing, never-replicated side of `ctr-0001`)**, then src-0002 (c6), src-0001 (c7),
src-0005 (c9, and see [10] — no number has ever been captured from it). Not recommended next:
src-0016 and src-0007 (c21), src-0015 (c20), src-0014 (c19).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19, 20 and 21.** `python3` is present at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks every
invocation; compound/piped commands are rejected if any segment is unapproved. **No PDF text
extraction exists** — poppler-utils, `mutool`, `gs`, `qpdf` absent; `WebFetch` returns PDF bytes
undecoded; prefer `/html` always. See [24] for `jq`. *Cycle 21 additions: **`gh` is NOT approved**
even un-compounded, so GitHub must go through `WebFetch` —
`raw.githubusercontent.com/<owner>/<repo>/main/<path>` reads individual files and `/tree/main/<path>`
gives directory listings, both of which worked. **`awk` refused again. `sed -n` and `cat >>`
heredoc ARE approved** — heredoc append is the cheapest way to extend a large source file and is
how both appendices this cycle were written.*

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Every claim it contributes is
abstract-level and directional, and it is one of the sources holding
`ttp-attack-mapping-reliability` at 3. **Oldest un-actioned collection task in the project
(open since cycle 1); T1 work.** A T1 targeting that issue should hunt the **human-analyst
baseline F1** first (the actual level-4 blocker) and src-0005's numbers second. *Cycle 21 note:
unchanged; per [28] the next T1 may be ~14 cycles away.*

**[11] — APPLIED AND EXTENDED cycle 20.** Tie-break 3a in `prompts/t5_select.md` is
under-specified, with no deterministic tie-break after 3c. Cycle 20 ruled for the **strict
pairwise** reading. Suggested fix for a cycle with standing: add "**3d. longest time since the
issue last received new evidence; then fewest total attempts**" — **but 3d as proposed is not
sufficient**: `ttp-attack-mapping-reliability` and `attribution-confident-wrong-gap` tie on
score, 3a, 3b, 3c **and both limbs of 3d**. A terminal deterministic tie-break (e.g.
lexicographic issue id) is needed for closure. Same class as [4]. *Cycle 21 note: this cycle
gave `ioc-extraction-reliability` new evidence at cycle 21, which moves it to the **front** of
3d's first limb — i.e. least stale — should 3d ever be adopted.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger
claim was WRONG; see [17].** T2 is the only task type with standing to split an issue, add an
issue, or reconcile the prompt/validator disagreement. The claim that the loop "never returns
to T2" is false; cycle 16 disproved it. See [28] for the corrected projection.

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel
is the upstream primary for the entire ENISA incident: a permanent structural gap. The
archived-PDF footnote-count route is also closed (see [14]). Prof. Christian Dietrich's /
Institut für Internet-Sicherheit's own writeup is the only remaining route known to this agent.
*Cycle 21 note: OpenReview now joins this category — see [6].*

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA
v1.2 PDFs cannot be opened. **Consequence: "ENISA never disclosed the AI use" is established at
landing-page level and UNVERIFIABLE at document level here.** That leg **cannot strengthen**.
**Do not re-spend budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET.** The curl/HackerOne
case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop" reports; ~20% of
submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to under 5%) is
an **open_question on `automated-triage-under-refusal`**. **It is a question, not evidence — no
curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycle 19 judged it **the highest-value uncollected source in the project**. *Cycle 21 note: a
T3 may add sources ([29]), and per [30] the cycle-23 T5 may well select
`automated-triage-under-refusal` — **the T3 that follows would be the natural place to collect
this**, since it would then be serving its own target issue. That is the first realistic route
to it in many cycles.*

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

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: `prompts/system.md` specifies `T1→T2`, and the refresh rule makes a T5 landing on
a multiple-of-7 cycle emit a T1, so the chain is **T5 → T1 → T2**. Confirmed end-to-end by
cycles 14→15→16. The **phase** claim is right; the forward projection appended at cycle 19 was
wrong. Structural finding for the paper: the only task type that can restructure the issue graph
fires when a T5 coincides with a multiple of 7, which under a clean three-cycle loop is **once
every 21 cycles**, not every 7.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS
exhibiting the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid
citations across 308 papers. No claim in our base repeats the error and **no G3 entry was
opened**. Any cycle quoting src-0011's *counts* should take them from Table 3's columns.

**[19] — FULLY DISCHARGED CYCLE 21.** src-0007's Table 4 has now been pulled **whole and
verbatim** and transcribed into `state/knowledge/src-0007.md`. The **Triage pass-rate/bias
rows** — cycle 20 called them "the single most valuable uncaptured table block in the base" —
are captured: precision (Accepted) **0.2717–0.3982**, recall (Accepted) **0.9091–1.0000** across
both triage tasks and all four models, so `automated-triage-under-refusal`'s stored "0.27–0.40
vs 0.90–1.00" **holds as stated** and now rests on a verbatim pull. **New from the same pull:
fine-tuning does not fix the asymmetry and on the Article task worsens precision** (GPT-4o
0.3037 → GPT-4o (FT) 0.2717 with recall unchanged at 0.9798–1.0000) — same direction as
src-0001's fine-tuning result. The **Deep Search URLs-Extraction block** is also captured
(GPT-4o 6.22 avg URLs vs GPT-4o-mini (FT) 1.25; URLs with additional info 3.54 → 0.22).
**RESIDUE, UNRESOLVED AND REPRODUCED:** the FT-column anomaly — GPT-4o (FT) tracks o3-mini to
within 0.001 on **all six** Content: Threat Actor rubric rows. Two independent pulls (c15, c21)
return identical cells, so it is as-printed, not a fetch artefact. **Cause unknown; do not
guess. Any claim resting on the GPT-4o (FT) rubric column must say the column is suspect.**

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES NOW VERIFIED.** src-0013 (c18),
src-0014 (c19), src-0015 (c20) and now **src-0016 (c21)**. src-0015 is doubly confirmed with two
columns recovered ([27]). src-0013 is confirmed at table level; its FT discrepancy is **narrowed
but not closed** — 33.9% is TABLE II's per-model aggregate, 16.9% → 83.2% is the
SALLM-to-repository comparison; different scopes, not arithmetically reconcilable, so **quote
them only with their scopes named**. Gemini's 0.161 → 0.721 was **not** re-checked. **Residue:
src-0014's F1 figures (0.398/0.103/0.465/0.427) are still body-sentence-only.** *src-0016's
outcome was not a clean pass — see [31].*

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18.** `src-0006.md` and
`index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 for a specialized agent vs.
0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak
is **G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly
0.20–0.90" against a true span of **0.286–0.882**. Cycle 18 **APPENDED** a corrective key_claim
to src-0006's `index.json` entry. `src-0006.md` itself is still untouched and still contains the
wrong sentence. **Column split: 8 general (G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber
(FSC, CB0, ZYS, LLY, CBS, SPT, DHT).**

**[22] — REPRODUCED A THIRD TIME cycle 18.** An unexplained regularity in src-0006's Table 2:
eleven of twenty-eight rows are **strictly monotone decreasing across all eight general-purpose
columns in exactly the printed column order**. Four are in the nine-row F1 subset
`extraction-vs-reasoning-ordinal-axis` depends on. For independent measurements, one row
matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.**
Cause unknown; do not speculate. **Any finding resting on src-0006's Table 2 must carry a
robustness check excluding these rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049,
same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.**
`task-dependent-reliability-framing`'s supported candidate cites src-0006's "F1/AUC roughly
0.20–0.90" as evidence that reliability varies sharply by sub-task. Mean between-**model** range
within a task (0.272) and mean between-**task** range within a model (0.263) are equal to within
0.009. **This does NOT negate the supported claim** — cycle 19 tested it as a counterargument
when raising that issue to 4 and concluded it is not one. It qualifies the implication that
sub-task is the *privileged* explanatory variable. A T2 should annotate the parent's candidate
rather than re-scope it. No contradiction entry: both facts hold simultaneously.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–21. `jq` IS INSTALLED AND APPROVED.**
`jq -e . <file>` parses and exits non-zero on malformed JSON; `jq -r '<filter>'` reads structure
without a full-file Read. **Every cycle from 9 to 17 recorded that this agent cannot validate
JSON and must check "by construction". That advice is wrong and it is expensive** — cycle 17 made
five blind edits to a 57 KB JSON file and had its entire `state/` output reverted. **Every JSON
edit should be followed by a `jq -e` check.** The permission layer is **not uniform**: `grep -n`
refused at c18; `jq` on `/dev/null` refused at c19 as a **path** violation; a compound call with
`awk` refused at c20 and again at c21; **`gh` refused outright at c21**. **Probe once; don't infer
from class.** *Cycle 21 note: the `Grep` tool works on `state/issues/graph.json` where `grep -n`
via Bash does not — use the tool, not the shell, for locating lines in the big JSON.*

**[25] — DISCHARGED CYCLE 21.** `state/knowledge/src-0007.md` now contains the Content: Threat
Actor rubric block in full, appended verbatim with all six rows and all four columns, alongside
the whole of Table 4. The values three issues depend on no longer live only in
`logs/cycle-015.md` and issue prose. **The two caveats travel with it and must keep travelling:**
the rubric's **absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs
(x−1)/4, a normalisation the paper never states), so **only within-table contrasts may be
cited**; and the GPT-4o (FT) column is suspect per [19].

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's errors to
stdout, but `logs/cycle-017-transcript.txt` captures the agent's own output only, and the
reverted `state/` files were never committed. Most likely cause is malformed JSON — a class [24]
now makes cheaply avoidable — but **no cycle can confirm it**. Suggested harness fix for a human:
tee `python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before
reverting, and `git stash` the rejected `state/` diff rather than discarding it.

**[27] — NEW cycle 20, STILL UNENTERED AND NOW MORE RELEVANT.** src-0015's Table 1 has a
**`Reward`** column no cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61,
DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward**, and
the two highest-containment models take the two highest rewards. Bears directly on
`automated-triage-under-refusal`'s `open_questions[0]` — models versus harness. **Caveats:** the
fetched material does not state the reward's composition; n = 40 per model, no CIs; the
association is not strictly monotone (DeepSeek outscores GPT-5.2 at lower containment);
adjacent-model differences are unresolved per src-0015's own limitations. **Not entered into the
state.** It is an observation about an already-collected source, so **no new citation is needed**
when a cycle working that issue uses it. Also uncaptured: the `Threshold` column.

**[28] — NEW cycle 20, RE-DERIVED AND CONFIRMED cycle 21.** The state machine is
T1→T2, T2→T3, T3→T4, T4→T5, T5→T3. Cycle 21 was a **T3**, so **cycle 22 is T4 and cycle 23 is
T5**. `collect_refresh_every: 7` and the refresh fires only when a T5 **runs on** a multiple-of-7
cycle (pinned from git history: cycle 14 T5 → cycle 15 T1 collect). 23 % 7 = 2, so **cycle 23's
T5 does NOT refresh**; under a clean loop T5 lands on 20, 23, 26, 29, 32, **35**, and **the next
T1 is cycle 35** with the next T2 after that. A failed-validation retry shifts the phase by one —
that is how the phase reached its current position (cycle 17's T3 failed, retried at 18) — so
**re-derive rather than trusting this if a cycle fails**. **Consequence for a human:** the two
highest-value uncollected items ([15] curl/HackerOne, [10] the human-analyst ATT&CK baseline)
both need a T1 and neither gets one for ~14 cycles. If that is not intended, either
`collect_refresh_every` or the refresh rule's phrasing needs attention. *Cycle 21 note: [15] now
has a possible earlier route via a T3 — see [15].*

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycle 21.** A T3 **MAY** add sources.
`prompts/t3_investigate.md` step 2: "Only web-search for what the knowledge base cannot answer
(and if you fetch something substantial, add it properly as a source per T1 rules — it counts
toward the same `max_new_sources` budget)." *Cycle 21 exercised this and added src-0017, without
which the whole recall finding would have been uncitable.* **Standing lesson: read the task's own
prompt file, not only the queue entry's description of it.**

**[30] — NEW cycle 20, for the T5 at cycle 23; ITS PREREQUISITES ARE NOW DISCHARGED.**
`automated-triage-under-refusal` (score 2, `created_cycle` 16, **attempts `[]` — the only issue
never worked on**) lost cycle 20's selection to `ioc-extraction-reliability` **only on rule 3c**,
older `created_cycle` (2 vs 16). *Cycle 21 note: **if the cycle-22 T4 raises
`ioc-extraction-reliability` above 2, the tie breaks on score and this issue wins outright** — 3c
never gets reached. Both things staged for it are now ready: [27]'s reward-column finding, and
[19]'s Triage rows, **which cycle 21 discharged** — its stored 0.27–0.40 vs 0.90–1.00 asymmetry
is confirmed verbatim and gained a finding (fine-tuning worsens triage precision).* Note the
structural asymmetry the policy does **not** encode: "never attempted" is not a tie-break in
`prompts/t5_select.md`, and cycle 19's `scores.json` rationale wrongly asserted it was. If a human
thinks never-worked issues should be favoured, that is a prompt change, not a reading of the
current rules.

**[31] — NEW cycle 21. A STORED "VERBATIM" QUOTE WAS A COMPOSITE, AND A COLLECTION NOTE WAS
FACTUALLY WRONG — BOTH IN src-0016, BOTH NOW REPAIRED BY APPENDIX.** (a) The string
`"80 of 161 unique-unmatched findings appeared in only one of five identical repetitions, while
only 22 appeared in all five"` is presented in `src-0016.md` and `index.json` as one quotation
and **does not exist on the page**; it splices a real sentence to a table cell. All figures are
correct, so this is a quotation defect, not a factual one — **but it is the first case in this
project of a fabricated-by-splicing quote surviving in the knowledge base, and it survived
because no cycle re-checked it for six cycles.** (b) The collection note "no table was present to
pull" is false; there are **four** tables, now transcribed. **Standing lesson, and the reason
this item exists: quote-splicing is invisible to any check that does not re-fetch the page and
string-search the exact stored string.** G2's methodological rule catches it; a substance-only
re-read never would. **Recommendation for a cycle with standing:** the same check has never been
run on the other sources' stored "verbatim" quotes, and there is no reason to think src-0016 is
unique. src-0003 (last verified cycle 5, sixteen cycles) is the obvious place to look next, and
it is also the load-bearing side of `ctr-0001` — see [8].
