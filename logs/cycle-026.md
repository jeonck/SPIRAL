# Cycle 26 — T4 (Assess)

Queue entry: `state/queue/next_task.json`, written by cycle 25, `task_type: T4`,
`target_issue: null`, `attempt_count: 0`. `prompts/t4_assess.md` was read directly rather
than relied on second-hand, as the entry instructed; so were
`scripts/validate_state.py` lines 95–158 and `config.yml`.

## Task performed

Scored **all eight** issues in `state/issues/graph.json` into
`state/assessments/scores.json`, set `assessed_cycle: 26` on every entry and
`last_assessed_cycle: 26` at the top level.

**Scores: 3 / 2 / 2 / 2 / 3 / 3 / 3 / 2.** One score moved.

| issue | c22 | c26 | |
|---|---|---|---|
| `ttp-attack-mapping-reliability` | 3 | **3** | held, composition corrected |
| `ioc-extraction-reliability` | 2 | **2** | held (`ctr-0001` open) |
| `consistency-calibration-as-failure-mode` | 2 | **2** | held (`ctr-0003` open) |
| `attribution-confident-wrong-gap` | 3 | **2** | **LOWERED** (`ctr-0002` open) |
| `task-dependent-reliability-framing` | 3 | **3** | held |
| `extraction-vs-reasoning-ordinal-axis` | 3 | **3** | held |
| `institutional-incident-real-world-impact` | 3 | **3** | held |
| `automated-triage-under-refusal` | 2 | **2** | held |

### The one move: `attribution-confident-wrong-gap` 3 → 2

`ctr-0002` (opened cycle 23) established from src-0002's own Section 4.2 that its CTI-TAA
`Plausible Accuracy` column **contains** its `Correct Accuracy` column. So the
"86% plausible vs 52% correct" gap this issue's primary candidate has carried since cycle 7
is **true by construction** for every model and cannot evidence anything. The contradiction
entry itself records that "a T4 may then rescore"; this is that rescore.

Strip the by-construction gap and count what remains for this issue's *distinctive* claim —
that CTI models emit wrong attributions that read as authoritative:

- **src-0004** — one production incident (ENISA/APT29), AI-causation reported-not-primary
  via Heise ← Der Spiegel, and `spiegel.de` is unreachable from this agent ([13]). n = 1.
- **src-0007** — Table 4 rubric, GPT-4o `Content: Threat Actor` 1.140 against
  `Content: Root Cause` 3.612 in the same table. Measures attribution **quality**, not
  expressed **confidence**.

That is one quantified-but-off-target source plus one anecdote: the rubric's definition of a
2. I did **not** attempt to repair it — per [36] the rewrite is a T3's job and a T4 has no
standing. `ctr-0002`'s reading (a) is live and may well be right (the paper's own
hallucination-inclusive incorrect rate = `100 − Plausible Accuracy` = 14 / 38 / 26 / 20 /
64%), but those five values are **derived by subtraction and not printed**, and no
`candidate_resolution` in the graph asserts them. **I score the state as it stands, not as it
could be repaired.** If a T3 executes [36](i)–(ii), this returns to 3 immediately and I
expect it to. The demotion is a **pointer to needed work**, which is what the weakest-link
selector is for.

### The call the handoff flagged: `consistency-calibration-as-failure-mode` stays 2

Named explicitly, as required. The evidence is **asymmetric across the issue's own two
conjuncts**:

- **consistency-on-CTI is two-source** — candidate 5 (`[src-0001, src-0018]`), independence
  clean (no shared author, academia vs industry lab, disjoint model sets a generation apart,
  no citation), and src-0018 is CTI proper so the cycle-16 scope ruling is cleared on its own
  terms rather than overturned.
- **calibration-on-CTI is still one-source** — src-0001, gpt4o only, nine table rows — and it
  is the leg `ctr-0003` sits on.

Level 3 asks whether the **primary** candidate has two independent sources. The candidate
answering **both** halves of the title question is candidate 2, `[src-0001]`, single-source
and the carrier of the very gloss `ctr-0003` disputes. The two-source candidate answers only
the consistency conjunct **and says so in terms**. Declaring the half-answer primary to reach
a 3 would be scoring the issue for a question it does not ask. Two further discounts: src-0018
supplies **direction only** (all four quantitative artefacts are unreadable images), and its
FDR/FNR abstention metrics are a *restraint* construct that must never be pooled with
ECE/Brier. Under step 5 ("when torn, give the lower one") → **2**.

This is not a verdict that cycle 25 achieved nothing. It broke a blocker standing since
cycle 3, and the rationale records that in full. **[37] is endorsed and strengthened**: two
legs of visibly different strength under one title is exactly the cycle-16 split situation.
Split, the consistency child plausibly scores 3 and the calibration child 2. Unsplit, the
title binds them and the weaker leg governs.

### G3 gate

Applied the **CEILING**, per cycle 16's ruling, and verified at source rather than inherited:
`scripts/validate_state.py` lines 144–156 error only when an issue with an open contradiction
scores **greater than** `scale_max − g3_contradiction_demotion` = 3.
`prompts/t4_assess.md` step 3 and `config.yml` line 35 both specify **subtraction**. The
conflict is unresolved and is item [4], now in its **seventeenth** cycle.

Three issues carry open contradictions — `ctr-0001` / `ioc-extraction-reliability`,
`ctr-0002` / `attribution-confident-wrong-gap`, `ctr-0003` /
`consistency-calibration-as-failure-mode` — and all three land at **2**, under the ceiling.
**So the ceiling did not bind on any issue, and the two readings have still never been forced
apart.** Under subtraction all three would read **0** — three of eight issues fabricated to
the bottom of the selector, silently, because subtraction never trips the validator.

One thing changed here and a successor must not miss it: **the 3 → 2 on
`attribution-confident-wrong-gap` is a merit judgement about the evidence, not a gate
artefact.** The ceiling would have permitted a 3. Nobody may restore a 3 by arguing the gate
was misapplied.

## Retrospection

**Target: src-0005 (CyberSOCEval, `arxiv.org/abs/2509.20166`).** Chosen per [8] — last
verified cycle **9**, the stalest source in the base by a wide margin — and per [10], which
had recorded since cycle 1 that **no number has ever been captured from it** in 25 cycles,
while it helped hold `ttp-attack-mapping-reliability` at 3.

Three fetches, all under the four-part method of [31]/[38]: `/abs` (abstract + metadata),
`/html/…v1` (whole-paper transcription, exact-string list, metric definitions, sample counts),
`/html/…v2` (confirming pass, ATT&CK search, limitations, full figure list).

### Verdict: **PASS.** All three stored key claims and all four stored quotations verified.

All four exact strings **PRESENT verbatim** in the abstract:
"core defensive domains with inadequate coverage in current benchmarks" · "larger, more
modern LLMs tend to perform better, confirming the training scaling laws paradigm" ·
"reasoning models leveraging test time scaling do not achieve the same boost as in coding and
math" · "Current LLMs are far from saturating our evaluations".

**A [38] trap avoided, and it is a new instance of that rule.** The stored quotations come
from the **abstract**; the body *paraphrases* two of them differently ("do not achieve the
boost they do in areas like coding and math"; "core defensive domains that have inadequate
coverage in current **security** benchmarks"). The v1 fetch, which read the body, returned
one of them **ABSENT**. Checking against the abstract returned it verbatim. Had I run one
body-only fetch and stopped, I would have opened a contradiction against a claim that is
exactly right. **[38] has now saved a false defect on the first cycle after it was written.**

### [10] is DISCHARGED, and the answer is that it was never achievable by this route

**The paper publishes no results table.** Every per-model number lives inside images:
Figures 8, 9, 12, 13, 14, 15, 16. Confirmed by **two independent fetches** (v1 and v2), both
instructed to write CANNOT READ rather than infer, both of which did — the [38] double-check
run deliberately, because this is a negative verdict. The only tables are Table 1 (malware
category descriptions) and appendix code listings. No sentence anywhere pairs a model name
with a score, and no numeric Jaccard value appears in text. Fifteen-plus cycles of asking for
these numbers were asking for something that is not in the text at all. **Do not re-attempt
without a new route** (published raw results, the CyberSecEval 4 repo, or OCR).

### First numbers ever captured from this source, in 26 cycles

Aggregate ranges *are* in the text and every prior pass missed them:

- **Malware Analysis**, §4.1 verbatim: "The overall accuracy scores range from approximately
  **23-34%**, which should be compared to a baseline of approximately **0.63%** accuracy that
  would be expected from purely random guessing (see Appendix B)."
- **Threat Intelligence Reasoning**, §4.2 verbatim: "Overall scores range from approximately
  **43%-53%**, which should be compared to a baseline of approximately **1.7%** accuracy that
  would be expected from purely random guessing (see Appendix C)."

Ranges across the model set, not per-model values; the paper names neither best nor worst
model in text. A third confirming fetch was spent solely on attributing each range to its
section, because the first pass returned both without saying which was which.

### Four findings that were never in the base, all material

1. **Both benchmarks are multi-select multiple choice.** Metric verbatim: "the share of
   questions for which the system selects all correct options and only the correct options."
   609 MA test cases; 588 TIR pairs from 45 reports, supplied "via a set of images (one per
   report page)".
2. **Questions are LLM-generated, then human-validated** — Llama 3.2 90B (MA); "Llama 4
   Maverick and Llama 3.2 90B with two strategies" (TIR).
3. **The paper's own limitations, verbatim, none of them recorded here before:** multiple
   choice "does not provide a perfect proxy for capabilities"; "performance bias … where the
   model under test is the same, or has similarities with the set of models that were used in
   synthetic data generation pipelines" — a live contamination risk, since the generators are
   Llama models; and a production-representativeness caveat.
4. **No ATT&CK metric exists in this source.** Targeted verbatim search for "ATT&CK",
   "MITRE", "TTP", "technique", "tactic" returned only "understanding complex attack chains,
   and mapping tactics to frameworks like MITRE ATT&CK" and an appendix listing retaining
   `tactic, technique` from a `mitre_attcks` field.

**Provenance ([39]):** v1 24 Sep 2025, v2 10 Nov 2025, **no venue, no DOI but the arXiv one,
no affiliations printed**. An unreviewed preprint as far as this base can establish — the
*opposite* direction from cycle 25's src-0001 finding. The CrowdStrike/Meta attribution
carried since cycle 1 rests on identifying two senior authors, not on the paper.

### No contradiction opened, and why

G3's trigger (`prompts/system.md` rule 3) is **two supported claims in conflict**. Nothing
stored about src-0005 is falsified. What was found is *missing context*, not conflict — the
state never recorded the multiple-choice format or the synthetic generation, but never
asserted otherwise, and `ttp-attack-mapping-reliability`'s `open_question[0]` had already
flagged the ATT&CK gap as suspected. Following cycle 12 (ENISA's silence), cycle 21
(src-0016) and cycle 22 (src-0003's Figure 6): recorded as a documented verification finding
so the G3 signal is not diluted. **[31] therefore stands at four-of-four failures out of four
sources checked; this is the fifth source checked and the first clean pass** — but it passed
on *content* while being materially *incomplete*, which is a fifth defect class worth naming.

### Consequence carried into the scoring

Cycle 22's rationale said `ttp-attack-mapping-reliability`'s primary claim "rests on three
unaffiliated teams (src-0002, src-0005, src-0007)". **That count is withdrawn.** src-0005 is
a directional corroborator, not a third measuring leg. The score survives at 3 because it
never depended on that leg — candidate 2 (`[src-0007, src-0002]`, both directly measuring
ATT&CK technique identification) carries the level-3 bar alone.

## Changes made

- **`state/assessments/scores.json`** — rewritten. All eight issues scored,
  `assessed_cycle: 26` on every entry, `last_assessed_cycle: 26`. One score moved (3 → 2 on
  `attribution-confident-wrong-gap`). `jq -e` validated. Every evidence id checked present in
  `index.json` (validator lines 140–142); src-0018 added to
  `consistency-calibration-as-failure-mode`'s evidence.
- **`state/knowledge/index.json`** — **six key_claims appended** to src-0005 (3 → 9), all
  marked `[APPENDED CYCLE 26 G2 …]`: the two verbatim range sentences; the figures-only
  finding with the full figure list and the two-fetch confirmation; task format, metric,
  sizes and synthetic generation; the paper's own three limitations verbatim; the ATT&CK
  finding; and provenance. **Nothing removed or rewritten** (validator lines 105–107).
  `jq -e` validated.
- **`state/knowledge/src-0005.md`** — full G2 appendix appended via heredoc, mirroring the
  above. **Both places repaired, per the [21]/cycle-22/23/25 pattern** — repairing only
  `index.json` is how src-0016's defect survived six cycles.
- **`state/issues/graph.json`** — **untouched.** No contradiction warranted (see above), and
  a T4 has no standing to rewrite candidates.
- `logs/cycle-026.md`, `state/queue/next_task.json`, `state/queue/last_completed_task.txt`.

## Next task rationale

**Cycle 27 is a T5 (select)**, per `T4 → T5`. This matches [28]'s re-derivation (25 = T3,
26 = T4, 27 = T5, 28 = T3). `collect_refresh_every: 7` fires only when a T5 *runs on* a
multiple-of-7 cycle; 27 is not, and of 28 / 35 / 42 only **42** is a T5 cycle, so **the next
T1 is cycle 43**. Re-derive rather than trust this if a cycle fails.

**The weakest tier changed shape this cycle and the T5 must derive its own tie-break.** There
is now a **four-way tie at 2**: `ioc-extraction-reliability` (attempts `[9, 21]`),
`consistency-calibration-as-failure-mode` (`[3, 15, 16, 25]`),
`attribution-confident-wrong-gap` (`[16]`, newly demoted) and `automated-triage-under-refusal`
(`[]`). `tie_break_recent_attempt_penalty: 1` per attempt within the last 5 cycles bites
`consistency-calibration-as-failure-mode` hard (attempt at 25) and nothing else. [11] (no
terminal deterministic tie-break) and [30] ("never attempted" is not a tie-break) both apply
and are both prompt changes for a human, not readings an agent may adopt.

Two of the four have a **named, specific, one-cycle repair waiting**:
`attribution-confident-wrong-gap` needs [36] (`ctr-0002`'s resolution path), and
`consistency-calibration-as-failure-mode` needs `ctr-0003`'s. Both are T3 work and both would
plausibly restore a 3. `automated-triage-under-refusal` has the highest-value *uncollected*
lead in the project ([15], curl/HackerOne) and a T3 may add sources ([29]).

## Budget

Rough: **3 web fetches** (all `arxiv.org`, one `/abs` + two `/html` versions of 2509.20166;
zero web searches — the target was already in the base), **~14 tool calls total**, one file
rewrite, one `Edit` append, one heredoc append, **3 `jq -e` validations**. Well inside
`max_turns: 50`. No fetch failed; no URL was unreachable. The third fetch was spent
disambiguating which range belonged to which benchmark rather than accepting a two-number
answer that did not say — cheap, and it is the difference between a citable number and a
guess.

---

## Carry-forward items

All items from `logs/cycle-025.md` reproduced **including those I could not act on**, with
cycle-26 updates. Discharged items stay marked rather than deleted. **Two new items: [40],
[41].** **[10] is discharged this cycle** and its answer is a negative one worth keeping.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim
stayed; ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2
candidate moved verbatim. Still vindicated: the two halves score 3 and 3 and moved for
different reasons at cycle 22. *Cycle 26: cited again as the precedent behind [37].*

**[2] — DISCHARGED cycle 16, AND ITS RESULT IS NOW PARTLY WITHDRAWN.** Attach src-0007 to
`ttp-attack-mapping-reliability`. The graph records a three-team claim. *Cycle 26: **the
three-team count is withdrawn.** My G2 established at source that **src-0005 reports no
ATT&CK metric at all** — only the descriptive phrase "mapping tactics to frameworks like
MITRE ATT&CK" and an appendix `mitre_attcks` key listing. The issue is a **two-team** claim
(src-0002 CTI-ATE F1 0.6388; src-0007 precision/recall), which still clears level 3, so the
score held. The blocker remains `open_question[1]`, the missing human-analyst baseline, now
in its **fifteenth** cycle.*

**[3] — DISCHARGED cycle 16.** New issue `automated-triage-under-refusal`. First-scored cycle
19 (2), held at 2 cycles 22 and 26. It has now **lost two consecutive selections** and still
has `attempts: []` — see [30].

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, AND STILL UNTESTED AFTER 17 CYCLES.** The
G3 gate is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml`
line 35 comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3
under current config). The enforced reading is in the minority. Cycle 16 ruled for the
**CEILING**; replacement text in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`,
`config.yml`, `scripts/` are outside this agent's output surface. **Until a human applies it,
T4s must apply the ceiling.** *Cycle 26 note, verified at source not inherited: all three
contradiction-carrying issues now sit at **2** — `ioc-extraction-reliability`,
`attribution-confident-wrong-gap` (demoted this cycle) and
`consistency-calibration-as-failure-mode`. **All are under the ceiling of 3, so the ceiling
did not bind and the two readings have STILL never been forced apart in 17 cycles.** Under
subtraction all three would read **0** — three of eight issues at a fabricated bottom,
silently. The divergence is now more likely than ever to stay latent, because demoting an
issue on merit moves it **away** from the ceiling. A human should not wait for it to trip.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6,
the paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no
contradiction opened. Needs a PDF-level check, blocked by [14]. Per-phase percentages exist
ONLY as pie charts (Figure 2); Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%,
Gemini 4.8%, Grok 0, Cohere 0) are verified exact. Not touched at cycles 25 or 26.

**[6] — UPDATED cycle 25; ONE LEAD KILLED, ONE DOWNGRADED.** Unfinished search directions,
open since cycle 9: citation-graph sweep of arXiv 2506.11325; **third-party evaluations of the
IoC Searcher / AlienVault OTX / VirusTotal baselines** (much more valuable since [32]); the
paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no preprint — do not
retry). **Forward-citation sweeps have FAILED on two different arXiv ids — unavailable
infrastructure, not an unsearched direction.** **CTIArena is resolved and dead for
consistency/calibration purposes** — `arXiv 2510.11974`, fetched at cycle 25, measures neither
repeat-query consistency nor calibration/abstention; it may still be a good T1 target for
`ttp-attack-mapping-reliability`-type issues but **never re-propose it for
`consistency-calibration-as-failure-mode`**. **SEvenLLM** (`arxiv.org/pdf/2405.03446`)
uncollected and downgraded. **AthenaBench** still has no URL. **No arXiv companion exists for
src-0018.** Unavailable: OpenReview, spiegel.de ([13]).

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT CYCLE 22.** `ctr-0001` resolution path. **Done:**
the released-code route is exhausted — recall is NOT recoverable but the release proves the
omission was a reporting choice. **METRIC confound ELIMINATED.** **Still open:** no
head-to-head; the **CORPUS confound is completely untouched and is the largest gap**. The
SYSTEM confound gained its first paper-stated anchor at cycle 22 ([33]); the matching-rule
limb is **closed as unanswerable from this base**. **Remaining steps, cheapest first:**
src-0007's TTP and rubric scorers in the src-0017 artefact ([34]);
`huggingface.co/datasets/xse/CyberThreat-Eval`, still unfetched; then corpus difficulty.

**[8] — UPDATED cycle 26. G2 COVERAGE REMAINS COMPLETE FOR EVERY SOURCE BUT TWO.** src-0004
(c4, c12), src-0003 (c5; c22 — substance passed, provenance partial fail, [32]), src-0002 (c6;
c23 — numbers passed exactly, interpretation failed, `ctr-0002`), src-0001 (c7; c25 — numbers
and protocol passed exactly, interpretation failed, `ctr-0003`, and peer-reviewed after all,
[39]), src-0006 (c8; c17 partial fail [21]; re-pulled c18), **src-0005 (c9 substance-only, c11
verbatim; c26 — FULL PASS on all claims and quotations, plus six appended key_claims, [10]
discharged and [40] opened)**, src-0008 (c10), src-0012 (c13), src-0011 (c14), src-0007 (c15;
c21 Table 4 whole), src-0009/src-0010 (c16), src-0013 (c18), src-0014 (c19), src-0015 (c20),
src-0016 (c21 — provenance partial fail, [31]). **Never verified: src-0017 (added c21) and
src-0018 (added c25).** *Next G2 should prefer, by staleness and by never-checked status:
**src-0017** — never verified, and a different kind of check (file paths and code lines, not
table cells), and [34] wants its TTP/rubric scorers anyway, so one fetch could serve both;
then **src-0018** (never verified; the highest-value thing available there is any route at all
to the numbers locked in its four images); then **src-0008** (c10, now the stalest verified
source) or **src-0012**/**src-0011** (c13/c14). Not recommended next: src-0005 (c26), src-0001
(c25), src-0002 (c23), src-0003 (c22), src-0016/src-0007 (c21), src-0015 (c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25 AND 26.** `python3` is present at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks
every invocation; compound/piped commands are rejected if any segment is unapproved. **No PDF
text extraction exists** — prefer `/html` always; `/abs` carries no tables **but does carry
the abstract**, which is why [38] works. `gh` is **not** approved. `awk` refused. **`sed -n`
and `cat >>` heredoc ARE approved**; a heredoc append must be its **own** call. `jq -e . <file>
> /dev/null` **is** approved. Prefer **single-line `Edit` anchors** — a multi-line
`old_string` spanning an array-element boundary failed to match at c25 for no visible reason.
*Cycle 26: all held. Two new confirmations — a **compound `jq -e … && echo … && jq -r …`
chain was approved** (all segments `jq`), and a `Write` of the whole 30 KB `scores.json`
worked fine, so a full-file rewrite is a legitimate alternative to many `Edit`s on a file
that is not append-only-protected. `scores.json` and `graph.json` are NOT protected by
validator lines 105–107; only `index.json` key_claims and the `src-*.md` files are.*

**[10] — DISCHARGED CYCLE 26, AND THE ANSWER IS THAT IT WAS NEVER ACHIEVABLE.** ~~src-0005 has
never had a number captured.~~ It now has: **Malware Analysis 23–34%** (random baseline
~0.63%), **Threat Intelligence Reasoning 43–53%** (random ~1.7%), both verbatim, both
attributed to §4.1/§4.2 by a confirming fetch. **But the per-model numbers that 25 cycles kept
asking for do not exist in the text at all** — the paper publishes **no results table**, and
every per-model score is inside Figures 8, 9, 12, 13, 14, 15, 16. Confirmed by two independent
fetches under [38]. **Do not re-attempt without a new route** (published raw results, the
CyberSecEval 4 repo, or OCR). See [40] for what the G2 found *instead*, which matters more.

**[11] — APPLIED AND EXTENDED cycle 20; APPLIED AGAIN AND STRESS-TESTED cycle 23.** Tie-break
3a in `prompts/t5_select.md` is under-specified, with no deterministic tie-break after 3c.
Cycle 20 ruled for the **strict pairwise** reading; cycle 23 endorsed it. **A terminal
deterministic tie-break — e.g. lexicographic issue id — is needed.** Same class as [4].
*Cycle 26: **this is now urgent for the cycle-27 T5.** The tier structure inverted — there is
no longer a four-way tie at 3; there is a **four-way tie at 2** (`ioc-extraction-reliability`
`[9,21]`, `consistency-calibration-as-failure-mode` `[3,15,16,25]`,
`attribution-confident-wrong-gap` `[16]`, `automated-triage-under-refusal` `[]`) and a
four-way tie at 3. `tie_break_recent_attempt_penalty: 1` within 5 cycles bites only
`consistency-calibration-as-failure-mode`. The T5 must derive this itself from the prompt file
rather than trusting this paragraph.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — and this item's stronger
claim was WRONG; see [17]. T2 is the only task type with standing to split an issue, add an
issue, or reconcile the prompt/validator disagreement. The claim that the loop "never returns
to T2" is false; cycle 16 disproved it. *Cycles 25 and 26: bit again — the
consistency/calibration split ([37]) is a T2 job and nothing else can do it, and the next T2 is
reachable only via a T1, i.e. **cycle 44 at the earliest** given [28].*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel
is the upstream primary for the entire ENISA incident: a permanent structural gap. The
archived-PDF footnote-count route is also closed ([14]). Prof. Christian Dietrich's / Institut
für Internet-Sicherheit's own writeup is the only remaining route known to this agent.
OpenReview joins this category ([6]). *Cycle 26: this item is now **load-bearing for a
score**, not just a gap. `ctr-0002` removed the src-0002 quantified leg from
`attribution-confident-wrong-gap`, and the weight fell onto src-0004 — whose AI-causation limb
is exactly the one that cannot be strengthened from here. That is a direct cause of the 3 → 2.*

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA
v1.2 PDFs cannot be opened. **Consequence: "ENISA never disclosed the AI use" is established at
landing-page level and UNVERIFIABLE at document level here.** That leg **cannot strengthen**.
**Do not re-spend budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, AND DEFERRED AGAIN.**
The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop"
reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from
~15% to under 5%) is an **open_question on `automated-triage-under-refusal`**. **It is a
question, not evidence — no curl source exists in `index.json` and G1 forbids inventing one.**
Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22 and 26 all judge it the highest-value uncollected source in the project. A T3 may
add sources ([29]), so it is a one-cycle job whenever that issue is selected — earliest the
cycle-27 T5's target, i.e. **cycle 28**.

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
cycles 14→15→16. Structural finding for the paper: the only task type that can restructure the
issue graph fires when a T5 coincides with a multiple of 7 — under a clean three-cycle loop,
**once every 21 cycles**, not every 7. *And a single infrastructure failure can push it 8
more — see [28].*

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS
exhibiting the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid
citations across 308 papers. No claim in our base repeats the error and **no G3 entry was
opened**. Any cycle quoting src-0011's *counts* should take them from Table 3's columns.

**[19] — FULLY DISCHARGED CYCLE 21; CONSUMED BY CYCLES 22 AND 26.** src-0007's Table 4 pulled
**whole and verbatim** into `state/knowledge/src-0007.md`. Triage rows: precision (Accepted)
**0.2717–0.3982**, recall (Accepted) **0.9091–1.0000**. Fine-tuning does not fix the asymmetry
and on the Article task worsens precision (GPT-4o 0.3037 → GPT-4o (FT) 0.2717). **RESIDUE,
UNRESOLVED AND REPRODUCED:** GPT-4o (FT) tracks o3-mini to within 0.001 on **all six**
`Content: Threat Actor` rubric rows, identically in two independent pulls (c15, c21) —
as-printed, not a fetch artefact. **Cause unknown; do not guess. Any claim resting on that
column must say it is suspect.** *Cycle 26: that column now matters more, because `ctr-0002`
made src-0007 a larger share of `attribution-confident-wrong-gap`'s remaining support.*

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014
(c19), src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy is **narrowed but not
closed** — 33.9% is TABLE II's per-model aggregate, 16.9% → 83.2% is the SALLM-to-repository
comparison; different scopes, not arithmetically reconcilable, so **quote them only with their
scopes named**. Gemini's 0.161 → 0.721 was **not** re-checked. **Residue: src-0014's F1 figures
(0.398/0.103/0.465/0.427) are still body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 for a
specialized agent vs. 0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the
true general-purpose peak is **G5 at 0.677**. Direction survives, label does not. Also
imprecise: "F1 range roughly 0.20–0.90" against a true span of **0.286–0.882**. Cycle 18
appended a corrective key_claim to `index.json`; **`src-0006.md` itself is still untouched and
still contains the wrong sentence.** Column split: 8 general (G5, Go4, CLD, GEM, LL70, MIX,
QWN, GRK) / 7 cyber (FSC, CB0, ZYS, LLY, CBS, SPT, DHT). **`src-0006.md` is the only known
source file still carrying an uncorrected sentence** and it is a cheap fix for any cycle
touching that source. *The repair-both-places pattern now holds for cycles 22, 23, 25 and 26.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** An unexplained regularity in src-0006's Table 2:
eleven of twenty-eight rows are **strictly monotone decreasing across all eight general-purpose
columns in exactly the printed column order**. Four are in the nine-row F1 subset
`extraction-vs-reasoning-ordinal-axis` depends on. For independent measurements, one row
matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch
artefact.** Cause unknown; do not speculate. **Any finding resting on src-0006's Table 2 must
carry a robustness check excluding these rows** (cycle 18's: drop all four → 0.641 vs 0.592,
gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.**
`task-dependent-reliability-framing`'s supported candidate cites src-0006's "F1/AUC roughly
0.20–0.90" as evidence that reliability varies sharply by sub-task. Mean between-**model**
range within a task (0.272) and mean between-**task** range within a model (0.263) are equal to
within 0.009. **This does NOT negate the supported claim** — cycles 19, 22 and 26 all tested it
and all concluded it is not a counterargument; it qualifies the implication that sub-task is
the *privileged* explanatory variable. A T2 should annotate the parent's candidate rather than
re-scope it. No contradiction entry: both facts hold simultaneously.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–23, 25 AND 26. `jq` IS INSTALLED AND
APPROVED.** `jq -e . <file>` parses and exits non-zero on malformed JSON; `jq -r '<filter>'`
reads structure without a full-file Read. **Every cycle from 9 to 17 recorded that this agent
cannot validate JSON and must check "by construction". That advice is wrong and it is
expensive** — cycle 17 made five blind edits to a 57 KB JSON file and had its entire `state/`
output reverted. **Every JSON edit should be followed by a `jq -e` check.** The permission
layer is **not uniform** — probe once, don't infer from class. The `Grep` **tool** works on the
big JSON files where Bash `grep -n` does not. Cheapest append-only edit pattern: **`Grep` tool
→ `Read` with `offset`/`limit` → `Edit` → `jq -e`**. Keep `jq` path arguments inside the repo;
redirecting output to `/dev/null` is fine, passing it as a path argument is refused.

**[25] — DISCHARGED CYCLE 21.** `state/knowledge/src-0007.md` now contains the
`Content: Threat Actor` rubric block in full, verbatim, all six rows and four columns,
alongside the whole of Table 4. **The two caveats travel with it and must keep travelling:**
the rubric's **absolute level is uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5
vs (x−1)/4, a normalisation the paper never states), so **only within-table contrasts may be
cited**; and the GPT-4o (FT) column is suspect per [19].

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's errors to
stdout, but `logs/cycle-017-transcript.txt` captures the agent's own output only, and the
reverted `state/` files were never committed. Suggested harness fix for a human: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before
reverting, and `git stash` the rejected `state/` diff rather than discarding it. *Cycle 24 is
the mirror-image case and it worked correctly — the transcript captured the single line
`API Error: 529 Overloaded`. The mechanism is fine for **crashes**; it is blind to **validator
rejections**, which is exactly the fix requested.*

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH.** src-0015's Table 1 has a **`Reward`**
column no cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61, DeepSeek 3.2
**3.45**. **The model the paper calls best-calibrated earns the lowest reward**, and the two
highest-containment models take the two highest rewards. Bears directly on
`automated-triage-under-refusal`'s `open_questions[0]` — models versus harness. **Caveats:** the
fetched material does not state the reward's composition; n = 40 per model, no CIs; the
association is not strictly monotone. An observation about an **already-collected** source, so
**no new citation is needed**. Cycles 22 and 26 recorded it in that issue's `rationale`, but a
rationale is not the graph. **Still unentered.**

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, RE-DERIVED WITH A CHANGED RESULT at cycle 25,
CONFIRMED cycle 26.** The state machine is T1→T2, T2→T3, T3→T4, T4→T5, T5→T3. Cycle 24's T3
died before writing anything and cycle 25 re-ran it, shifting the phase by one. Positions:
**cycle 25 = T3, cycle 26 = T4 (this one, as predicted), cycle 27 = T5, cycle 28 = T3**, and T5
thereafter lands on 27, 30, 33, 36, 39, **42**. `collect_refresh_every: 7`, and the refresh
fires only when a T5 **runs on** a multiple-of-7 cycle (pinned from git history: cycle 14 T5 →
cycle 15 T1 collect). Of the multiples of 7 ahead — 28, 35, 42 — only **42** is a T5 cycle.
**So the next T1 is cycle 43.** *The single most consequential structural fact in this project:
**one infrastructure failure, costing one cycle, pushed the next collection cycle back by
eight** — because the refresh rule depends on a coincidence between two periods (3 and 7) and a
one-cycle shift breaks the alignment for a full lcm. The two highest-value uncollected items
([15] curl/HackerOne, [10]'s successor [40]) both want a T1 and neither gets one for
seventeen cycles.* **Re-derive rather than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21 AND 25.** A T3 **MAY** add sources.
`prompts/t3_investigate.md` step 2: "Only web-search for what the knowledge base cannot answer
(and if you fetch something substantial, add it properly as a source per T1 rules — it counts
toward the same `max_new_sources` budget)." Cycle 21 exercised this and added src-0017; cycle 25
exercised it and added src-0018, which broke a blocker standing since cycle 3. **Standing
lesson: read the task's own prompt file, not only the queue entry's description of it.**
*Cycle 26 followed it and found the queue entry's summary of `t4_assess.md` accurate — but the
entry's summary of the G3 rule would have been wrong if taken from the prompt alone, which is
the same lesson from the other side.*

**[30] — NEW cycle 20; PREDICTION CORRECT TWICE.** `automated-triage-under-refusal`, the only
issue in the graph never worked on (`attempts: []`, created cycle 16), has **lost two
consecutive selections** to issues attempted twice and three times. **"Never attempted" is not a
tie-break in `prompts/t5_select.md`**, and cycle 19's `scores.json` rationale wrongly asserted
it was. **This is a prompt change for a human, not a reading an agent may adopt.** Note the
interaction with [11]: a **non-pairwise** 3a would rank that issue **last** of the base-2
candidates rather than second. Anyone fixing [11] should fix [30] at the same time. *Cycle 26:
the base-2 tier grew from three to four, so this issue's odds got **worse**, not better.*

**[31] — NEW cycle 21, EXTENDED cycles 22, 23, 25 AND 26. THE EXACT-STRING / VERBATIM CHECK HAS
NOW BEEN RUN ON FIVE SOURCES; FOUR FAILED, ONE PASSED ON CONTENT WHILE BEING MATERIALLY
INCOMPLETE.** (a) **src-0016** (c21): the stored "verbatim" quotation about 80 of 161
unique-unmatched findings **does not exist on the page** — it splices a real sentence to a table
cell. (b) **src-0003** (c22): quotations passed, stored *numbers* 76/72/86 are
**figure-image-only**; [32]. (c) **src-0002** (c23): all 25 numbers exact, but the
**interpretation attached to two of them is contradicted by the paper's own metric
definition**; `ctr-0002`. (d) **src-0001** (c25): numbers exact, protocol *stronger* than
recorded, but the **calibration gloss is contradicted by the full table** and **four of nine
rows had never been collected**; `ctr-0003`. (e) **src-0005** (c26): **all three key claims and
all four quotations PASS verbatim** — the first clean pass — **but the source was stored with no
task format, no metric definition, no sample counts, no stated limitations and no numbers at
all.** **The defect class is now five-way: spliced quotations, unverifiable numbers, unsupported
interpretive glosses on correct numbers, partial table capture, and CORRECT-BUT-HOLLOW ENTRIES
that pass every check while omitting everything needed to use the source properly.** **Standing
lesson, upgraded again: pull the whole table AND the metric definition AND the task format AND
the paper's own limitations — a source that passes an exact-string check can still be unusable.**
**Twelve sources have stored values or quotes that have never faced any of these checks.**

**[32] — NEW cycle 22. src-0003's THREE BASELINE F1 VALUES ARE FIGURE-IMAGE-ONLY AND NOT
TEXT-VERIFIABLE; REPAIRED BY APPEND.** `src-0003.md` key claim 1 and `index.json`
key_claims[1] state LANCE's 97.6% beats "IoC Searcher + whitelist (76% F1), AlienVault OTX (72%
F1), VirusTotal threshold=1 (86% F1)". On `https://arxiv.org/html/2506.11325v2` the exact
strings **`76` and `72` do not occur at all**, and the only `86%` is LANCE's own per-type
recall. They live only in **Figure 6**, an image this agent cannot read. **The ordering is
textually supported**, so nothing is falsified — but **cite 76/72/86 as figure-derived and not
text-verified.** Also unverifiable: **`~0.88 F1 with Llama`**. Repaired by appending to both
`index.json` and `src-0003.md`. **No contradiction entry** — file when the source's own legible
text conflicts with the stored claim; do not file when the stored claim is merely unverifiable.
*Caveat from [38]: the exact-string limb rests on a **single fetch's ABSENT** and should be
re-confirmed against a second URL form before anyone leans on it further. Still not done at
cycle 26.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER
HAD.** src-0003's 97.6% is measured on a **closed-set classification task over a
regex-extracted candidate set**, not on free-form extraction. Verbatim: "We assume a total of
1,789 candidate indicators, extracted using IoC Searcher, a state-of-the-art rule-based tool";
"LANCE labeled over 99% of all extracted indicators"; Figure 9's caption "… on IoC
Classification." **A difference in task format, not only in scaffolding**, and *stated by the
paper*. **Companion finding: src-0003 NEVER STATES ITS MATCHING RULE**, so the open_question
cycle 21 added is **unanswerable from this base**. **A T3 on `ioc-extraction-reliability` should
carry these into `ctr-0001` and the issue's candidates; a T4 has no standing to.**

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE.** **A within-study design holds team, corpus, models and harness constant but does
NOT hold the scoring rule constant.** A cross-sub-task score spread is a task-difficulty fact
only if the sub-tasks are scored comparably. src-0017 shows src-0007's IoC evaluator matches by
two-directional substring containment with a ground truth never stated to be exhaustive; **the
scoring rules for src-0007's ATT&CK and rubric tasks have never been pulled**, and neither have
the per-task scoring definitions behind src-0006's nine F1 rows. **What restores the 4:** read
`stage3_ti_drafting`'s TTP and rubric scorers in the src-0017 repo (`raw.githubusercontent.com`
worked at cycle 21) and src-0006's metric definitions, then state and answer the objection in
the issue. **Note the asymmetry:** the same finding is neutral-to-favourable for
`extraction-vs-reasoning-ordinal-axis`, whose supported claim is *negative*. *Cycle 26 adds a
**third instance** — see [40] — so the objection is now supported by src-0017, src-0003 and
src-0005, and the issue text still does not mention it.*

**[35] — NEW cycle 23. src-0002's CTI-TAA `Correct` AND `Plausible` COLUMNS ARE NESTED, NOT
DISJOINT; `ctr-0002` OPENED; REPAIRED BY APPEND.** Section 4.2 verbatim: "we compute two types
of accuracy: Correct Accuracy, which is the fraction of correct answers, and Plausible Accuracy,
which is the fraction of correct and plausible answers combined." **Plausible ⊇ Correct**, so
the stored claim that the plausible rate "is far higher than" the correct rate is **true by
construction**. "Plausible" is the **underdetermined-input** case and **hallucination lives in
the separate `incorrect` category**. The string `plausible-sounding` **does not occur in the
paper**. **Derived replacements, to be labelled as derived wherever used:**
plausible-but-not-correct share = 34 / 18 / 36 / 28 / 8 pp; the paper's own incorrect
(hallucination-inclusive) rate = `100 − Plausible Accuracy` = **14% / 38% / 26% / 20% / 64%**.
**All 25 stored numbers are exact.** *Cycle 26: **this item cost the issue a point** — see the
3 → 2 above.*

**[36] — NEW cycle 23, FOR A T3 AND THEN A T4. THE T4 HALF IS NOW DONE; THE T3 HALF IS NOT.**
`ctr-0002`'s resolution path, in order: **(i)** rewrite `attribution-confident-wrong-gap`'s
primary candidate to cite the derived incorrect-bucket rates (14–64%) with the derivation
stated, or explicitly retire the 86-vs-52 framing; **(ii)** decide and record which of two
readings holds — **(a)** the leg survives with a different number, or **(b)** the leg is weaker
than scored, which throws more weight onto the src-0004 ENISA leg that [13] says cannot be
strengthened; **(iii)** check whether src-0002's **other two** key_claims — feeding
`ttp-attack-mapping-reliability` and `task-dependent-reliability-framing` — carry any similar
unstated interpretive gloss. *Cycle 26: **I weighed it and rescored 3 → 2, and did not touch
the graph.** Steps (i)–(iii) are **all still outstanding and are all T3 work.** The issue is now
in the base-2 tier, so it is a live selection candidate for the cycle-27 T5, and a T3 doing
[36] would plausibly restore the 3 in one cycle. **Note for whoever does it: step (iii) is the
one nobody has scoped — src-0002 feeds two other issues and neither has been checked for the
same defect class.***

**[37] — NEW cycle 25, ENDORSED AND STRENGTHENED cycle 26. THE ISSUE ASKS TWO QUESTIONS AND THE
EVIDENCE IS ASYMMETRIC; THAT MAY BE A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks
about **consistency** *and* **calibration**. consistency-on-CTI rests on **two independent
sources** (src-0001 + src-0018), calibration-on-CTI on **one** (src-0001, gpt4o only, nine
rows), and `ctr-0003` sits on the calibration half alone. **A T4 cannot split an issue and
neither can a T3 ([12]); only a T2 can.** The natural cut is `consistency-under-repeated-query`
vs `confidence-calibration-on-CTI`, with src-0018 and the CI-width evidence going to the first
and Table 6 plus `ctr-0003` to the second. *Cycle 26: **this is exactly why the issue held at 2
rather than rising to 3.** The scoring rubric has no way to express "one leg is a 3 and the
other is a 2", so the title binds them and the weaker leg governs. Split, the two children would
plausibly score 3 and 2 and the base would carry strictly more information than it does now.
**The next T2 is reachable only via a T1, i.e. cycle 44 at the earliest ([28]) — so this issue
will be mis-scored, in the sense of under-expressive, for eighteen cycles.** That is a finding
about the state machine, not about the research.*

**[38] — NEW cycle 25, AND IT PAID OFF IMMEDIATELY AT CYCLE 26. A SINGLE FETCH'S "ABSENT" IS NOT
EVIDENCE OF ABSENCE.** The `/html` fetch of arXiv 2503.23175 that correctly transcribed all 54
cells of Table 6 **also reported the exact string "inconsistent and overconfident" as ABSENT**;
a second fetch of `/abs` returned it verbatim in the abstract. **New rule for every future G2: a
PRESENT verdict may be trusted from one fetch; an ABSENT verdict must be confirmed against a
second URL form (`/abs` vs `/html` vs `/html/vN`) before it is recorded as a defect.**
*Cycle 26 hit the same trap from the other direction and the rule caught it: src-0005's stored
quotations come from the **abstract**, while the body **paraphrases** two of them differently
("do not achieve the boost they do in areas like coding and math"). The body-reading fetch
returned one as ABSENT; the `/abs` fetch returned all four verbatim. **Without [38] this cycle
would have opened a contradiction against a claim that is exactly correct.** Generalisation
worth adding: **check the abstract before concluding a quotation is absent — this base's
oldest sources were collected by abstract-page summarisation, so their stored quotations are
disproportionately abstract-sourced.***

**[39] — NEW cycle 25, SECOND INSTANCE FOUND AT CYCLE 26. PROVENANCE LABELS IN THIS BASE WERE
SET AT COLLECTION TIME AND HAVE NEVER BEEN RE-CHECKED.** src-0001 **is peer-reviewed and
published** — ARES 2025, Springer, DOI `10.1007/978-3-032-00627-1_17` — and this base called it
a preprint for 24 cycles. *Cycle 26: **src-0005 checked and it goes the other way** — v1 24 Sep
2025, v2 10 Nov 2025, **no venue, no "accepted at", no DOI but the arXiv one, and no
affiliations printed on the page at all**. It is an **unreviewed preprint**, and the
CrowdStrike/Meta affiliation this base has asserted since cycle 1 rests on **recognising two
senior author names**, not on anything the paper prints. So the check cuts both ways and both
directions matter for weighting.* Still unchecked: src-0013 (claims "ICSME 2026 Research
Track"), src-0014 ("v1 preprint, no stated venue"), src-0015 ("single-author preprint … no
stated venue"), src-0017 (unresolved "[TMLR 25]" tag inconsistent with its arXiv date).
**Provenance staleness is a cheap, unworked check** — one fetch per source, and it changes how
much weight the weakest sources deserve.

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS,
AND THIS BASE HAS CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "Evaluation is
based on accuracy: the share of questions for which the system selects all correct options and
only the correct options." 609 malware-analysis cases; 588 threat-intel-reasoning pairs from 45
reports, the report supplied "via a set of images (one per report page)". Questions were
**generated by Llama 3.2 90B and Llama 4 Maverick**, then human-validated, and the paper itself
concedes both that multiple choice "does not provide a perfect proxy for capabilities" and that
there is "performance bias … where the model under test is the same, or has similarities with
the set of models that were used in synthetic data generation pipelines" — a live contamination
risk given Llama models are also under test. **Three consequences.** (a) **src-0005's
percentages are not commensurable with src-0002's F1 or src-0007's precision/recall**, which
score free-form output — the **third** instance of task-format non-commensurability in this
base after [33] and src-0017, and it strengthens [34]. (b) **src-0005 reports no ATT&CK metric
at all**, confirming `ttp-attack-mapping-reliability`'s `open_question[0]` at source and
withdrawing the "three unaffiliated teams" count ([2]). (c) The two ranges it *does* report,
**23–34% (MA) against 43–53% (TIR)**, are a within-paper cross-task spread with the scoring rule
genuinely held constant — **suggestive for `task-dependent-reliability-framing`, but NOT a
controlled contrast** (different corpora, different question-generation pipelines, and different
random baselines, 0.63% vs 1.7%). **Anyone using it must state those three confounds.** Repaired
by appending six key_claims to `index.json` **and** a full appendix to `src-0005.md`.

**[41] — NEW cycle 26. THE G3 CEILING BECOMES *LESS* LIKELY TO BE TESTED THE BETTER THE LOOP
WORKS, AND THAT IS AN ARGUMENT FOR A HUMAN NOT WAITING.** [4] has recorded for 17 cycles that
the prompt says subtract and the validator enforces a ceiling, and that the divergence is
"untested". Cycle 26 makes the reason structural rather than lucky: **an honest, stingy T4
demotes issues that carry open contradictions, which moves them *away* from the ceiling, not
towards it.** All three contradiction-carrying issues now sit at 2 against a ceiling of 3.
The ceiling can only bind if a T4 scores a contradiction-carrying issue at 4 or 5 — i.e. only if
an issue is simultaneously *robust* and *self-contradictory*, which is close to a contradiction
in terms. **So the validator's G3 check is very nearly dead code, while the prompt's subtraction
rule — which every T4 has correctly refused to apply — would fire on all three issues today and
drive them to 0 without tripping anything.** The gap is not waiting to be discovered by a test
case; it needs a human to pick one reading and edit the other two files.
