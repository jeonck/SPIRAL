# Cycle 016 — T2 Structure

## Task performed

**T2 (Structure)** over `state/issues/graph.json`, per `state/queue/next_task.json` written
by cycle 15. This is the **first T2 since the opening pass at cycle 2** — fourteen cycles.
The queue entry carried a specific five-item agenda rather than a generic review, on the
reasoning that T2 is reachable only via `T5 → T1 → T2` under the refresh rule
(`collect_refresh_every: 7`) and so fires at most once every seven cycles, with the next
not due until cycle 23.

**All five agenda items were reached.** Four were executed as graph edits; the fifth (the
G3 gate specification conflict) was **decided but not executed**, because executing it
requires editing `prompts/` and `config.yml`, which are outside this agent's stated output
surface. That is set out in full below rather than deferred again.

The graph went from **6 issues to 8**. Both additions are genuine structural changes that
no other task type has standing to make, and both had been blocked for six-to-nine cycles.

## Retrospection

**G2 targets: `src-0009` and `src-0010`** (the two ENISA publication pages, collected cycle
12). Selected per the queue entry: they were the **oldest never-re-verified sources** in the
base, and re-verifying them also attacks carry-forward **[14]** (the v1.2 PDF front matter
was never opened, so "ENISA never disclosed the AI use" was established only for the landing
pages, not for the documents).

**Method.** Per the standing rule — now six cycles of evidence that it changes outcomes — I
did not ask "is claim X still true". I asked for the revision notice, publication date, PDF
filename, and **every occurrence** of `AI` / `artificial intelligence` / `generative` / `LLM`
/ `language model` quoted in full sentence, with an explicit instruction to answer "ABSENT"
per item rather than infer.

**Result on the landing pages: PASS, both, unqualified.**

| stored claim | re-fetched 2026-07-29 |
|---|---|
| src-0009 notice | `Revision Notice – Version 1.2. (09 January 2026): This publication has been updated to edit some links.` — **exact match**, including the stray period after "1.2" |
| src-0009 pub date | October 1, 2025 — match |
| src-0009 PDF | `ENISA Threat Landscape 2025_v1.2.pdf`, served from a `2026-01/` path — match |
| src-0009 AI mention | "NO OCCURRENCE ... ANYWHERE ON PAGE" — match (absence re-confirmed 8 months post-exposure) |
| src-0009 footnote count | ABSENT — match (still does not corroborate 26/492) |
| src-0010 notice | `Revision Notice – Version 1.2 (09 January 2026): This publication has been updated to correct some broken links and typos.` — **exact match**, including the absence of the period this time |
| src-0010 pub date | November 6, 2025 — match |
| src-0010 AI mention | "NO OCCURRENCE ANYWHERE ON PAGE" — match |

Both sources verified clean. **No contradiction entry opened and none was warranted.**

**Carry-forward [14] is NOT discharged, and it is now reclassified as blocked infrastructure
rather than as a cheap unfinished check.** I attempted the PDF front matter by three routes
and all three failed:

1. `WebFetch` on both v1.2 PDFs returned raw FlateDecode binary, not text — "PDF TEXT NOT
   EXTRACTABLE". (It did save both files locally, 4.3 MB and 1.6 MB.)
2. The `Read` tool on the saved PDFs failed: `pdftoppm is not installed` — poppler-utils is
   absent from this runner.
3. `pdftotext`, `pdftohtml`, `mutool`, `gs` and `qpdf` are all absent from `PATH`.

**A correction to carry-forward [9], which matters for future cycles.** [9] has said since
cycle 9 that "`python3` and `curl` are blocked". `python3` is **not absent** — it is present
at `/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` and resolves on `PATH`. What blocks
it is the **permission layer**: any `python3` invocation returns "This command requires
approval" and, unattended, is never approved. The practical consequence is identical (no
JSON parse, no PDF extraction) but the diagnosis is different, and a future cycle should not
waste budget looking for a different Python. Same for a piped command: the sandbox rejects
compound commands containing an unapproved segment.

So [14] joins [13] (spiegel.de unreachable) as a **permanent structural gap for this agent**,
not a to-do. This is worth stating plainly because it bounds a claim the graph relies on:
`institutional-incident-real-world-impact` was raised to 3 partly on the AI-non-disclosure
finding, and that finding is solid **at landing-page level** and **unverifiable at document
level** by any tool available here. Closing it needs a human, or a runner with poppler.

**One incidental observation, recorded but not entered as a claim.** src-0010's v1.2 PDF is
served as `ENISA Public Administration TL 2024 - v1.2.pdf` — "TL **2024**" for a report the
same page dates to 6 November **2025**. Most likely the filename refers to the data year or
is a template leftover. It contradicts nothing in our base (our stored claim is about the
publication date and the revision notice, both of which matched), and one filename is not
evidence of anything, so **no contradiction was opened**. Noted so a later cycle citing the
PDF is not surprised by it.

## Changes made

All changes are in `state/issues/graph.json`. **No file in `state/knowledge/` was touched**,
so the append-only knowledge rule is trivially satisfied. No score was set anywhere — T2 has
no standing to score, and agenda item 5 explicitly declines to.

### Item 1 — SPLIT `task-dependent-reliability-framing` (carry-forward [1], carried nine cycles)

The issue conflated a well-supported narrow claim with an actively disputed ordinal axis
inside one issue and one candidate_resolution. Cycle 13's T4 rationale states the cost
exactly: "a single score is being forced to average a narrow claim that is now near-4 with
an axis that is actively disputed and scores 1-2, so 3 is the stingy resultant" — a number
that describes neither half. Six consecutive assessments recorded the split as the highest-
value available change and none had standing to make it.

- `task-dependent-reliability-framing` **keeps** the narrow claim. It retains the cycle-6
  `supported` candidate_resolution unchanged, and gains a new `supported` candidate citing
  **src-0007** (within-corpus spread: IoC extraction precision 0.8240–0.8846 vs ATT&CK TTP
  0.2787/0.2270, vs threat-actor Attribution rubric 1.140/5 against root-cause 3.612/5, same
  four models, same corpus) and **src-0013** (task-dependence extends to *calibration*:
  functional worse than security calibration for every model, ΔECE −0.15/−0.16, −0.26/−0.27,
  −0.52/−0.53). Its old open_question[0] is replaced by a SPLIT NOTE pointing at the new issue.
- New issue **`extraction-vs-reasoning-ordinal-axis`** takes the ordinal half. The cycle-2
  `proposed` candidate_resolution was **moved verbatim**, not rewritten, with a provenance
  header naming cycle 2 as its author and the split as its route here, plus an appended
  cycle-16 annotation. The old open_question[0] moved with it verbatim.

**I did not open a contradiction, and I did read both tables before deciding.** Cycle 10
declined to file src-0006-vs-src-0007 as a G3 conflict on the reasoning that src-0006
measures where failure *mechanisms* occur and src-0007 where performance *levels* differ.
I re-read both and **endorse that reasoning**: a mechanism can be present at every pipeline
stage while its impact on measured performance is unequal across stages, and both facts hold
at once. That is exactly why this is an open issue and not a contradiction — the sources are
not in conflict; the *axis* is simply unestablished. The full argument is written into the
new issue's open_questions so cycle 23 need not reconstruct it.

I also added a genuinely new objection the prior cycles had not made: **src-0007's apparent
ordering is partly an artefact of changing the yardstick between rows** — IoC extraction
reports precision only, TTP identification reports precision and recall, drafting reports a
1–5 rubric. The three numbers that look like a descending ranking are not commensurable
measurements. That is now the issue's stated bar for rising above `proposed`.

### Item 2 — NEW ISSUE `automated-triage-under-refusal` (carry-forward [3] merged with [15])

Two independent sources on one failure mode that had no home in the graph: **src-0007**
(triage recall Accepted 0.90–1.00 vs precision Accepted 0.27–0.40, all four models) and
**src-0015** (GPT-5.2 contains in 100% of episodes at 82.5% FP; DeepSeek 3.2 92.5%/65%;
Gemini 3 75%/57.5%; Sonnet 4.5 62.5%/45%; evidence-gated action rate 0.375–0.542).

The argument for issue-hood rather than footnote-hood is src-0015's own diagnosis: *"All
models correctly identify the ground-truth threat when they act; the calibration gap is not
in detection but in restraint."* **Accuracy-based evaluation scores these systems well.** The
defect is invisible to every metric the rest of this knowledge base uses, which is precisely
why it needs its own issue rather than a line under an accuracy-shaped one.

The candidate_resolution states the **provenance asymmetry** rather than averaging it: the
claim rests on src-0007 (verified verbatim, institutional, re-confirmed exact by cycle 15);
src-0015 is by its own recorded assessment the weakest-provenance source in the base and
corroborates *direction* only. It also flags the pooling error to avoid — src-0015's
"calibration" is an action-threshold construct, not the ECE/Brier of src-0001 and src-0013.

**On merging [15] (curl/HackerOne):** I merged it, but as an **open_question, not evidence**.
Cycle 12's reason for excluding it as a source (inbound AI claims ≠ AI content published by
an institution) was right for the *institutional-incident* issue but is not a reason to
exclude the *phenomenon* here, where the two halves fit: "AI slop arrives inbound AND
automated triage cannot filter it" is one problem, and it has a sharp edge — if triage
accepts 60–73% of what analysts reject, it is the wrong instrument for the volume problem it
is most often proposed to solve. **No curl source exists in `index.json`, so per G1 it is
recorded as a question with a collection pointer for a future T1, and cannot be cited.**

### Item 4 — attach src-0007 where it was missing (carry-forwards [2] and [19])

- **`ttp-attack-mapping-reliability`**: new `supported` candidate citing src-0007 + src-0002
  with all four ATT&CK precision/recall pairs. open_question[2] (does fine-tuning close the
  gap?) rewritten to **PARTIALLY ANSWERED — no, fine-tuning made it worse** (GPT-4o
  0.2787/0.2270 → FT 0.2387/0.1846), while flagging that the question *as literally posed*
  asks about ATT&CK-*specific* fine-tuning, which src-0007 does not test. Explicitly **not**
  a contradiction with src-0002: different benchmark, corpus and metric decomposition, and
  real production material being harder is the expected direction.
- **`attribution-confident-wrong-gap`**: new candidate citing src-0007's Content: Threat
  Actor rubric, **status `proposed`, not `supported`**, and citing **only** the GPT-4o vs
  o3-mini contrast per the queue entry's caution. The FT-column anomaly (GPT-4o FT
  3.964/3.655/2.967 vs o3-mini 3.964/3.656/2.968 — identical to within 0.001 on all three
  rows) is written into the candidate text as a re-pull instruction, not silently dropped.
  The load-bearing part is the *within-table* contrast: the same GPT-4o scores 3.686/3.458/
  3.612 on Content: Root Cause, so 1.140 on attribution is task-specific, not a drafting
  deficiency. open_question[0] updated: o3-mini is the first later-generation datapoint and
  it cuts both ways.

### Item 5 — SCOPE RULING on `consistency-calibration-as-failure-mode`

Cycle 15 added four sources and honestly left the judgement it had no standing to make.
**I ruled: the domain gap holds.** The issue's scope stays anchored to CTI, and its two
CTI-claiming candidate_resolutions remain single-source (src-0001) for scoring purposes.

Three grounds, recorded in the graph: (a) all four measure security-*adjacent* tasks — secure
code generation, CVE-code vulnerability detection, JS SAST review, simulated IR — and none
measures IoC extraction, TTP mapping, attribution or report drafting; (b) the model overlap
with src-0001/0002/0005 is **empty**, so open_questions (i) and (ii) are untouched and are
*not* marked answered; (c) this base's own precedent for a security-adjacent source
(src-0008) admitted it *with* a scope gap and never as a replication — ruling the other way
would retroactively rewrite what that precedent meant.

What the four **do** establish is recorded and not minimised: the mechanism is robust across
four unrelated teams, four methods, four corpora and ~15 models, and two of src-0001's most
fragile-looking sub-findings are independently echoed (intervention-worsens-calibration:
src-0013 ECE 0.411→0.697 and 0.161→0.721, src-0014 A-CoT recall Gemma 0.420→0.057;
grounded-stable/volunteered-unstable: src-0016's 134/158 vs 80/161). That is a claim about
**security-task LLM reliability generally**, held as context for the CTI claim, not as
support for it.

**A T4 may overrule this, but must say so explicitly and give a reason** — what it must not
do is silently count the four as multi-source support for a CTI claim. No score set here.

### Item 3 — the G3 gate: DECIDED, NOT EXECUTED

I read both artefacts myself, and found a **third** one the carry-forward did not mention:

- `prompts/t4_assess.md` step 3 — "loses `gates.g3_contradiction_demotion` points (floor 0)"
  → **SUBTRACTION**
- `config.yml` line 35 comment — "score points **deducted** when a contradiction flag is open"
  → **SUBTRACTION**
- `scripts/validate_state.py` lines 144–156 — errors only if `score > scale_max - demotion`
  → **CEILING** (= 3 under the current config)

So it is **two artefacts to one**, and the minority reading is the only one mechanically
enforced and the one applied by cycles 10, 11 and 13.

**Decision: the CEILING is correct and the other two artefacts should yield to it.** The
reason is not precedent, it is that the rubric is **definitional, not arithmetic**. Its
levels define evidential *states* — 0 is "unexamined: no candidate resolutions", 1 is "no
supported resolution". Subtracting 2 from `ioc-extraction-reliability`'s honest 2 yields 0,
which asserts the issue has no candidate resolutions when it has three, two of them
supported. A gate that makes the state file *factually false* and hands the weakest-link
selector a fabricated bottom is worse than one that merely caps the top. The ceiling achieves
what G3 is for — an unresolved conflict blocks the top of the scale — without corrupting the
bottom of it. Note also that switching to subtraction would **not** be caught by the
validator, since lower scores never trip a ceiling check: the divergence would be silent.

**I did not make the edit, and I want to be plain about why rather than dress it up.**
`prompts/system.md` states that a cycle's entire output is the edits it commits to `state/`
and `logs/`. `prompts/`, `config.yml` and `scripts/` are the harness that governs every
future cycle; rewriting it from inside a cycle is an escalation beyond what a T2 was asked to
do, and the queue entry named "record the recommended fix for a human" as an acceptable
outcome. So this is a decision with a deferred execution, **not an eighth carry**.

**Exact patch, for a human or a cycle with standing.** Replace `prompts/t4_assess.md` step 3:

> 3. Apply the contradiction demotion as a CEILING, not a subtraction: an issue with an open
>    contradiction entry may not be scored above `scoring.scale_max - gates.g3_contradiction_demotion`
>    (= 3 under the current config). If the score on the merits is already at or below that
>    ceiling, the gate does not bind and the score is unchanged. State in the rationale both
>    the ceiling and whether it bound. This matches `scripts/validate_state.py` lines 144–156,
>    which is the enforced behaviour; the rubric levels are definitions of evidential states,
>    not points on an arithmetic scale, so subtracting from them can yield a score whose own
>    definition is false of the issue.

And `config.yml` line 35 comment → `# max score allowed while a contradiction flag is open =
scale_max - this value`.

### Summary of the graph after this cycle

8 issues (was 6), 20 candidate_resolutions (was 17), 1 open contradiction (unchanged,
`ctr-0001`). Within the 5–12 healthy range. **No issues were merged** — I looked for
near-duplicates and found none; the two new issues are carved from material that was
previously mis-filed, not duplicated.

**JSON validity** was checked by construction and by structural re-read, since `python3` is
permission-blocked (see Retrospection): 8 `{`/`}` issue pairs at 4-space indent matching 8
`id`/`title`/`depends_on`/`created_cycle`/`attempts` sets; 21 opening and 21 closing braces at
8-space indent against 20 `status` lines + 1 `_schema` exemplar; `contradictions` and
`_schema` blocks intact. All `evidence` ids are within src-0001…src-0016, all of which exist
in `index.json`, so no dangling reference (validator G1).

## Next task rationale

**T3 (Investigate)**, per the state machine `T2→T3`. Not a T4 — I checked, since the
temptation after restructuring is to want the new issues scored immediately; they will be, at
cycle 18.

**Target: `extraction-vs-reasoning-ordinal-axis`**, following the queue entry's own guidance
to send the T3 at whichever new issue is least supported. It is the weaker of the two
additions by a clear margin: one `proposed` candidate_resolution inherited from cycle 2 and
no evidence gathered *for it as an issue*, against the triage issue's `supported` candidate
with two attached sources. It is also the half of the nine-cycle split that was blocking a
score, so investigating it converts the split from a structural act into a substantive one.

The T3 has a concrete, bounded first move that needs no web search — put src-0006's Table 5
and src-0007's Table 4 side by side and test the commensurability objection — which is worth
more than an open-ended search, and it can escalate to search only if that comes up dry.

## Budget

- **Web fetches:** 4 (src-0009 landing page, src-0010 landing page, both v1.2 PDFs — the
  latter two failed to yield text)
- **Web searches:** 0 — this was a structure cycle; the agenda was executable from the
  existing base, and searching would have been T1 work I had no budget mandate for
- **File reads:** 9 (next_task, meta, graph, index, cycle-015 log, t4_assess, validate_state,
  t3_investigate, scores, config) + 3 structural verification reads/greps of the edited graph
- **File edits/writes:** 7 edits to `graph.json` + this log + `next_task.json` +
  `last_completed_task.txt`
- **Bash:** 3 (tool availability check; two blocked `python3` probes that established the
  permission-gate diagnosis)
- **Assistant turns:** ~12
- **Dead ends:** the ENISA v1.2 PDF front matter, attempted three ways and unreachable — see
  Retrospection. Cost ~2 fetches and 2 tool probes, and it converted carry-forward [14] from
  an open task into a documented infrastructure limit, which is worth the spend once but must
  not be repeated.

---

## Carry-forward items

All twenty items from `logs/cycle-015.md` are reproduced below **including those I could not
act on**, with cycle-16 updates. Discharged items are marked and kept rather than deleted, so
the record of *why* they closed survives. Three handoffs have now lost or corrupted state
(cycle 11 dropped [8] and [9]; cycle 14 found [12]'s central claim false), so this section is
load-bearing.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. **Done.** The
narrow claim stays in the original issue (now with src-0007 + src-0013 added); the ordinal
axis moved to the new issue `extraction-vs-reasoning-ordinal-axis` with the cycle-2
candidate_resolution moved verbatim and provenance recorded. Cycle 10's refusal to open a
G3 contradiction over src-0006-vs-src-0007 was re-read and **endorsed, not overturned**. New
objection added that no prior cycle had made: src-0007's sub-task metrics are not
commensurable (precision-only vs precision+recall vs a 1–5 rubric), so its apparent ordering
is partly an artefact of a changing yardstick. Carried cycles 7–15; closed at 16.

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`. **Done**
— new `supported` candidate with all four precision/recall pairs, and open_question[2]
rewritten to record that fine-tuning made ATT&CK mapping *worse*. Carried six cycles.

**[3] — DISCHARGED cycle 16.** New issue on triage precision. **Done** — created as
`automated-triage-under-refusal` with src-0007 and src-0015 attached and the provenance
asymmetry between them stated explicitly. Carried six cycles.

**[4] — DECIDED cycle 16, execution deferred.** The G3 gate specification conflict. Cycle 16
found it is actually **three** artefacts, not two: `prompts/t4_assess.md` (subtraction),
`config.yml` line 35 comment (subtraction), `scripts/validate_state.py` (ceiling) — i.e. the
enforced reading is in the minority. **Ruled in favour of the CEILING**, on the ground that
the rubric is definitional rather than arithmetic and subtraction produces scores whose own
definitions are false of the issue. Exact replacement text for both artefacts is in this
log's "Item 3" section. **NOT APPLIED**: `prompts/`, `config.yml` and `scripts/` are outside
this agent's stated output surface (`state/` and `logs/`). A human, or a cycle with explicit
standing, should apply it. Until then, **T4s must keep applying the ceiling**, consistent
with cycles 10, 11 and 13. Note the divergence is silent if unfixed — subtraction produces
lower scores, which never trip the validator's ceiling check.

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6,
the paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no
contradiction opened, since both readings are automated fetches of the same HTML and one
demonstrably mis-rendered characters. Needs a PDF-level check before src-0008's phase
structure is cited. Its per-phase percentages exist ONLY as pie charts (Figure 2) and cannot
be verified by table pull; its Table 7 hallucination rates (Anthropic 0.11%, ChatGPT 0.23%,
Gemini 4.8%, Grok 0, Cohere 0) are verified exact and their "approximate" caveat can be
lifted. *Cycle 16 note: [14]'s finding that no PDF text extraction is available to this agent
applies here too — the PDF-level check this item wants is likely also blocked.*

**[6]** THREE UNFINISHED SEARCH DIRECTIONS, open since cycle 9: citation-graph sweep of arXiv
2506.11325; third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal
baselines; and the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403, no
preprint located). **Forward-citation sweeps have now FAILED on two different arXiv ids
(2506.11325 and 2503.23175) — treat as unavailable infrastructure, not an unsearched
direction.** Use direct topical search, which is what produced cycle 15's four sources.

**[7]** `ctr-0001` RESOLUTION PATH: recover recall/F1 from src-0007's released code
(GitHub/HuggingFace per its abstract) to make its precision-only numbers comparable with
src-0003's F1, and/or find a source running an unscaffolded LLM against PRISM or a
LANCE-style pipeline against CyberThreat-Eval. If the SYSTEM confound is confirmed as the
explanation, ctr-0001 should be CLOSED and folded into `ioc-extraction-reliability`'s third
candidate_resolution. Cycle 15's full Table 4 pull confirmed there is no recall or F1 row for
IoC Extraction anywhere in that table — the omission is real, not a fetch artefact, which
strengthens the case that the code release is the only route. *Cycle 16 note: this now also
bears on `extraction-vs-reasoning-ordinal-axis` — src-0003's 97.6% F1 is the top of that
issue's proposed ordering, so if ctr-0001 resolves toward scaffolding, the axis loses its
clearest supporting datapoint. Written into that issue's candidate text.*

**[8] — UPDATED cycle 16.** G2 RE-VERIFICATION COVERAGE: src-0004 (c4, c12), src-0003 (c5),
src-0002 (c6), src-0001 (c7), src-0006 (c8), src-0005 (c9 substance-only, c11 verbatim),
src-0008 (c10), src-0012 (c13), src-0011 (c14), src-0007 (c15 — PASSED), **src-0009 and
src-0010 (c16 — PASSED, both revision notices exact including the inconsistent trailing
period, both publication dates, both PDF filenames, and the absence of any AI mention
re-confirmed on both pages)**. **Never verified: src-0013, src-0014, src-0015, src-0016**
(all added c15). Of those, **src-0013 and src-0014 are the priority** — see [20].

**[9] — CORRECTED cycle 16.** SANDBOX LIMITATION. The effect is unchanged (no JSON parse
available; validate by construction and by re-reading edited seams) but the **diagnosis was
wrong**: `python3` is **present** at `/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` and
resolves on `PATH`. It is the **permission layer** that blocks it — invocations return "This
command requires approval" and are never approved unattended. Compound/piped commands are
rejected if any segment is unapproved. Do not look for a different Python. **Also newly
established: no PDF text extraction exists on this runner** — poppler-utils (`pdftoppm`,
`pdftotext`), `mutool`, `gs` and `qpdf` are all absent, and `WebFetch` returns PDF bytes
undecoded.

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Cycle 11's G2 verified its stored
quotes verbatim against the arXiv abstract, but every claim it contributes is abstract-level
and directional. It is one of two sources holding `ttp-attack-mapping-reliability` at 3, and
the other (src-0002) supplies the only figure. Pulling CyberSOCEval's per-model/per-task
scores from the full paper remains the cheapest thing that could move that issue. **Now the
oldest un-actioned collection task in the project (open since cycle 1); it is T1 work.**
*Cycle 16 note: src-0007 is now attached to that issue as a third source, which reduces the
urgency slightly but does not close the item — src-0005 is still the weakest-verified source
carrying a 3.*

**[11]** TIE-BREAK 3a IN `prompts/t5_select.md` IS UNDER-SPECIFIED and the policy has no
deterministic tie-break after 3c. "An issue that others depend_on outranks its dependents"
admits a strict pairwise reading and an in-degree reading. Suggested fix for a cycle with
standing: add "3d. longest time since the issue last received new evidence; then fewest total
attempts" — **note that ordering**, established by cycle 14's experience: "fewest attempts"
was useless on the pair it hit (both had exactly one) and the evidence-recency clause is what
actually decided. Cycles 11 and 14 both declined to edit the prompt. *Cycle 16 note: this is
the same class of problem as [4] — a specification defect only a cycle with harness-editing
standing can fix — and cycle 16's ruling on [4] applies the same reasoning: decide it, record
the exact patch, do not edit the harness unilaterally. **The graph now has two new issues
with no scores at all**, which will make ties less likely at cycle 18 but adds two new
`depends_on` edges (`extraction-vs-reasoning-ordinal-axis` → `task-dependent-reliability-framing`)
that the in-degree reading will see differently from the pairwise one.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger
claim was WRONG; see [17].** T2 is the only task type with standing to split an issue, add an
issue, or reconcile the prompt/validator disagreement. What cycles 11–13 recorded — that the
loop "never returns to T2" — is false. *Cycle 16 note: this cycle is the proof of both halves.
T2 was reachable, and items [1], [2], [3] were all discharged the moment it fired, after being
blocked for nine, six and six cycles respectively. **The structural cost is now measured
rather than predicted: three ready-to-execute changes waited ~9 cycles for a task type that
fires every 7.***

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400, "The
following domains are not accessible to our user agent". Der Spiegel is the upstream primary
for the entire ENISA incident, so this is a permanent structural gap, not a to-do. Remaining
routes to the 26/492 figure: count footnotes in the archived original/v1.1 PDF against v1.2,
or locate Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own writeup.
*Cycle 16 note: **the first of those two routes is now also closed** — see [14]. The Dietrich
writeup is the only remaining route known to this agent.*

**[14] — ATTEMPTED AND BLOCKED cycle 16; reclassified from to-do to infrastructure limit.**
The two ENISA v1.2 PDFs still have not been opened, and **cannot be by this agent**. Three
routes tried and failed: `WebFetch` returns raw FlateDecode binary ("PDF TEXT NOT
EXTRACTABLE"); the `Read` tool needs poppler-utils, which is absent (`pdftoppm is not
installed`); and `pdftotext`/`pdftohtml`/`mutool`/`gs`/`qpdf` are all absent from `PATH` while
`python3` is permission-blocked. **Consequence, stated plainly: "ENISA never disclosed the AI
use" is established at landing-page level (re-verified this cycle, both pages) and is
UNVERIFIABLE at document level here.** `institutional-incident-real-world-impact` was raised
to 3 partly on this finding, so a T4 should treat the document-level claim as unestablished
rather than pending. Closing it needs a human or a runner with poppler-utils installed. **Do
not re-spend budget on it the same way.**

**[15] — DISCHARGED cycle 16 by merge.** The curl/HackerOne case (bug bounty ended 31 January
2026 after a flood of AI-generated "slop" reports; ~20% of submissions AI slop by mid-2025;
confirmed-vulnerability rate falling from ~15% to under 5%;
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`)
is now recorded as an **open_question on the new `automated-triage-under-refusal` issue**,
merged with [3] as the queue entry suggested. Cycle 12's reason for excluding it as a source
was right for the *institutional-incident* issue but not for this one. **It is a question, not
evidence — no curl source exists in `index.json` and G1 forbids inventing one.** A future T1
should collect it; the issue text carries the URL.

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question any cycle has found. Verbatim from `https://gptzero.me/investigations/ey`:
it has "set up an automated pipeline to search for vibe citations by finding and scanning
public reports from major consulting firms", is releasing findings "one report at a time", and
has already investigated "a government publication, two different Deloitte reports, and
prestigious machine learning / artificial intelligence conferences like NeurIPS and ICLR". A
T1 should chase `gptzero.me/news/tag/investigations` for the Deloitte and government
write-ups, taking the incident count from 2 to 4–5 across three institution types. Caveats:
GPTZero is a commercial AI-detection vendor reporting on its own product's value, no *rate* is
published, and the scorecard widget renders as "0 of N" to automated fetch — read the body
text, not the widget. **Still the top T1 lead for the next collect cycle (cycle 22).**

**[17]** THE REFRESH RULE IS THE ESCAPE TO T2: `prompts/system.md` line 46 specifies `T1→T2`,
the refresh rule makes every seventh cycle's T5 emit a T1, so the chain is **T5 → T1 → T2**.
This corrects [12]. Confirmed end-to-end by cycles 14→15→16. *Cycle 16 note: **now confirmed
from the far end.** The prediction held through all three hops and this cycle executed the
structural work it predicted would become possible. Structural finding for the paper, now
evidenced rather than asserted: the only task type that can restructure the issue graph fires
at most once every seven cycles and only as a side effect of a rule whose stated purpose is
refreshing evidence. The loop has no first-class trigger for "the graph itself is the
problem", which is why six consecutive T4 assessments named the same split as the highest-value
available change and none could make it. **Next T2 is due at cycle 23.** Anything structural
found between now and then must be queued, not acted on.*

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly, but cite carefully. Body
text says "NeurIPS exhibiting the highest absolute count (391 papers)" while its own Table 3
gives NeurIPS 391 invalid citations across 308 papers — the prose conflates the columns. No
claim in our base repeats the error and **no G3 entry was opened**: one source disagreeing
with itself is not two of our supported claims in conflict. Any cycle quoting src-0011's
*counts* should take them from Table 3's columns, not that sentence.

**[19] — DISCHARGED cycle 16.** src-0007's Table 4 Content: Threat Actor rubric block is now
attached to `attribution-confident-wrong-gap` as a **`proposed`** candidate, citing only the
GPT-4o (1.547/1.528/1.140) vs o3-mini (3.964/3.656/2.968) contrast, with the within-table
Root Cause comparison (GPT-4o 3.686/3.458/3.612) as the load-bearing part. **The FT-column
anomaly is preserved in the candidate text as a re-pull instruction**: GPT-4o (FT)
3.964/3.655/2.967 tracks o3-mini to within 0.001 on all three rows. Also still uncaptured and
available from that table: the Deep Search URLs-Extraction block (GPT-4o 6.22 avg URLs
processed vs GPT-4o-mini-FT 1.25) and the full Triage pass-rate/bias rows — *the latter are
now directly relevant to the new `automated-triage-under-refusal` issue and are the obvious
first pull for a cycle investigating it.*

**[20]** THE FOUR SOURCES ADDED AT CYCLE 15 HAVE VERBATIM-CONFIRMED ABSTRACTS BUT ONLY
src-0015 HAD A TABLE PULLED WHOLE. src-0013's ECE/Brier/False-Trust values and src-0014's
F1/coverage values were returned as quoted body sentences, not pulled tables. Per the rule
that has now changed the outcome six cycles running, **those numbers are single-pass and
should not be treated as load-bearing until a G2 pulls the tables whole.** src-0013
additionally has an unreconciled internal discrepancy: False Trust for GPT-4o-mini appears as
33.9% in one section and as "16.9% to 83.2%" in another — **do not quote those two figures
together** until the FT table is pulled. *Cycle 16 note: src-0013 is now cited in a
`supported` candidate on `task-dependent-reliability-framing` (the ΔECE functional-vs-security
figures), which **raises the priority of this item** — a load-bearing citation now rests on
single-pass numbers. src-0013 is the recommended G2 target for cycle 17.*
