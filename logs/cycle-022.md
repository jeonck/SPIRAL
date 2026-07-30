# Cycle 022 — T4 Assess — all eight issues

## Task performed

T4 per `prompts/t4_assess.md` (read directly, not via the queue entry's description of it).
Every issue in `state/issues/graph.json` was scored, `assessed_cycle` set to 22 on all eight
entries, and `last_assessed_cycle` set to 22.

| issue | c19 | c22 | movement |
|---|---|---|---|
| `ttp-attack-mapping-reliability` | 3 | **3** | held |
| `ioc-extraction-reliability` | 2 | **2** | held (merit 2; ceiling 3 did not bind) |
| `consistency-calibration-as-failure-mode` | 2 | **2** | held |
| `attribution-confident-wrong-gap` | 3 | **3** | held |
| `task-dependent-reliability-framing` | 4 | **3** | **LOWERED** |
| `extraction-vs-reasoning-ordinal-axis` | 3 | **3** | held |
| `institutional-incident-real-world-impact` | 3 | **3** | held |
| `automated-triage-under-refusal` | 2 | **2** | held (a better-verified 2) |

Full reasoning is in each `rationale` in `state/assessments/scores.json` and is not repeated
here. Three things need to be said in the log because they are decisions about the loop rather
than about the evidence.

### 1. `ioc-extraction-reliability` held at 2, and carry-forward [4] stayed latent for a 13th cycle

The cycle-21 handoff predicted that this cycle would finally expose the G3 specification
conflict, because a rise above 2 would meet the enforced ceiling. It did not, and not for a
procedural reason: **the honest merit score is still 2.** Level 3 requires the *primary*
candidate to rest on ≥2 **independent** sources. Candidate 1 rests on src-0003 alone,
candidate 2 on src-0007 alone, and cycle 21's new supported candidate 4 cites
`[src-0003, src-0007, src-0017]` but **src-0017 is the same team's artefact release for
src-0007** — a fact stated plainly both in src-0017's own index entry and in candidate 4's own
text ("rests on ONE independent measurement plus arithmetic … not on two independent
measurements"). Three source ids is not three independent sources, and a candidate that states
its own independence limit honestly should be taken at its word.

Both readings of the gate were recorded in the rationale anyway, per item [4]: **merit 2,
ceiling-applied 2, ceiling did not bind.** The conflict is therefore still *untested*, not
resolved — and worth restating because it is getting closer to mattering, not further: under the
**subtraction** reading (`prompts/t4_assess.md` step 3, `config.yml` line 35 comment) this issue
would now read **0**, which would stamp an issue holding four `candidate_resolutions` with the
rubric label "no candidate resolutions" and hand the weakest-link selector a fabricated bottom
it could never escape. Under the **ceiling** reading (`scripts/validate_state.py` lines 144–156,
the only enforced one) it reads 2. Replacement text is in `logs/cycle-016.md` "Item 3" and awaits
a human, since `prompts/`, `config.yml` and `scripts/` are outside this agent's output surface.

### 2. `task-dependent-reliability-framing` lowered 4 → 3, on new evidence rather than a re-reading

Cycle 19 raised this to 4 on an explicit argument: the counterargument that could sink the issue
is `open_question[3]` (is the whole pattern an artefact of leaning on src-0003's single-study,
never-replicated LANCE result?), and the answer is that it survives with src-0003 deleted, because
the two strongest legs are **within-study** designs holding team, corpus, models and harness
constant while varying only the sub-task. That argument was right on the evidence then available.
It has a hole that only became visible afterwards:

> A within-study design holds team, corpus, models and harness constant. **It does not hold the
> scoring rule constant.** A cross-sub-task score spread is a task-difficulty fact only if the
> sub-tasks are scored comparably.

Two findings post-dating cycle 19 turn that from a quibble into a live objection: (a) src-0017
(added cycle 21) shows src-0007's released IoC evaluator matches by **two-directional substring
containment**, not strict equality, and the corresponding rule for its ATT&CK task has never been
pulled — so some unknown part of the ~3× within-table spread could be scoring leniency; (b) my own
G2 this cycle shows src-0003's 97.6% is a **classification** score over a regex-extracted candidate
set, a task-*format* difference rather than a sub-task difference.

This does not touch level 3, which is cleared easily (seven sources, ≥5 unaffiliated teams, and the
qualitative claim is not in doubt), and it does not touch every leg — src-0007's rubric contrast
(Threat Actor 1.140 vs Root Cause 3.612) is one instrument and is immune. It touches level 4
precisely, because level 4 is *counterarguments addressed* and this one is **not stated anywhere in
the issue, in either candidate, or in any open_question.** An issue cannot be credited with
addressing an objection it has not noticed. **What restores the 4:** pull src-0007's per-task
evaluation protocols from the src-0017 artefact (the IoC evaluator is already read; the TTP and
rubric scorers are not) and src-0006's per-task scoring definitions, then state and answer the
objection in the issue. If the scoring rules are comparable, cycle 19's argument stands as written.

I explicitly did **not** demote on the ground cycle 19 itself offered a successor (that candidate 2
answers `open_question[3]` without cross-referencing it in the state). I think cycle 19 was right
about that. The distinction matters for the paper: **this is a score responding to new evidence,
not to a more grudging reading of the same evidence.**

### 3. The same finding is neutral-to-favourable for the child issue, and I did not apply it mechanically

`extraction-vs-reasoning-ordinal-axis` held at 3 even though the commensurability finding bears on
it too, because its supported claim is **negative and evidential** — the available commensurable
measurement does not support the proposed ordering. If the measurements are *less* commensurable
than believed, there is even less evidence for the ordering. I checked the reverse reading (route 1
weakens because its "commensurable measurement" may not be commensurable) and the outcome is the
same either way: then no commensurable measurement supporting the ordering exists at all. What it
does add is a **third unaddressed caveat**, which keeps that issue well clear of 4.

## Retrospection

**G2 target: src-0003** (`https://arxiv.org/html/2506.11325v2`), chosen on the cycle-21
recommendation: last verified at **cycle 5 — sixteen cycles, by far the stalest** — and it is the
load-bearing, never-replicated side of `ctr-0001`. Two fetches of the same URL, both demanding
verbatim strings with an explicit instruction to answer ABSENT rather than infer, per the
methodological rule.

**Verdict: SUBSTANCE PASSED on every load-bearing figure; PROVENANCE PARTIAL FAIL on three stored
baseline values and one per-LLM value; plus two substantive new findings.**

### Passed, verbatim

- `"The first open, fully manually validated, and well-documented benchmark dataset of IoCs from
  threat reports, consisting of 1,791 indicators extracted from 50 real-world threat reports."`
- `"LANCE outperforms all other methods, consistently achieving over 90% F1 score across all types
  and 97.6% overall."` — one sentence supporting both the 97.6% overall F1 and the ">90% across all
  four types" claim.
- `"LANCE labeled over 99% of all extracted indicators, with the few unlabeled cases attributed to
  malformed LLM outputs."`
- `"we see a 43% drop in the average and median time the analysts spent on a report."`
- `"we see that the LANCE-trained model outperforms the VT1-trained model by over 6% and the
  VT5-trained model by over 8% in terms of F1 score."` (the ">8% vs VT5" limb was not previously
  recorded anywhere.)

**The [31] quote-splice check PASSED** on all three of src-0003's stored quotations — the exact
strings are on the page. This is the first source to pass that check.

### Failed: the three baseline F1 values are figure-image-only

`src-0003.md` key claim 1 and `index.json` key_claims[1] both state LANCE's 97.6% "outperform[s]
IoC Searcher + whitelist (76% F1), AlienVault OTX (72% F1), and VirusTotal at detection
threshold=1 (86% F1)". **None of those three numbers appears as text anywhere on the page.** The
exact strings `76` and `72` do not occur. The only `86%` is
`"Its lowest score, 86.8% recall on domains, is due to intentional disagreements between LANCE's
labels and the senior analyst in cases involving compromised legitimate websites"` — which is
**LANCE's own per-type recall, not VirusTotal's F1.** A full caption inventory (Figures 1–10,
TABLE I–IV) confirms **no table carries baseline performance numbers**; they exist only inside
**Figure 6**, "Performance evaluation of prominent Automated ground truth creation methods", an
image this agent cannot read. Cycle 1 collected this source by "automated HTML summarization",
which cannot read a figure image, so the provenance of 76/72/86 is unknown.

The **ordering** *is* textually supported: VirusTotal at thresholds 1 and 5 are "the two highest
performing ground truth generation methods … as indicated in Figure 6"; the whitelist method
"still suffers from poor precision due to insufficient context awareness"; AlienVault "yields the
most unlabeled indicators (37%)" and platforms like it "suffer from coverage gaps and labeling
inconsistencies". So 86 > 76 > 72 is consistent with the prose and **nothing is falsified** — but
these three values must be cited as **figure-derived and not text-verified**, never as reported
values. Likewise `~0.88 F1 with Llama` (src-0003.md key claim 3) is unverifiable: `0.88` does not
occur. What the page says is `"Gemma and Gemini perform comparably to GPT, achieving total F1
scores of 0.98 and 0.92, respectively"` — so 0.92 is **Gemini** (the stored claim is right about
that) and **0.98 is Gemma, never recorded before**; Llama's value is in Figure 9 only.

**Why I did not open a contradiction entry, stated so a successor can reverse me.** G3's trigger
(`prompts/system.md` rule 3) is **two supported claims in conflict**. There is no rival claim
asserting different baseline values, and since I cannot read Figure 6 I cannot assert 76/72/86 are
*wrong* — only that they are not text-verifiable. Filing a contradiction for an
unverified-provenance finding would dilute the G3 signal, which is the mechanism the loop depends
on. Cycle 21 reached the same conclusion on src-0016's spliced quote and cycle 12 on ENISA's
silence; the same test is applied in `institutional-incident-real-world-impact`'s rationale this
cycle, and the consistency is deliberate. Instead the defect is **repaired where it lives**: three
corrective `key_claims` **appended** to src-0003's `index.json` entry (nothing removed or
rewritten) and an appendix **appended** to `state/knowledge/src-0003.md`. src-0016's splice
survived six cycles precisely because it was only ever going to be caught by something that
re-fetched the page — a defect recorded only in a log is a defect still in the knowledge base.

### Two substantive new findings from the same fetches

**(a) The 97.6% is a CLASSIFICATION score over a regex-extracted candidate set.** Verbatim: `"We
assume a total of 1,789 candidate indicators, extracted using IoC Searcher, a state-of-the-art
rule-based tool"`; `"For this purpose, we adopted IoC Searcher … and integrated it into our
pipeline"`; `"IoC Searcher demonstrates high recall across various IoC types, making it well-suited
for the initial extraction phase"`; `"LANCE labeled over 99% of all extracted indicators"`; and
Figure 9's caption, `"Comparison of the F1 Score of the LANCE implementation using GPT, Llama,
Nvidia Nemotron, Gemini, and Gemma on IoC Classification."` The LLM's job is to **label**
indicators a regex has already found, over an enumerated candidate list. src-0007's 0.8240–0.8846
is precision on IoCs a model generates itself from an article. **This is a difference in task
format, not only in scaffolding** — and unlike the "Vanilla LLMs" caption reading, which cycle 21
correctly downgraded to an inference the paper never states, this one is *stated by the paper*. It
is the strongest textual anchor `ctr-0001`'s SYSTEM confound has ever had, and simultaneously makes
the two headline numbers less commensurable than any cycle has recorded.

**(b) src-0003 never states its matching rule.** A targeted verbatim search of its
evaluation/metrics/methodology sections for `exact match`, `matched`, `matching`, `normaliz`,
`defang`, `case-insensitive`, `ground truth`, `true positive`, `false positive` returned **no**
sentence stating how a predicted indicator is compared with a ground-truth indicator. The nearest
is about label agreement, not string matching: `"We define a disputed indicator as an indicator for
which there was no total agreement between the labels of the analysts and the LANCE-generated
label."` So the open_question cycle 21 added — strict equality vs substring/normalised matching —
**cannot be closed from the sources in this base.** It is not merely unresolved; it is unresolvable
without a source we do not have. Under finding (a) a string-matching rule may not even be
well-defined for src-0003's headline number.

### Methodological note: the two fetches disagreed, and the summarising one was wrong

Fetch 1, asked "is the value X?", answered that the text "references 'achieving an average F1 score
of 86%'" for VirusTotal. Fetch 2, asked for exact strings, returned the only `86%` on the page as
LANCE's 86.8% domain recall. Fetch 2 is self-consistent and quotable; fetch 1 **misattributed a
real number to the wrong subject** — exactly the failure the methodological rule exists to catch,
and it would have "confirmed" a stored claim that is not text-supported. **Twelfth consecutive
cycle in which demanding verbatim strings changed the outcome.**

## Changes made

- `state/assessments/scores.json` — all eight issues rescored, `assessed_cycle` 22,
  `last_assessed_cycle` 22. One movement: `task-dependent-reliability-framing` 4 → 3. `jq -e`
  validated.
- `state/knowledge/index.json` — **three `key_claims` APPENDED** to src-0003's entry (G2
  by-product): the provenance correction on 76/72/86 and Llama 0.88; the classification-vs-extraction
  finding; the absent-matching-rule finding. **No key_claim removed or rewritten**, so the
  append-only gate (`validate_state.py` lines 105–107) is satisfied; src-0003 is not a new source so
  the URL liveness check does not re-run. `jq -e` validated.
- `state/knowledge/src-0003.md` — appendix appended (heredoc), recording all of the above verbatim.
  Nothing above it altered.
- `logs/cycle-022.md` — this file.
- `state/queue/next_task.json` — T5 (select) for cycle 23, `target_issue` null, `attempt_count` 0.
- `state/queue/last_completed_task.txt` — `T4 assess`.

**Not changed, deliberately:** `state/issues/graph.json`. A T4 scores; it does not open or close
contradictions, promote candidates, or add open_questions. `ctr-0001` stays open with
`resolved_cycle` null. The three findings above are recorded in the knowledge base and in
rationales, and are flagged below for the cycle-24 T3.

### Sandbox findings, new this cycle

- **A compound command mixing `jq … && cat >> … <<'EOF'` was rejected** with
  `Parser skipped input between top-level statements`. Split into two calls and both halves worked.
  Consistent with [24]: heredoc append is approved *alone*; compounding it is not.
- `jq -e . <file> > /dev/null` is approved (redirect to `/dev/null` as an *output redirect* works,
  unlike passing `/dev/null` as a jq *path* argument, which was refused at cycle 19).
- The `Grep` tool on `state/knowledge/index.json` worked and is much cheaper than reading the 36 KB
  file to locate an insertion point.

## Next task rationale

State machine: T3 (c21) → **T4 (c22)** → **T5 (c23)**. `23 % 7 = 2`, so the refresh rule does not
fire and cycle 23's T5 emits a **T3**, not a T1. Next refresh under a clean loop is **cycle 35**
(T5 lands on 20, 23, 26, 29, 32, 35). A failed-validation retry shifts the phase by one, so cycle 23
must **re-derive** rather than trust this.

**The T5's arithmetic is going to come out differently from what cycle 20 and item [30] expected, so
I set out my own working — but the T5 must redo it and show its own table, not copy mine.** Three
issues sit at 2:

| issue | score | attempts | created | 3a upstream? | 3b penalty | effective |
|---|---|---|---|---|---|---|
| `ioc-extraction-reliability` | 2 | [9, **21**] | 2 | — | **+1** (c21 is inside the window) | **3** |
| `consistency-calibration-as-failure-mode` | 2 | [3, 15, 16] | 2 | — | 0 | **2** |
| `automated-triage-under-refusal` | 2 | [] | 16 | — | 0 | **2** |

- **3a is silent here.** Under cycle 20's *strict pairwise* ruling (item [11]), 3a separates
  candidates only when one candidate `depends_on` another candidate. None of these three depends on
  another of the three. (`consistency-calibration-as-failure-mode` *is* depended on by two issues,
  but neither is in the candidate set.)
- **3b removes `ioc-extraction-reliability`.** It was attempted at cycle 21, one cycle ago —
  inside the five-cycle window under any defensible reading of the floor (≥18 or ≥19), so the
  result is robust to that ambiguity. This is the change item [30] did not anticipate: at cycle 20
  this issue had no recent attempt; now it does.
- **3c breaks the remaining tie for `consistency-calibration-as-failure-mode`** — older
  `created_cycle` (2 vs 16).

So on a mechanical application of the current policy the likely selection is
**`consistency-calibration-as-failure-mode`**, *not* `automated-triage-under-refusal`. Note what
that means and do not paper over it: the only issue in the graph **never worked on** loses again, to
an issue attempted three times, because "never attempted" is **not** a tie-break in
`prompts/t5_select.md` (cycle 19's `scores.json` rationale wrongly asserted it was). If a human
thinks never-worked issues should be favoured, that is a prompt change, not a reading of the
current rules. Item [30] flagged this asymmetry; it now bites for the second consecutive T5.

Whichever issue is selected, the T3 that follows has unusually well-staged work waiting:
- `consistency-calibration-as-failure-mode` → the blocker is exact and narrow: **one CTI-task
  measurement of consistency or calibration** would take it to 3. Its four corroborating sources all
  measure non-CTI tasks and the cycle-16 scope ruling correctly refuses to count them.
- `automated-triage-under-refusal` → [15] (the curl/HackerOne source, still uncollected and judged
  the project's highest-value uncollected item) and [27] (src-0015's unentered `Reward` column,
  which bears directly on its central models-vs-harness question).
- `ioc-extraction-reliability` → the CORPUS confound, now the largest gap in `ctr-0001`, plus the new
  items [33] and [34] below.

## Budget

- WebFetch: **2** (both on `https://arxiv.org/html/2506.11325v2`, the G2 target; the second was
  needed because the first returned a summarising misattribution, and it carried the caption
  inventory, the exact-string list and the matching-rule request in one call).
- WebSearch: **0**.
- Bash: 8 (`ls`/`wc`, four `jq` reads/validations, one heredoc append, one rejected compound).
- Read: 7 files (`meta.json`, `next_task.json`, `config.yml`, `scores.json`, `t4_assess.md`,
  `validate_state.py` excerpt, `t5_select.md`, `src-0003.md`, `cycle-021.md` carry-forward section).
- Grep tool: 1. Edit: 2. Write: 3.
- Turns: well inside the 50 cap. `state/issues/graph.json` (83 KB) was never read whole — all six
  inspections went through `jq -r` projections, which is where the saving came from.

## Carry-forward items

All items from `logs/cycle-021.md` reproduced **including those I could not act on**, with cycle-22
updates. Discharged items stay marked rather than deleted. **Five handoffs have lost or corrupted
state** (cycle 11 dropped [8] and [9]; cycle 14 found [12]'s central claim factually wrong; cycle
17's entire `state/` output was reverted; cycle 20 found [17]'s schedule projection wrong and the T3
source-adding rule misstated), cycle 21 found a sixth defect class in a source record, **and this
cycle found the same defect class in a second source — see [31] and [32].** This section is
load-bearing.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2 candidate moved
verbatim. *Cycle 22 note: the split is still vindicated — the two halves now score 3 and 3, and they
moved for different reasons this cycle (the parent demoted, the child held), which a single averaged
score could not have expressed.*

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`. The graph
records a three-team claim. Did **not** move the score; the blocker is `open_question[1]`, the
missing human-analyst baseline, now in its **eleventh** cycle. See [10].

**[3] — DISCHARGED cycle 16.** New issue `automated-triage-under-refusal`. First-scored cycle 19 (2),
held at 2 cycle 22 on a discharged verification gap — see [19] and [30].

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, AND STILL UNTESTED AFTER 13 CYCLES.** The G3
gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35
comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3 under current
config). The enforced reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement
text in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are
outside this agent's output surface. **Until a human applies it, T4s must apply the ceiling.**
*Cycle 22 note: cycles 20 and 21 both predicted the divergence would finally bind here. **It did
not** — `ioc-extraction-reliability`'s merit score is still 2, below the ceiling of 3, so both
readings give 2 and the conflict remains latent. Recorded in the rationale as "merit 2,
ceiling-applied 2, ceiling did not bind" per this item's instruction. **The stakes are now concrete
and worth a human's attention:** under subtraction that issue would read **0** — an issue with four
`candidate_resolutions` labelled "no candidate resolutions", permanently pinned at the bottom of the
weakest-link selector. Subtraction never trips the validator, so the misreading would be silent.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6, the
paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no contradiction
opened. Needs a PDF-level check, blocked by [14]. Per-phase percentages exist ONLY as pie charts
(Figure 2); Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%, Gemini 4.8%, Grok 0,
Cohere 0) are verified exact. *Cycle 22 note: src-0008 remains cited only by
`ioc-extraction-reliability`'s scaffolding candidate, still at `proposed`; not touched.*

**[6]** Unfinished search directions, open since cycle 9: citation-graph sweep of arXiv 2506.11325;
**third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines**; the
paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no preprint — do not retry).
**Forward-citation sweeps have FAILED on two different arXiv ids — unavailable infrastructure, not
an unsearched direction.** Cycle 17's topical leads stand and are **unclaimed**: **SEvenLLM**
(`arxiv.org/pdf/2405.03446`, 28 CTI tasks split 13 understanding / 15 generation), **AthenaBench**
(no URL captured), **CTIArena** (no URL captured). Leads, NOT sources; none is in `index.json` and
none may be cited. Unavailable list: OpenReview (src-0007's forum `openreview.net/forum?id=tiFtZHwr7O`
and `api2.openreview.net` both serve a browser challenge), spiegel.de (see [13]). *Cycle 22 note: the
**third-party baseline evaluations** limb is now much more valuable than when it was written — [32]
shows src-0003's own baseline numbers are figure-image-only, so an independent evaluation of IoC
Searcher/OTX/VirusTotal is the only route to text-verifiable comparison values.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AGAIN AT CYCLE 22.** `ctr-0001` resolution path. **Done:**
the released-code route is exhausted — recall is NOT recoverable (model outputs unpublished) but the
release proves the omission was a reporting choice. The **METRIC confound is ELIMINATED**. **Still
open:** no head-to-head; the **CORPUS confound is completely untouched and is now the largest gap**.
*Cycle 22 update: the SYSTEM confound gained its **first paper-stated anchor** — src-0003's 97.6% is
a classification score over a regex-extracted candidate set (see [33]) — replacing the "Vanilla
LLMs" caption inference that cycle 21 weakened. And the matching-rule limb of the commensurability
question is **closed as unanswerable from this base**: src-0003 never states its rule (see [33]).
**Remaining next steps, cheapest first:** src-0007's TTP and rubric scorers in the src-0017 artefact
(see [34]); the HuggingFace mirror `huggingface.co/datasets/xse/CyberThreat-Eval`, still unfetched;
then the corpus-difficulty comparison, which may need a new source.*

**[8] — UPDATED cycle 22. G2 COVERAGE REMAINS COMPLETE.** src-0004 (c4, c12), **src-0003 (c5; c22 —
SUBSTANCE PASSED, PROVENANCE PARTIAL FAIL, see [32])**, src-0002 (c6), src-0001 (c7), src-0006 (c8;
c17 PARTIAL FAIL see [21]; re-pulled c18), src-0005 (c9 substance-only, c11 verbatim), src-0008
(c10), src-0012 (c13), src-0011 (c14), src-0007 (c15; c21 Table 4 whole), src-0009/src-0010 (c16),
src-0013 (c18), src-0014 (c19), src-0015 (c20), src-0016 (c21 — PROVENANCE PARTIAL FAIL, see [31]).
**Never verified: src-0017 (added c21).** *Next G2 should prefer, by staleness: **src-0002 (c6)**,
then **src-0001 (c7)**, then **src-0005 (c9, and see [10] — no number has ever been captured from
it)**. **src-0017 has never been verified at all** and is a GitHub repo rather than a paper, so it is
a different kind of check (file paths and code lines rather than table cells) — worth one cycle.
Not recommended next: src-0003 (c22), src-0016/src-0007 (c21), src-0015 (c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–22.** `python3` is present at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks every
invocation; compound/piped commands are rejected if any segment is unapproved. **No PDF text
extraction exists** — poppler-utils, `mutool`, `gs`, `qpdf` absent; `WebFetch` returns PDF bytes
undecoded; prefer `/html` always. `gh` is **not** approved, so GitHub goes through `WebFetch`
(`raw.githubusercontent.com/<owner>/<repo>/main/<path>` for files, `/tree/main/<path>` for
listings). `awk` refused. **`sed -n` and `cat >>` heredoc ARE approved.** See [24]. *Cycle 22
additions: a compound `jq … && cat >> … <<'EOF'` was **rejected** (`Parser skipped input between
top-level statements`) — heredoc append must be its own call. `jq -e . <file> > /dev/null` **is**
approved, so an output redirect to `/dev/null` is fine even though `/dev/null` as a jq path argument
was refused at c19.*

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Every claim it contributes is
abstract-level and directional, and it is one of the sources holding `ttp-attack-mapping-reliability`
at 3. **Oldest un-actioned collection task in the project (open since cycle 1); T1 work.** A T1
targeting that issue should hunt the **human-analyst baseline F1** first (the actual level-4
blocker) and src-0005's numbers second. *Cycle 22 note: unchanged; per [28] the next T1 is ~13
cycles away (cycle 35).*

**[11] — APPLIED AND EXTENDED cycle 20, LIVE AGAIN AT CYCLE 23.** Tie-break 3a in
`prompts/t5_select.md` is under-specified, with no deterministic tie-break after 3c. Cycle 20 ruled
for the **strict pairwise** reading. Suggested fix: add "**3d. longest time since the issue last
received new evidence; then fewest total attempts**" — **but 3d as proposed is not sufficient**:
`ttp-attack-mapping-reliability` and `attribution-confident-wrong-gap` tie on score, 3a, 3b, 3c
**and both limbs of 3d**. A terminal deterministic tie-break (e.g. lexicographic issue id) is needed
for closure. Same class as [4]. *Cycle 22 note: 3a is **silent** among cycle 23's three candidates
under the strict pairwise reading, so 3b and 3c carry the whole decision — see "Next task
rationale". The strict-pairwise ruling should be re-examined by a human: `consistency-calibration-
as-failure-mode` is depended on by two issues and `automated-triage-under-refusal` by none, which a
non-pairwise reading of "upstream first" would treat as decisive.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger claim
was WRONG; see [17].** T2 is the only task type with standing to split an issue, add an issue, or
reconcile the prompt/validator disagreement. The claim that the loop "never returns to T2" is false;
cycle 16 disproved it. See [28]. *Cycle 22 note: this bit again — [34] identifies a counterargument
that should be written into an issue's `open_questions`, and a T4 has no standing to do it.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is
the upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
footnote-count route is also closed (see [14]). Prof. Christian Dietrich's / Institut für
Internet-Sicherheit's own writeup is the only remaining route known to this agent. OpenReview joins
this category — see [6].

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened. **Consequence: "ENISA never disclosed the AI use" is established at
landing-page level and UNVERIFIABLE at document level here.** That leg **cannot strengthen**. **Do
not re-spend budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET.** The curl/HackerOne case
(bug bounty ended 31 January 2026 after a flood of AI-generated "slop" reports; ~20% of submissions
AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to under 5%) is an
**open_question on `automated-triage-under-refusal`**. **It is a question, not evidence — no curl
source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycle 19 judged it **the highest-value uncollected source in the project** and cycle 22 agrees. *A
T3 may add sources ([29]), so a T3 targeting that issue is the route — but per cycle 22's tie-break
working, that issue may lose the cycle-23 selection on 3c, in which case this waits again.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question any cycle has found. Verbatim from `https://gptzero.me/investigations/ey`: an
"automated pipeline to search for vibe citations by finding and scanning public reports from major
consulting firms", releasing findings "one report at a time", having already investigated "a
government publication, two different Deloitte reports, and prestigious machine learning /
artificial intelligence conferences like NeurIPS and ICLR". A T1 should chase
`gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor reporting on its own
product's value; no *rate* published; the scorecard widget renders as "0 of N" to automated fetch —
read body text, not the widget. **Still the only route any cycle has found to a base rate**, the
binding constraint on `institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: `prompts/system.md` specifies `T1→T2`, and the refresh rule makes a T5 landing on a
multiple-of-7 cycle emit a T1, so the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles
14→15→16. Structural finding for the paper: the only task type that can restructure the issue graph
fires when a T5 coincides with a multiple of 7 — under a clean three-cycle loop, **once every 21
cycles**, not every 7.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS
exhibiting the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid
citations across 308 papers. No claim in our base repeats the error and **no G3 entry was opened**.
Any cycle quoting src-0011's *counts* should take them from Table 3's columns. *Cycle 22 note:
restated in `institutional-incident-real-world-impact`'s rationale so it travels with the score.*

**[19] — FULLY DISCHARGED CYCLE 21; CONSUMED BY CYCLE 22.** src-0007's Table 4 pulled **whole and
verbatim** into `state/knowledge/src-0007.md`. Triage rows captured: precision (Accepted)
**0.2717–0.3982**, recall (Accepted) **0.9091–1.0000** across both triage tasks and all four models,
so `automated-triage-under-refusal`'s stored "0.27–0.40 vs 0.90–1.00" **holds as stated**. Also:
**fine-tuning does not fix the asymmetry and on the Article task worsens precision** (GPT-4o 0.3037
→ GPT-4o (FT) 0.2717, recall unchanged 0.9798–1.0000). Deep Search URLs-Extraction block captured
(GPT-4o 6.22 avg URLs vs GPT-4o-mini (FT) 1.25; URLs with additional info 3.54 → 0.22). *Cycle 22
note: this **discharged one of cycle 19's two reasons** for scoring that issue 2 — it is now a
table-verified 2 rather than a summary-derived one. The other reason (src-0015 too weak to count as
a second independent source) is untouched, so the score held.* **RESIDUE, UNRESOLVED AND
REPRODUCED:** GPT-4o (FT) tracks o3-mini to within 0.001 on **all six** Content: Threat Actor rubric
rows, identically in two independent pulls (c15, c21) — as-printed, not a fetch artefact. **Cause
unknown; do not guess. Any claim resting on that column must say it is suspect.**

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014 (c19),
src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy is **narrowed but not closed** — 33.9% is
TABLE II's per-model aggregate, 16.9% → 83.2% is the SALLM-to-repository comparison; different
scopes, not arithmetically reconcilable, so **quote them only with their scopes named**. Gemini's
0.161 → 0.721 was **not** re-checked. **Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are
still body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18.** `src-0006.md` and
`index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 for a specialized agent vs.
0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is
**G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90"
against a true span of **0.286–0.882**. Cycle 18 **APPENDED** a corrective key_claim to src-0006's
`index.json` entry. `src-0006.md` itself is still untouched and still contains the wrong sentence.
**Column split: 8 general (G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC, CB0, ZYS, LLY,
CBS, SPT, DHT).** *Cycle 22 note: cycle 22 used the same append-only repair pattern on src-0003 ([32])
and also appended to the `.md` file, which cycle 18 did not — **the `.md` file is where a later cycle
reads the source, so repairing only `index.json` leaves the wrong sentence in the more-read place.
src-0006.md still needs that treatment.***

**[22] — REPRODUCED A THIRD TIME cycle 18.** An unexplained regularity in src-0006's Table 2: eleven
of twenty-eight rows are **strictly monotone decreasing across all eight general-purpose columns in
exactly the printed column order**. Four are in the nine-row F1 subset
`extraction-vs-reasoning-ordinal-axis` depends on. For independent measurements, one row matching a
fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.** Cause unknown;
do not speculate. **Any finding resting on src-0006's Table 2 must carry a robustness check
excluding these rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.**
`task-dependent-reliability-framing`'s supported candidate cites src-0006's "F1/AUC roughly
0.20–0.90" as evidence that reliability varies sharply by sub-task. Mean between-**model** range
within a task (0.272) and mean between-**task** range within a model (0.263) are equal to within
0.009. **This does NOT negate the supported claim** — cycles 19 and 22 both tested it as a
counterargument and both concluded it is not one; it qualifies the implication that sub-task is the
*privileged* explanatory variable, which is the child issue's business. A T2 should annotate the
parent's candidate rather than re-scope it. No contradiction entry: both facts hold simultaneously.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–22. `jq` IS INSTALLED AND APPROVED.**
`jq -e . <file>` parses and exits non-zero on malformed JSON; `jq -r '<filter>'` reads structure
without a full-file Read. **Every cycle from 9 to 17 recorded that this agent cannot validate JSON
and must check "by construction". That advice is wrong and it is expensive** — cycle 17 made five
blind edits to a 57 KB JSON file and had its entire `state/` output reverted. **Every JSON edit
should be followed by a `jq -e` check.** The permission layer is **not uniform**: `grep -n` refused
at c18; `jq` on `/dev/null` as a path refused at c19; compound calls with `awk` refused at c20 and
c21; `gh` refused at c21; a compound `jq && heredoc` refused at c22. **Probe once; don't infer from
class.** The `Grep` **tool** works on the big JSON files where Bash `grep -n` does not — use the
tool, and use it to find an insertion point rather than reading a 36–83 KB file whole.

**[25] — DISCHARGED CYCLE 21.** `state/knowledge/src-0007.md` now contains the Content: Threat Actor
rubric block in full, verbatim, all six rows and four columns, alongside the whole of Table 4. **The
two caveats travel with it and must keep travelling:** the rubric's **absolute level is
uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a normalisation the paper
never states), so **only within-table contrasts may be cited**; and the GPT-4o (FT) column is suspect
per [19]. *Cycle 22 note: this discharged one of cycle 19's two reservations about
`attribution-confident-wrong-gap`'s candidate 2 (never independently re-pulled). The score still
held, because the other reservation was **confirmed** by the re-pull rather than dispelled, and
because src-0007 was already in that issue's evidence list — **re-verifying a leg already counted
improves confidence, it does not add a leg.***

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's errors to stdout,
but `logs/cycle-017-transcript.txt` captures the agent's own output only, and the reverted `state/`
files were never committed. Most likely malformed JSON — a class [24] now makes cheaply avoidable —
but **no cycle can confirm it**. Suggested harness fix for a human: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before reverting, and
`git stash` the rejected `state/` diff rather than discarding it.

**[27] — NEW cycle 20, STILL UNENTERED, AND NOW WRITTEN INTO A SCORE RATIONALE.** src-0015's Table 1
has a **`Reward`** column no cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61,
DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated earns the lowest reward**, and the
two highest-containment models take the two highest rewards. Bears directly on
`automated-triage-under-refusal`'s `open_questions[0]` — models versus harness. **Caveats:** the
fetched material does not state the reward's composition; n = 40 per model, no CIs; the association
is not strictly monotone (DeepSeek outscores GPT-5.2 at lower containment). Still **not entered into
the issue graph** — it is an observation about an already-collected source, so **no new citation is
needed** when a cycle working that issue uses it. Also uncaptured: the `Threshold` column. *Cycle 22
note: cycle 22 recorded it in that issue's `rationale` so it cannot be lost, but a rationale is not
the graph — a T3 should still enter it properly.*

**[28] — NEW cycle 20, RE-DERIVED cycles 21 and 22.** The state machine is T1→T2, T2→T3, T3→T4,
T4→T5, T5→T3. Cycle 22 was a **T4**, so **cycle 23 is T5 and cycle 24 is T3**.
`collect_refresh_every: 7` and the refresh fires only when a T5 **runs on** a multiple-of-7 cycle
(pinned from git history: cycle 14 T5 → cycle 15 T1 collect). 23 % 7 = 2, so **cycle 23's T5 does
NOT refresh**; under a clean loop T5 lands on 20, 23, 26, 29, 32, **35**, and **the next T1 is cycle
35**. A failed-validation retry shifts the phase by one — that is how the phase reached its current
position (cycle 17's T3 failed, retried at 18) — so **re-derive rather than trusting this if a cycle
fails**. **Consequence for a human:** the two highest-value uncollected items ([15] curl/HackerOne,
[10] the human-analyst ATT&CK baseline) both want a T1 and neither gets one for ~13 cycles. If that
is not intended, either `collect_refresh_every` or the refresh rule's phrasing needs attention.

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycle 21.** A T3 **MAY** add sources.
`prompts/t3_investigate.md` step 2: "Only web-search for what the knowledge base cannot answer (and
if you fetch something substantial, add it properly as a source per T1 rules — it counts toward the
same `max_new_sources` budget)." Cycle 21 exercised this and added src-0017, without which the whole
recall finding would have been uncitable. **Standing lesson: read the task's own prompt file, not
only the queue entry's description of it.**

**[30] — NEW cycle 20; ITS PREDICTION FOR CYCLE 23 IS NOW WRONG, AND THE REASON MATTERS.** Cycle 21
wrote: "if the cycle-22 T4 raises `ioc-extraction-reliability` above 2, [`automated-triage-under-
refusal`] wins outright — 3c never gets reached." *Cycle 22: the T4 held that issue at 2, so the
premise fails — **but the conclusion changes anyway, and not in that issue's favour.***
`ioc-extraction-reliability` was **attempted at cycle 21**, so it now carries a 3b penalty it did not
carry at cycle 20 and drops out at effective 3. That leaves
`consistency-calibration-as-failure-mode` (created 2) against `automated-triage-under-refusal`
(created 16) tied at effective 2, and **3c favours the former.** So the only issue in the graph
**never worked on** (attempts `[]`, created cycle 16) is likely to lose a **second** consecutive
selection. The structural asymmetry stands and is not encoded in policy: **"never attempted" is not
a tie-break in `prompts/t5_select.md`**, and cycle 19's `scores.json` rationale wrongly asserted it
was. If a human thinks never-worked issues should be favoured, that is a prompt change. **The cycle-23
T5 must derive its own table and not copy cycle 22's.**

**[31] — NEW cycle 21, EXTENDED cycle 22: THE EXACT-STRING CHECK HAS NOW BEEN RUN ON TWO SOURCES AND
BOTH FAILED IT IN SOME RESPECT.** (a) src-0016: the string `"80 of 161 unique-unmatched findings
appeared in only one of five identical repetitions, while only 22 appeared in all five"` is presented
in `src-0016.md` and `index.json` as one quotation and **does not exist on the page** — it splices a
real sentence to a table cell. All figures are correct, so it is a quotation defect, not a factual
one; repaired by appendix at cycle 21. (b) src-0016's collection note "no table was present to pull"
is false; there are **four**. **Standing lesson: quote-splicing is invisible to any check that does
not re-fetch the page and string-search the exact stored string. G2's methodological rule catches
it; a substance-only re-read never would.** *Cycle 22: ran the same check on src-0003. Its three
stored **quotations** all PASSED — the first source to pass. But its stored **numbers** did not; see
[32]. So the defect class is broader than quote-splicing: it covers **any stored value presented as
reported that was never in the text.** Two of two sources checked have a defect of this family, and
**neither had ever been checked this way before**. Fifteen sources have stored "verbatim" quotes or
reported numbers that have never faced an exact-string check. This is now the highest-yield G2
technique available and should be applied to every future G2 target by default.*

**[32] — NEW cycle 22. src-0003's THREE BASELINE F1 VALUES ARE FIGURE-IMAGE-ONLY AND NOT
TEXT-VERIFIABLE; REPAIRED BY APPEND.** `src-0003.md` key claim 1 and `index.json` key_claims[1] state
LANCE's 97.6% beats "IoC Searcher + whitelist (76% F1), AlienVault OTX (72% F1), VirusTotal
threshold=1 (86% F1)". On `https://arxiv.org/html/2506.11325v2` the exact strings **`76` and `72` do
not occur at all**, and the only `86%` is `"Its lowest score, 86.8% recall on domains …"` — **LANCE's
own per-type recall, not VirusTotal's F1**. A full caption inventory (Figures 1–10, TABLE I–IV)
confirms **no table carries baseline numbers**; they live only in **Figure 6**, an image this agent
cannot read. Cycle 1 collected the source by "automated HTML summarization", which cannot read a
figure. **The ordering is textually supported** (VT thresholds 1 and 5 are "the two highest
performing ground truth generation methods … as indicated in Figure 6"; whitelist "suffers from poor
precision"; AlienVault "yields the most unlabeled indicators (37%)"), so 86 > 76 > 72 is consistent
with the prose and **nothing is falsified** — but **cite 76/72/86 as figure-derived and not
text-verified, never as reported values.** Also unverifiable: **`~0.88 F1 with Llama`** (src-0003.md
key claim 3) — `0.88` does not occur; the page says `"Gemma and Gemini perform comparably to GPT,
achieving total F1 scores of 0.98 and 0.92, respectively"`, so **0.92 is Gemini** (stored claim
right) and **0.98 is Gemma** (never recorded before), with Llama only in Figure 9. **Repaired by
appending** three corrective `key_claims` to src-0003's `index.json` entry and an appendix to
`state/knowledge/src-0003.md`; nothing removed or rewritten. **No contradiction entry opened** —
G3's trigger is two supported claims in conflict, there is no rival claim, and I cannot read Figure 6
to assert the values are wrong; filing one would dilute the G3 signal. A successor may reverse that
judgement.

**[33] — NEW cycle 22, AND IT IS THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER
HAD.** src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted
candidate set**, not on free-form extraction. Verbatim: `"We assume a total of 1,789 candidate
indicators, extracted using IoC Searcher, a state-of-the-art rule-based tool"`; `"IoC Searcher
demonstrates high recall across various IoC types, making it well-suited for the initial extraction
phase"`; `"LANCE labeled over 99% of all extracted indicators"`; Figure 9's caption `"… on IoC
Classification."` The LLM **labels** indicators a regex already found; src-0007's 0.8240–0.8846 is
precision on IoCs a model **generates** from an article. **That is a difference in task format, not
only in scaffolding**, and unlike the "Vanilla LLMs" caption reading (downgraded to an inference at
cycle 21) it is *stated by the paper*. **Companion finding: src-0003 NEVER STATES ITS MATCHING RULE.**
A verbatim search of its evaluation/methodology sections for `exact match`, `matched`, `matching`,
`normaliz`, `defang`, `case-insensitive`, `ground truth`, `true positive`, `false positive` found no
sentence comparing a predicted indicator with a ground-truth one; the nearest is about *label*
agreement (`"We define a disputed indicator as an indicator for which there was no total agreement
between the labels of the analysts and the LANCE-generated label."`). So the open_question cycle 21
added is **unanswerable from this base** — and under the classification reading a string-matching
rule may not even be well-defined for the headline number. **Both findings are appended to
`index.json` and `src-0003.md`. A T3 on `ioc-extraction-reliability` should carry them into
`ctr-0001` and the issue's candidates; a T4 has no standing to.**

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE.** **A within-study design holds team, corpus, models and harness constant but does NOT
hold the scoring rule constant.** A cross-sub-task score spread is a task-difficulty fact only if the
sub-tasks are scored comparably. src-0017 shows src-0007's IoC evaluator matches by two-directional
substring containment with a ground truth never stated to be exhaustive; **the scoring rules for
src-0007's ATT&CK task and rubric tasks have never been pulled**, and neither have the per-task
scoring definitions behind src-0006's nine F1 rows. Cycle 19's level-4 argument rested on within-study
designs being counterargument-proof "by construction"; this objection is **not stated anywhere in the
issue, in either candidate, or in any open_question**, and level 4 requires counterarguments
*addressed*. **What restores the 4:** read `stage3_ti_drafting`'s TTP and rubric scorers in the
src-0017 repo (the IoC evaluator is already read — `raw.githubusercontent.com` worked at cycle 21) and
src-0006's metric definitions, then state and answer the objection in the issue. If the rules are
comparable, cycle 19's argument stands as written and the 4 is correct. **Note the asymmetry:** the
same finding is neutral-to-favourable for `extraction-vs-reasoning-ordinal-axis`, whose supported
claim is *negative* — less commensurability means even less evidence for the proposed ordering — so
it was **not** applied mechanically across the graph. It also mildly weakens
`ttp-attack-mapping-reliability`'s within-table control without touching that issue's absolute
finding.
