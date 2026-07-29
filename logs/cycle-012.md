# Cycle 012 — T3 Investigate: `institutional-incident-real-world-impact`

## Task performed

T3 on `institutional-incident-real-world-impact` ("Have AI-generated CTI failures already
reached production/publication at real institutions, and how do institutions respond when
caught?"). This issue was selected by cycle 11 because it was the only issue in the graph
never targeted by any T1 or T3 in eleven cycles (`attempts: []`) and the only one with no
new evidence since cycle 1 — its score of 2 measured our neglect, not the world. Its
entire evidence base was one secondary source (src-0004, Heise reporting Der Spiegel's
reporting).

Per the T3 prompt, the knowledge base was consulted first and exhausted immediately, as
the queue predicted: no source other than src-0004 documents a production/publication
incident at a named institution, and cycle 10 had already checked and rejected src-0007
and src-0008 as benchmarks rather than incident reports. The cycle was therefore almost
entirely search and primary-source verification. Four new sources were added (budget:
`max_new_sources: 5`, so one unused).

**What the three open questions actually resolved to:**

**OQ[2] — does a primary source confirm the 26/492 figure? For the NUMBER, no; for the
INCIDENT'S STRUCTURE, yes, and this is the cycle's most solid result.** ENISA's own
publication pages for *both* affected reports were located and carry verbatim revision
notices:

- ENISA Threat Landscape 2025 (published 1 Oct 2025) — "Revision Notice – Version 1.2.
  (09 January 2026): This publication has been updated to edit some links." (src-0009)
- ENISA Sectorial Threat Landscape: Public Administration (published 6 Nov 2025) —
  "Revision Notice – Version 1.2 (09 January 2026): This publication has been updated to
  correct some broken links and typos." (src-0010)

Two reports, October and November 2025, both corrected for links on the same date — this
independently corroborates, from ENISA's own artefacts, the report count, the dates, the
link-related defect type, and the "updated version posted 2026-01-09" detail that
src-0004's file recorded only as *related reporting*. What ENISA's own record does **not**
contain is any footnote count and any mention of AI. So the 26-of-492 figure remains
sourced to Der Spiegel via Heise, corroborated only by outlets (cybernews, Tagesspiegel,
derStandard) that themselves cite Der Spiegel — not independent corroboration.

**Der Spiegel's original article could not be retrieved: `spiegel.de` is blocked to this
agent's user agent** (WebSearch returns HTTP 400, "The following domains are not
accessible to our user agent"). This is an infrastructure limit, not an unsearched
direction; future cycles should not re-spend budget on it the same way. Recorded in the
issue's open_questions so it survives.

**No contradiction was opened over ENISA's silence, and the reasoning is deliberate.**
ENISA's revision notices assign *no cause at all* to the link defects. Silence is not a
competing claim. G3 requires two supported claims in conflict; "ENISA says links were
edited" and "Der Spiegel says 26 footnotes were wrong and AI was involved" are compatible.
Opening a contradiction here would be the cycle-8 failure mode (a spurious G3 off a
non-conflict) in a new costume. The under-disclosure is recorded as a *finding* instead.

**OQ[1] — was AI usage disclosed, and did policy change? First half now closed, and the
answer is stronger than the issue previously recorded.** ENISA's AI usage was not
disclosed pre-publication and was admitted only when Der Spiegel asked. New this cycle:
as of 2026-07-29 — ~8 months after exposure and ~6 months after the v1.2 corrections —
*neither* ENISA publication page carries any mention of AI or generative AI. The
non-disclosure did not merely precede publication; it persists in the corrected public
record, which describes the fix in purely mechanical terms. Still open: any ENISA internal
policy change (searched, none published found), any peer-agency policy change, and a
PDF-front-matter check (only landing pages were pulled, so "no AI disclosure anywhere" is
established for the pages, not the documents).

**OQ[0] — base rate. NOT answered, exactly as the queue warned, and I did not pretend
otherwise.** The queue's warning (c) was correct and load-bearing: finding a second
anecdote gives a second data point, not a rate. I found one, and recorded it as evidence
of *recurrence*, not frequency:

- **A second named institutional incident (src-0012):** EY Canada's 2025 report "Points of
  Attack: Uncovering Cyber Threats and Fraud in Loyalty Systems" was found by GPTZero
  (14 May 2026) to have **16 of 27 references hallucinated**, with "more than a half-dozen
  footnotes led to dead webpages or did not contain the cited information". EY Canada
  removed the study from its website. Same discovery route as ENISA — an outsider clicking
  through footnotes, not internal QA.

The thing that would actually move OQ[0] is a systematic audit, so I searched for one
directly rather than collecting a third anecdote. The nearest one found is **src-0011
(GhostCite)**: 2.2M citations across 56,381 papers at top AI/ML *and Security* venues
(2020–2025), with automated flagging followed by manual review of every flagged citation
by 16 trained assistants; **1.07% of papers overall and 1.01% of Security-venue papers
contain at least one invalid or fabricated citation, with an 80.9% increase in 2025
alone**, described by its own authors as "a conservative lower bound". Per-venue: NDSS
2.56%, CCS 1.14%, USENIX 0.57%, S&P 0.56%.

**This is not the CTI base rate and is recorded at `proposed`, not `supported`.** The
population is peer-reviewed conference papers (which have reviewers; CTI reports do not),
the ghost-citation definition keys on absence from academic databases (largely
inapplicable to CTI footnotes, which are news/vendor URLs), and the rate is per-*paper*
where src-0004's 26/492 is per-*footnote* — comparing the two numbers directly would be an
error, and the source file and index entry both say so explicitly. OQ[0] was rewritten to
specify what would actually close it (a link-resolution sweep over N reports from M
publishers; a disclosure-policy survey; or an audit of vendor/agency reports if one
exists — searched this cycle, none found).

**A second, unexpected result on the issue's own second question** ("how do institutions
respond when caught?") is that there is no single response pattern to report: EY
**withdrew** the report and issued a statement invoking its "organisation-wide commitment
to the responsible use of AI"; ENISA **retained** both reports, silently patched links,
called the errors "human errors" to the press, and still carries no AI disclosure. The
common element is that neither institution's internal QA caught it and both moved only
after an external party published the finding. Two new open questions were added for this
(what predicts withdraw-vs-patch; does any CTI publisher run pre-release link
verification).

## Retrospection (G2)

**Target chosen: src-0004**, over the alternative candidate src-0007 (the only source never
re-verified). Justification, as the queue asked me to state: src-0004 was last checked at
cycle 4, it is *secondary* reporting, and it was the sole evidence base for the very issue
under investigation — re-verifying it sat on this cycle's critical path rather than being a
detour, whereas src-0007's Table 4 was already pulled verbatim across all four model
columns at collection time.

Method per the standing methodological rule: the fetch was asked for **entire sentences
verbatim** across six specified topics, with an explicit instruction to answer "ABSENT:
<topic>" rather than infer. No summarised "the value is X" was accepted.

**Result: PASSED, verbatim, on every stored claim.** Re-fetch of
`https://www.heise.de/en/news/EU-cyber-agency-secretly-uses-AI-for-reports-and-gets-caught-11136978.html`
returned:

- "26 out of 492 footnotes in one of the reports were incorrect." — and its attribution,
  "according to Der Spiegel magazine, 26 out of 492 footnotes in one of the reports were
  incorrect."
- ENISA response: "Human errors" had occurred and the AI had been allowed to make "minor
  editorial revisions." Also: "Enisa, which has an annual budget of around 27 million
  euros, admitted the errors when asked by Der Spiegel magazine".
- APT29 fingerprint: "For example, a link to a Microsoft page about the Russian hacker
  group APT29 also contained this name – but Microsoft itself refers to the group as
  Midnight Blizzard."
- Discoverers: "When researchers from Westfälische Hochschule read the publications, they
  became suspicious." / "Christian Dietrich, one of the researchers and a professor at
  Westfälische Hochschule".
- Dates: "The reports in question were published last October and November, respectively."

All three of src-0004's stored key_claims are confirmed as faithful renderings of what
Heise printed. Note precisely what this does and does not establish — the same distinction
cycle 4 drew: it verifies Heise's text, not Der Spiegel's underlying claim. That second
layer was attacked separately this cycle as the main task (OQ[2] above), with the result
that ENISA's own record corroborates the incident's structure but not the number.

**Incidental G2-adjacent result worth recording as a near-miss.** The GPTZero investigation
page (`https://gptzero.me/investigations/ey`) was fetched **twice** and both times returned
its scorecard widget in an unrun/default state reading **"0 of 27 references hallucinated"**
— which contradicts both the same page's own article body ("Almost all of the URLs are
broken or fake, and more than half of the titles don't correspond to real sources") and two
independent outlets that each report **16 of 27** (consulting.ca: "found 16 of 27 references
in the EY study were hallucinated and that 72% of the study was AI"; Going Concern: "16 out
of 27 citations to be exact"). Had I taken the automated read at face value I would have
recorded a false zero, or opened a spurious contradiction. It is treated as a JS-rendering
artefact, not a competing claim, and this is documented in src-0012.md so a later cycle with
browser rendering can confirm 16/27 at the primary. This is the third consecutive cycle in
which the verbatim-not-paraphrase rule changed the outcome.

## Changes made

**New sources (4 of 5 budget used; next free id is `src-0013`):**

| id | what | why it matters |
|---|---|---|
| src-0009 | ENISA Threat Landscape 2025 official publication page | PRIMARY. Revision Notice v1.2 (09 Jan 2026), "updated to edit some links"; **no AI disclosure** |
| src-0010 | ENISA Public Administration sectorial TL publication page | PRIMARY. The *second* affected report; v1.2 same date, "broken links and typos"; **no AI disclosure** |
| src-0011 | GhostCite, arXiv 2602.06718 | First systematic citation audit found; Security venues 1.01%; scope-limited, **not** a CTI base rate |
| src-0012 | consulting.ca, "EY Canada takes down study after apparent AI hallucinations" | Second named institutional incident: 16/27 references hallucinated; report withdrawn |

**`state/knowledge/index.json`** — four entries appended. Nothing deleted or rewritten
(append-only respected).

**`state/issues/graph.json`**, issue `institutional-incident-real-world-impact`:
- `attempts`: `[]` → `[12]`.
- `candidate_resolutions`: 1 → 5. The original cycle-2 resolution is **unchanged**; four
  added — ENISA primary corroboration (`supported`), recurrence at EY (`supported`),
  divergent institutional response (`supported`), base-rate synthesis (`proposed`, with
  the population-mismatch caveat written into the summary itself so it cannot be quoted
  without it).
- `open_questions`: 3 → 5, all rewritten. OQ[0] reframed to state what would actually
  establish a rate; OQ[1] and OQ[2] marked partially answered with the residue named; two
  new questions added (response typology; pre-release verification practice).

**No contradiction opened.** Two candidates were considered and both declined with reasons
given: (i) ENISA's silence vs Der Spiegel's AI attribution — silence is not a competing
claim (see Task performed); (ii) src-0011's LLM citation-hallucination rates (14.23%–94.93%)
vs src-0008's Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%, Gemini 4.8%) —
these look wildly incompatible but measure different things on different units (fabricated
academic *citations* in generated references across 40 domains, vs wrong *IoC recovery* in
a code-analysis task). Same reasoning cycle 10 used to decline the src-0006/src-0007
tension. Flagged here so a future cycle can revisit rather than rediscover it.

## Next task rationale

T3 → T4 per the state machine. T4 assesses **all** issues, so it takes no `target_issue`.

The timing is favourable: this cycle changed the evidence base of exactly one issue, and
changed it substantially — from one secondary source to five sources including two primary
artefacts and a second independent incident. `institutional-incident-real-world-impact`
has stood at 2 since cycle 2 largely because nothing had ever been done to it; a T4 now
has something real to re-score. The honest expectation is that it rises but does **not**
reach the top of the scale, because its base-rate question is still open by scope rather
than by evidence volume — the same reason cycle 10 recorded that level 4 was blocked. A
T4 that scores it 4 or 5 on the strength of a second anecdote would be repeating precisely
the error the cycle-11 queue warned against.

Refresh check: `collect_refresh_every: 7`, and 12 % 7 = 5, so cycle 12 is not a refresh
cycle; the next task is a plain T4.

## Budget

- **Web searches**: 6 (1 failed — `spiegel.de` blocked to this user agent, HTTP 400).
- **Web fetches**: 11 attempted, 8 successful. Failures: cybernews 403, The Register 404,
  computing.co.uk 403. The GPTZero page counted twice (both returning the same widget
  artefact).
- **Assistant turns**: ~16.
- **Sources added**: 4 of `max_new_sources: 5`.
- **Files written**: 4 new `src-*.md`, `index.json`, `graph.json`, this log,
  `next_task.json`, `last_completed_task.txt`.

## Carry-forward items

Copied forward in full, including items that cannot be acted on. Cycle 12 adds items 13–15.
**Note on numbering:** the cycle-11 queue handed over items 1–7 and 10–12 but omitted 8 and
9; both were recovered from `logs/cycle-010.md` and are restored below.

**[1]** SPLIT `task-dependent-reliability-framing` into the NARROW claim (CTI reliability
varies by sub-task; src-0001, src-0002, src-0006, src-0007; merits 3) and the SPECIFIC
ORDINAL AXIS ("mechanical extraction < classification < attribution < generation"), which
is no longer merely doubted but actively DISPUTED — src-0007's Table 4 supports it (IoC
extraction precision 0.82–0.88 vs TTP identification 0.2787/0.2270, same team/corpus/models)
while src-0006's Table 5 opposes it (failure subtypes span all four pipeline stages, e.g.
"Co-mention bias (Type 1.1) — stages 1234"). Cycle 10 explicitly DECLINED to open a
contradiction for that tension, reasoning that src-0006 is about where failure MECHANISMS
occur and src-0007 about where performance LEVELS differ, which are compatible; do not
overturn that without reading both tables. **CARRIED BY CYCLES 7, 8, 9, 10, 11 AND 12 — SIX
CONSECUTIVE CYCLES.** Only a T2 has standing to do it.

**[2]** ATTACH src-0007 to `ttp-attack-mapping-reliability`: it is an unattached third
independent source (ATT&CK TTP identification P/R 0.2787/0.2270 GPT-4o, 0.3480/0.1759
o3-mini, 0.2387/0.1846 GPT-4o-FT, 0.1771/0.1414 GPT-4o-mini-FT on real production material
vs CTIBench's 0.6388 F1 ceiling) that cycle 10's rationale cites but graph.json's
`candidate_resolutions` do not list (still `[src-0002, src-0005]`). It also gives that
issue's open_question[2] its first direct evidence, and the answer is that fine-tuning made
ATT&CK mapping WORSE. Not a contradiction with src-0002 (different benchmark and corpus;
real-world material being harder is the expected direction). Cycle 12 did not act: T3 has
standing only over its own target issue.

**[3]** NEW-ISSUE CANDIDATE for a T2: LLM triage precision — src-0007 reports recall
(Accepted) 0.90–1.00 vs precision (Accepted) 0.27–0.40 across all four models, i.e. an
automated triage stage passes through roughly two of every three items a human analyst
would reject; no existing issue covers triage.

**[4]** THE G3 GATE IS SPECIFIED TWO INCOMPATIBLE WAYS: `prompts/t4_assess.md` step 3 says
an issue with an open contradiction LOSES `gates.g3_contradiction_demotion` points (a
subtraction), while `scripts/validate_state.py` lines 144–156 implements a CEILING (error
only if score > scale_max − demotion = 3). Cycle 10 applied the CEILING and argued why: the
rubric's levels are definitions of states (0 = "no candidate resolutions", 1 = "no supported
resolution"), and `ioc-extraction-reliability` has three candidate_resolutions with two
supported, so a subtraction to 0 or 1 would assign a label that is factually false of the
issue. Cycle 11 confirmed live that the reading changes the agenda. **FOURTH CYCLE CARRIED.**
No task type in the state machine has standing to reconcile the prompt and the validator.
*Directly relevant to the next cycle, which is a T4.*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at
P5–P6, but the paper's body text says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance
is unaffected (encryption collapses detection either way) and no contradiction was opened,
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

**[8]** G2 RE-VERIFICATION COVERAGE TO DATE (restored from cycle 10, updated): src-0004
(c4, **and c12 — passed verbatim**), src-0003 (c5), src-0002 (c6), src-0001 (c7), src-0006
(c8), src-0005 (c9 substance-only, c11 verbatim — passed both), src-0008 (c10).
**src-0007 remains the only source never re-verified**, and src-0009 through src-0012 are
new this cycle and unverified by construction. src-0007's Table 4 was pulled verbatim at
collection time, making it a lower-value target than a first-ever check of one of the new
cycle-12 sources — of which **src-0012 is the highest-value target**, since its central
16/27 figure rests on two secondary outlets reporting one upstream investigation whose own
page returns a contradictory widget value (see Retrospection).

**[9]** SANDBOX LIMITATION, unchanged from cycles 9 and 10 and hit again this cycle:
`python3` and `curl` are blocked (every form attempted returned "This command requires
approval" in this unattended run). JSON validity was therefore checked by construction and
by re-reading the edited seams in both `graph.json` and `index.json`, not by a parse. This
is a weaker check than a parse and is recorded as such.

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Cycle 11's G2 verified all four of
its stored quotes verbatim against the arXiv abstract, but every claim it contributes is
abstract-level and directional. It is one of two sources holding
`ttp-attack-mapping-reliability` at 3 and the other (src-0002) is the only one supplying a
figure (0.6388 F1). Pulling CyberSOCEval's per-model/per-task scores from the full paper is
the cheapest thing that could move that issue, and it has been an open limitation since
cycle 1.

**[11]** TIE-BREAK 3a IN `prompts/t5_select.md` IS UNDER-SPECIFIED. "An issue that others
depend_on outranks its dependents" admits a strict pairwise reading (applied in cycle 11;
inert on unrelated nodes) and an in-degree reading (not applied; would have selected
`consistency-calibration-as-failure-mode` instead). THE TWO READINGS SELECTED DIFFERENT
ISSUES. Separately, the policy has no deterministic tie-break after 3c and ran out entirely
on a genuine 2-vs-2 tie with identical `created_cycle`. Suggested fix for a cycle with
standing: add "3d. fewest total attempts first; then longest time since the issue last
received new evidence." Cycle 11 deliberately did NOT edit that file — T5 has no standing to
change the system's rules. Note also that cycle 11 found cycle 10's queue entry asserted,
falsely, that none of the tied issues was depended upon by anything; checking premises
against `graph.json` rather than trusting the handoff is why that was caught. *Cycle 12
endorses the proposed 3d from experience: had it existed, this issue's `attempts: []` would
have selected it outright without needing a judgement call, and the cycle produced four
sources and closed half of two open questions.*

**[12]** THE STATE MACHINE HAS NO PATH TO STRUCTURAL WORK. T1→T2→T3→T4→T5→T3 is the only
cycle, and after the first pass it never returns to T2 — every subsequent lap runs
T3→T4→T5→T3. T2 is the ONLY task type with standing to split an issue, add a new issue, or
reconcile the prompt/validator disagreement, and carry-forward items 1, 3 and 4 have now
been blocked on that for six, three and four cycles respectively. The refresh rule provides
an escape to T1 every 7th cycle but there is NO ANALOGOUS ESCAPE TO T2. Structural finding
about the loop design; belongs in the paper. Also for the record: `collect_refresh_every` is
keyed to `current_cycle` (12 % 7 = 5, so cycle 12 was not a refresh), and since cycle 7
happened to be a T4 rather than a T5, the refresh rule has never yet fired in twelve cycles.

**[13] NEW (cycle 12).** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns
HTTP 400, "The following domains are not accessible to our user agent". Der Spiegel is the
upstream primary for the entire ENISA incident, so this is a permanent structural gap in
the evidence base, not a to-do. Do not re-spend budget fetching it the same way. Remaining
routes to the 26/492 figure: count footnotes in the archived original/v1.1 PDF against
v1.2, or locate Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own
writeup (searched briefly this cycle, not found).

**[14] NEW (cycle 12).** THE TWO ENISA v1.2 PDFs WERE NEVER OPENED. Only the landing pages
were fetched, so "ENISA never disclosed the AI use" is established for the publication
pages, not for the documents' front matter/legal notices. Pulling the front matter of
`ENISA Threat Landscape 2025_v1.2.pdf` (2026-01 path) would either strengthen that claim to
document level or refute it — a cheap, decisive check. The same PDFs are also the route to
carry-forward [13]'s footnote count.

**[15] NEW (cycle 12).** SCOPE-ADJACENT CASE DELIBERATELY NOT ADDED AS A SOURCE, recorded so
it is not re-searched from scratch: curl ended its HackerOne bug bounty on 31 January 2026
after a flood of AI-generated "slop" vulnerability reports, with reported figures of ~20% of
submissions being AI slop by mid-2025 and the confirmed-vulnerability rate falling from
~15% historically to under 5% (bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/;
The Register's URL 404'd on the path tried). It was excluded because it is a different
phenomenon from this issue's subject: AI-generated security claims arriving *inbound* and
being rejected at triage, not AI-generated content *published* by an institution. It would
fit a new issue on AI slop in security reporting pipelines — a T2 candidate, alongside [3].
