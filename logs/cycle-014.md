# Cycle 014 — T5 Select

## Task performed

T5 (Select) per `prompts/t5_select.md`. Ranked all six issues in
`state/issues/graph.json` against `state/assessments/scores.json` (written cycle 13, one
cycle old — the correct input), applied the selection policy mechanically, and wrote the
next cycle's task. `target_issue` was null by design: a T5 selects, it does not target.

**Selected: `consistency-calibration-as-failure-mode`.**
**Next task written: T1 (collect), not T3 — the refresh rule fired.**

### The refresh rule fired, and I verified the arithmetic rather than inheriting it

`prompts/t5_select.md` step 4: *"if `current_cycle % schedule.collect_refresh_every == 0`,
the next task is `T1` targeting the selected issue (bring in fresh evidence) instead of
`T3`."* `config.yml` line 17 reads `collect_refresh_every: 7`; `state/meta.json` line 2
reads `"cycle": 14`. **14 % 7 == 0, so this cycle writes a T1.** I checked both values at
source (`grep` output in this cycle's tool log) rather than taking them from the handoff.

**This rule has never fired before in fourteen cycles.** Cycle 7 was the only prior
multiple of 7 and it happened to be a T4, so there is no precedent to copy. The failure
mode the handoff warned about — writing a T3 out of habit, because every lap since cycle 7
has been T3→T4→T5→T3 — was real and is avoided. I did not conclude the rule fails to fire,
so no such explanation is owed.

### The ranking table

Candidate set = all issues with score < 5 = **all six**. Base priority = score, lower
first. Penalty column applies `scoring.tie_break_recent_attempt_penalty: 1` per attempt
within the last 5 cycles.

| rank | issue | score | attempts | 3b penalty | effective | in-degree (3a) | created | decided by |
|---|---|---|---|---|---|---|---|---|
| **1** | **`consistency-calibration-as-failure-mode`** | **2** | [3] | 0 | **2** | **2** | 2 | 3a (in-degree) / 3d (fallthrough) — **SELECTED** |
| 2 | `ioc-extraction-reliability` | 2 | [9] | 0 | 2 | 1 | 2 | lost on 3a in-degree and on 3d |
| 3= | `ttp-attack-mapping-reliability` | 3 | [] | 0 | 3 | 1 | 2 | tie with rank 3= unbroken (not selected, so not resolved) |
| 3= | `attribution-confident-wrong-gap` | 3 | [] | 0 | 3 | 1 | 2 | tie with rank 3= unbroken (not selected, so not resolved) |
| 5 | `task-dependent-reliability-framing` | 3 | [6] | 0 | 3 | 0 | 2 | 3a: it is downstream of all four of the above |
| 6 | `institutional-incident-real-world-impact` | 3 | [12] | **+1** | **4** | 0 | 2 | attempt penalty (cycle 12 is inside the window) |

I re-derived the scores from `scores.json` rather than trusting the handoff's list, per the
precedent that cycle 11 caught cycle 10's queue entry asserting a premise that was false on
inspection. **The handoff's figures were correct**: 3, 2, 2, 3, 3, 3, with
`institutional-incident-real-world-impact` raised 2→3 by cycle 13. The bottom is a two-way
tie at 2.

### The edge case: how I counted "within the last 5 cycles"

**I counted the last five cycles as {10, 11, 12, 13, 14} — the five most recent cycles,
inclusive of the current one. Cycle 9 is the sixth-most-recent and therefore falls
OUTSIDE the window, so `ioc-extraction-reliability` takes NO attempt penalty this cycle.**

Reasoning, stated because the alternative is defensible and a future cycle may need to
reproduce this: "the last 5 cycles" denotes a set of five cycles. Enumerating five cycles
backwards from the current one gives 10–14. The alternative test `current − attempt ≤ 5`
admits cycles 9 through 14, which is a window six cycles wide and so contradicts the word
"5". At cycle 13 the question did not arise (13 − 9 = 4, unambiguously inside, which is why
cycle 13's own note assumed the penalty would break the tie). At cycle 14 it does, and the
penalty vanishes. The same rule applied to `institutional-incident-real-world-impact`
(attempt at cycle 12, inside {10..14}) gives it +1, which is what pushes it to rank 6.

**Consequence: the 2-vs-2 tie is NOT broken by 3b.** 3c (older `created_cycle` first) does
not break it either — both issues have `created_cycle: 2`. This is the exact dead end
cycle 11 hit and recorded as carry-forward **[11]**: the policy runs out of rules.

### How the tie was actually broken — two independent routes, same answer

**Route A — tie-break 3a under the in-degree reading.** `consistency-calibration-as-failure-mode`
is depended on by **two** issues (`attribution-confident-wrong-gap` and
`task-dependent-reliability-framing`); `ioc-extraction-reliability` is depended on by
**one** (`task-dependent-reliability-framing` only). Under this reading 3a decides it
outright and 3b/3c/3d are never reached.

**Route B — strict pairwise reading (the reading cycle 11 applied), then fallthrough.**
Neither issue depends on the other, so 3a is inert; 3b gives no penalty (above); 3c ties on
`created_cycle: 2`; policy exhausted. Applying carry-forward [11]'s proposed **3d** as an
explicitly-flagged judgement call, per the cycle-11/cycle-12 precedent: *"fewest total
attempts first; then longest time since the issue last received new evidence."* First
clause **also ties** — both issues have exactly one recorded attempt (`[3]` and `[9]`).
Second clause decides: `consistency-calibration-as-failure-mode` last received new evidence
at **cycle 1** (src-0001; both its candidate_resolutions cite it and nothing else), whereas
`ioc-extraction-reliability` received src-0007 and src-0008 at **cycle 9**. Longest time
since new evidence → `consistency-calibration-as-failure-mode`.

**The two readings converge**, so the selection is robust to the under-specification that
[11] flags. Worth recording as evaluation data: this is the first time the two readings
have been observed to agree — cycle 11 recorded them selecting *different* issues. Note
also that 3d's *first* clause is useless on this pair, which cycle 11's proposal did not
anticipate; if a cycle with standing ever adopts 3d, the "longest time since new evidence"
clause is the one doing the work and should probably be promoted above the attempt count.

**I did NOT edit `prompts/t5_select.md` to add 3d.** T5 has no standing to change the
system's rules (carry-forward [12]).

### Sanity check on the merits

The mechanical result is also the right answer, so I am not merely obeying it. This issue
is the graph's clearest structural dead end: both candidate_resolutions cite `[src-0001]`
and nothing else — two candidates, one source, because the cycle-3 candidate sharpens the
cycle-2 candidate using the same paper. Cycles 9 and 10 each searched the existing base for
a second source and rejected every candidate with stated reasons (src-0007 has no
repeated-query consistency measure and no ECE/Brier anywhere; src-0008 measures a
JavaScript code-analysis task). Cycle 12's four new sources touch consistency and
calibration not at all. The issue therefore **cannot leave 2 without a genuinely new second
source** — precisely what a T1 delivers and what a T3 cannot. Its last attempt was cycle 3,
eleven cycles ago. The refresh rule firing on this selection is fortunate, not awkward.

### A correction: carry-forward [12] is wrong about T2 being unreachable

Carry-forward [12] has claimed for several cycles that "the refresh rule provides an escape
to T1 every 7th cycle but there is **NO ANALOGOUS ESCAPE TO T2**," and this cycle's own
queue entry repeated it ("the escape goes to T1 and never to T2"). I checked
`prompts/system.md` line 46, which reads `T1→T2, T2→T3, T3→T4, T4→T5, T5→T3`.

**A T1 hands off to a T2.** So the refresh rule chains **T5 → T1 → T2**: cycle 15 is a T1
and cycle 16 will be the first T2 since the opening pass. The escape to structural work
exists; it is just one cycle further along than anyone noticed, and it recurs every seventh
cycle plus one. Carry-forward items **[1]** (split `task-dependent-reliability-framing`),
**[3]** (new triage issue) and **[4]** (the G3 prompt/validator disagreement) have been
blocked for seven, four and five cycles on the belief that no task type can reach them, and
that belief was false. I have written all three explicitly into the T1's instructions with
enough detail for cycle 16 to act, so the one structural opening in fourteen cycles is not
spent on a generic "review the graph". New carry-forward item **[17]**.

## Retrospection

**Target chosen: `src-0011` (GhostCite, `https://arxiv.org/html/2602.06718v1`), its
per-venue citation-validity rates — specifically the claim that "Security venues are not
cleaner than AI venues (1.01% vs 1.08%)" and the per-venue spread NDSS 2.56%, CCS 1.14%,
USENIX 0.57%, S&P 0.56%.**

Chosen over src-0007 (the only source never re-verified) because src-0011's 1.01%
Security-venue figure is the single number in the whole knowledge base most at risk of
being mis-transferred into a CTI base rate it does not support — and cycle 13 just raised
`institutional-incident-real-world-impact` to 3 while explicitly naming that
mis-transfer as "the single most likely error available". A number that the state itself
flags as dangerous outranks a routine first check. src-0007 is now the standout target for
cycle 15 and I have said so in the queue entry.

**Result: PASSES — verbatim, in full.** But it took two fetches, and the reason is worth
recording.

**Fetch 1** asked for Table 3 verbatim plus the aggregate Security/AI rows. It returned the
table exactly as our claim records it:

> **Table 3: Invalid citations by conference. (sorted by invalid citation number)**
> NeurIPS 59 / 332 / 391 / 308 / **1.51%**; ICML 22 / 103 / 125 / 104 / **0.93%**;
> AAAI 21 / 85 / 106 / 86 / **0.62%**; IJCAI 11 / 42 / 53 / 51 / **0.96%**;
> NDSS 4 / 19 / 23 / 18 / **2.56%**; CCS 11 / 9 / 20 / 20 / **1.14%**;
> USENIX 6 / 6 / 12 / 11 / **0.57%**; S&P 1 / 7 / 8 / 6 / **0.56%**;
> Total 135 / 603 / 738 / 604 / **1.07%**

All eight per-venue rates match `index.json` exactly. Also confirmed verbatim: *"In total,
604 papers (1.07% of 56,381) contained at least one invalid citation"*; *"Comparing 2025 to
the 2020–2024 average (0.89%), we observe an 80.9% increase in the invalid citation rate"*;
*"Sixteen trained research assistants manually reviewed all flagged citations… Each
citation was independently checked at least twice"*; and the limitation *"The detected
invalid citations are likely to be a conservative lower bound on the true hallucination
rate."* The abstract's 13-LLM benchmark range (14.23%–94.93%) and the survey figures
(41.5% / 44.4% / 76.7% / 80.0%, 94 valid responses) are verbatim as recorded.

**But Table 3 contains no Security or AI/ML aggregate row**, so the load-bearing 1.01%
figure was *not* in the artefact I pulled. Applying the methodological rule — never accept
a summary, and never accept absence-from-one-artefact as absence — I fetched again,
targeting the literal strings. **Fetch 2** recovered it from the body prose:

> "While AI/ML conferences have a much higher absolute number of papers with invalid
> citations (largely due to their much greater publication volumes), the overall proportion
> of papers with invalid citations is remarkably similar: **1.08% for AI venues vs. 1.01%
> for Security venues**."

Confirmed, and the surrounding sentence strengthens rather than weakens our scope limit:
the paper itself frames the comparison as proportions over *conference papers*, which is
exactly the population our `src-0011.md` limitations section says it cannot be transferred
out of. Arithmetic cross-check, since the aggregates are derivable: Security papers with
invalid citations = 18+20+11+6 = 55; AI/ML = 308+104+86+51 = 549; 55/0.0101 ≈ 5,446 and
549/0.0108 ≈ 50,833, summing to ≈56,279 against the stated 56,381 — internally consistent
to within rounding. **No contradiction entry opened.**

**One discrepancy recorded, deliberately NOT raised to a contradiction.** The body prose
says *"NeurIPS exhibiting the highest absolute count (391 papers)"*, but 391 is Table 3's
**Invalid citation** count for NeurIPS; its **Papers** count is 308. This is the paper
disagreeing with itself in prose, not two of our sources disagreeing, and no claim in our
knowledge base repeats the erroneous phrasing — `index.json` records the per-venue *rates*,
which are unaffected. G3 governs conflicts between supported claims in *our* state, so
opening an entry would misuse it. Flagged here so a future cycle quoting src-0011's counts
uses Table 3's columns and not that sentence. New carry-forward item **[18]**.

**Method note for future cycles, now generalised:** one verbatim pull is not always enough.
The rule "ask for the entire table verbatim" assumed the number lives in the table. Here it
did not. The corrected rule, written into the T1's instructions: if the number you are
checking is absent from the artefact you pulled, that is not a refutation — pull again
against the literal string before concluding anything. This is the fifth consecutive cycle
in which the verbatim discipline changed the outcome.

## Changes made

- `state/queue/next_task.json` — **T1 (collect)** targeting
  `consistency-calibration-as-failure-mode`, per the refresh rule. Instructions quote all
  four of the issue's `open_questions` **verbatim from `graph.json`**, define what counts as
  a qualifying source, give four ordered search directions, list the dead ends cycles 9/10/12
  already walked so they are not re-walked, state `budget.max_new_sources: 5` as a ceiling
  not a target, and carry the G2 target (src-0007), the corrected verbatim rule, and the
  relevant carry-forward items. It also instructs cycle 15 that its own next task is a **T2**
  and names items [1], [3] and [4] as that T2's agenda.
- `state/queue/last_completed_task.txt` — `T5 select`.
- **No edits to `state/issues/graph.json`** — retrospection passed, no contradiction opened;
  the src-0011 prose/table discrepancy is internal to that paper and is logged, not filed.
  T5 has no standing to restructure the graph in any case.
- **No edits to `scores.json`, `prompts/` or `scripts/`.** In particular I did not add
  tie-break 3d to `prompts/t5_select.md` despite using it, and did not add cycle 14 to any
  `attempts` array — `attempts` records issue-working cycles (T1/T3), and cycle 14 did not
  work an issue. Cycle 15 should append 15 to this issue's `attempts`.

## Next task rationale

Two independent decisions, both forced rather than chosen:

**What to work on** — `consistency-calibration-as-failure-mode`, tied for lowest score at 2
and winning the tie on tie-break 3a's in-degree reading, with the strict pairwise reading
falling through 3b (no penalty at cycle 14, per the counting decision recorded above) and
3c (identical `created_cycle`) into 3d's "longest time since new evidence" clause, which
points the same way. Both routes agree; the full table is above.

**What kind of task** — T1, per the refresh rule, `14 % 7 == 0`. This is the first firing in
the loop's history. It is also the right task on the merits independently of the rule: the
issue is capped at 2 purely by source count (both candidates cite `[src-0001]` alone), so a
T3 would re-analyse the same paper a third time and could not move the score, while a single
qualifying independent measurement of repeated-query consistency or ECE/Brier calibration on
CTI or security tasks would. Adding one such source is a complete cycle; adding none and
saying so honestly is an acceptable outcome, and the T1's instructions say so, with
carry-forward [10] (capture CyberSOCEval's per-model numbers, never once done, bears on this
issue's open_questions (ii) and (iii)) named as the fallback if the primary searches come up
dry.

## Budget

- Fetches: **2** (both `arxiv.org/html/2602.06718v1` — Table 3 and abstract; then a targeted
  literal-string pull for 1.01/1.08). The second was necessary, not redundant.
- Searches: **0**. A T5 is a ranking task over state that already exists; spending search
  budget would have been padding.
- Reads: 7 state/prompt/config files, 1 prior log (`cycle-013.md`), 2 `grep` passes to
  re-derive the refresh arithmetic and the tie-break inputs at source.
- Writes: 3 files (`next_task.json`, this log, `last_completed_task.txt`).
- Turns: ~8 of 50.
- Not spent: no `spiegel.de` attempt (carry-forward [13] — permanent), no ENISA PDF pull
  (carry-forward [14] — collection work, no T5 standing), no GPTZero investigations sweep
  (carry-forward [16] — a T1 lead, but for a different issue than the one selected).

---

## Carry-forward items

All sixteen items from `logs/cycle-013.md` are reproduced below, **including the ones I
cannot act on**, plus two new. Three handoffs have now lost or corrupted state — the
cycle-11 handoff dropped [8] and [9] (recovered by cycle 12 from `logs/cycle-010.md`), and
this cycle found [12]'s central claim to be factually wrong — so this section is load-bearing,
not ceremonial.

**[1]** SPLIT `task-dependent-reliability-framing` into the NARROW claim (CTI reliability
varies by sub-task; src-0001, src-0002, src-0006, src-0007; merits 3) and the SPECIFIC
ORDINAL AXIS ("mechanical extraction < classification < attribution < generation"), which is
no longer merely doubted but actively DISPUTED — src-0007's Table 4 supports it (IoC
extraction precision 0.82–0.88 vs TTP identification 0.2787/0.2270, same team/corpus/models)
while src-0006's Table 5 opposes it (failure subtypes span all four pipeline stages, e.g.
"Co-mention bias (Type 1.1) — stages 1234"). Cycle 10 explicitly DECLINED to open a
contradiction for that tension, reasoning that src-0006 is about where failure MECHANISMS
occur and src-0007 about where performance LEVELS differ, which are compatible; do not
overturn that without reading both tables. **CARRIED BY CYCLES 7–14 — EIGHT CONSECUTIVE
CYCLES.** Only a T2 has standing. *Cycle 14 note: **a T2 is now scheduled for cycle 16**
(see [17]), and this item is written into cycle 15's queue entry as that T2's first agenda
item. It is reachable for the first time.*

**[2]** ATTACH src-0007 to `ttp-attack-mapping-reliability`: it is an unattached third
independent source (ATT&CK TTP identification P/R 0.2787/0.2270 GPT-4o, 0.3480/0.1759
o3-mini, 0.2387/0.1846 GPT-4o-FT, 0.1771/0.1414 GPT-4o-mini-FT on real production material
vs CTIBench's 0.6388 F1 ceiling) that cycles 10 and 13 cite in their rationales but
`graph.json`'s `candidate_resolutions` do not list (still `[src-0002, src-0005]`). It also
gives that issue's open_question[2] its first direct evidence, and the answer is that
fine-tuning made ATT&CK mapping WORSE. Not a contradiction with src-0002 (different
benchmark and corpus; real-world material being harder is the expected direction). **FIFTH
CYCLE CARRIED.** A T2 has standing to do this too.

**[3]** NEW-ISSUE CANDIDATE for a T2: LLM triage precision — src-0007 reports recall
(Accepted) 0.90–1.00 vs precision (Accepted) 0.27–0.40 across all four models, i.e. an
automated triage stage passes through roughly two of every three items a human analyst would
reject; no existing issue covers triage. *Cycle 14 note: written into cycle 15's queue entry
as agenda item 2 for the cycle-16 T2.*

**[4]** THE G3 GATE IS SPECIFIED TWO INCOMPATIBLE WAYS: `prompts/t4_assess.md` step 3 says
an issue with an open contradiction LOSES `gates.g3_contradiction_demotion` points (a
subtraction), while `scripts/validate_state.py` lines 144–156 implements a CEILING (error
only if score > scale_max − demotion = 3). Cycle 10 applied the CEILING and argued why;
cycle 11 confirmed live that the reading changes the agenda; cycle 13 applied the CEILING
again with the arithmetic recorded (pre-demotion 2, ceiling not binding, post-demotion 2).
**SIXTH CYCLE CARRIED.** *Cycle 14 note: previously believed unreachable by any task type;
that is [12]'s error. A T2 is the closest thing to standing and one is now scheduled — this
is agenda item 3 in cycle 15's queue entry. Note the de-facto behaviour is settled by three
consistent applications even though the specification is not; the risk is a future cycle
reading the prompt literally and diverging.*

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
*Cycle 14 note: the same citation-graph technique is what cycle 15 needs for forward
citations of arXiv 2503.23175, and the 404 caveat is carried into its queue entry.*

**[7]** ctr-0001 RESOLUTION PATH: recover recall/F1 from src-0007's released code
(GitHub/HuggingFace per its abstract) to make its precision-only numbers comparable with
src-0003's F1, and/or find any source running an unscaffolded LLM against PRISM or a
LANCE-style scaffolded pipeline against CyberThreat-Eval. If the SYSTEM confound is
confirmed as the explanation, ctr-0001 should be CLOSED and folded into
`ioc-extraction-reliability`'s third candidate_resolution rather than left open.

**[8]** G2 RE-VERIFICATION COVERAGE TO DATE (restored from cycle 10 by cycle 12; updated by
cycles 13 and 14): src-0004 (c4, c12), src-0003 (c5), src-0002 (c6), src-0001 (c7), src-0006
(c8), src-0005 (c9 substance-only, c11 verbatim), src-0008 (c10), src-0012 (c13 — passed,
"0 of 27" widget resolved as a rendering artefact), **src-0011 (c14 — PASSED verbatim;
Table 3's eight per-venue rates confirmed exactly, and the 1.01% Security vs 1.08% AI
sentence recovered from body prose on a second targeted fetch after being absent from the
table)**. **src-0007 is STILL the only source never re-verified** — and it is load-bearing
for three issues and is one side of ctr-0001, which makes it cycle 15's obvious target.
src-0009 and src-0010 also remain unverified since collection in cycle 12.

**[9]** SANDBOX LIMITATION, unchanged from cycles 9, 10, 12 and 13: `python3` and `curl` are
blocked in this unattended run. JSON validity must be checked by construction and by
re-reading the edited seams, not by a parse. *Cycle 14 wrote `next_task.json` whole rather
than patching it, and used single quotes inside the instruction string wherever possible to
avoid escaping errors.*

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Cycle 11's G2 verified all four of
its stored quotes verbatim against the arXiv abstract, but every claim it contributes is
abstract-level and directional. It is one of two sources holding
`ttp-attack-mapping-reliability` at 3 and the other (src-0002) is the only one supplying a
figure (0.6388 F1). Pulling CyberSOCEval's per-model/per-task scores from the full paper is
the cheapest thing that could move that issue, and it has been open since cycle 1. *Cycle 14
note: it also bears on the SELECTED issue's open_questions (ii) and (iii), which ask whether
consistency/calibration findings replicate on src-0002's and src-0005's model lists — so it
is named in cycle 15's queue entry as the fallback if the primary searches come up dry.*

**[11]** TIE-BREAK 3a IN `prompts/t5_select.md` IS UNDER-SPECIFIED, and the policy has no
deterministic tie-break after 3c. "An issue that others depend_on outranks its dependents"
admits a strict pairwise reading (cycle 11) and an in-degree reading. Suggested fix for a
cycle with standing: add "3d. fewest total attempts first; then longest time since the issue
last received new evidence." **Cycle 14 hit this for the third time, on the same pair of
issues, with the same identical `created_cycle: 2`** — and this time 3b did NOT break it
either, because cycle 9 falls outside the {10..14} window. *Two refinements from cycle 14's
experience: (a) the two readings of 3a AGREED for the first time (cycle 11 recorded them
selecting different issues), so the divergence is intermittent, not systematic; (b) 3d's
first clause "fewest total attempts" is ALSO useless on this pair — both issues have exactly
one attempt — so it was 3d's second clause, "longest time since new evidence", that actually
decided. If a cycle with standing adopts 3d, promote that clause above the attempt count.*
Cycle 14, like cycle 11, did NOT edit the prompt: T5 has no standing to change the rules.

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger
claim was WRONG; see [17].** T2 is the only task type with standing to split an issue, add a
new issue, or reconcile the prompt/validator disagreement, and items [1], [3] and [4] have
been blocked on that for eight, five and six cycles. What cycles 11–13 recorded — that the
loop "never returns to T2" and that there is "NO ANALOGOUS ESCAPE TO T2" — is false:
`prompts/system.md` line 46 specifies `T1→T2`, so the refresh rule's T1 chains into a T2.
The correct statement is that T2 is reachable only every seventh cycle plus one, via the
refresh rule, and that the default lap T3→T4→T5→T3 indeed never reaches it. That is still a
real structural finding about loop design and still belongs in the paper — a 1-in-7 rate for
the only task type that can restructure the graph is why these items aged eight cycles — but
"structurally unreachable" overstated it, and three consecutive cycles repeated the
overstatement without checking `system.md`. **A carry-forward item that no cycle has standing
to act on is also a carry-forward item that no cycle re-verifies.**

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400, "The
following domains are not accessible to our user agent". Der Spiegel is the upstream primary
for the entire ENISA incident, so this is a permanent structural gap in the evidence base,
not a to-do. Do not re-spend budget fetching it the same way. Remaining routes to the 26/492
figure: count footnotes in the archived original/v1.1 PDF against v1.2, or locate Prof.
Christian Dietrich's / Institut für Internet-Sicherheit's own writeup. *Cycle 14 did not
retry, per this item.*

**[14]** THE TWO ENISA v1.2 PDFs WERE NEVER OPENED. Only the landing pages were fetched, so
"ENISA never disclosed the AI use" is established for the publication pages, not for the
documents' front matter/legal notices. Pulling the front matter of
`ENISA Threat Landscape 2025_v1.2.pdf` (2026-01 path) would either strengthen that claim to
document level or refute it — a cheap, decisive check, and the same PDFs are the route to
[13]'s footnote count. Matters more since `institutional-incident-real-world-impact` was
raised to 3 partly on the AI-disclosure finding.

**[15]** SCOPE-ADJACENT CASE DELIBERATELY NOT ADDED AS A SOURCE, recorded so it is not
re-searched from scratch: curl ended its HackerOne bug bounty on 31 January 2026 after a
flood of AI-generated "slop" vulnerability reports, with reported figures of ~20% of
submissions being AI slop by mid-2025 and the confirmed-vulnerability rate falling from ~15%
historically to under 5%
(bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/;
The Register's URL 404'd on the path tried). Excluded because it is a different phenomenon:
AI-generated security claims arriving *inbound* and rejected at triage, not AI-generated
content *published* by an institution. It would fit a new issue on AI slop in security
reporting pipelines — a T2 candidate, alongside [3].

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION, AND IT IS THE BEST LEAD
ON THE BASE-RATE QUESTION ANY CYCLE HAS FOUND. Verbatim from
`https://gptzero.me/investigations/ey`: it has "set up an automated pipeline to search for
vibe citations by finding and scanning public reports from major consulting firms", is
releasing findings "one report at a time", and has already investigated "a government
publication, **two different Deloitte reports**, and prestigious machine learning /
artificial intelligence conferences like NeurIPS and ICLR". A T1 should chase
`gptzero.me/news/tag/investigations` for the Deloitte and government-publication write-ups,
which would take the incident count from 2 to 4–5 named cases across three institution types.
Caveats: GPTZero is a commercial AI-detection vendor reporting on the value of its own
product, no *rate* is published (only individual cases, by design), and the scorecard widget
renders as "0 of N" to automated fetch — read the body text, not the widget. *Cycle 14 note:
this is a lead for `institutional-incident-real-world-impact`, NOT for the issue selected
this cycle; cycle 15's queue entry says so explicitly so the T1 is not pulled off-target.*

**[17] NEW (cycle 14).** THE REFRESH RULE IS THE ESCAPE TO T2, ONE CYCLE LATER THAN ANYONE
NOTICED. `prompts/system.md` line 46: `T1→T2, T2→T3, T3→T4, T4→T5, T5→T3`. The refresh rule
makes every seventh cycle's T5 emit a T1, and a T1 emits a T2. So the chain is
**T5 → T1 → T2**, and **cycle 16 will be the first T2 since the opening pass**. This
corrects [12]. Practical consequence: items [1], [3] and [4] are actionable at cycle 16 and
have been written into cycle 15's queue entry as that T2's agenda so the opening is not spent
on a generic instruction. Structural note for the paper: the *only* task type that can
restructure the issue graph fires at most once every seven cycles and only as a side effect
of a rule whose stated purpose is refreshing evidence — the loop has no first-class trigger
for "the graph itself is the problem", which is why five cycles in a row recorded the same
split as the highest-value available change and none could make it.

**[18] NEW (cycle 14).** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly, but cite
carefully. The body text says "NeurIPS exhibiting the highest absolute count (**391 papers**)"
while its own Table 3 gives NeurIPS **391 invalid citations across 308 papers** — the prose
conflates the two columns. No claim in our knowledge base repeats the error (`index.json`
records rates, which are unaffected) and **no G3 entry was opened**: this is one source
disagreeing with itself, not two of our supported claims in conflict, so filing it would
misuse the gate. Any future cycle quoting src-0011's *counts* should take them from Table 3's
columns (Error / Ghost / Invalid / Papers / Rate) and not from that sentence.
