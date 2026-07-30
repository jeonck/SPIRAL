# Cycle 023 — T5 (Select)

## Task performed

**T5 — Select the weakest link.** I read `prompts/t5_select.md` myself rather than relying on the
queue entry's description of it, and re-derived every fact of the ranking from
`state/issues/graph.json` with `jq` rather than copying cycle 22's transcription. The selection is
**`consistency-calibration-as-failure-mode`**, which agrees with cycle 22's prediction, but the
arithmetic below is independent of it and one step of the reasoning differs (see 3a).

`23 % 7 = 2 ≠ 0`, so the **refresh rule does not fire** and the next task is a **T3**, not a T1.

A T5 selects. I did **not** rescore, did not edit `state/assessments/scores.json`, and did not
resolve `ctr-0001`. I did edit `state/issues/graph.json` — but only to open a new contradiction
entry, which is what the G2 rule in `prompts/system.md` **requires** when a re-checked conclusion
fails, and which the queue entry explicitly authorised. See Retrospection.

---

## Retrospection

**Target: `src-0002` (CTIBench, arXiv 2406.07599), last verified cycle 6 — the stalest source in the
base, and a leg of three issues.** Chosen per carry-forward [8]'s staleness ordering.

**Method.** Two fetches, `https://arxiv.org/html/2406.07599` and `https://arxiv.org/html/2406.07599v3`,
with **different prompts**. Both were asked for whole tables verbatim with an explicit instruction to
write `ABSENT` or `CANNOT READ` rather than infer, plus the [31] exact-string check on every stored
number and quotation. The two agree cell for cell.

### Result: numbers PASS exactly; the interpretation FAILS

**PASS — and this is the first cell-by-cell check this source has ever had.** All **25** stored
numeric cells match Table 1 verbatim. `src-0002.md`'s own "Limitations" section warned that its
numbers were extracted by "automated HTML-to-summary tooling, not manually cross-checked cell-by-cell
against the PDF tables; treat as approximate pending manual verification." **That limitation is now
discharged: they are exact, not approximate.** The stored motivation quotation also passed the
exact-string check. Two refinements: the ATE column is labelled **Macro-F1**, not plain F1, and Table
1 carries a **CTI-VSP (MAD)** column never stored here (1.31 / 1.57 / 1.09 / 1.83 / 1.91) — the
original collection deliberately omitted it as non-comparable, which was right, but it is now recorded.

**FAIL — key claim 2's interpretation is not supported by the paper, and is arguably contradicted by
it.** Two findings, both verbatim from Section 4.2:

1. **`Correct` and `Plausible` are NESTED, not disjoint.**
   > "Based on these categories, we compute two types of accuracy: Correct Accuracy, which is the
   > fraction of correct answers, and Plausible Accuracy, which is the fraction of correct and
   > plausible answers combined."

   Plausible Accuracy **contains** Correct Accuracy. So the stored claim that "every tested model's
   plausible-sounding attribution rate is far higher than its correct attribution rate" is **true by
   construction for every model** and is not an empirical finding at all. The empirical quantity is
   the *difference* — the plausible-but-not-correct share — which the paper never prints: GPT-4-turbo
   **34**, GPT-3.5-turbo **18**, Gemini-1.5 **36**, LLAMA3-70B **28**, LLAMA3-8B **8** percentage
   points.

2. **"Plausible" is not the paper's hallucination category.**
   > "…correct answer (when the LLM accurately identifies the threat actor or one of its aliases),
   > plausible answer (when the threat report lacks sufficient details to pinpoint the answer, but the
   > LLM provides a plausible or related threat actor within a similar group), and incorrect answer
   > (when the LLM misattributes the threat actor due to misjudgment, hallucination, or spurious
   > correlation)."

   "Plausible" is scoped to **underdetermined input** answered with a related actor from a similar
   group. Misjudgment / hallucination / spurious correlation is the **separate third bucket**. So the
   state has been citing the paper's *near-miss-on-an-ambiguous-report* rate as its
   *confident-but-wrong* rate.

Two further exact-string results: **`plausible-sounding` does not occur in the paper**, though
`index.json` and `src-0002.md` present it in scare quotes as if quoting it; and **no sentence in the
paper interprets the correct-versus-plausible gap** — the interpretation is entirely ours.

### Why this is a contradiction entry and cycle 22's src-0003 finding was not

Cycle 22 declined to file for src-0003 because the values were merely *unverifiable* (figure-image
only), there was no rival claim, and filing would dilute the G3 signal. **This is a different case
and the distinction is deliberate.** Here the source's own definitional text is legible, verbatim,
recovered twice, and says something incompatible with the claim the state has entered. That is two
claims in conflict, and one of them is the paper's. `ctr-0002` is opened against
`attribution-confident-wrong-gap`.

**This is a success of the system, and it is the most consequential thing this cycle produced.** The
86-vs-52 figure has been carried since cycle 1, has been cited in that issue's score rationale at
every assessment since cycle 7, and was one of the two "genuinely independent legs" that cycle 22
gave as the reason it outranks the single-source 2s. It survived every prior G2 because no earlier
check pulled the *metric definition* — the numbers were always right.

### What survives, stated plainly so the next cycle does not over-correct

CTIBench still supports a confident-but-wrong finding: **the paper's own `incorrect` bucket is
hallucination-inclusive by its definition** and equals `100 − Plausible Accuracy` — GPT-4-turbo
**14%**, GPT-3.5-turbo **38%**, Gemini-1.5 **26%**, LLAMA3-70B **20%**, LLAMA3-8B **64%** on 50 real
reports. That is a real misattribution rate. **But it is not 86 vs 52, and the gap between the two
columns is not on its own evidence of overconfidence.** Whether the leg is as strong as scored is a
question for a T3 and then a T4; a T5 has no standing to rescore and I have not.

**Validator check:** `attribution-confident-wrong-gap` is scored **3**; the G3 ceiling is
`scale_max − g3_contradiction_demotion = 3`. `3 > 3` is false, so opening `ctr-0002` does **not**
trip `validate_state.py` lines 144–156. It does **cap that issue at 3** until resolved.

---

## Changes made

- **`state/issues/graph.json`** — **`ctr-0002` opened** against `attribution-confident-wrong-gap`,
  `opened_cycle` 23, `resolved_cycle` null. Nothing else in the file touched: no rescoring, no
  candidate promoted, no `open_questions` edited, `ctr-0001` left open. `jq -e` validated.
- **`state/knowledge/index.json`** — **three `key_claims` APPENDED** to src-0002's entry (one
  positive verification record, two corrections). **No key_claim removed or rewritten**, so the
  append-only gate at `validate_state.py` lines 105–107 is satisfied; src-0002 is not a new source so
  the URL liveness check does not re-run. `jq -e` validated.
- **`state/knowledge/src-0002.md`** — appendix appended by heredoc, carrying Table 1 whole, both
  Section 4.2 definitions verbatim, and the derived rates. Nothing above it altered. Per [21], the
  `.md` file is where a later cycle actually reads the source, so repairing only `index.json` would
  leave the wrong sentence in the more-read place.
- `logs/cycle-023.md` — this file.
- `state/queue/next_task.json` — T3 targeting `consistency-calibration-as-failure-mode`.
- `state/queue/last_completed_task.txt` — `T5 select`.

**Not changed, deliberately:** `state/assessments/scores.json`. A T5 does not rescore, even when its
own G2 has found something that plainly bears on a score.

---

## Next task rationale

### Selection policy, applied mechanically

Facts pulled with `jq -r` from `state/issues/graph.json` (not transcribed from the handoff):

| issue | score | created | attempts |
|---|---|---|---|
| ttp-attack-mapping-reliability | 3 | 2 | [16] |
| ioc-extraction-reliability | 2 | 2 | [9, 21] |
| consistency-calibration-as-failure-mode | 2 | 2 | [3, 15, 16] |
| attribution-confident-wrong-gap | 3 | 2 | [16] |
| task-dependent-reliability-framing | 3 | 2 | [6, 16] |
| extraction-vs-reasoning-ordinal-axis | 3 | 16 | [17, 18] |
| institutional-incident-real-world-impact | 3 | 2 | [12] |
| automated-triage-under-refusal | 2 | 16 | [] |

**Step 1 — candidate set.** All issues with score < 5. **All eight qualify**; none is at 5, so the
all-resolved branch (write a T2 scope review) does not apply.

**Step 2 — base priority = score.** Three issues at **2**: `ioc-extraction-reliability`,
`consistency-calibration-as-failure-mode`, `automated-triage-under-refusal`. Five at 3.

**Step 3b — attempt penalty window, stated before use.** `scoring.tie_break_recent_attempt_penalty`
is **1** per attempt within the last 5 cycles. I read "the last 5 cycles" as the five completed
cycles before this one, **18–22** (`current − c ≤ 5`). Only two attempts fall inside it: **cycle 21**
(`ioc-extraction-reliability`) and **cycle 18** (`extraction-vs-reasoning-ordinal-axis`). The one
borderline case is cycle 18; a stricter `c ≥ 19` reading drops the penalty on
`extraction-vs-reasoning-ordinal-axis` only, moving it from effective 4 to 3. **Neither reading
touches ranks 1 or 2.** Cycle 21's attempt is inside the window under any defensible reading.

### Full ranking table

Effective score = base score + 3b penalty, compared globally (see the note below on the alternative).

| rank | issue | score | 3a | 3b penalty | effective | created | why it sits here |
|---|---|---|---|---|---|---|---|
| **1** | **consistency-calibration-as-failure-mode** | **2** | silent | **0** | **2** | **2** | **SELECTED.** Lowest effective score; wins 3c against rank 2 on `created_cycle` 2 vs 16. |
| 2 | automated-triage-under-refusal | 2 | silent | 0 | 2 | 16 | Ties rank 1 on score and on 3b; **loses on 3c**, the last tie-break in the policy. |
| 3 | attribution-confident-wrong-gap | 3 | neutral | 0 | 3 | 2 | Four-way terminal tie, see below. Now also capped at 3 by `ctr-0002`. |
| 4 | institutional-incident-real-world-impact | 3 | neutral | 0 | 3 | 2 | Four-way terminal tie. |
| 5 | ioc-extraction-reliability | 3 | upstream | **+1** | 3 | 2 | **Base score 2, demoted by 3b** for its cycle-21 attempt. Four-way terminal tie. |
| 6 | ttp-attack-mapping-reliability | 3 | upstream | 0 | 3 | 2 | Four-way terminal tie. |
| 7 | task-dependent-reliability-framing | 3 | **dependent** | 0 | 3 | 2 | **Demoted by 3a**: it `depends_on` four issues, three of them in this tier. |
| 8 | extraction-vs-reasoning-ordinal-axis | 3 | dependent | **+1** | 4 | 16 | Demoted by both 3a (depends on rank 7) and 3b (cycle-18 attempt). |

Ranks **3–6 are a genuine four-way tie that the policy cannot break** — same effective score, 3a
silent or neutral among them, same `created_cycle` 2. I ordered them lexicographically by issue id as
a **display convention, not policy**. This is exactly the closure gap recorded in carry-forward [11]
and it is now demonstrated with four issues rather than two.

### The 3a question, and where I differ from cycle 22's framing

Cycle 20 ruled for a **strict pairwise** reading: 3a separates two candidates only when one
`depends_on` the other. Among the three base-2 issues, all three have `depends_on: []`, so **3a is
silent** and 3b and 3c carry the decision.

**I endorse the strict pairwise reading** — `prompts/t5_select.md` says "an issue that others
`depend_on` outranks **its dependents**", and "its dependents" is pairwise language. But cycle 22 was
right to flag the alternative, so I tested it rather than only noting it. Under a **non-pairwise**
reading ("more dependents = more upstream"), `consistency-calibration-as-failure-mode` is depended on
by **two** issues, `ioc-extraction-reliability` by one, and `automated-triage-under-refusal` by
**none** — which would decide the tie at 3a, before 3b or 3c ever run.

**Both readings select the same issue this cycle.** That is worth recording for the paper: the [11]
policy ambiguity is **live but not load-bearing at cycle 23**. It changes the *justification* (3a vs
3b+3c) but not the *outcome*. A human resolving [11] can do so without invalidating this selection.

### The consequence, reported plainly as the queue entry required

**`automated-triage-under-refusal` — the only issue in the graph never worked on (`attempts: []`,
created cycle 16) — loses a second consecutive selection**, to an issue that has been worked three
times. It loses on `created_cycle`, the policy's final tie-break. **"Never attempted" is not a
tie-break in `prompts/t5_select.md`**; cycle 19's `scores.json` rationale wrongly asserted it was,
and I did not adopt that invented rule. If a human believes never-worked issues should be favoured,
that is a prompt change — carry-forward [30]. I note the practical cost: this also defers
carry-forward [15], the curl/HackerOne case, which cycles 19 and 22 both called the highest-value
uncollected source in the project, for at least three more cycles.

### Refresh rule

`schedule.collect_refresh_every: 7`. The rule fires when a T5 **runs on** a multiple-of-7 cycle
(pinned from git history: cycle 14 T5 → cycle 15 T1). **`23 % 7 = 2`, so no refresh** — the next task
is a **T3**. Under a clean loop the next T5s land on 26, 29, 32, **35**, so the next T1 is cycle 35.
A failed-validation retry shifts the phase by one, so a later cycle must re-derive rather than trust
this projection.

### Why this target is a good use of the next cycle, independent of the arithmetic

The blocker on `consistency-calibration-as-failure-mode` is unusually **narrow and exactly known**,
and has been unchanged since cycle 16: both SUPPORTED candidates cite `[src-0001]` and nothing else,
so **one CTI-task measurement of output consistency or confidence calibration moves it from 2 to 3**.
Its four corroborating sources all measure non-CTI tasks and the cycle-16 scope ruling — endorsed at
cycles 19 and 22 — correctly refuses to count them. This is a fetch-and-collect problem with a clean
success criterion, which is a better fit for a T3 than the interpretive work the 3-tier issues need.

---

## Budget

- **Web fetches: 2** (both `arxiv.org/html/2406.07599`, different prompts and one version-pinned).
- **Web searches: 0.**
- **`jq` invocations: 6** (4 read-only structure pulls, 2 post-edit `jq -e` validations).
- **Grep-tool calls: 2**; **Read calls: 7** (all windowed except the four small state files and
  `prompts/t5_select.md`); **Edit: 2**; **Write: 2**; **heredoc appends: 2**.
- **Turns: ~16 of 50.** No blocked or refused commands this cycle; no new sandbox findings.

Cheapest thing that produced the most: the second fetch. The first fetch's answer to the
exact-string block was a summarised "All values requested are PRESENT" rather than the quoted
sentences I asked for — **exactly the failure mode [31] and the methodological rule warn about** —
but it happened to include the phrase "Plausible Accuracy, which is the fraction of correct and
plausible answers combined" in passing. The second fetch, asked only for the verbatim scoring
definitions, is what turned that phrase into a verified finding. **Thirteen cycles running, asking
for the whole passage verbatim has changed the outcome.**

---

## Carry-forward items

All items from `logs/cycle-022.md` reproduced **including those I could not act on**, with cycle-23
updates. Discharged items stay marked rather than deleted. **Six handoffs have lost or corrupted
state**, and this cycle found the exact-string/verbatim defect class in a **third** source — see
[31] and the new [35]. This section is load-bearing.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2 candidate moved
verbatim. Still vindicated: the two halves score 3 and 3 and moved for different reasons at cycle 22.

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`. The graph records
a three-team claim. Did **not** move the score; the blocker is `open_question[1]`, the missing
human-analyst baseline, now in its **twelfth** cycle. See [10].

**[3] — DISCHARGED cycle 16.** New issue `automated-triage-under-refusal`. First-scored cycle 19 (2),
held at 2 cycle 22. *Cycle 23 note: it has now **lost two consecutive selections** and still has
`attempts: []` — see [30], which is the live policy question this creates.*

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, AND STILL UNTESTED AFTER 14 CYCLES.** The G3 gate
is specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35
comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3 under current
config). The enforced reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement
text in `logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are
outside this agent's output surface. **Until a human applies it, T4s must apply the ceiling.**
*Cycle 23 note: **the stakes just doubled.** `ctr-0002` means a **second** issue now carries an open
contradiction. Under the ceiling, `attribution-confident-wrong-gap` is capped at 3 and its current 3
is legal. **Under subtraction it would read 1** (3 − 2), and `ioc-extraction-reliability` would read
0. Two of eight issues would be fabricated bottoms in the weakest-link selector, and **subtraction
never trips the validator, so the misreading would be silent.** The cycle-24 T3 and the T4 after it
must apply the ceiling.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6, the
paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no contradiction
opened. Needs a PDF-level check, blocked by [14]. Per-phase percentages exist ONLY as pie charts
(Figure 2); Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%, Gemini 4.8%, Grok 0, Cohere
0) are verified exact. Not touched at cycle 23.

**[6]** Unfinished search directions, open since cycle 9: citation-graph sweep of arXiv 2506.11325;
**third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines** (much more
valuable since [32]); the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no
preprint — do not retry). **Forward-citation sweeps have FAILED on two different arXiv ids —
unavailable infrastructure, not an unsearched direction.** Cycle 17's topical leads stand and are
**unclaimed**: **SEvenLLM** (`arxiv.org/pdf/2405.03446`, 28 CTI tasks split 13 understanding / 15
generation), **AthenaBench** (no URL captured), **CTIArena** (no URL captured). Leads, NOT sources;
none is in `index.json` and none may be cited. Unavailable: OpenReview (src-0007's forum
`openreview.net/forum?id=tiFtZHwr7O` and `api2.openreview.net` both serve a browser challenge),
spiegel.de (see [13]). *Cycle 23 note: **SEvenLLM is now the single best-matched lead for the
cycle-24 T3** — 28 CTI tasks split understanding/generation is the right shape for a CTI-task
consistency or calibration measurement. It is still only a lead.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT CYCLE 22.** `ctr-0001` resolution path. **Done:** the
released-code route is exhausted — recall is NOT recoverable (model outputs unpublished) but the
release proves the omission was a reporting choice. **METRIC confound ELIMINATED.** **Still open:** no
head-to-head; the **CORPUS confound is completely untouched and is the largest gap**. The SYSTEM
confound gained its first paper-stated anchor at cycle 22 ([33]); the matching-rule limb is **closed
as unanswerable from this base**. **Remaining next steps, cheapest first:** src-0007's TTP and rubric
scorers in the src-0017 artefact ([34]); `huggingface.co/datasets/xse/CyberThreat-Eval`, still
unfetched; then the corpus-difficulty comparison, which may need a new source.

**[8] — UPDATED cycle 23. G2 COVERAGE REMAINS COMPLETE FOR EVERY SOURCE BUT ONE.** src-0004 (c4,
c12), src-0003 (c5; c22 — substance passed, provenance partial fail, [32]), **src-0002 (c6; c23 —
NUMBERS PASSED EXACTLY, INTERPRETATION FAILED, see `ctr-0002` and [35])**, src-0001 (c7), src-0006
(c8; c17 partial fail [21]; re-pulled c18), src-0005 (c9 substance-only, c11 verbatim), src-0008
(c10), src-0012 (c13), src-0011 (c14), src-0007 (c15; c21 Table 4 whole), src-0009/src-0010 (c16),
src-0013 (c18), src-0014 (c19), src-0015 (c20), src-0016 (c21 — provenance partial fail, [31]).
**Never verified: src-0017 (added c21).** *Next G2 should prefer, by staleness: **src-0001 (c7)** —
now the stalest, and it is the **sole** support for both of the selected issue's supported
candidates, so the cycle-24 T3 has a strong reason to re-check it anyway; then **src-0005 (c9, and
see [10])**; then **src-0017**, never verified at all and a different kind of check (file paths and
code lines, not table cells). Not recommended next: src-0002 (c23), src-0003 (c22), src-0016/src-0007
(c21), src-0015 (c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23.** `python3` is present at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks every
invocation; compound/piped commands are rejected if any segment is unapproved. **No PDF text
extraction exists** — prefer `/html` always; `/abs` pages carry no tables. `gh` is **not** approved,
so GitHub goes through `WebFetch` (`raw.githubusercontent.com/<owner>/<repo>/main/<path>` for files,
`/tree/main/<path>` for listings). `awk` refused. **`sed -n` and `cat >>` heredoc ARE approved.** A
compound `jq … && cat >> … <<'EOF'` was **rejected** at c22 — run a heredoc append as its own call.
`jq -e . <file> > /dev/null` **is** approved. *Cycle 23: all of this held; nothing new refused, and
no new probes were needed.*

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Every claim it contributes is abstract-level
and directional, and it is one of the sources holding `ttp-attack-mapping-reliability` at 3.
**Oldest un-actioned collection task in the project (open since cycle 1); T1 work.** A T1 targeting
that issue should hunt the **human-analyst baseline F1** first (the actual level-4 blocker) and
src-0005's numbers second. *Cycle 23 note: unchanged; per [28] the next T1 is cycle **35**, twelve
cycles away.*

**[11] — APPLIED AND EXTENDED cycle 20; APPLIED AGAIN AND STRESS-TESTED cycle 23.** Tie-break 3a in
`prompts/t5_select.md` is under-specified, with no deterministic tie-break after 3c. Cycle 20 ruled
for the **strict pairwise** reading. *Cycle 23: **I endorse strict pairwise** — the prompt says "its
dependents", which is pairwise language — and I also **computed the non-pairwise reading and both
select the same issue**, so the ambiguity is live but **not load-bearing at cycle 23**. That is the
first time either reading has been checked against the other rather than assumed. **The closure gap
got worse, though:** the eff-3 tier is now a **four-way** terminal tie (`attribution-confident-wrong-
gap`, `institutional-incident-real-world-impact`, `ioc-extraction-reliability`,
`ttp-attack-mapping-reliability`) on score, 3a, 3b **and** 3c, where cycle 20 saw only a two-way one.
The proposed "3d. longest since new evidence; then fewest total attempts" would **not** close it
either. **A terminal deterministic tie-break — e.g. lexicographic issue id — is needed.** I used
lexicographic ordering above as a display convention and labelled it as such. Same class as [4].*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — and this item's stronger claim was
WRONG; see [17]. T2 is the only task type with standing to split an issue, add an issue, or reconcile
the prompt/validator disagreement. The claim that the loop "never returns to T2" is false; cycle 16
disproved it. *Cycle 23 note: bit again, mildly — [36] identifies work on `attribution-confident-
wrong-gap`'s candidate text that a T3 can do but that a T5 cannot.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is the
upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
footnote-count route is also closed (see [14]). Prof. Christian Dietrich's / Institut für
Internet-Sicherheit's own writeup is the only remaining route known to this agent. OpenReview joins
this category — see [6]. *Cycle 23 note: **this item just became more load-bearing.** `ctr-0002`
weakens `attribution-confident-wrong-gap`'s src-0002 leg, which throws more weight onto the src-0004
ENISA leg — whose AI-causation limb is exactly the one that cannot be strengthened from here.*

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2 PDFs
cannot be opened. **Consequence: "ENISA never disclosed the AI use" is established at landing-page
level and UNVERIFIABLE at document level here.** That leg **cannot strengthen**. **Do not re-spend
budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, AND DEFERRED AGAIN.** The
curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated "slop" reports;
~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from ~15% to under 5%)
is an **open_question on `automated-triage-under-refusal`**. **It is a question, not evidence — no
curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19 and 22 both judged it the highest-value uncollected source in the project. *Cycle 23: that
issue **lost the selection on 3c**, so this waits at least until cycle 27's T5. A T3 may add sources
([29]), so it remains a one-cycle job whenever that issue is finally selected.*

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

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the escape
to T2: `prompts/system.md` specifies `T1→T2`, and the refresh rule makes a T5 landing on a
multiple-of-7 cycle emit a T1, so the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles
14→15→16. Structural finding for the paper: the only task type that can restructure the issue graph
fires when a T5 coincides with a multiple of 7 — under a clean three-cycle loop, **once every 21
cycles**, not every 7.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS exhibiting
the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid citations across 308
papers. No claim in our base repeats the error and **no G3 entry was opened**. Any cycle quoting
src-0011's *counts* should take them from Table 3's columns.

**[19] — FULLY DISCHARGED CYCLE 21; CONSUMED BY CYCLE 22.** src-0007's Table 4 pulled **whole and
verbatim** into `state/knowledge/src-0007.md`. Triage rows: precision (Accepted) **0.2717–0.3982**,
recall (Accepted) **0.9091–1.0000** across both triage tasks and all four models, so
`automated-triage-under-refusal`'s stored "0.27–0.40 vs 0.90–1.00" **holds as stated**. Also:
fine-tuning does not fix the asymmetry and on the Article task worsens precision (GPT-4o 0.3037 →
GPT-4o (FT) 0.2717, recall unchanged 0.9798–1.0000). **RESIDUE, UNRESOLVED AND REPRODUCED:** GPT-4o
(FT) tracks o3-mini to within 0.001 on **all six** Content: Threat Actor rubric rows, identically in
two independent pulls (c15, c21) — as-printed, not a fetch artefact. **Cause unknown; do not guess.
Any claim resting on that column must say it is suspect.**

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014 (c19),
src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy is **narrowed but not closed** — 33.9% is
TABLE II's per-model aggregate, 16.9% → 83.2% is the SALLM-to-repository comparison; different
scopes, not arithmetically reconcilable, so **quote them only with their scopes named**. Gemini's
0.161 → 0.721 was **not** re-checked. **Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are
still body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 for a
specialized agent vs. 0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true
general-purpose peak is **G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1
range roughly 0.20–0.90" against a true span of **0.286–0.882**. Cycle 18 appended a corrective
key_claim to `index.json`; **`src-0006.md` itself is still untouched and still contains the wrong
sentence.** Column split: 8 general (G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC, CB0,
ZYS, LLY, CBS, SPT, DHT). *Cycle 23 note: cycles 22 and 23 both repaired **both** places
(`index.json` **and** the `.md`), so that is now the established pattern. **`src-0006.md` is the only
known source file still carrying an uncorrected sentence** and it is a cheap fix for any cycle
touching that source.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** An unexplained regularity in src-0006's Table 2: eleven
of twenty-eight rows are **strictly monotone decreasing across all eight general-purpose columns in
exactly the printed column order**. Four are in the nine-row F1 subset
`extraction-vs-reasoning-ordinal-axis` depends on. For independent measurements, one row matching a
fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.** Cause unknown;
do not speculate. **Any finding resting on src-0006's Table 2 must carry a robustness check excluding
these rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.**
`task-dependent-reliability-framing`'s supported candidate cites src-0006's "F1/AUC roughly 0.20–0.90"
as evidence that reliability varies sharply by sub-task. Mean between-**model** range within a task
(0.272) and mean between-**task** range within a model (0.263) are equal to within 0.009. **This does
NOT negate the supported claim** — cycles 19 and 22 both tested it as a counterargument and both
concluded it is not one; it qualifies the implication that sub-task is the *privileged* explanatory
variable, which is the child issue's business. A T2 should annotate the parent's candidate rather
than re-scope it. No contradiction entry: both facts hold simultaneously.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–23. `jq` IS INSTALLED AND APPROVED.**
`jq -e . <file>` parses and exits non-zero on malformed JSON; `jq -r '<filter>'` reads structure
without a full-file Read. **Every cycle from 9 to 17 recorded that this agent cannot validate JSON
and must check "by construction". That advice is wrong and it is expensive** — cycle 17 made five
blind edits to a 57 KB JSON file and had its entire `state/` output reverted. **Every JSON edit
should be followed by a `jq -e` check.** The permission layer is **not uniform** — probe once, don't
infer from class. The `Grep` **tool** works on the big JSON files where Bash `grep -n` does not.
*Cycle 23: the cheapest working pattern for an append-only edit to a large JSON file is now
established and was used twice — **`Grep` tool to find the line, `Read` with `offset`/`limit` for a
~15-line window, `Edit`, then `jq -e`.** That reads ~15 lines instead of 36–85 KB.*

**[25] — DISCHARGED CYCLE 21.** `state/knowledge/src-0007.md` now contains the Content: Threat Actor
rubric block in full, verbatim, all six rows and four columns, alongside the whole of Table 4. **The
two caveats travel with it and must keep travelling:** the rubric's **absolute level is
uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a normalisation the paper
never states), so **only within-table contrasts may be cited**; and the GPT-4o (FT) column is suspect
per [19].

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's errors to stdout, but
`logs/cycle-017-transcript.txt` captures the agent's own output only, and the reverted `state/` files
were never committed. Suggested harness fix for a human: tee `python scripts/validate_state.py`
output into `logs/cycle-NNN-validation.txt` before reverting, and `git stash` the rejected `state/`
diff rather than discarding it.

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH.** src-0015's Table 1 has a **`Reward`** column no
cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61, DeepSeek 3.2 **3.45**. **The
model the paper calls best-calibrated earns the lowest reward**, and the two highest-containment
models take the two highest rewards. Bears directly on `automated-triage-under-refusal`'s
`open_questions[0]` — models versus harness. **Caveats:** the fetched material does not state the
reward's composition; n = 40 per model, no CIs; the association is not strictly monotone (DeepSeek
outscores GPT-5.2 at lower containment). It is an observation about an **already-collected** source,
so **no new citation is needed**. Cycle 22 recorded it in that issue's `rationale`, but a rationale is
not the graph. *Cycle 23: still unentered, and now waiting on that issue's next selection — see [15]
and [30].*

**[28] — NEW cycle 20, RE-DERIVED cycles 21, 22 and 23.** The state machine is T1→T2, T2→T3, T3→T4,
T4→T5, T5→T3. **Cycle 23 was a T5, so cycle 24 is a T3, cycle 25 a T4, cycle 26 a T5.**
`collect_refresh_every: 7`; the refresh fires only when a T5 **runs on** a multiple-of-7 cycle (pinned
from git history: cycle 14 T5 → cycle 15 T1 collect). `23 % 7 = 2`, so **cycle 23 did not refresh**;
under a clean loop T5 lands on 26, 29, 32, **35**, and **the next T1 is cycle 35**. A failed-validation
retry shifts the phase by one — that is how the phase reached its current position (cycle 17's T3
failed, retried at 18) — so **re-derive rather than trusting this if a cycle fails**. **Consequence
for a human:** the two highest-value uncollected items ([15] curl/HackerOne, [10] the human-analyst
ATT&CK baseline) both want a T1 and neither gets one for twelve cycles.

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycle 21.** A T3 **MAY** add sources.
`prompts/t3_investigate.md` step 2: "Only web-search for what the knowledge base cannot answer (and if
you fetch something substantial, add it properly as a source per T1 rules — it counts toward the same
`max_new_sources` budget)." Cycle 21 exercised this and added src-0017. **Standing lesson: read the
task's own prompt file, not only the queue entry's description of it.** *Cycle 23: this is the
mechanism the cycle-24 T3 needs — its whole job is to find one CTI-task source.*

**[30] — NEW cycle 20; ITS CYCLE-23 PREDICTION WAS CORRECT AND THE STRUCTURAL PROBLEM IS NOW
DEMONSTRATED TWICE.** *Cycle 23 confirms cycle 22's arithmetic in full: `ioc-extraction-reliability`
took the 3b penalty for its cycle-21 attempt and dropped to effective 3; `consistency-calibration-as-
failure-mode` beat `automated-triage-under-refusal` on 3c.* **So the only issue in the graph never
worked on (`attempts: []`, created cycle 16) has now lost two consecutive selections, to issues
attempted twice and three times respectively.** **"Never attempted" is not a tie-break in
`prompts/t5_select.md`**, and cycle 19's `scores.json` rationale wrongly asserted it was — I did not
adopt that invented rule. **This is a prompt change for a human, not a reading an agent may adopt.**
Note the interaction with [11]: a **non-pairwise** 3a would rank that issue **last** of the three
base-2 candidates rather than second, because it is depended on by nothing — so resolving [11] the
other way would make this problem *worse*, not better. Anyone fixing [11] should fix [30] at the same
time.

**[31] — NEW cycle 21, EXTENDED cycle 22, EXTENDED AGAIN cycle 23: THE EXACT-STRING / VERBATIM CHECK
HAS NOW BEEN RUN ON THREE SOURCES AND ALL THREE FAILED IT IN SOME RESPECT.** (a) **src-0016** (c21):
the stored "verbatim" quotation about 80 of 161 unique-unmatched findings **does not exist on the
page** — it splices a real sentence to a table cell; figures correct, quotation defect; repaired by
appendix. Its collection note claiming no table was present is false; there are four. (b) **src-0003**
(c22): three stored *quotations* passed — the first clean pass — but its stored *numbers* 76/72/86 are
**figure-image-only**; see [32]. (c) **src-0002** (c23): all 25 stored *numbers* passed exactly and
the stored quotation passed — **the cleanest numeric result yet** — but the **interpretation attached
to two of those numbers is contradicted by the paper's own metric definition**; see [35] and
`ctr-0002`. **The defect class is now three-way: spliced quotations, unverifiable numbers, and
unsupported interpretive glosses on correct numbers.** The third is the most dangerous, because
**every check that stops at "is the number right?" passes it** — src-0002's numbers have been right
since cycle 1 and were re-checked at cycle 6. **Standing lesson, upgraded: a G2 must pull the
DEFINITION of the metric, not only its value.** Ask what the column *means*, verbatim, in the same
fetch as the table. Fourteen sources have stored values or quotes that have never faced any of these
three checks.

**[32] — NEW cycle 22. src-0003's THREE BASELINE F1 VALUES ARE FIGURE-IMAGE-ONLY AND NOT
TEXT-VERIFIABLE; REPAIRED BY APPEND.** `src-0003.md` key claim 1 and `index.json` key_claims[1] state
LANCE's 97.6% beats "IoC Searcher + whitelist (76% F1), AlienVault OTX (72% F1), VirusTotal
threshold=1 (86% F1)". On `https://arxiv.org/html/2506.11325v2` the exact strings **`76` and `72` do
not occur at all**, and the only `86%` is "Its lowest score, 86.8% recall on domains …" — **LANCE's
own per-type recall, not VirusTotal's F1**. No table carries baseline numbers; they live only in
**Figure 6**, an image this agent cannot read. **The ordering is textually supported**, so nothing is
falsified — but **cite 76/72/86 as figure-derived and not text-verified, never as reported values.**
Also unverifiable: **`~0.88 F1 with Llama`** — the page says "Gemma and Gemini perform comparably to
GPT, achieving total F1 scores of 0.98 and 0.92, respectively", so **0.92 is Gemini** and **0.98 is
Gemma**. Repaired by appending to both `index.json` and `src-0003.md`. **No contradiction entry** —
no rival claim, and Figure 6 is unreadable, so the values cannot be asserted wrong. *Cycle 23 note:
that judgement still looks right, and `ctr-0002` shows where the line falls — **file when the
source's own legible text conflicts with the stored claim; do not file when the stored claim is
merely unverifiable.***

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.**
src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted candidate
set**, not on free-form extraction. Verbatim: "We assume a total of 1,789 candidate indicators,
extracted using IoC Searcher, a state-of-the-art rule-based tool"; "LANCE labeled over 99% of all
extracted indicators"; Figure 9's caption "… on IoC Classification." **A difference in task format,
not only in scaffolding**, and *stated by the paper*. **Companion finding: src-0003 NEVER STATES ITS
MATCHING RULE**, so the open_question cycle 21 added is **unanswerable from this base**. Both findings
are appended to `index.json` and `src-0003.md`. **A T3 on `ioc-extraction-reliability` should carry
them into `ctr-0001` and the issue's candidates; a T4 has no standing to.**

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE.** **A within-study design holds team, corpus, models and harness constant but does NOT
hold the scoring rule constant.** A cross-sub-task score spread is a task-difficulty fact only if the
sub-tasks are scored comparably. src-0017 shows src-0007's IoC evaluator matches by two-directional
substring containment with a ground truth never stated to be exhaustive; **the scoring rules for
src-0007's ATT&CK and rubric tasks have never been pulled**, and neither have the per-task scoring
definitions behind src-0006's nine F1 rows. **What restores the 4:** read `stage3_ti_drafting`'s TTP
and rubric scorers in the src-0017 repo (`raw.githubusercontent.com` worked at cycle 21) and
src-0006's metric definitions, then state and answer the objection in the issue. **Note the
asymmetry:** the same finding is neutral-to-favourable for `extraction-vs-reasoning-ordinal-axis`,
whose supported claim is *negative*. *Cycle 23 note: **[35] is the same failure mode one level up** —
[34] is "the scoring rule may differ between sub-tasks"; [35] is "the metric definition differs from
what we assumed it was". Both say the same thing about this knowledge base: **numbers were collected
without their definitions.***

**[35] — NEW cycle 23. src-0002's CTI-TAA `Correct` AND `Plausible` COLUMNS ARE NESTED, NOT DISJOINT;
`ctr-0002` OPENED; REPAIRED BY APPEND.** Section 4.2 verbatim: "we compute two types of accuracy:
Correct Accuracy, which is the fraction of correct answers, and Plausible Accuracy, which is the
fraction of correct and plausible answers combined." **Plausible ⊇ Correct**, so the stored claim
that the plausible rate "is far higher than" the correct rate is **true by construction** and is not
a finding. Further, "plausible" is defined as the **underdetermined-input** case ("when the threat
report lacks sufficient details to pinpoint the answer, but the LLM provides a plausible or related
threat actor within a similar group") and **hallucination lives in the separate `incorrect`
category**. The string `plausible-sounding` **does not occur in the paper**. **Derived replacements,
not printed in the paper and to be labelled as derived wherever used:** plausible-but-not-correct
share = 34 / 18 / 36 / 28 / 8 pp; the paper's own incorrect (hallucination-inclusive) rate =
`100 − Plausible Accuracy` = **14% / 38% / 26% / 20% / 64%** for GPT-4-turbo / GPT-3.5-turbo /
Gemini-1.5 / LLAMA3-70B / LLAMA3-8B. **All 25 stored numbers are exact** and the source's own
"treat as approximate" limitation is discharged. Repaired by appending three `key_claims` to
`index.json` and an appendix to `src-0002.md`; nothing removed or rewritten.

**[36] — NEW cycle 23, FOR A T3 AND THEN A T4; A T5 HAS NO STANDING.** `ctr-0002`'s resolution path,
in order: **(i)** rewrite `attribution-confident-wrong-gap`'s primary candidate to cite the derived
incorrect-bucket rates (14–64%) with the derivation stated, or explicitly retire the 86-vs-52
framing; **(ii)** decide and record which of two readings holds — **(a)** the leg survives with a
different number, since a 14–64% misattribution rate on 50 real reports is a real confident-wrong
finding, or **(b)** the leg is weaker than scored, because what made it compelling was the *size* of
the 86-vs-52 gap, which throws more weight onto the src-0004 ENISA leg that [13] says cannot be
strengthened; **(iii)** check whether src-0002's **other two** key_claims — which feed
`ttp-attack-mapping-reliability` and `task-dependent-reliability-framing` — carry any similar
unstated interpretive gloss. Both re-verified **numerically** clean at cycle 23, but **neither was
checked for interpretation**, and CTI-ATE's Macro-F1 in particular has no stated matching rule in
anything this base has pulled — the same gap as [34]. **Then** a T4 may rescore. Until `ctr-0002` is
resolved, that issue is **capped at 3** by the G3 ceiling — see [4] for why the ceiling, not
subtraction.
