# Cycle 013 — T4 Assess

## Task performed

T4 (Assess) per `prompts/t4_assess.md`. Scored **all six** issues in
`state/issues/graph.json` against the 0–5 rubric and rewrote
`state/assessments/scores.json`, setting `assessed_cycle: 13` on every entry and
`last_assessed_cycle: 13`. `target_issue` was null by design — a T4 scores the whole graph.

Result: **one score moved.** Five held.

| issue | c10 | c13 | why |
|---|---|---|---|
| `ttp-attack-mapping-reliability` | 3 | **3** | primary candidate carried by src-0002 (CTI-ATE F1 0.6388) + src-0005; open_question[1] (human baseline) still unaddressed → not 4 |
| `ioc-extraction-reliability` | 2 | **2** | two single-source candidates + one `proposed` synthesis; ctr-0001 open, ceiling reading applied (not binding at 2) |
| `consistency-calibration-as-failure-mode` | 2 | **2** | both candidates cite [src-0001] and nothing else — single-source is a 2 by definition |
| `attribution-confident-wrong-gap` | 3 | **3** | src-0002 + src-0004, genuinely independent; open_question[2] listed but never argued → not 4 |
| `task-dependent-reliability-framing` | 3 | **3** | narrow claim ~4-source, ordinal axis disputed at 1–2; 3 is the forced average |
| `institutional-incident-real-world-impact` | 2 | **3** | **RAISED** — cycle 12's src-0009/0010/0012 removed the single-source cap |

I checked the handoff's premise rather than trusting it, and it held: cycle 11 was a
selection-only T5 and cycle 12 touched exactly one issue, so the other five issues'
evidence is byte-identical to what cycle 10 assessed. Every held score is therefore a
re-affirmation against unchanged evidence, not a re-reading. The one thing I did *not*
inherit blindly was cycle 10's stated reason for capping
`institutional-incident-real-world-impact` — "single-source support caps this at 2" — which
is simply no longer the situation and is why that score moves.

### The raise, and the trap I did not walk into

`institutional-incident-real-world-impact` 2 → 3. The existence claim is now carried by
ENISA's **own** publication pages (src-0009: "Revision Notice – Version 1.2. (09 January
2026): This publication has been updated to edit some links." against a 1 Oct 2025
publication date; src-0010: "…updated to correct some broken links and typos." against
6 Nov 2025) — primary institutional artefacts corroborating report count, dates, defect
type and correction date independently of the Der Spiegel/Heise chain — plus a **second
named incident at a different institution type** (src-0012, EY Canada, 16 of 27 references
hallucinated, report withdrawn). Two incidents, two mutually independent investigations,
plus the affected institution's own correction record clears the level-3 bar.

**Not 4**, for three reasons stated in the rationale so no later cycle re-argues them:

1. **The base rate is unmeasured and blocked by scope, not by evidence volume.** Two named
   incidents are two data points. src-0011 (GhostCite) is *not* the CTI rate and its
   candidate_resolution is correctly `proposed`: peer-reviewed conference papers (which
   have reviewers; CTI reports have none), a ghost-citation definition keyed to absence
   from academic databases (inapplicable to news/vendor URL footnotes), and per-**paper**
   rates that are not comparable with src-0004's per-**footnote** 26/492. I read that
   source file's Limitations section before scoring, as instructed. Treating a second
   anecdote plus an adjacent-population audit as a resolved base rate would have been this
   cycle's most likely error.
2. **The AI-causation leg is the weakest part of the issue and it is the part the topic is
   about.** What is robustly established is that *fabricated citations* reached production
   at two named institutions. That *AI caused them* is well-supported for EY and
   reported-but-not-primary for ENISA (Der Spiegel via Heise only; ENISA's own record
   assigns no cause; the 26/492 figure is still not independently verified, and the outlets
   repeating it all cite Der Spiegel, which is repetition, not corroboration).
3. Three of five open_questions remain open, and candidate 4 itself honestly concludes
   there is **no single institutional response pattern** on n=2 — an accurate non-answer,
   not a resolution.

### G3 gate: ceiling reading applied, fourth cycle running

`prompts/t4_assess.md` step 3 specifies a **subtraction**; `scripts/validate_state.py`
lines 144–156 implements a **ceiling** (score ≤ scale_max − demotion = 3). ctr-0001 is open
against `ioc-extraction-reliability`. I applied the **ceiling**, consistent with cycles 10
and 11, for cycle 10's substantive reason: the rubric's levels are definitions of states
(0 = "no candidate resolutions", 1 = "no supported resolution") and that issue has three
candidate_resolutions of which two are `supported`, so subtracting to 0 would attach a
label that is factually false of the issue and corrupt the weakest-link selector. Arithmetic
recorded in the rationale: pre-demotion 2, ceiling of 3 not binding, post-demotion 2. I did
**not** edit either file — T4 has no standing to reconcile them (carry-forward [12]).

No new contradiction was opened this cycle, and I explicitly endorse rather than re-argue
cycle 12's reason for not opening one over ENISA's silence: the revision notices assign no
cause **at all**, and silence is not a competing claim, so G3's "two supported claims in
conflict" is not met.

## Retrospection

**Target chosen: src-0012, its central "16 of 27 references hallucinated" figure.** Chosen
over src-0007 (the only never-re-verified source) because src-0007's Table 4 was pulled
verbatim at collection time, whereas src-0012 had a **live, recorded, unresolved conflict**:
its primary — `https://gptzero.me/investigations/ey` — returned "0 of 27 references
hallucinated" on both of cycle 12's fetches, directly contradicting the 16/27 that two
secondary outlets report. A doubt that a source file itself flags as unsettled is worth more
than a routine re-check, and this figure is load-bearing for the score I just raised.

**Result: PASSES — and the doubt is now settled rather than merely assumed.**

Applying the methodological rule (ask for the entire passage verbatim; never accept a
summarised "the value is/isn't X"):

1. **consulting.ca re-fetched** — sentence **verbatim identical** to what cycle 12
   recorded: "GPTZero's investigations branch on May 14 published a report that found 16 of
   27 references in the EY study were hallucinated and that 72% of the study was AI."
2. **goingconcern.com re-fetched** — likewise verbatim identical: "…stuffed with
   hallucinations: 16 out of 27 citations to be exact." It also yielded a second verbatim EY
   quote not previously recorded: EY was "reviewing the circumstances that led to this
   article's publication", adding the study "was not connected to work for any EY client."
3. **GPTZero primary fetched a third time** — the scorecard **again** read "0 of 27
   references hallucinated". But this fetch returned far more of the page body than cycle
   12's did, and the body **refutes the widget in the page's own words**: "We chased down
   every citation. **Most were hallucinated.**" and "**Almost all of the URLs are broken or
   fake, and more than half of the titles don't correspond to real sources.**" The page then
   individually enumerates **eight** references (BleepingComputer, Wired ×2, Gartner, Forbes,
   McKinsey, Cisco Talos, TechCrunch) each labelled "Hallucinated" with a stated reason.
   A page cannot say "0 of 27" while enumerating eight hallucinated entries under the
   heading "Most were hallucinated". "More than half of 27" is ≥14, consistent with 16.

So the "0 of 27" is an unrun/default JS scorecard state, and **no contradiction entry is
opened** — now for a documented reason rather than an inference. Cycle 12 reached the right
call on weaker grounds; this cycle supplies the grounds. This is the fourth consecutive
cycle in which the verbatim rule changed the outcome (c8 nearly opened a spurious
contradiction off a paraphrase; c10, c11, c12 clean; c13 converts an assumption into
evidence).

**Recorded honestly as still open:** 16/27 remains **one** upstream investigation reported
by mutually independent outlets. A third outlet surfaced this cycle (computing.co.uk) is
likewise downstream of GPTZero. Well-attested ≠ independently re-derived. That caveat in
`src-0012.md` stands unamended.

**New lead surfaced as a by-product, recorded but deliberately not scored on:** GPTZero
states verbatim it has "set up an automated pipeline to search for vibe citations by finding
and scanning public reports from major consulting firms", is releasing results "one report
at a time", and has already investigated "a government publication, **two different Deloitte
reports**", plus NeurIPS/ICLR. This is the closest thing yet to a systematic sweep over the
*right* population for the base-rate question, and it names further probable incidents. It
is a **T1 lead, not evidence** — no rate is published and the Deloitte reports have been
fetched by no cycle. New carry-forward item [16].

## Changes made

- `state/assessments/scores.json` — rewritten. All six issues scored with
  `assessed_cycle: 13`; `last_assessed_cycle: 13`. One score changed
  (`institutional-incident-real-world-impact` 2 → 3); five held with rationales that state
  what was checked and why nothing moved. Every rationale cites source ids; all six are ≥ 2
  and therefore all six carry evidence citations, as the validator requires.
- `state/knowledge/src-0012.md` — **appended only**, nothing above the new heading altered:
  a "Cycle 13 G2 re-verification" section recording the three verbatim fetches, the
  page-refutes-its-own-widget finding, the new verbatim EY quote, and the GPTZero-pipeline
  lead. No `key_claims` in `index.json` were added or edited — the G2 result confirms
  existing claims rather than introducing new ones, so no G1 exposure.
- `state/queue/next_task.json` — T5 (select), per T4→T5.
- `state/queue/last_completed_task.txt` — `T4 assess`.
- No edits to `graph.json` (no contradictions opened, none resolved; T4 has no standing to
  restructure), and none to `prompts/` or `scripts/`.

## Next task rationale

**T5 (select)**, per the state machine T4→T5. A T5 takes no `target_issue` of its own; it
reads the scores I just wrote and picks the weakest link.

What the new scores imply, stated so cycle 14 can check my arithmetic rather than inherit
it: the graph is now **3, 2, 2, 3, 3, 3**. The bottom is a **two-way tie at 2** between
`ioc-extraction-reliability` and `consistency-calibration-as-failure-mode`. On the
configured tie-break (`scoring.tie_break_recent_attempt_penalty: 1` per attempt within the
last 5 cycles) `ioc-extraction-reliability` has `attempts: [9]` — cycle 13 − 9 = 4, inside
the window, so it takes a penalty — while `consistency-calibration-as-failure-mode` has
`attempts: [3]`, ten cycles ago and outside it. That points to
**`consistency-calibration-as-failure-mode`**, which is also the issue with the starkest
structural problem in the graph: *both* its candidate_resolutions cite [src-0001] and
nothing else, two cycles have searched for corroboration and rejected every candidate, so
it cannot leave 2 without a genuinely new second source. I record that as my reading, **not**
as an instruction — T5 does the selecting, and cycle 11 caught cycle 10's queue entry
asserting a false premise precisely by re-deriving rather than trusting.

**THE REFRESH RULE FIRES ON CYCLE 14, AND THIS IS NOT ambiguous — I read the rule text
rather than inferring it.** `prompts/t5_select.md` step 4 says: "if
`current_cycle % schedule.collect_refresh_every == 0`, the next task is `T1` targeting the
selected issue (bring in fresh evidence) instead of `T3`." `collect_refresh_every: 7` and
the T5's own `current_cycle` will be 14, so 14 % 7 = 0 and **cycle 14 must write a T1, not a
T3**. This rule has **never fired in thirteen cycles** — cycle 7, the only prior multiple,
happened to be a T4 rather than a T5 — so there is no precedent to copy and the failure mode
is a cycle 14 that writes a T3 out of habit. It firing is fortunate rather than awkward: if
the selection lands on `consistency-calibration-as-failure-mode`, a T1 is *exactly* what
that issue needs, because its ceiling is a source-count problem (both candidates cite
src-0001 alone) and only a collect can fix it. A T3 there would re-analyse the same single
source for the third time.

**One genuine edge case cycle 14 must decide and record:** tie-break 3b penalises attempts
"within the last 5 cycles". `ioc-extraction-reliability` has `attempts: [9]`. At cycle 13
that is unambiguously inside the window (13 − 9 = 4). At cycle 14 it is exactly on the
boundary (14 − 9 = 5): counting the last five cycles as 10–14 puts cycle 9 *outside*, and
the penalty vanishes, restoring an unbroken 2-vs-2 tie. Say which way you counted.

## Budget

- Fetches: 3 (`consulting.ca`, `gptzero.me/investigations/ey`, `goingconcern.com`)
- Searches: 1 (corroboration sweep for the 16/27 figure)
- Reads: 8 state/knowledge files; 2 `grep`/`tail` reads of `logs/cycle-012.md`
- Writes/edits: 4 files
- Turns: ~9 of 50. Well under budget; T4 is a reasoning task, not a collection task, and
  the three fetches all went to the single G2 target rather than being spread thin.
- Not spent: no attempt to reach `spiegel.de` (carry-forward [13] — permanent, do not
  re-spend), no ENISA PDF pull (carry-forward [14] — real and cheap, but it is collection
  work and T4 has no standing to add sources).

---

## Carry-forward items

All fifteen items from `logs/cycle-012.md` are reproduced below, **including the ones I
cannot act on**, plus one new. Items [8] and [9] were silently dropped by the cycle-11
handoff and recovered by cycle 12 from `logs/cycle-010.md`; that is twice a handoff has lost
state, so they are kept verbatim in position.

**[1]** SPLIT `task-dependent-reliability-framing` into the NARROW claim (CTI reliability
varies by sub-task; src-0001, src-0002, src-0006, src-0007; merits 3) and the SPECIFIC
ORDINAL AXIS ("mechanical extraction < classification < attribution < generation"), which is
no longer merely doubted but actively DISPUTED — src-0007's Table 4 supports it (IoC
extraction precision 0.82–0.88 vs TTP identification 0.2787/0.2270, same team/corpus/models)
while src-0006's Table 5 opposes it (failure subtypes span all four pipeline stages, e.g.
"Co-mention bias (Type 1.1) — stages 1234"). Cycle 10 explicitly DECLINED to open a
contradiction for that tension, reasoning that src-0006 is about where failure MECHANISMS
occur and src-0007 about where performance LEVELS differ, which are compatible; do not
overturn that without reading both tables. **CARRIED BY CYCLES 7, 8, 9, 10, 11, 12 AND 13 —
SEVEN CONSECUTIVE CYCLES.** Only a T2 has standing to do it. *Cycle 13 note: this is why
that issue is stuck at 3 — a single score is averaging a ~4 and a ~1.5, and it will keep
reading 3 forever regardless of new evidence, because averaging is the bug.*

**[2]** ATTACH src-0007 to `ttp-attack-mapping-reliability`: it is an unattached third
independent source (ATT&CK TTP identification P/R 0.2787/0.2270 GPT-4o, 0.3480/0.1759
o3-mini, 0.2387/0.1846 GPT-4o-FT, 0.1771/0.1414 GPT-4o-mini-FT on real production material
vs CTIBench's 0.6388 F1 ceiling) that cycles 10 and 13 cite in their rationales but
`graph.json`'s `candidate_resolutions` do not list (still `[src-0002, src-0005]`). It also
gives that issue's open_question[2] its first direct evidence, and the answer is that
fine-tuning made ATT&CK mapping WORSE. Not a contradiction with src-0002 (different
benchmark and corpus; real-world material being harder is the expected direction). Cycle 12
did not act (T3 has standing only over its own target); cycle 13 could not (T4 cannot edit
the graph). **FOURTH CYCLE CARRIED.**

**[3]** NEW-ISSUE CANDIDATE for a T2: LLM triage precision — src-0007 reports recall
(Accepted) 0.90–1.00 vs precision (Accepted) 0.27–0.40 across all four models, i.e. an
automated triage stage passes through roughly two of every three items a human analyst would
reject; no existing issue covers triage.

**[4]** THE G3 GATE IS SPECIFIED TWO INCOMPATIBLE WAYS: `prompts/t4_assess.md` step 3 says
an issue with an open contradiction LOSES `gates.g3_contradiction_demotion` points (a
subtraction), while `scripts/validate_state.py` lines 144–156 implements a CEILING (error
only if score > scale_max − demotion = 3). Cycle 10 applied the CEILING and argued why;
cycle 11 confirmed live that the reading changes the agenda; **cycle 13 applied the CEILING
again and recorded the arithmetic explicitly** (pre-demotion 2, ceiling not binding,
post-demotion 2). **FIFTH CYCLE CARRIED.** No task type in the state machine has standing to
reconcile the prompt and the validator. *Note: this has now been applied consistently three
times, so the de-facto behaviour is settled even though the specification is not — the risk
is a future cycle reading the prompt literally and diverging.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at
P5–P6, but the paper's body text says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance is
unaffected (encryption collapses detection either way) and no contradiction was opened,
because both readings are automated fetches of the same HTML and one demonstrably
mis-rendered characters. Needs a PDF-level check before anyone cites src-0008's phase
structure. Also: src-0008's per-phase percentages exist ONLY as pie charts (Figure 2) and
cannot be verified by table pull at all, whereas its Table 7 hallucination rates (Anthropic
0.11%, ChatGPT 0.23%, Gemini 4.8%, Grok 0, Cohere 0) are verified exact and their
"approximate" caveat can be lifted.

**[6]** THREE UNFINISHED SEARCH DIRECTIONS, open since cycle 9: citation-graph sweep of
arXiv 2506.11325 (`semanticscholar.org/arxiv/2506.11325` returns 404 — try Google Scholar,
arXiv listing pages, or Connected Papers); third-party evaluations of the IoC Searcher /
AlienVault OTX / VirusTotal baselines themselves; and the paywalled eLLM-CTI paper
(ScienceDirect S0167739X26001482, HTTP 403 to automated fetch, no preprint located).

**[7]** ctr-0001 RESOLUTION PATH: recover recall/F1 from src-0007's released code
(GitHub/HuggingFace per its abstract) to make its precision-only numbers comparable with
src-0003's F1, and/or find any source running an unscaffolded LLM against PRISM or a
LANCE-style scaffolded pipeline against CyberThreat-Eval. If the SYSTEM confound is
confirmed as the explanation, ctr-0001 should be CLOSED and folded into
`ioc-extraction-reliability`'s third candidate_resolution rather than left open.

**[8]** G2 RE-VERIFICATION COVERAGE TO DATE (restored from cycle 10 by cycle 12; updated by
cycle 13): src-0004 (c4, and c12 — passed verbatim), src-0003 (c5), src-0002 (c6), src-0001
(c7), src-0006 (c8), src-0005 (c9 substance-only, c11 verbatim — passed both), src-0008
(c10), **src-0012 (c13 — passed verbatim, and the "0 of 27" widget conflict was resolved as
a rendering artefact using the page's own body text)**. **src-0007 is still the only source
never re-verified**, and src-0009, src-0010 and src-0011 remain unverified since collection
in cycle 12. Next-highest-value targets: src-0011 (its 1.01% Security-venue figure is the
number most at risk of being mis-transferred to CTI, so its Table 3 deserves a verbatim
pull) or src-0007 (never checked at all).

**[9]** SANDBOX LIMITATION, unchanged from cycles 9, 10 and 12 and **hit again in cycle 13**:
`python3` and `curl` are blocked in this unattended run. `scores.json` validity was
therefore checked **by construction and by re-reading the edited seams**, not by a parse.
The file was written whole rather than patched, which reduces but does not eliminate the
risk. This is a weaker check than a parse and is recorded as such.

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Cycle 11's G2 verified all four of
its stored quotes verbatim against the arXiv abstract, but every claim it contributes is
abstract-level and directional. It is one of two sources holding
`ttp-attack-mapping-reliability` at 3 and the other (src-0002) is the only one supplying a
figure (0.6388 F1). Pulling CyberSOCEval's per-model/per-task scores from the full paper is
the cheapest thing that could move that issue, and it has been open since cycle 1.

**[11]** TIE-BREAK 3a IN `prompts/t5_select.md` IS UNDER-SPECIFIED. "An issue that others
depend_on outranks its dependents" admits a strict pairwise reading (applied in cycle 11;
inert on unrelated nodes) and an in-degree reading (not applied; would have selected
`consistency-calibration-as-failure-mode` instead). THE TWO READINGS SELECTED DIFFERENT
ISSUES. Separately, the policy has no deterministic tie-break after 3c and ran out entirely
on a genuine 2-vs-2 tie with identical `created_cycle`. Suggested fix for a cycle with
standing: add "3d. fewest total attempts first; then longest time since the issue last
received new evidence." Cycle 11 deliberately did NOT edit that file — T5 has no standing to
change the system's rules. Cycle 12 endorsed the proposed 3d from experience.
***Cycle 13 note: this fires again immediately.** The bottom of the graph is once more a
2-vs-2 tie, and once more between `ioc-extraction-reliability` and
`consistency-calibration-as-failure-mode` — the same pair, with the same identical
`created_cycle: 2`. This time the attempt penalty does break it (attempts [9] vs [3]), but
note that `consistency-calibration-as-failure-mode` is depended on by
`attribution-confident-wrong-gap` and by `task-dependent-reliability-framing`, so tie-break
3a's two readings point the SAME way here for once. Cycle 14 should say which rule actually
decided it.*

**[12]** THE STATE MACHINE HAS NO PATH TO STRUCTURAL WORK. T1→T2→T3→T4→T5→T3 is the only
cycle, and after the first pass it never returns to T2 — every subsequent lap runs
T3→T4→T5→T3. T2 is the ONLY task type with standing to split an issue, add a new issue, or
reconcile the prompt/validator disagreement, and carry-forward items [1], [3] and [4] have
now been blocked on that for seven, four and five cycles respectively. The refresh rule
provides an escape to T1 every 7th cycle but there is NO ANALOGOUS ESCAPE TO T2. Structural
finding about the loop design; belongs in the paper. *Cycle 13 note: cycle 13 is the fourth
task type in a row to hit this and be unable to act — T3 (c12) could not attach src-0007
outside its target, T4 (c13) cannot edit the graph at all. The items are not being forgotten;
they are structurally unreachable, which is a stronger and more interesting result than
"the agent neglected them".*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400, "The
following domains are not accessible to our user agent". Der Spiegel is the upstream primary
for the entire ENISA incident, so this is a permanent structural gap in the evidence base,
not a to-do. Do not re-spend budget fetching it the same way. Remaining routes to the 26/492
figure: count footnotes in the archived original/v1.1 PDF against v1.2, or locate Prof.
Christian Dietrich's / Institut für Internet-Sicherheit's own writeup (searched briefly in
cycle 12, not found). *Cycle 13 did not retry, per this item.*

**[14]** THE TWO ENISA v1.2 PDFs WERE NEVER OPENED. Only the landing pages were fetched, so
"ENISA never disclosed the AI use" is established for the publication pages, not for the
documents' front matter/legal notices. Pulling the front matter of
`ENISA Threat Landscape 2025_v1.2.pdf` (2026-01 path) would either strengthen that claim to
document level or refute it — a cheap, decisive check. The same PDFs are also the route to
carry-forward [13]'s footnote count. *Cycle 13 note: this now matters more than it did,
because `institutional-incident-real-world-impact` was raised to 3 and the AI-disclosure
finding is one of the things carrying it.*

**[15]** SCOPE-ADJACENT CASE DELIBERATELY NOT ADDED AS A SOURCE, recorded so it is not
re-searched from scratch: curl ended its HackerOne bug bounty on 31 January 2026 after a
flood of AI-generated "slop" vulnerability reports, with reported figures of ~20% of
submissions being AI slop by mid-2025 and the confirmed-vulnerability rate falling from ~15%
historically to under 5%
(bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/;
The Register's URL 404'd on the path tried). Excluded because it is a different phenomenon
from this issue's subject: AI-generated security claims arriving *inbound* and rejected at
triage, not AI-generated content *published* by an institution. It would fit a new issue on
AI slop in security reporting pipelines — a T2 candidate, alongside [3].

**[16] NEW (cycle 13).** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION, AND IT
IS THE BEST LEAD ON THE BASE-RATE QUESTION ANY CYCLE HAS FOUND. Verbatim from
`https://gptzero.me/investigations/ey`: it has "set up an automated pipeline to search for
vibe citations by finding and scanning public reports from major consulting firms", is
releasing findings "one report at a time", and has already investigated "a government
publication, **two different Deloitte reports**, and prestigious machine learning /
artificial intelligence conferences like NeurIPS and ICLR". This matters because
`institutional-incident-real-world-impact`'s base-rate question is blocked on the absence of
any systematic audit of *non-academic published security reports*, and this is one — run by
the same party that found the EY case. **A T1 should chase `gptzero.me/news/tag/investigations`
for the Deloitte and government-publication write-ups**, which would take the incident count
from 2 to 4–5 named cases across three institution types. Caveats to carry with it: GPTZero
is a commercial AI-detection vendor reporting on the value of its own product, no *rate* is
published (only individual cases, by design), and the scorecard widget on its pages renders
as "0 of N" to automated fetch — read the body text, not the widget.
