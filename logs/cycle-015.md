# Cycle 015 — T1 Collect

## Task performed

**T1 (Collect)**, targeting `consistency-calibration-as-failure-mode`, per
`state/queue/next_task.json` written by cycle 14. This was the first firing of the
refresh rule in the project's history (`collect_refresh_every: 7`, 14 % 7 == 0).

**The problem I was sent to solve, restated:** the target issue has been scored 2 since
cycle 3, and the cause is arithmetic, not epistemic. Both of its `candidate_resolutions`
cite `src-0001` and nothing else — the cycle-3 candidate merely sharpens the cycle-2 one
using the same paper — and `prompts/t4_assess.md` scores single-source support as a 2 by
definition. Cycle 7's G2 already re-verified src-0001 thoroughly (model identities, the
350-report set, the 10-re-prompt bootstrapped-CI method, all ten Table 6 gpt4o ECE/Brier
values), so verification quality was never the blocker. The issue could not leave 2 until
a genuinely independent source measuring consistency and/or calibration existed. My job
was to find one.

**Result: four accepted, from four unrelated teams.** Ceiling was 5; I stopped at 4 not
to pad. Every one measures at least one of the four qualifying axes named in the queue
entry (repeat-query consistency, confidence calibration via ECE/Brier, abstention /
selective prediction, uncertainty quantification) on a security task.

| id | source | axis it measures | provenance strength |
|---|---|---|---|
| src-0013 | *An Empirical Study of Security Calibration in LLMs for Code* (arXiv 2606.31159) | **ECE + Brier**, False Trust | strongest — ICSME 2026 Research Track, peer reviewed |
| src-0014 | *PromptAudit* (arXiv 2605.24171) | prompt-sensitivity instability, **abstention/coverage** | v1 preprint, 4 authors, UCF |
| src-0015 | *OpenSec* (arXiv 2601.21083) | **under-refusal / evidence-gating** in IR agents | weakest — single author, cs.AI, n=40 episodes |
| src-0016 | *Snyk VulnBench JS 1.0* (Snyk blog, 29 Jun 2026) | **repeat-identical-query stability**, src-0001's own method | vendor report, direct commercial interest |

**Why these four and not five.** `src-0016` and `src-0014` between them cover the two
distinct instability axes (same-input repetition vs prompt variation) that are easy to
conflate; `src-0013` is the only one carrying ECE/Brier; `src-0015` is the only one on an
operational security workflow and the only one testing the current model generation. A
fifth would have duplicated an axis. Several plausible candidates were seen in search
results and **not** fetched or added for that reason — notably arXiv 2503.15850
(UQ/calibration survey), 2602.13540, 2601.11956 and 2605.11954, all general-domain
calibration work, which the queue entry explicitly rules out as off-topic flooding.

### What the collect actually establishes — and what it does not

I want to be exact here, because the temptation is to declare the issue unblocked.

**Established.** Consistency failure, overconfidence and under-refusal in security-task
LLM use are *not* artefacts of one team, one paper, one model family, or one evaluation
harness. Four teams with no overlap with Mezzi/Massacci/Tuma, using four different
methods on four different corpora, find the same three phenomena. Two specific
sub-findings of src-0001 that looked most fragile are independently echoed:

- **"An intervention meant to help can make calibration worse."** src-0001: fine-tuning
  raised gpt4o CVE-generation ECE from 0.15 to 0.91. src-0013: moving from a controlled
  benchmark to a realistic repository-level setting raised ECE for *every* model
  (GPT-4o-mini 0.411 → 0.697, ΔECE +0.286; Gemini-2.0-Flash 0.161 → 0.721, ΔECE +0.560),
  and architectural gating "improves calibration on controlled benchmarks" while
  "calibration deteriorates in realistic repository-level settings". src-0014: adaptive
  chain-of-thought "reduces recall relative to CoT for every model" (Gemma 0.420 → 0.057,
  an ~86% relative collapse). Three sources, three mechanisms, same direction of surprise.
- **"Mechanical/grounded output is stable; open-ended output is not."** src-0001's CI
  widths were 0.02 for information-extraction and 0.06 for information-generation.
  src-0016, running the identical task five times with code, prompt and harness held
  constant, found 134/158 reference-matched findings recurred in **all five** runs while
  80/161 *unmatched* findings appeared in **only one of five**. Same split, wholly
  different measurement.

**Not established, and I am not going to let this slide.** None of the four measures CTI.
They measure secure code generation, CVE-code vulnerability detection, JavaScript SAST
review, and simulated incident response. The queue entry authorised admitting
security-generally sources *provided the scope gap is recorded explicitly* — I have done
that in all four `src-*.md` limitations sections, in all four `index.json` entries, and in
the new `candidate_resolution`. Concretely:

- **open_question (ii) remains fully open.** It asks whether the findings replicate on the
  specific models in src-0002's and src-0005's lists. Not one of the four sources tests a
  model from src-0001's, src-0002's or src-0005's lists. Models tested here are
  GPT-4o-mini / Gemini-2.0-Flash / Qwen3-Coder-Next / CodeLlama / Falcon / Gemma / Mistral
  / DeepSeek / GPT-5.2 / Claude Sonnet 4.5 / Gemini 3 / DeepSeek 3.2 / Claude Opus 4.6 /
  4.7 / Sonnet 4.6. The overlap with the CTI benchmarks in this base is empty.
- **open_question (i) remains fully open.** It asks whether gemini-1.5-pro-latest and
  mistral-large-2 show gpt4o's fine-tuning-worsens-calibration pattern. Nothing here
  touches those model versions.
- **open_questions (iii) and (iv) are informed but not answered.** src-0013's finding that
  functional calibration is consistently worse than security calibration within one study
  (ΔECE −0.15 to −0.53) is direct evidence that calibration is *itself* task-dependent —
  which is (iii)'s shape — but measured on the wrong task family.
- **The base still has no non-src-0001 source measuring consistency AND calibration
  together.** src-0013 has calibration and no consistency; src-0014 and src-0016 have
  consistency and no ECE. src-0001 remains the only source doing both.

So: a T4 scoring this issue must make an explicit judgement that no cycle has yet made —
does cross-domain corroboration of the same failure mode count toward multi-source
support, or does the domain gap hold the issue at 2? I have written that question into the
new candidate_resolution rather than pre-empting it. **A T1 has no standing to score, and
I have not scored.**

### One unexpected finding, recorded as a lead

`src-0015` (OpenSec) and `src-0007` (CyberThreat-Eval) independently find the same
operational failure from opposite ends of the field. src-0007: triage recall (Accepted)
0.90–1.00 against precision (Accepted) 0.27–0.40 — the models accept nearly everything a
human analyst would reject. src-0015: containment executed in 62.5–100% of episodes at
45–82.5% false-positive rate, with evidence-gated action rate 0.375–0.542, and the
diagnosis "the calibration gap is not in detection but in restraint." Different teams,
different years, different model generations, different task framings — **the models
under-refuse.** This is the strongest cross-source pattern I saw this cycle and it is
currently attached to no issue as such. It also makes carry-forward **[3]** (the
triage-precision new-issue candidate) considerably stronger than when it was written, and
I have said so in the T2 queue entry.

## Retrospection

**G2 target: `src-0007` (CyberThreat-Eval, https://arxiv.org/abs/2603.09452).** Selected
per the queue entry's reasoning, which I verified independently against carry-forward [8]:
src-0007 was the **only** source in the base never re-verified since collection, it is
load-bearing for three issues (`ttp-attack-mapping-reliability`, `ioc-extraction-reliability`,
`task-dependent-reliability-framing`), and it is one side of the open contradiction
`ctr-0001`. Coverage before this cycle: src-0004 (c4, c12), src-0003 (c5), src-0002 (c6),
src-0001 (c7), src-0006 (c8), src-0005 (c9 substance, c11 verbatim), src-0008 (c10),
src-0012 (c13), src-0011 (c14).

**Method.** Per the standing methodological rule (carry-forward, and now five cycles of
evidence that it changes outcomes), I did not ask "is value X still correct". I asked for
the **entire Table 4, every row, verbatim**, with an explicit instruction to reply
"TABLE NOT PRESENT" and enumerate what tables *were* present if it was missing — so that a
summarising failure could not masquerade as confirmation. Separately I pulled `/abs` for
the title, full author list, abstract and subject classes.

**Result: PASS. Unqualified.**

- **Abstract:** returned verbatim and matches the stored quote in `src-0007.md`
  word-for-word across all ~230 words, including the trailing "TRA allows human experts to
  iteratively provide feedback for continuous improvement. The code is available at GitHub
  and HuggingFace."
- **Authorship, date, subject classes:** Xiangsen Chen, Xuan Feng, Shuo Chen, Matthieu
  Maitre, Sudipto Rakshit, Diana Duvieilh, Ashley Picone, Nan Tang; submitted 10 Mar 2026;
  cs.CR + cs.CL. All match.
- **Table 4:** all **nine** rows previously stored matched **exactly**, to four decimal
  places, across all four model columns. Specifically re-confirmed: IoC Extraction
  Precision 0.8240 / 0.8503 / 0.8846 / 0.6944; MITRE ATT&CK TTP Identification Precision
  0.2787 / 0.3480 / 0.2387 / 0.1771 and Recall 0.2270 / 0.1759 / 0.1846 / 0.1414; Priority
  Scoring (Description) Precision 0.3590 / 0.3982 / 0.3392 / 0.3477 and Recall 0.9899 /
  0.9091 / 0.9798 / 0.9798; Priority Scoring (Article) Precision 0.3037 / 0.3802 / 0.2717 /
  0.2964 and Recall 1.0000 / 0.9293 / 0.9798 / 1.0000. **No discrepancy of any kind.**

**No contradiction entry opened, and none was warranted.** Reporting that plainly: the
system's most load-bearing unverified source verified clean.

**Bonus recovered — the whole-table rule paying off again.** Because I asked for every row
rather than the nine I already had, the fetch returned **25 rows that were never captured**,
including the Deep Search URL-extraction block and the full 1–5 rubric scores that
`src-0007.md` explicitly recorded as "existing, not summarised". Among them is a result
that is materially interesting and that no cycle has seen:

| TI drafting — Content: Threat Actor | GPT-4o | o3-mini | GPT-4o (FT) | GPT-4o-mini (FT) |
|---|---|---|---|---|
| Relevance | 1.547 | 3.964 | 3.964 | 2.475 |
| Accuracy | 1.528 | 3.656 | 3.655 | 2.405 |
| Attribution | 1.140 | 2.968 | 2.967 | 1.832 |

GPT-4o scores **1.140 / 5 on Attribution** and 1.528 on Accuracy for threat-actor content,
against o3-mini's 2.968 and 3.656 — a ~2.6x model gap on the same task and corpus, and far
below the same table's Root Cause scores (3.612 and 3.458 for GPT-4o). This is a third
independent quantitative datapoint on threat-actor attribution quality, alongside
src-0002's plausible-vs-correct split and src-0004's ENISA misattribution, and
`attribution-confident-wrong-gap` currently cites neither src-0007 nor these numbers. **I
did not attach it** — a T1 does not restructure issues, and this belongs to a different
issue from the one I was sent to collect for. It is written into the T2 queue entry as
agenda item 4 and into carry-forward **[19]**. Note also that GPT-4o (FT) 3.964/3.655/2.967
tracks o3-mini's 3.964/3.656/2.968 to within 0.001 on all three rows, which is close enough
to warrant a second look before anyone cites both columns.

## Changes made

**Added (4 new source files):**
- `state/knowledge/src-0013.md` — Security Calibration in LLMs for Code (ECE/Brier/False Trust)
- `state/knowledge/src-0014.md` — PromptAudit (prompt sensitivity, abstention/coverage)
- `state/knowledge/src-0015.md` — OpenSec (IR agent under-refusal, EGAR)
- `state/knowledge/src-0016.md` — Snyk VulnBench JS 1.0 (repeat-identical-query stability)

Each carries frontmatter (url, title, type, `accessed: 2026-07-29`, `added_cycle: 15`), a
summary stating why it was added and what it is for, 3–4 key claims each with verbatim
numeric support, a quotes section with locations, and an explicit limitations section. All
four limitations sections lead with the scope gap. Two flag that their results tables were
**not** pulled in full and should be a future G2 target; `src-0013.md` additionally records
an unresolved internal number discrepancy in the source (False Trust reported as 33.9% for
GPT-4o-mini in one section and as rising "from 16.9% to 83.2%" in another, with no stated
reconciliation) rather than silently picking one.

**Modified:**
- `state/knowledge/index.json` — four entries appended after src-0012. Seam re-read and
  verified by eye per carry-forward [9] (`python3`/`curl` blocked; no parse available).
- `state/issues/graph.json` — confined to the target issue, as the queue entry permitted:
  appended `15` to `attempts` (now `[3, 15]`), and added one **`proposed`**
  candidate_resolution recording what the four sources do and do not establish. It is
  proposed, not supported, and it states in terms that the promote-or-not judgement belongs
  to a T4. No scores changed (T1 has no standing). No existing claim edited or deleted.

**G1:** all four URLs were fetched successfully by me this cycle and returned content
(HTTP < 400). No source was invented; every number in every key claim came back as quoted
text from the fetch, not from memory.

**G3:** no contradiction opened. I checked for conflict deliberately rather than by
default: src-0013's "functional calibration is consistently worse than security
calibration" might look like it softens src-0001's "LLMs are not calibrated for CTI", but
it is a *within-study relative* comparison on a different task family, and src-0013's
absolute ECEs (0.247–0.481, rising to 0.697–0.721 at repository level) are poor by any
reading — no conflict. src-0016 and src-0015 both agree in direction with existing supported
claims (src-0001 and src-0007 respectively). Nothing in conflict, so nothing filed. Filing
a spurious entry would misuse the gate as much as suppressing a real one.

## Next task rationale

**T2 (Structure), and the state machine leaves no discretion here.** `prompts/system.md`
line 46: `T1→T2, T2→T3, T3→T4, T4→T5, T5→T3`. I performed a T1, so the next task is a T2.
I re-checked this against `system.md` rather than inheriting it, because carry-forward [12]
asserted for several cycles that T2 is unreachable and cycle 14 found that claim false —
the refresh rule chains **T5 → T1 → T2**, so the escape to T2 exists and fires every
seventh cycle plus one. Cycle 16 is the first T2 since the opening pass.

That makes cycle 16 the scarcest cycle in this project: the only task type that can split
an issue, add an issue, or reconcile the prompt/validator disagreement fires at most once
every seven cycles, and three items have been blocked on it for eight, five and six cycles
respectively. I have therefore written a **specific five-item agenda** into the queue entry
rather than a generic "review the graph", with each item's evidence, prior reasoning, and
the arguments *against* acting reproduced in full so cycle 16 need not read back through
seven logs. The five: [1] split `task-dependent-reliability-framing`; [3] the triage-precision
new issue, now materially stronger given src-0015; [4] the G3 gate specification conflict;
[2]+[19] attach src-0007 to the two issues whose resolutions omit it; and a scope-boundary
decision on whether security-adjacent calibration evidence counts for the CTI issue — a
question my own collect created and cannot itself answer.

**One caution I am passing forward explicitly:** the fifth item is genuinely a judgement
call and I have not stacked it. A defensible T2 could rule that cross-domain evidence does
not count and that `consistency-calibration-as-failure-mode` stays at 2 with four new
sources attached as context. If cycle 16 rules that way, that is a legitimate outcome and
the collect was still worth doing — it converted "we have one paper" into "we have one CTI
paper and four security-domain corroborations", which is a better-characterised state even
if the score does not move.

## Budget

- **Web searches:** 5 (forward-citation attempt on src-0001; LLM-calibration-cybersecurity;
  UQ/vulnerability-detection; CTIBench/CyberSOCEval consistency update; self-consistency /
  repeated-prompt stability)
- **Web fetches:** 8 (src-0007 `/abs` + `/html` for G2; 2606.31159 `/abs` + `/html`;
  2605.24171 `/html`; 2601.21083 `/abs` + `/html/v3`; snyk.io blog)
- **File reads:** 7 (meta, next_task, config, index, graph, src-0007.md, cycle-014.md tail)
- **File writes/edits:** 9 (4 new src files; index.json; graph.json; this log; next_task.json;
  last_completed_task.txt) + 3 seam-verification reads
- **Assistant turns:** ~13
- **Dead ends:** the forward-citation sweep of arXiv 2503.23175 returned only the paper
  itself, its mirrors and its ARES 2025 conference version — **no citing paper measuring
  calibration was found by that route**, consistent with carry-forward [6]'s note that the
  citation-graph technique remains unsolved for this agent. All four sources came from
  direct topical search instead. The CTIBench/CyberSOCEval update search confirmed **no v2
  or companion paper with a consistency/calibration axis exists** — that was named the
  single highest-value possible find and it is not available; recorded so cycle 22 does not
  re-search it blind. Carry-forward [10] (pull CyberSOCEval's per-model numbers) was NOT
  needed as a fallback, since the primary searches succeeded; it remains open.

---

## Carry-forward items

All eighteen items from `logs/cycle-014.md` are reproduced below **including the ones I
cannot act on**, with cycle-15 updates, plus one new. Three handoffs have now lost or
corrupted state (cycle 11 dropped [8] and [9]; cycle 14 found [12]'s central claim
factually wrong), so this section is load-bearing, not ceremonial.

**[1]** SPLIT `task-dependent-reliability-framing` into the NARROW claim (CTI reliability
varies by sub-task; src-0001, src-0002, src-0006, src-0007; merits 3) and the SPECIFIC
ORDINAL AXIS ("mechanical extraction < classification < attribution < generation"), which is
actively DISPUTED — src-0007's Table 4 supports it (IoC extraction precision 0.82–0.88 vs
TTP identification 0.2787/0.2270, same team/corpus/models) while src-0006's Table 5 opposes
it (failure subtypes span all four pipeline stages). Cycle 10 explicitly DECLINED to open a
contradiction, reasoning that src-0006 is about where failure MECHANISMS occur and src-0007
about where performance LEVELS differ, which are compatible; do not overturn that without
reading both tables. **CARRIED BY CYCLES 7–15 — NINE CONSECUTIVE CYCLES.** *Cycle 15 note:
now agenda item 1 of the cycle-16 T2, and **src-0013 adds new evidence bearing on it**:
within one study, functional calibration is consistently worse than security calibration
(ΔECE −0.15 to −0.53 by model), i.e. calibration is task-dependent in the same way accuracy
is. That is support for the narrow claim from a fifth angle and is silent on the ordinal
axis.*

**[2]** ATTACH src-0007 to `ttp-attack-mapping-reliability`: it is an unattached third
independent source (ATT&CK TTP identification P/R 0.2787/0.2270 GPT-4o, 0.3480/0.1759
o3-mini, 0.2387/0.1846 GPT-4o-FT, 0.1771/0.1414 GPT-4o-mini-FT on real production material
vs CTIBench's 0.6388 F1 ceiling) that cycles 10 and 13 cite in their rationales but
`graph.json`'s `candidate_resolutions` do not list (still `[src-0002, src-0005]`). It gives
that issue's open_question[2] its first direct evidence, and the answer is that fine-tuning
made ATT&CK mapping WORSE. Not a contradiction with src-0002. **SIXTH CYCLE CARRIED.**
*Cycle 15 re-verified every one of those numbers verbatim (see Retrospection) — they are
confirmed exact and ready to attach.*

**[3]** NEW-ISSUE CANDIDATE for a T2: LLM triage precision — src-0007 reports recall
(Accepted) 0.90–1.00 vs precision (Accepted) 0.27–0.40 across all four models; no existing
issue covers triage. *Cycle 15 note: **this item is now materially stronger than when
written.** src-0015 (OpenSec) independently finds the same under-refusal on a different
task, different team, different model generation: containment executed in 62.5–100% of
episodes at 45–82.5% FP, evidence-gated action rate 0.375–0.542, and the explicit diagnosis
"the calibration gap is not in detection but in restraint." Two independent sources on one
un-modelled failure mode is a much better case for a new issue than one. Agenda item 2 for
cycle 16.*

**[4]** THE G3 GATE IS SPECIFIED TWO INCOMPATIBLE WAYS: `prompts/t4_assess.md` step 3 says
an issue with an open contradiction LOSES `gates.g3_contradiction_demotion` points (a
subtraction), while `scripts/validate_state.py` lines 144–156 implements a CEILING (error
only if score > scale_max − demotion = 3). Cycle 10 applied the CEILING and argued why;
cycle 11 confirmed live that the reading changes the agenda; cycle 13 applied the CEILING
again with arithmetic recorded. **SEVENTH CYCLE CARRIED.** De-facto behaviour is settled by
three consistent applications even though the specification is not; the risk is a future
cycle reading the prompt literally and diverging. Agenda item 3 for cycle 16.

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at
P5–P6, but the paper's body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance
unaffected; no contradiction opened, because both readings are automated fetches of the same
HTML and one demonstrably mis-rendered characters. Needs a PDF-level check before anyone
cites src-0008's phase structure. src-0008's per-phase percentages exist ONLY as pie charts
(Figure 2) and cannot be verified by table pull; its Table 7 hallucination rates (Anthropic
0.11%, ChatGPT 0.23%, Gemini 4.8%, Grok 0, Cohere 0) are verified exact and their
"approximate" caveat can be lifted.

**[6]** THREE UNFINISHED SEARCH DIRECTIONS, open since cycle 9: citation-graph sweep of
arXiv 2506.11325 (`semanticscholar.org/arxiv/<id>` returns 404 — try Google Scholar, arXiv
listing pages, or Connected Papers); third-party evaluations of the IoC Searcher /
AlienVault OTX / VirusTotal baselines; and the paywalled eLLM-CTI paper (ScienceDirect
S0167739X26001482, HTTP 403, no preprint located). *Cycle 15 attempted the same
citation-graph technique on arXiv **2503.23175** and it again returned only the paper, its
mirrors and its ARES 2025 conference version (Springer DOI 10.1007/978-3-032-00627-1_17,
pp. 343–364) — **no citing paper was surfaced by that route.** The technique has now failed
on two different arXiv ids for this agent; treat forward-citation sweeps as unavailable
infrastructure, not as an unsearched direction, and use direct topical search instead,
which is what actually produced this cycle's four sources.*

**[7]** ctr-0001 RESOLUTION PATH: recover recall/F1 from src-0007's released code
(GitHub/HuggingFace per its abstract) to make its precision-only numbers comparable with
src-0003's F1, and/or find any source running an unscaffolded LLM against PRISM or a
LANCE-style scaffolded pipeline against CyberThreat-Eval. If the SYSTEM confound is
confirmed as the explanation, ctr-0001 should be CLOSED and folded into
`ioc-extraction-reliability`'s third candidate_resolution rather than left open. *Cycle 15
note: the full Table 4 pull confirms there is no recall or F1 row for IoC Extraction
anywhere in that table — only Precision, Time (s) and Tokens. The omission is now verified
as real rather than a fetch artefact, which strengthens the case that the code release is
the only route.*

**[8]** G2 RE-VERIFICATION COVERAGE TO DATE: src-0004 (c4, c12), src-0003 (c5), src-0002
(c6), src-0001 (c7), src-0006 (c8), src-0005 (c9 substance-only, c11 verbatim), src-0008
(c10), src-0012 (c13), src-0011 (c14), **src-0007 (c15 — PASSED, all nine stored Table 4
rows exact to 4 dp, abstract/authors/date/subject-classes all matching, plus 25 previously
uncaptured rows recovered)**. **Every source added before cycle 12 has now been re-verified
at least once.** Still never verified: **src-0009 and src-0010** (ENISA pages, collected
c12) — these are now the oldest unverified sources and are the natural c16+ target — and
the four added this cycle (**src-0013, src-0014, src-0015, src-0016**). Of those four,
src-0013 and src-0014 explicitly need a full results-table pull (see [20]).

**[9]** SANDBOX LIMITATION, unchanged from cycles 9, 10, 12, 13, 14: `python3` and `curl`
are blocked in this unattended run. JSON validity must be checked by construction and by
re-reading the edited seams, not by a parse. *Cycle 15 appended to `index.json` and
`graph.json` via targeted single-seam edits and re-read both seams with `sed` afterwards;
`next_task.json` was written whole rather than patched, with single quotes used inside the
instruction string wherever possible to avoid escaping errors.*

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Cycle 11's G2 verified all four of
its stored quotes verbatim against the arXiv abstract, but every claim it contributes is
abstract-level and directional. It is one of two sources holding `ttp-attack-mapping-reliability`
at 3 and the other (src-0002) is the only one supplying a figure (0.6388 F1). Pulling
CyberSOCEval's per-model/per-task scores from the full paper is the cheapest thing that
could move that issue, open since cycle 1. *Cycle 15 note: named as this cycle's fallback if
primary searches came up dry; they did not, so it was NOT done and remains fully open. It is
now the single oldest un-actioned collection task in the project.*

**[11]** TIE-BREAK 3a IN `prompts/t5_select.md` IS UNDER-SPECIFIED, and the policy has no
deterministic tie-break after 3c. "An issue that others depend_on outranks its dependents"
admits a strict pairwise reading (cycle 11) and an in-degree reading. Suggested fix for a
cycle with standing: add "3d. longest time since the issue last received new evidence; then
fewest total attempts" — **note the ordering, which cycle 14 established by experience:
"fewest total attempts" was useless on the pair it hit (both had exactly one attempt) and the
"longest time since new evidence" clause is what actually decided.** Cycle 14 hit this for
the third time, on the same pair, with the same identical `created_cycle: 2`; the two readings
of 3a agreed for the first time, so the divergence is intermittent, not systematic. Cycles 11
and 14 both DECLINED to edit the prompt: T5 has no standing to change the rules.

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger
claim was WRONG; see [17].** T2 is the only task type with standing to split an issue, add a
new issue, or reconcile the prompt/validator disagreement, and items [1], [3] and [4] have
been blocked on that for nine, six and seven cycles. What cycles 11–13 recorded — that the
loop "never returns to T2" and there is "NO ANALOGOUS ESCAPE TO T2" — is false:
`prompts/system.md` line 46 specifies `T1→T2`, so the refresh rule's T1 chains into a T2. The
correct statement is that T2 is reachable only every seventh cycle plus one, and that the
default lap T3→T4→T5→T3 indeed never reaches it. **A carry-forward item that no cycle has
standing to act on is also a carry-forward item that no cycle re-verifies.**

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400, "The
following domains are not accessible to our user agent". Der Spiegel is the upstream primary
for the entire ENISA incident, so this is a permanent structural gap, not a to-do. Do not
re-spend budget fetching it the same way. Remaining routes to the 26/492 figure: count
footnotes in the archived original/v1.1 PDF against v1.2, or locate Prof. Christian
Dietrich's / Institut für Internet-Sicherheit's own writeup. *Cycles 14 and 15 did not retry,
per this item.*

**[14]** THE TWO ENISA v1.2 PDFs WERE NEVER OPENED. Only the landing pages were fetched, so
"ENISA never disclosed the AI use" is established for the publication pages, not for the
documents' front matter/legal notices. Pulling the front matter of
`ENISA Threat Landscape 2025_v1.2.pdf` (2026-01 path) would either strengthen that claim to
document level or refute it — a cheap, decisive check, and the same PDFs are the route to
[13]'s footnote count. Matters more since `institutional-incident-real-world-impact` was
raised to 3 partly on the AI-disclosure finding. *Note this now overlaps with [8]: src-0009
and src-0010 are simultaneously the oldest unverified sources and the ones whose PDFs were
never opened, so a single cycle could discharge both.*

**[15]** SCOPE-ADJACENT CASE DELIBERATELY NOT ADDED AS A SOURCE, recorded so it is not
re-searched from scratch: curl ended its HackerOne bug bounty on 31 January 2026 after a flood
of AI-generated "slop" vulnerability reports, with reported figures of ~20% of submissions
being AI slop by mid-2025 and the confirmed-vulnerability rate falling from ~15% historically
to under 5% (bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/;
The Register's URL 404'd on the path tried). Excluded because it is a different phenomenon: AI
security claims arriving *inbound* and rejected at triage, not AI content *published* by an
institution. It would fit a new issue on AI slop in security reporting pipelines — a T2
candidate alongside [3]. *Cycle 15 note: with src-0015 and src-0007 both showing automated
triage passes through most of what humans reject, an "AI slop inbound + automated triage that
cannot filter it" issue is now more coherent than it was; consider merging this with [3]
rather than filing separately.*

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION, AND IT IS THE BEST LEAD ON
THE BASE-RATE QUESTION ANY CYCLE HAS FOUND. Verbatim from `https://gptzero.me/investigations/ey`:
it has "set up an automated pipeline to search for vibe citations by finding and scanning public
reports from major consulting firms", is releasing findings "one report at a time", and has
already investigated "a government publication, two different Deloitte reports, and prestigious
machine learning / artificial intelligence conferences like NeurIPS and ICLR". A T1 should chase
`gptzero.me/news/tag/investigations` for the Deloitte and government-publication write-ups,
taking the incident count from 2 to 4–5 named cases across three institution types. Caveats:
GPTZero is a commercial AI-detection vendor reporting on its own product's value, no *rate* is
published, and the scorecard widget renders as "0 of N" to automated fetch — read the body text,
not the widget. *Cycle 15 did NOT chase this, correctly: it is a lead for
`institutional-incident-real-world-impact`, not for the issue this cycle was sent to collect
for. It remains the top T1 lead for the NEXT collect cycle (cycle 22 under the refresh rule).*

**[17]** THE REFRESH RULE IS THE ESCAPE TO T2. `prompts/system.md` line 46:
`T1→T2, T2→T3, T3→T4, T4→T5, T5→T3`. The refresh rule makes every seventh cycle's T5 emit a T1,
and a T1 emits a T2. So the chain is **T5 → T1 → T2**. This corrects [12]. *Cycle 15 note:
**CONFIRMED IN PRACTICE, not just on paper** — this cycle was the T1 and it has written a T2 to
the queue. The prediction held end-to-end. Structural note for the paper: the only task type
that can restructure the issue graph fires at most once every seven cycles and only as a side
effect of a rule whose stated purpose is refreshing evidence — the loop has no first-class
trigger for "the graph itself is the problem", which is why five cycles in a row recorded the
same split as the highest-value available change and none could make it.*

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly, but cite carefully. Body
text says "NeurIPS exhibiting the highest absolute count (391 papers)" while its own Table 3
gives NeurIPS 391 invalid citations across 308 papers — the prose conflates the columns. No
claim in our base repeats the error and **no G3 entry was opened**: one source disagreeing with
itself is not two of our supported claims in conflict, so filing it would misuse the gate. Any
cycle quoting src-0011's *counts* should take them from Table 3's columns, not that sentence.

**[19] NEW (cycle 15).** src-0007's TABLE 4 CONTAINS 25 ROWS NO CYCLE HAD SEEN, recovered by
the whole-table G2 pull, and one block is directly relevant to an issue that does not cite
src-0007 at all. **Content: Threat Actor** rubric scores (1–5) are GPT-4o **1.547 Relevance /
1.528 Accuracy / 1.140 Attribution** vs o3-mini **3.964 / 3.656 / 2.968** — a ~2.6x model gap on
the same task and corpus, and far below the same table's Content: Root Cause scores (GPT-4o
3.686 / 3.458 / 3.612). This is a third independent quantitative datapoint on threat-actor
attribution quality alongside src-0002's plausible-vs-correct split and src-0004's ENISA
misattribution, and `attribution-confident-wrong-gap` cites neither src-0007 nor these numbers.
A T2 should attach it (agenda item 4). **Caution before citing:** GPT-4o (FT) reads
3.964/3.655/2.967 against o3-mini's 3.964/3.656/2.968 — identical to within 0.001 on all three
rows, which is suspicious enough to warrant a targeted re-pull of those two columns before
either is quoted. Also uncaptured and available: the Deep Search URLs-Extraction block
(GPT-4o 6.22 avg URLs processed vs GPT-4o-mini-FT 1.25) and full Triage pass-rate/bias rows.

**[20] NEW (cycle 15).** THE FOUR SOURCES ADDED THIS CYCLE HAVE VERBATIM-CONFIRMED ABSTRACTS BUT
ONLY src-0015 HAD A TABLE PULLED WHOLE. src-0013's ECE/Brier/False-Trust values and src-0014's
F1/coverage values were returned as quoted body sentences, not as pulled tables, and both
`src-*.md` files say so in their limitations. Per the rule that has changed the outcome five
cycles running, **those numbers are single-pass and should not be treated as load-bearing until
a G2 pulls the tables whole.** src-0013 additionally has an unreconciled internal discrepancy
recorded at collection: False Trust for GPT-4o-mini appears as 33.9% in one section and as
"16.9% to 83.2%" in another, and the fetched text does not say which aggregation each uses — **do
not quote those figures together** until the FT table is pulled.
