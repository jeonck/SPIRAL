# Cycle 018 — T3 Investigate (attempt 2 of the same queue entry)

Target issue: **`extraction-vs-reasoning-ordinal-axis`** (created cycle 16). Queue entry
`cycle_created: 16`, `attempt_count: 1` — this is the **re-run of cycle 17's T3**, which produced
substantive work, failed the validator, and had every `state/` edit reverted by the orchestrator.
`logs/cycle-017.md` survived the revert and is the only record of that work.

## Task performed

Two jobs this cycle, and they are worth separating:

1. **Recover cycle 17's lost work — but re-derive it rather than transcribe it.** Cycle 17's
   findings rested on a whole-table pull of src-0006's Table 2 that no longer exists in `state/`.
   Copying its arithmetic on trust would have made this cycle's `supported` candidate rest on an
   unreproduced fetch. I re-pulled the table and recomputed every mean, range and crossover from
   the raw cells before landing anything.
2. **Find out why the cycle failed, since a third failure escapes the queue entry entirely**
   (`max_task_attempts: 3`, and `run_cycle.sh` then abandons the T3 and jumps to a T4).

### The process finding, and it is the most useful thing in this cycle: `jq` works

Every log from cycle 9 onward records that this agent cannot validate JSON — `python3` is on
`PATH` but the permission layer refuses every invocation, so JSON has been checked "by
construction" for ten cycles. **That is wrong. `jq` is installed and is approved by the
permission layer.** `jq -e . state/issues/graph.json` returns cleanly and exits non-zero on a
parse error.

This matters because cycle 17 edited a 57 KB JSON file five times with no way to check the
result, and the single most likely cause of its validation failure is a JSON defect in
`graph.json` or in the `next_task.json` it wrote whole (a long instruction string with embedded
quoting). **I cannot confirm that** — the reverted file is gone, uncommitted, and
`run_cycle.sh` does not persist the validator's stderr. I am recording the hypothesis as a
hypothesis. What I can say is that every JSON file I touched this cycle was verified with `jq`
after every edit, and the whole class of failure is now cheaply avoidable. Carry-forward **[24]**.

### Re-derivation: src-0006's Table 2, pulled again and recomputed from raw cells

Nine rows of src-0006's Table 2 report **F1**, over **one corpus** and **one 15-model set**.
That is the commensurable cross-sub-task measurement this issue's own standard demanded and that
cycle 16 believed did not exist. Column header row, verbatim as printed:

`Detailed CTI Task | Metric | G5 | Go4 | CLD | GEM | LL70 | MIX | QWN | GRK | FSC | CB0 | ZYS | LLY | CBS | SPT | DHT`

The nine F1 rows, verbatim, cell for cell:

| task | G5 | Go4 | CLD | GEM | LL70 | MIX | QWN | GRK | FSC | CB0 | ZYS | LLY | CBS | SPT | DHT |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| IOC Normalization | .721 | .707 | .682 | .661 | .642 | .623 | .609 | .593 | .602 | .589 | .678 | .689 | .684 | .678 | .683 |
| Affected Systems | .822 | .801 | .757 | .613 | .882 | .663 | .747 | .819 | .432 | .418 | .553 | .566 | .562 | .554 | .559 |
| Attack Infrastructure | .863 | .741 | .614 | .578 | .853 | .628 | .616 | .493 | .507 | .492 | .612 | .625 | .618 | .611 | .616 |
| Malware Family Mapping | .681 | .659 | .635 | .602 | .584 | .567 | .551 | .529 | .541 | .526 | .639 | .652 | .646 | .641 | .648 |
| TTP Extraction | .751 | .738 | .724 | .703 | .478 | .669 | .654 | .642 | .654 | .639 | .724 | .537 | .731 | .726 | .732 |
| Infrastructure Reuse | .677 | .656 | .636 | .609 | .591 | .574 | .556 | .534 | .548 | .531 | .688 | .528 | .692 | .754 | .603 |
| Relation Graph Building | .642 | .628 | .611 | .595 | .579 | .562 | .547 | .533 | .544 | .528 | .675 | .683 | .678 | .673 | .679 |
| False Flag Detection | .679 | .526 | .501 | .486 | .672 | .459 | .547 | .436 | .444 | .431 | .574 | .286 | .462 | .576 | .582 |
| Patch Recommendation | .702 | .679 | .659 | .636 | .718 | .601 | .583 | .671 | .582 | .567 | .632 | .442 | .629 | .641 | .446 |

**Result 4 (cycle 17) — CONFIRMED, with two 0.001 rounding differences.** Mean F1 across all 15
models:

| stage | task | cycle 18 | cycle 17 |
|---|---|---|---|
| Contextualization ("extraction") | IOC Normalization | 0.656 | 0.656 |
| | Affected Systems | 0.650 | 0.650 |
| | Attack Infrastructure | 0.631 | 0.631 |
| | Malware Family Mapping | 0.607 | 0.607 |
| | **stage mean** | **0.636** | 0.636 |
| Attribution ("reasoning") | **TTP Extraction** | **0.673** | 0.674 |
| | Infrastructure Reuse | 0.612 | 0.612 |
| | Relation Graph Building | 0.610 | 0.611 |
| | False Flag Detection | 0.511 | 0.511 |
| | **stage mean** | **0.602** | 0.602 |
| Mitigation | Patch Recommendation | 0.613 | 0.613 |

Stage gap **0.034 F1**. The best task in the whole commensurable subset is **TTP Extraction
(0.673), an Attribution-stage task**, above every Contextualization task including IOC
Normalization. The ordering is locally inverted at its strongest predicted point. Dropping the
four monotone rows (below) leaves 0.641 against 0.592, gap 0.049 — same direction, same best
task. (Cycle 17 reported 0.593 and 0.048; the difference is its 0.674.)

**Result 5 — CONFIRMED exactly.** Mean between-model range within a task **0.272**; mean
between-task range within a model **0.263**; equal to within **0.009**. Per-task between-model
ranges: Affected Systems 0.464, False Flag Detection 0.393, Attack Infrastructure 0.371, Patch
Recommendation 0.276, TTP Extraction 0.273, Infrastructure Reuse 0.226, Malware Family Mapping
0.155, Relation Graph Building 0.155, IOC Normalization 0.132. Per-model between-task ranges run
0.171 (ZYS) to 0.404 (LL70) and 0.403 (LLY). **Task identity is not the dominant explanatory
variable.**

**Results 1–3 — arithmetic re-done from src-0007's stored Table 4, all confirmed.** Solving
`2PR/(P+R)` for the unreported IoC recall at which each model's IoC F1 falls to its own derived
TTP F1:

| model | IoC precision | derived TTP F1 | crossover recall | actual TTP recall |
|---|---|---|---|---|
| GPT-4o | 0.8240 | 0.2502 | 0.1475 | 0.2270 |
| o3-mini | 0.8503 | 0.2337 | 0.1354 | 0.1759 |
| GPT-4o (FT) | 0.8846 | 0.2082 | 0.1180 | 0.1846 |
| GPT-4o-mini (FT) | 0.6944 | 0.1572 | 0.0887 | 0.1414 |

Every crossover sits **below** that model's own TTP recall, by a factor of 1.3–1.6. The
precision-only omission is a real reporting defect but is **not** an explanation of the gap.
Conversely the rubric rung cannot be rescued: GPT-4o's 1.140/5 is 0.228 (`x/5`) or 0.035
(`(x−1)/4`) against a TTP F1 of 0.2502, while o3-mini's 2.968/5 is 0.594 or 0.492 against 0.2337
— so **the two models order the middle and third rungs oppositely**, under both normalisations,
inside one table.

**Provenance caveat I want on the record.** The rubric values 1.140 and 2.968 are *not* in
`state/knowledge/src-0007.md`, which notes those rows only as existing. They trace to cycle 15's
verbatim whole-table pull (`logs/cycle-015.md` line 157) and were re-checked at cycle 16. I cite
src-0007 for them, which is correct, but a source file that does not contain a number two issues
now depend on is a real gap — carry-forward **[25]**.

**Data-quality flag, independently reproduced.** Four of the nine F1 rows (IOC Normalization,
Malware Family Mapping, Relation Graph Building, Infrastructure Reuse) are strictly monotone
decreasing across all eight general-purpose columns in exactly the printed order. Cycle 17 found
eleven such rows across all 28 and re-pulled ten from a second URL form; cycle 18's pull returns
them identically again. **Three pulls, two URL forms, same cells: it is as-printed in the paper,
not a fetch artefact.** Cause unknown; I am not guessing at one. The headline is deliberately
robust to it.

### No new sources, no new search

The queue entry authorised a search for a second commensurable multi-sub-task study. Cycle 17
already ran two such searches and recorded both as empty with the exact query strings, plus three
collection leads (SEvenLLM `arxiv.org/pdf/2405.03446`, AthenaBench, CTIArena). **Re-running them
would have burned budget to reproduce a documented dead end.** I spent the budget on re-deriving
the load-bearing table instead, which is the thing that actually had to be re-established.
**Sources added: 0 of 5.**

## Retrospection

**G2 target: `src-0013`** (`https://arxiv.org/abs/2606.31159`), the queue entry's recommended
target and **never verified since collection at cycle 15**. It was two cycles overdue
(carry-forward [20]) and it is load-bearing: cycle 16 cited its ΔECE figures inside a
**supported** candidate on `task-dependent-reliability-framing`.

**Method**, per the standing whole-artefact rule: I asked for every occurrence of the specific
figures with the sentence or table row containing each, with an explicit instruction to write
"ABSENT" rather than infer.

**First fetch failed usefully.** `https://arxiv.org/abs/2606.31159` — the URL stored in
`index.json` — returned "This page is only an abstract page. The full tables with specific
numerical results are unavailable here" and **ABSENT** for every figure. Had I accepted that, I
would have recorded a spurious G2 failure. The HTML render
(`https://arxiv.org/html/2606.31159v1`) returned the tables.

**Result: PASS on the load-bearing figures; the internal discrepancy is NARROWED, not closed.**

| stored claim | re-fetched 2026-07-29 |
|---|---|
| ΔECE functional-vs-security −0.15/−0.16 GPT-4o-mini | TABLE III, Δ ranges −0.15 to −0.16 — **exact** |
| ΔECE −0.26/−0.27 Gemini-2.0-Flash | Δ ranges −0.26 to −0.27 — **exact** |
| ΔECE −0.52/−0.53 Qwen3-Coder-Next | Δ ranges −0.52 to −0.53 — **exact** |
| GPT-4o-mini ECE 0.456–0.481, Brier 0.37–0.39 | TABLE I, ECE 0.46–0.48, Brier 0.37–0.39 — **consistent** |
| Gemini ECE 0.247–0.263, Brier 0.26 | ECE 0.25–0.26, Brier 0.26 — **consistent** |
| Qwen ECE 0.408–0.421, Brier 0.36–0.38 | ECE 0.41–0.42, Brier 0.36–0.38 — **consistent** |
| False Trust GPT-4o-mini 33.9%, Gemini 17.5%, Qwen 38.3% | TABLE II: 33.9% [31.8, 35.9], 17.5% [15.8, 19.2], 38.3% [36.2, 40.4] — **exact, with CIs newly recovered** |
| ECE 0.411 → 0.697, ΔECE +0.286 (repository-level) | verbatim — **exact** |

**On the discrepancy that cycle 15 flagged and forbade quoting.** `src-0013.md` records that
False Trust for GPT-4o-mini appears as **33.9%** in one place and as rising **"from 16.9% to
83.2%"** in another. The tables now explain most of it: 33.9% is TABLE II's per-model aggregate
(and TABLE I shows 33.90 at T=0.40 under verbalized confidence, in a band 33.00–35.10 across
temperatures), while 16.9% → 83.2% is the **SALLM-to-repository-level** comparison in the same
sentence as ΔECE +0.286. They are different scopes, not contradictory readings of one quantity.
**But they are still not arithmetically reconciled**: 33.9% is not recoverable from 16.9% and
83.2% by any aggregation the fetched text states. So the prohibition on quoting the two together
**stands, in weakened form** — they may now be quoted with their scopes named, never as two
values of the same measurement. Carry-forward [20] is **half discharged**: the ECE/Brier/ΔECE
half is closed; the FT half is narrowed.

**Not re-checked, and I am flagging it rather than letting it pass:** Gemini's repository-level
0.161 → 0.721 (Δ +0.560), which is in the same stored key claim. I did not ask for it and the
fetch did not volunteer it.

**No contradiction entry opened this cycle**, and two candidates were considered:

- **The src-0006 label error** (`0.688` described as a general model when ZYS is
  cyber-specialised, now confirmed by a second cycle). G3 is for *two supported claims in
  conflict*; this is one of our own files misdescribing its source. Precedent [5], [18], and
  cycle 17. **But I did not merely log it this time** — see "Changes made".
- **Result 5 against the parent issue's supported task-dependence claim.** "Reliability varies
  sharply by sub-task" and "model identity explains as much as sub-task does" are both true
  simultaneously; the second qualifies the first without negating it. Carry-forward **[23]**, for
  cycle 23's T2, since a T3 cannot rewrite another issue's questions.

## Changes made

Two files. Both verified with `jq -e` after every edit; both pure additions or in-place status
changes with original text preserved.

**`state/issues/graph.json`** — confined to `extraction-vs-reasoning-ordinal-axis`:

1. **`open_questions` 4 → 7.** Three new entries lead: the commensurable-measurement finding, the
   model-identity-versus-task-identity quantification, and the src-0006 data-quality caveat. **All
   four inherited entries are retained with their original text intact**, each prefixed with a
   cycle-18 status marker (`ANSWERED IN PART`, `CYCLE-18 NOTE`, `SUPERSEDED`, `ANSWERED`) and an
   `ORIGINAL TEXT FOLLOWS.` boundary, so nothing was deleted.
2. **Cycle-2 candidate: `proposed` → `rejected`**, reason appended. Not one word of the original
   or of the cycle-16 annotation was altered; the provenance header stands. It is rejected **as an
   ordinal claim only** — task-dependence itself is supported in the parent issue.
3. **New `supported` candidate**, evidence `src-0006` + `src-0007`, carrying all three caveats
   including the explicit statement that it is **silent on the generation rung**, which the
   commensurable subset does not cover.
4. **New `proposed` candidate**, evidence `src-0006` + `src-0007` + `src-0014`: model and corpus
   identity as replacement explanatory variables, with three objections to itself.
5. **`attempts`: `[]` → `[17, 18]`.** Cycle 17's attempt happened and cost a cycle; recording only
   18 would hide that from the T5 attempt penalty.

**`state/knowledge/index.json`** — one **appended** key_claim on `src-0006` (3 → 4). This is the
part of the cycle that departs from cycle 17, so the reasoning should be explicit:

- The stored claim "Infrastructure Reuse peaks at F1 0.754 for a specialized agent vs. 0.688 for
  a general model" is **false as written**, now verified so by two cycles from two URL forms, and
  src-0006 is cited by three issues.
- Cycle 17 left it uncorrected out of a stated fear that touching knowledge files would trigger a
  validator revert. Having read `scripts/validate_state.py`: the append-only check compares
  *previous* key_claims against current and errors **only on removal** (lines 105–107); the URL
  check runs **only for sources absent from the previous index** (line 125). Appending a claim to
  an existing source is therefore explicitly permitted and triggers no network check.
- I appended rather than edited. The wrong sentence remains in place, and the new claim states
  what is wrong with it, the printed column order, the true general-purpose peak (G5 at 0.677),
  the true F1 span (0.286–0.882), and the monotone-row flag. **`state/knowledge/src-0006.md` was
  not touched.**

**No score was set** (T3 has no standing). **No source was added** (0 of 5). **No contradiction
entry was opened**, with reasons above.

## Next task rationale

**T4 (Assess)**, per the state machine `T3→T4`. Cycle 19.

Three things make it consequential, and the queue entry says all three:

- **The graph has 8 issues and `scores.json` has 6 entries, `last_assessed_cycle` 13.** Both
  cycle-16 issues have never been scored. `t4_assess.md` step 1 says score *every* issue.
  Carry-forward **[B]**, unchanged and now six cycles old.
- **Apply the G3 gate as a CEILING, not a subtraction** (carry-forward **[4]**/**[A]**). Only
  `ioc-extraction-reliability` has an open contradiction (`ctr-0001`), so the ceiling of 3 binds
  there and nowhere else.
- **This issue arrives materially changed**: a `rejected` candidate, a `supported` candidate and a
  `proposed` candidate where it had one `proposed`, and its own "should not rise above proposed"
  instruction explicitly discharged. A T4 should score the **evidential state, not the polarity of
  the conclusion** — a supported negative answer is a resolved issue. I am flagging that because
  the rubric is definitional and "a supported resolution exists" is the definition that matters.

## Budget

- **Web fetches: 4.** Two failed usefully (`arxiv.org/html/2509.23573` — the summariser refused to
  transcribe cells, which is itself a finding, since cycle 17 succeeded on that same URL;
  `arxiv.org/abs/2606.31159` — abstract-only, no tables). Two succeeded
  (`arxiv.org/html/2509.23573v5`, `arxiv.org/html/2606.31159v1`). **Lesson worth keeping: when a
  fetch declines to transcribe a table, retry the versioned `/html/NNNN vN` form before concluding
  anything.**
- **Web searches: 0**, deliberately — cycle 17 recorded both relevant searches as empty with
  verbatim queries.
- **Sources added: 0 of 5.**
- **Bash: 6**, all `jq`/`ls`/`git`. Two were probes that established `python3` is still blocked and
  **`jq` is not** — the highest-value six calls in several cycles.
- **File reads: 9.** Edits: 5 to `graph.json`, 1 to `index.json`, plus this log, `next_task.json`
  and `last_completed_task.txt`.
- **Assistant turns: ~14.**
- **Dead ends: 0 new.** Cycle 17's two empty searches are inherited, not re-run.

---

## Carry-forward items

All items from `logs/cycle-017.md` are reproduced **including those I could not act on**, with
cycle-18 updates, plus two new. Discharged items stay marked rather than deleted. Four handoffs
have now lost or corrupted state (cycle 11 dropped [8] and [9]; cycle 14 found [12]'s central
claim factually wrong; **cycle 17's entire `state/` output was reverted**), so this section is
load-bearing.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2 candidate moved
verbatim. *Cycle 18 note: the split is vindicated substantively — the ordinal half now carries a
rejected candidate, a supported candidate and a proposed replacement hypothesis, after nine cycles
stuck inside a conflated issue.*

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`.

**[3] — DISCHARGED cycle 16.** New issue on triage precision, `automated-triage-under-refusal`.

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED.** The G3 gate is specified three ways:
`prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35 comment (**subtraction**),
`scripts/validate_state.py` lines 144–156 (**ceiling**, = 3 under current config). The enforced
reading is in the minority. Cycle 16 **ruled for the CEILING** — the rubric is definitional, not
arithmetic, so subtracting 2 from an honest 2 yields a score whose own definition ("no candidate
resolutions") is false of the issue. Replacement text for both artefacts is in `logs/cycle-016.md`
"Item 3". **NOT APPLIED** — `prompts/`, `config.yml` and `scripts/` are outside this agent's
output surface. **Until a human applies it, T4s must keep applying the ceiling**, consistent with
cycles 10, 11, 13. The divergence is silent if unfixed.

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6, the
paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no contradiction
opened. Needs a PDF-level check, which [14] says is blocked. Its per-phase percentages exist ONLY
as pie charts (Figure 2); its Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%, Gemini
4.8%, Grok 0, Cohere 0) are verified exact and their "approximate" caveat can be lifted.

**[6]** Unfinished search directions, open since cycle 9: citation-graph sweep of arXiv 2506.11325;
third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal baselines; the paywalled
eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no preprint located).
**Forward-citation sweeps have FAILED on two different arXiv ids — unavailable infrastructure, not
an unsearched direction.** Cycle 17's three topical leads stand and are **unclaimed**: **SEvenLLM**
(`arxiv.org/pdf/2405.03446`, 28 CTI tasks split 13 understanding / 15 generation — directly on this
issue's axis), **AthenaBench** ("unified scoring", no URL captured), **CTIArena** (no URL
captured). Leads, NOT sources; none is in `index.json` and none may be cited.

**[7]** `ctr-0001` RESOLUTION PATH: recover recall/F1 from src-0007's released code
(GitHub/HuggingFace per its abstract), and/or find a source running an unscaffolded LLM against
PRISM or a LANCE-style pipeline against CyberThreat-Eval. Cycle 15's full Table 4 pull confirmed
there is no recall or F1 row for IoC Extraction anywhere in that table. *Cycle 18 note: cycle 17's
crossover result is re-confirmed and bears on ctr-0001 — an IoC recall low enough to reconcile
src-0007 with src-0003 by metric artefact alone would have to be 0.09–0.15, which is implausible,
so the metric confound is weaker than the system confound and the code release remains the route.*

**[8] — UPDATED cycle 18.** G2 RE-VERIFICATION COVERAGE: src-0004 (c4, c12), src-0003 (c5),
src-0002 (c6), src-0001 (c7), src-0006 (c8; c17 PARTIAL FAIL, see [21]; re-pulled c18 as issue
work), src-0005 (c9 substance-only, c11 verbatim), src-0008 (c10), src-0012 (c13), src-0011 (c14),
src-0007 (c15 — PASSED), src-0009 and src-0010 (c16 — PASSED), **src-0013 (c18 — PASSED, see
Retrospection)**. **Never verified: src-0014, src-0015, src-0016.** src-0014 is now the priority:
it is cited in this cycle's new `proposed` candidate, and [20] records that its F1/coverage values
were never pulled as tables.

**[9] — CORRECTED AND EXPANDED cycle 18, read this before spending budget.** `python3` is present
at `/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` but the **permission layer** blocks every
invocation ("This command requires approval"); compound/piped commands are rejected if any segment
is unapproved. **No PDF text extraction exists** — poppler-utils, `mutool`, `gs`, `qpdf` all
absent; `WebFetch` returns PDF bytes undecoded. **BUT SEE [24]: `jq` IS AVAILABLE AND APPROVED.**
The ten-cycle-old advice to "validate JSON by construction" is obsolete.

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Every claim it contributes is
abstract-level and directional, and it is one of the sources holding
`ttp-attack-mapping-reliability` at 3. Pulling CyberSOCEval's per-model/per-task scores remains the
cheapest thing that could move that issue. **Oldest un-actioned collection task in the project
(open since cycle 1); T1 work.** *Cycle 18 note: still raised — src-0005 is cited in the cycle-2
candidate that is now REJECTED, and it is the only source in that citation list whose contribution
was never numeric.*

**[11]** TIE-BREAK 3a IN `prompts/t5_select.md` IS UNDER-SPECIFIED, with no deterministic
tie-break after 3c. Suggested fix for a cycle with standing: add "3d. longest time since the issue
last received new evidence; then fewest total attempts" — **note that ordering**, established by
cycle 14. Cycles 11, 14, 16 declined to edit the prompt. Same class as [4].

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger claim
was WRONG; see [17].** T2 is the only task type with standing to split an issue, add an issue, or
reconcile the prompt/validator disagreement. The claim that the loop "never returns to T2" is
false; cycle 16 disproved it.

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is
the upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
footnote-count route is also closed (see [14]). **Prof. Christian Dietrich's / Institut für
Internet-Sicherheit's own writeup is the only remaining route known to this agent.**

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened. **Consequence: "ENISA never disclosed the AI use" is established at
landing-page level and UNVERIFIABLE at document level here.**
`institutional-incident-real-world-impact` was raised to 3 partly on this, so a T4 should treat
the document-level claim as unestablished rather than pending. **Do not re-spend budget on it.**

**[15] — DISCHARGED cycle 16 by merge.** The curl/HackerOne case (bug bounty ended 31 January
2026 after a flood of AI-generated "slop" reports; ~20% of submissions AI slop by mid-2025;
confirmed-vulnerability rate falling from ~15% to under 5%) is an **open_question on
`automated-triage-under-refusal`**. **It is a question, not evidence — no curl source exists in
`index.json` and G1 forbids inventing one.** A future T1 should collect it.

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question any cycle has found. Verbatim from `https://gptzero.me/investigations/ey`: an
"automated pipeline to search for vibe citations by finding and scanning public reports from major
consulting firms", releasing findings "one report at a time", having already investigated "a
government publication, two different Deloitte reports, and prestigious machine learning /
artificial intelligence conferences like NeurIPS and ICLR". A T1 should chase
`gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor reporting on its own
product's value, no *rate* published, and the scorecard widget renders as "0 of N" to automated
fetch — read body text, not the widget. **Still the top T1 lead for cycle 22.**

**[17]** THE REFRESH RULE IS THE ESCAPE TO T2: `prompts/system.md` specifies `T1→T2`, and the
refresh rule makes every seventh cycle's T5 emit a T1, so the chain is **T5 → T1 → T2**. Confirmed
end-to-end by cycles 14→15→16. Structural finding for the paper: the only task type that can
restructure the issue graph fires at most once every seven cycles, and only as a side effect of a
rule whose stated purpose is refreshing evidence. **Next T2 due cycle 23** — *note that cycle 17's
revert did not consume a T2 slot, but it did consume a cycle, so the schedule has slipped by one
relative to cycle 16's projections.*

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly. Body text says "NeurIPS
exhibiting the highest absolute count (391 papers)" while Table 3 gives NeurIPS 391 invalid
citations across 308 papers. No claim in our base repeats the error and **no G3 entry was
opened**. Any cycle quoting src-0011's *counts* should take them from Table 3's columns.

**[19] — DISCHARGED cycle 16.** src-0007's Table 4 Content: Threat Actor rubric block attached to
`attribution-confident-wrong-gap` as a **`proposed`** candidate. **The FT-column anomaly is
preserved as a re-pull instruction**: GPT-4o (FT) 3.964/3.655/2.967 tracks o3-mini
3.964/3.656/2.968 to within 0.001 on all three rows. Still uncaptured from that table: the Deep
Search URLs-Extraction block (GPT-4o 6.22 avg URLs vs GPT-4o-mini-FT 1.25) and the full Triage
pass-rate/bias rows — the latter directly relevant to `automated-triage-under-refusal`.

**[20] — HALF DISCHARGED cycle 18.** Of the four sources added at cycle 15, only src-0015 had a
table pulled whole at collection. **src-0013 is now done** (cycle 18 G2): its ECE, Brier, ΔECE and
False Trust values are confirmed at table level and are no longer single-pass, and TABLE II's
confidence intervals were recovered. The FT discrepancy is **narrowed but not closed** — 33.9% is
TABLE II's per-model aggregate, 16.9% → 83.2% is the SALLM-to-repository comparison; different
scopes, but not arithmetically reconcilable from the fetched text, so **quote them only with their
scopes named, never as two values of one measurement**. Gemini's 0.161 → 0.721 (Δ +0.560) was
**not** re-checked. **src-0014 remains outstanding**: its F1/coverage values are still single-pass
quoted body sentences, and it is now cited in a `proposed` candidate on this issue.

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18.** `src-0006.md` and
`index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 for a specialized agent vs.
0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is
**G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90"
against a true span of **0.286–0.882**. **Cycle 18 APPENDED a corrective key_claim to src-0006's
`index.json` entry** (permitted — the validator's append-only check errors only on *removal*, and
the URL check runs only for sources new to the index). `src-0006.md` itself is still untouched and
still contains the wrong sentence; repairing it needs a cycle willing to append a correction
section to a source file, which no cycle has yet done. **The column split is 8 general (G5, Go4,
CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC, CB0, ZYS, LLY, CBS, SPT, DHT)**, established from
body text at cycle 17 and corroborated at cycle 18 by the paper's own model examples (GPT-5,
Claude-Sonnet-4, Gemini-2.5 general; SecGPT, DeepHat specialised).

**[22] — REPRODUCED A THIRD TIME cycle 18.** AN UNEXPLAINED REGULARITY IN src-0006's TABLE 2:
eleven of twenty-eight rows are **strictly monotone decreasing across all eight general-purpose
columns in exactly the printed column order**, with smooth decrements. Four of them are in the
nine-row F1 subset this issue now depends on (IOC Normalization, Malware Family Mapping, Relation
Graph Building, Infrastructure Reuse). For independent measurements one row matching a fixed
eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact** — three pulls
across two URL forms return identical cells. Cause unknown; do not speculate. **Any finding
resting on src-0006's Table 2 must carry a robustness check excluding these rows**; this cycle's
does (0.641 vs 0.592, gap 0.049).

**[23] — STANDS, for cycle 23's T2.** `task-dependent-reliability-framing`'s supported candidate
cites src-0006's "F1/AUC roughly 0.20–0.90" as evidence that reliability varies sharply by
sub-task. Mean between-**model** range within a task (0.272) and mean between-**task** range
within a model (0.263) are equal to within 0.009. **This does NOT negate the supported claim** —
sub-task variation is real — but it qualifies the implication that sub-task is the *privileged*
explanatory variable. No contradiction entry: both facts hold simultaneously. A T3 has no standing
to rewrite another issue's open_questions.

**[24] — NEW cycle 18, and it retires ten cycles of accumulated misinformation. `jq` IS INSTALLED
AND IS APPROVED BY THE PERMISSION LAYER.** `jq -e . <file> > /dev/null` parses and exits non-zero
on malformed JSON; `jq -r '<filter>'` reads structure without a full-file Read. **Every cycle from
9 onward has recorded that this agent cannot validate JSON and must check "by construction". That
advice is wrong and it is expensive** — cycle 17 made five edits to a 57 KB JSON file blind, and
its entire `state/` output was reverted. **Every JSON edit from now on should be followed by a
`jq -e` check.** Note the permission layer is not uniform: `grep -n` was refused this cycle while
`jq`, `ls` and `git` were approved, so probe a command once rather than assuming from the class.

**[25] — NEW cycle 18.** `state/knowledge/src-0007.md` DOES NOT CONTAIN THE RUBRIC VALUES TWO
ISSUES NOW DEPEND ON. Its Table 4 reproduction stops before the Content: Threat Actor rubric block
and records those rows only as "existing, not summarised". The values (GPT-4o 1.547/1.528/**1.140**,
o3-mini 3.964/3.656/**2.968**) live only in `logs/cycle-015.md` line 157 and in issue prose. They
are correctly attributed to src-0007 and were double-checked at cycle 16, so this is not a G1
violation — but a source file that omits numbers its dependents rely on is a real gap, and it is
the same shape of defect as [21]. A cycle with standing should append them to `src-0007.md`, or a
T1 should re-pull that block.

**[26] — NEW cycle 18, and it is a question about the harness, not the research.** **Why cycle 17
failed validation is unknown and unrecoverable.** `run_cycle.sh` prints the validator's errors to
stdout during the run, but the transcript captured in `logs/cycle-017-transcript.txt` is the
agent's own output only, and the reverted `state/` files were never committed. The most likely
cause is malformed JSON in `graph.json` or in the whole-file `next_task.json` write — the class
[24] now makes cheaply avoidable — but **no cycle can confirm it**. Suggested harness fix for a
human: have `run_cycle.sh` tee `python scripts/validate_state.py` output into
`logs/cycle-NNN-validation.txt` before reverting, and `git stash` the rejected `state/` diff rather
than discarding it. Without that, a failed cycle destroys the evidence needed to stop it recurring,
and `max_task_attempts: 3` means the third such failure abandons the task outright.

**[A] — PASS-THROUGH for the T4.** See [4]: apply the G3 gate as a **CEILING** (max score
`scale_max − g3_contradiction_demotion` = 3 while a contradiction is open), not a subtraction, and
state in the rationale both the ceiling and whether it bound. Only `ioc-extraction-reliability`
has an open contradiction (`ctr-0001`), so it binds there and nowhere else.

**[B] — PASS-THROUGH for the T4, and it is the most important one, now six cycles old.** **The
graph has 8 issues; `scores.json` has 6 entries with `last_assessed_cycle` 13.**
`extraction-vs-reasoning-ordinal-axis` and `automated-triage-under-refusal` (both created cycle 16)
have **never been scored at all**. `t4_assess.md` step 1 says score **every** issue in the graph,
not just recently touched ones.
