# Cycle 017 — T3 Investigate

Target issue: **`extraction-vs-reasoning-ordinal-axis`** (created cycle 16, no prior attempts,
one inherited `proposed` candidate_resolution, no score).

## Task performed

**T3 (Investigate)** per `prompts/t3_investigate.md`, on the issue carved out by cycle 16's
split. The queue entry prescribed a bounded first move needing no web search — put src-0006's
and src-0007's tables side by side and test the commensurability objection. I did that, and it
produced more than the queue entry anticipated, so I want to state the headline plainly before
the detail:

> **Cycle 16 wrote that the study which would settle this issue does not exist. It does exist,
> and it has been in this knowledge base since cycle 6.** src-0006's Table 2 contains nine rows
> all reported in **F1**, over **one corpus** and **one 15-model set**, spanning both ends of the
> proposed ordering. Restricted to those rows the yardstick does not change between sub-tasks —
> which is exactly the property src-0007 lacks and exactly the bar cycle 16 set. **The ordering
> is not reproduced.** No cycle had pulled that table whole in eleven cycles.

The issue's title question is therefore answered, in the negative, and the inherited cycle-2
candidate_resolution is **rejected** rather than left hanging at `proposed`.

Four analytical results, then the search that came up empty.

### Result 1 — the commensurability objection FAILS for the extraction-vs-classification rung

Cycle 16's objection was that src-0007's apparent ordering is an artefact of a changing
yardstick: IoC extraction reports precision only, TTP identification reports precision *and*
recall, drafting reports a 1–5 rubric. The queue entry asked the right question — *if IoC
extraction's recall were as low as TTP identification's, would the ordering survive?* — and
noted we cannot know, because recall was never reported. But we **can** compute the exact
recall at which it would break, and no cycle had.

Deriving F1 from src-0007's reported TTP precision/recall pairs, then solving `2PR/(P+R)` for
the IoC recall `R*` at which each model's IoC F1 would fall to its own TTP F1:

| model | IoC precision | derived TTP F1 | crossover IoC recall `R*` | that model's actual TTP recall |
|---|---|---|---|---|
| GPT-4o | 0.8240 | 0.2502 | **0.1475** | 0.2270 |
| o3-mini | 0.8503 | 0.2337 | **0.1354** | 0.1759 |
| GPT-4o (FT) | 0.8846 | 0.2082 | **0.1180** | 0.1846 |
| GPT-4o-mini (FT) | 0.6944 | 0.1572 | **0.0887** | 0.1414 |

**Every crossover sits below the same model's own TTP recall.** So if IoC recall were merely
*as bad as* TTP recall, the ordering survives for all four models. It breaks only if IoC recall
is worse than TTP recall by a further factor of **1.3–1.6**, i.e. an absolute recall of
0.09–0.15. No source in this base reports report-level extraction recall anywhere near that:
src-0001's extraction precision/recall run 0.68–0.87, and src-0003's *weakest* legacy baseline
is 72% F1.

The precision-only omission is a real reporting defect. It is **not** an explanation of
src-0007's extraction-vs-TTP gap. Cycle 16's objection was half right and I am recording which
half.

### Result 2 — the objection HOLDS, decisively, for the third rung

The drafting rubric cannot be rescued by any arithmetic, and the demonstration is sharper than
"different units". GPT-4o scores **1.140** on the 1–5 `Content: Threat Actor` Attribution
rubric. Two defensible normalisations:

- naive `x/5` → **0.228**
- floor-corrected `(x−1)/4` → **0.035**

GPT-4o's own derived TTP F1 is **0.2502**. So under one normalisation attribution **ties**
classification; under the other it is **seven times worse**. The *ordering of two rungs* flips
between "indistinguishable" and "far apart" purely on a normalisation choice the paper never
states. That is what non-commensurability looks like when you try to force it.

### Result 3 — the ordering is not model-invariant, inside src-0007's own table

| model | IoC (precision) | TTP (derived F1) | Attribution rubric → naive / floor-corrected |
|---|---|---|---|
| GPT-4o | 0.8240 | 0.2502 | 1.140/5 → 0.228 / 0.035 — **at or below** TTP |
| o3-mini | 0.8503 | 0.2337 | 2.968/5 → 0.594 / 0.492 — **above** TTP |

Two models of the same family, one corpus, one table, one rubric, and they order the middle two
rungs **oppositely** — robustly, under both normalisations. An ordinal axis that reverses
between two models is not a property of the tasks.

### Result 4 — the commensurable measurement exists, and it does not reproduce the ordering

src-0006's Table 2, pulled whole for the first time. Nine rows report F1. Mean F1 across all 15
models, by task:

| stage | task | mean F1 |
|---|---|---|
| ❶ Contextualization ("extraction") | IOC Normalization | 0.656 |
| | Affected Systems | 0.650 |
| | Attack Infrastructure | 0.631 |
| | Malware Family Mapping | 0.607 |
| | **stage mean** | **0.636** |
| ❷ Attribution ("reasoning") | **TTP Extraction** | **0.674** |
| | Infrastructure Reuse | 0.612 |
| | Relation Graph Building | 0.611 |
| | False Flag Detection | 0.511 |
| | **stage mean** | **0.602** |
| ❹ Mitigation | Patch Recommendation | 0.613 |

Three things follow.

1. **The extraction-vs-reasoning stage gap is 0.034 F1.** That is about one fifth of the
   within-Attribution-stage spread (0.511–0.674 = 0.163) and about one eighth of the mean
   between-model spread on a single task (0.272, Result 5). A category boundary explaining an
   eighth of what model choice explains is not the axis of variation.
2. **The best task in the entire commensurable subset is TTP Extraction (0.674) — an
   Attribution-stage task**, outscoring every Contextualization task including IOC
   Normalization. The predicted ordering is not merely weak; it is locally inverted at its
   strongest predicted point.
3. It is **robust** to the data-quality caveat below: dropping the four F1 rows I flagged as
   suspiciously regular leaves 0.641 (Contextualization) vs 0.593 (Attribution), gap 0.048,
   same direction, TTP Extraction still highest.

### Result 5 — between-model variance ≈ between-task variance (open_question[3], answered)

On the same nine-row F1 subset:

- mean **between-model** range within a task = **0.272** (Affected Systems 0.464, False Flag
  Detection 0.393, Attack Infrastructure 0.371, Patch Recommendation 0.276, TTP Extraction
  0.273, Infrastructure Reuse 0.226, Malware Family Mapping 0.155, Relation Graph Building
  0.155, IOC Normalization 0.132)
- mean **between-task** range within a model = **0.263** (0.171 for ZYS up to 0.404 for LL70
  and 0.403 for LLY)

**Equal to within 0.009.** Task identity is not the dominant explanatory variable. The
AUC 0.912-vs-0.547 pair the question cited is confirmed exact and is an instance of the pattern,
not an outlier.

A sixth observation, entered as a `proposed` candidate rather than a finding: **corpus identity
may dominate both.** The same nominal sub-task — ATT&CK TTP mapping — scores F1 0.478–0.751 in
src-0006 but a derived F1 of 0.157–0.250 in src-0007. A ~0.4 shift on *one task*, larger than
any between-task gap either paper reports. The comparison is uncontrolled (task definition,
model set, year and metric decomposition all differ at once), which is exactly why it is
`proposed`.

### Search — EMPTY, recorded so cycle 23 does not re-run it blind

Two searches for the specific shape the issue needs (one commensurable metric across sub-tasks
spanning the ordering, one corpus, one model set), not for "CTI benchmark" generally:

1. `CTI benchmark single metric across sub-tasks IoC extraction TTP mapping attribution same corpus same models F1 comparable`
2. `"task difficulty" ordering cyber threat intelligence LLM extraction versus reasoning which sub-tasks are harder commensurable evaluation 2026`

**No source meeting the bar was found, and no source was added.** CTIBench (already src-0002)
was returned and explicitly confirmed as *not* meeting it — accuracy for CTI-MCQ/CTI-RCM, mean
absolute deviation for CTI-VSP, F1 for CTI-ATE, i.e. the same changing-yardstick defect as
src-0007.

**Three genuinely new collection leads for a future T1** (recorded as leads, **not** as sources
— none is in `index.json` and none may be cited, G1):

- **SEvenLLM**, `arxiv.org/pdf/2405.03446` — bilingual multi-task CTI dataset of **28 tasks
  split 13 "understanding" / 15 "generation"**. That split is this issue's axis, pre-drawn by
  another team. Strongest lead found.
- **AthenaBench** — described in results as augmenting CTIBench with **"unified scoring"**,
  which is the commensurability property this issue needs. No URL captured; needs a search.
- **CTIArena** — named alongside AthenaBench as a CTIBench successor. No URL captured.

## Retrospection

**G2 target: `src-0006`** (`https://arxiv.org/abs/2509.23573`), last verified at cycle 8. Chosen
over the queue entry's first recommendation (src-0013) because the queue entry itself noted
src-0006 doubles as issue work — verifying it and investigating the target issue are the same
fetch. That judgement paid off; Results 4 and 5 are its by-product.

**Method**, per the standing rule now seven cycles deep: I asked for entire tables verbatim with
an explicit instruction to write "ABSENT" rather than infer, never "is claim X true".

**Result: PARTIAL FAIL. Every number verifies exactly. One label is wrong.**

| stored claim (src-0006.md key claim 2) | re-fetched 2026-07-29 |
|---|---|
| Source Reliability Scoring AUC **0.912** (G5) | `.912` — **exact** |
| Source Reliability Scoring AUC **0.547** (LLY) | `.547` — **exact** |
| Infrastructure Reuse F1 **0.754** (SPT) | `.754` — **exact** |
| Infrastructure Reuse F1 **0.688** (ZYS) | `.688` — **exact as a number** |
| Table 5 `Co-mention bias (Type 1.1) — stages 1234` | `(1.1) Co-mention bias │ ❶❷❸❹` — **exact** |
| "**0.688 for a general model**" | ✗ **FAIL — ZYS is a cybersecurity-SPECIALIZED model** |
| "F1 range roughly **0.20–0.90**" | ✗ **imprecise — actual F1 min is .286, max .882** |

**On the failure.** src-0006.md key claim 2 reads "Infrastructure Reuse peaks at F1 0.754 for a
specialized agent vs. 0.688 for a general model". ZYS is not a general model. I established this
from the paper's **own body text**, not from the fetch tool's assertion: *"Source Reliability AUC
tops out at ∼0.91 versus a best cyber score of ∼0.74"* — and `.738` in that row is ZYS, so ZYS
sits in the cyber-specialized block. The actual general-model peak on Infrastructure Reuse is G5
at `.677`, below SPT's `.754`. **The comparison's direction survives; the label does not.**

**On the range.** "roughly 0.20–0.90" overstates the floor downward: the true F1 span in Table 2
is **.286** (False Flag Detection, LLY) to **.882** (Affected Systems, LL70). Loose rather than
false, but it is quoted in `index.json` too and should be tightened when a cycle has standing.

**The methodological rule earned its keep for the eighth cycle running.** The fetch's *own*
answer on the general-vs-specialized column split was **self-contradictory** — it stated "16
columns, fourteen for models" while listing fifteen, and split them 6/9, contradicting the first
pull's caption-based reading. I did not accept either. I resolved it against two verbatim body
sentences the second pull returned (the ∼0.91-vs-∼0.74 sentence above, and *"Affected Systems F1
peaks at ∼0.82–0.88 versus ∼0.55–0.56 for most cyber agents"*), which fix the split at **8
general (G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC, CB0, ZYS, LLY, CBS, SPT, DHT)**.
Had I taken the summariser's split, the G2 failure above would have been invisible.

**No contradiction entry opened, and I want to be explicit about why rather than let it pass.**
G3 is for *two supported claims in conflict*. This is one of our own files misdescribing its
source — a defect in our state, not a disagreement between sources. It is the same class as
carry-forward **[5]** (src-0008 phase labels) and **[18]** (src-0011 prose vs Table 3), both of
which were recorded without a contradiction entry, and cycle 16 endorsed that handling
explicitly. Opening one here would also attach a G3 ceiling to whichever issue I filed it
against, penalising a healthy issue for a labelling slip. **I did not edit `src-0006.md`**: the
append-only rule technically permits appending a correction section, but no cycle in this project
has ever touched a source file after creation, and a validator revert would cost the whole
cycle. The correction is instead recorded here, in carry-forward **[21]**, and inside the target
issue's `open_questions`, which is where a future cycle reading src-0006 will actually look.

**New, and it is why I re-pulled before building anything.** Eleven of Table 2's twenty-eight
rows are **strictly monotone decreasing across all eight general-purpose columns in exactly the
printed column order**, with unusually smooth decrements (Malware Family Mapping, IOC
Normalization, Campaign Attribution, Language/Style Profiling, Relation Graph Building,
Mitigation–TTP Mapping, Defensive Playbook Gen, Countermeasure Ranking, Campaign Escalation,
Event Timeline Construction, Infrastructure Reuse). For independent measurements the chance of
*one* row matching a fixed eight-column order is 1/8! ≈ 1 in 40,320.

I therefore ran a **second fetch against a different URL form** (`/html/2509.23573v5`) asking for
ten named rows cell-by-cell, with an explicit instruction to answer "CANNOT READ" rather than
reconstruct. **All ten rows came back identical, cell for cell.** So this is as-printed in the
paper and **not** a fetch artefact. I do not know its cause and I am not going to guess at one.
It matters because src-0006 is cited by three issues, so it is carry-forward **[22]** — and
Result 4 point (3) is the robustness check that keeps this cycle's main finding independent of
it. This is also why "one verbatim pull is not always enough" is in the standing rule; here the
second pull confirmed rather than corrected, which is the outcome that lets a finding be relied
on.

## Changes made

All changes are in `state/issues/graph.json`, confined to the issue
`extraction-vs-reasoning-ordinal-axis`. **No file in `state/knowledge/` was touched** and **no
source was added**, so the append-only rule and the `max_new_sources` budget are both trivially
satisfied. **No score was set** — T3 has no standing to score.

1. **`open_questions` rewritten** (t3_investigate step 4), from 4 entries to 6. Two new entries
   lead: the commensurable-measurement finding, and the model-vs-corpus-identity hypothesis with
   its first quantification. The three inherited entries are **retained verbatim** with cycle-17
   status prefixes (`SUPERSEDED IN PART`, `ANSWERED`, `ANSWERED`) rather than deleted, and one
   carries a prepended note recording that I re-examined the src-0006-vs-src-0007 pair and
   **still decline to open a contradiction**.
2. **Cycle-2 candidate_resolution: `proposed` → `rejected`**, with the reason appended. **Not one
   word of the original text was altered** and the cycle-2 provenance header stands, per the
   queue entry's instruction. It is rejected *as an ordinal claim*, which is all it still asserts
   after the cycle-16 split moved task-dependence out of it.
3. **New candidate_resolution, `supported`**, evidence `src-0006` + `src-0007`: the axis is not
   supported by the one commensurable measurement available and the binary is too coarse.
   Carries both data-quality caveats and the residual label-space limitation.
4. **New candidate_resolution, `proposed`**, evidence `src-0006` + `src-0007`: model identity and
   corpus identity as replacement explanatory variables, with three stated objections to itself.
5. **`attempts`: `[]` → `[17]`** (step 5).

**On promoting to `supported` with two sources.** The bar is ≥1 source, ≥2 for strong claims.
This is a strong claim, so I held it to two: src-0006's commensurable subset is the primary
evidence, and src-0007's within-table model reversal is independent corroboration from a
different team, corpus and model set. Both fail to reproduce the ordering by different routes.

**No contradiction entry was opened this cycle** (step 6). Two candidates were considered and
both declined, with reasons recorded above and in the issue: the src-0006 label error (a state
defect, not a source conflict), and the tension between Result 5 and the parent issue's supported
task-dependence claim. On the latter: *"reliability varies sharply by sub-task"* and *"model
identity explains as much as sub-task does"* are both true simultaneously — the second qualifies
the first without negating it. It is flagged for cycle 18's T4 and cycle 23's T2 as
carry-forward **[23]** rather than silently dropped, since a T3 has no standing to rewrite
another issue's questions.

**JSON validity** checked by construction and by re-reading the edited seam (`python3` is
permission-blocked, see [9]): the issue block re-read whole at lines 141–172 — 6 `open_questions`
strings, 3 `candidate_resolutions` objects each with `summary`/`evidence`/`status`, braces
balanced, `created_cycle` and `attempts` intact, all `evidence` ids within src-0001…src-0016.

## Next task rationale

**T4 (Assess)**, per the state machine `T3→T4`. Cycle 18. Not a T5 — I checked.

Cycle 18's T4 is unusually consequential and the queue entry says so explicitly:

- **The graph has 8 issues and `scores.json` has 6 entries, `last_assessed_cycle` 13.** Both
  cycle-16 issues have never been scored. `t4_assess.md` step 1 says score *every* issue in the
  graph, not just recently touched ones. This is the single most important instruction in that
  entry and it is carry-forward **[B]** from cycle 16.
- **The G3 gate must be applied as a CEILING, not a subtraction**, per cycle 16's ruling
  (carry-forward **[4]**), which remains unexecuted because it needs harness edits outside this
  agent's output surface.
- **This issue's score should move on the merits.** It arrives with a `rejected` candidate, a
  `supported` candidate and a `proposed` candidate where it had one `proposed` — but a T4 should
  note that a *supported negative* answer is still a resolved issue, and score the evidential
  state rather than the polarity of the conclusion. I am flagging that explicitly because the
  rubric is definitional and "supported resolution exists" is the definition that matters.

## Budget

- **Web fetches:** 2 (src-0006 `/html/2509.23573` full-table pull; `/html/2509.23573v5` targeted
  ten-row re-pull for the monotonicity check). Both succeeded.
- **Web searches:** 2, both **empty** against the stated bar. Queries recorded verbatim above.
- **Sources added:** 0 of a budget of 5.
- **File reads:** 7 (next_task, meta, config, cycle-016 log, index, graph, src-0006.md +
  src-0007.md) + 1 structural re-read of the edited seam.
- **File edits/writes:** 5 edits to `graph.json` + this log + `next_task.json` +
  `last_completed_task.txt`.
- **Bash:** 0. Nothing this cycle needed it, and [9] says probing it is wasted budget.
- **Assistant turns:** ~10.
- **Dead ends:** the two searches (Result section). Cost 2 searches; yielded three collection
  leads, one of them (SEvenLLM's 13-understanding/15-generation split) directly on this issue's
  axis. Recorded so cycle 22's T1 can act and cycle 23 does not re-run them blind.

---

## Carry-forward items

All twenty items from `logs/cycle-016.md` are reproduced below **including those I could not act
on**, with cycle-17 updates, plus three new. Discharged items stay marked rather than deleted.
Three handoffs have lost or corrupted state (cycle 11 dropped [8] and [9]; cycle 14 found [12]'s
central claim factually wrong), so this section is load-bearing.

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Done. Narrow claim
stayed; ordinal axis moved to `extraction-vs-reasoning-ordinal-axis` with the cycle-2 candidate
moved verbatim. Cycle 10's refusal to open a G3 contradiction over src-0006-vs-src-0007 was
re-read and endorsed. *Cycle 17 note: the split is now vindicated substantively, not just
structurally — the ordinal half resolved in one cycle once it was scoreable on its own terms,
after nine cycles stuck inside a conflated issue.*

**[2] — DISCHARGED cycle 16.** Attach src-0007 to `ttp-attack-mapping-reliability`. Done.

**[3] — DISCHARGED cycle 16.** New issue on triage precision, created as
`automated-triage-under-refusal`.

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED.** The G3 gate is specified three ways:
`prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35 comment (**subtraction**),
`scripts/validate_state.py` lines 144–156 (**ceiling**, = 3 under current config). The enforced
reading is in the minority. Cycle 16 **ruled for the CEILING** — the rubric is definitional, not
arithmetic, so subtracting 2 from an honest 2 yields a score whose own definition ("no candidate
resolutions") is false of the issue and hands the weakest-link selector a fabricated bottom.
Exact replacement text for both artefacts is in `logs/cycle-016.md` "Item 3". **NOT APPLIED** —
`prompts/`, `config.yml` and `scripts/` are outside this agent's output surface. **Until a human
applies it, T4s must keep applying the ceiling**, consistent with cycles 10, 11, 13. The
divergence is silent if unfixed: subtraction produces lower scores, which never trip the
validator's ceiling check.

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6, the
paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Substance unaffected; no contradiction
opened. Needs a PDF-level check before src-0008's phase structure is cited — *but see [14]: no
PDF text extraction exists on this runner, so that check is likely blocked too.* Its per-phase
percentages exist ONLY as pie charts (Figure 2) and cannot be verified by table pull; its Table 7
hallucination rates (Anthropic 0.11%, ChatGPT 0.23%, Gemini 4.8%, Grok 0, Cohere 0) are verified
exact and their "approximate" caveat can be lifted.

**[6] — PARTIALLY UPDATED cycle 17.** Three unfinished search directions, open since cycle 9:
citation-graph sweep of arXiv 2506.11325; third-party evaluations of the IoC Searcher /
AlienVault OTX / VirusTotal baselines; and the paywalled eLLM-CTI paper (ScienceDirect
S0167739X26001482, HTTP 403, no preprint located). **Forward-citation sweeps have FAILED on two
different arXiv ids — treat as unavailable infrastructure, not an unsearched direction.** Use
direct topical search. *Cycle 17 note: adds three new topical leads from this cycle's empty
searches — **SEvenLLM** (`arxiv.org/pdf/2405.03446`, 28 CTI tasks split 13 understanding / 15
generation), **AthenaBench** ("unified scoring", no URL captured), **CTIArena** (no URL
captured). All three are leads, NOT sources; none is in `index.json` and none may be cited.*

**[7]** `ctr-0001` RESOLUTION PATH: recover recall/F1 from src-0007's released code
(GitHub/HuggingFace per its abstract) to make its precision-only numbers comparable with
src-0003's F1, and/or find a source running an unscaffolded LLM against PRISM or a LANCE-style
pipeline against CyberThreat-Eval. Cycle 15's full Table 4 pull confirmed there is no recall or
F1 row for IoC Extraction anywhere in that table — the omission is real, so the code release is
likely the only route. *Cycle 17 note: **this is now LESS urgent for the ordinal-axis issue and
unchanged for `ioc-extraction-reliability`.** Cycle 16 wrote that if ctr-0001 resolves toward
scaffolding, the ordinal axis "loses its clearest supporting datapoint". The axis has since been
rejected on other grounds, so that dependency is moot. But cycle 17's Result 1 does bear on
ctr-0001 itself: an IoC recall low enough to reconcile src-0007 with src-0003 by metric artefact
alone would have to be 0.09–0.15, which is implausible — so the metric confound (2) in ctr-0001
is weaker than the system confound (1), and the code release remains the resolution path.*

**[8] — UPDATED cycle 17.** G2 RE-VERIFICATION COVERAGE: src-0004 (c4, c12), src-0003 (c5),
src-0002 (c6), src-0001 (c7), **src-0006 (c8, and c17 — PARTIAL FAIL, see [21])**, src-0005 (c9
substance-only, c11 verbatim), src-0008 (c10), src-0012 (c13), src-0011 (c14), src-0007 (c15 —
PASSED), src-0009 and src-0010 (c16 — PASSED). **Never verified: src-0013, src-0014, src-0015,
src-0016** (all added c15). **src-0013 is now the clear priority** — see [20]; cycle 17 chose
src-0006 over it because src-0006 doubled as issue work, and that trade paid off, but it means
src-0013's load-bearing ΔECE figures are now two cycles overdue.

**[9]** SANDBOX LIMITATION, diagnosis corrected at cycle 16. `python3` is **present** at
`/opt/hostedtoolcache/Python/3.12.13/x64/bin/python3` and resolves on `PATH`; the **permission
layer** blocks it — invocations return "This command requires approval" and are never approved
unattended. Compound/piped commands are rejected if any segment is unapproved. Do not look for a
different Python. **No PDF text extraction exists on this runner** — poppler-utils (`pdftoppm`,
`pdftotext`), `mutool`, `gs`, `qpdf` all absent; `WebFetch` returns PDF bytes undecoded.
Consequence: validate JSON by construction and by re-reading edited seams. *Cycle 17 note:
followed, and cycle 17 spent zero Bash calls — do not re-probe this.*

**[10]** src-0005 HAS STILL NEVER HAD A NUMBER CAPTURED. Cycle 11's G2 verified its stored quotes
verbatim against the arXiv abstract, but every claim it contributes is abstract-level and
directional. It is one of the sources holding `ttp-attack-mapping-reliability` at 3. Pulling
CyberSOCEval's per-model/per-task scores from the full paper remains the cheapest thing that
could move that issue. **Oldest un-actioned collection task in the project (open since cycle 1);
it is T1 work.** *Cycle 17 note: raised in priority. src-0005 is cited in the cycle-2 candidate
that cycle 17 just REJECTED, and it is the only source in that citation list whose contribution
was never numeric — so a T1 pulling its per-task scores could bear directly on whether any
ordinal structure survives at all.*

**[11]** TIE-BREAK 3a IN `prompts/t5_select.md` IS UNDER-SPECIFIED and the policy has no
deterministic tie-break after 3c. "An issue that others depend_on outranks its dependents" admits
a strict pairwise reading and an in-degree reading. Suggested fix for a cycle with standing: add
"3d. longest time since the issue last received new evidence; then fewest total attempts" —
**note that ordering**, established by cycle 14: "fewest attempts" was useless on the pair it hit
(both had exactly one) and evidence-recency is what actually decided. Cycles 11, 14 and 16 all
declined to edit the prompt. Same class as [4].

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW — **and this item's stronger claim
was WRONG; see [17].** T2 is the only task type with standing to split an issue, add an issue, or
reconcile the prompt/validator disagreement. What cycles 11–13 recorded — that the loop "never
returns to T2" — is false. Cycle 16 was the proof of both halves: three ready-to-execute changes
waited ~9 cycles for a task type that fires every 7.

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400, "The following
domains are not accessible to our user agent". Der Spiegel is the upstream primary for the entire
ENISA incident, so this is a permanent structural gap. The archived-PDF footnote-count route is
**also closed** (see [14]). **Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own
writeup is the only remaining route known to this agent.**

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened by this agent. Three routes failed: `WebFetch` returns raw FlateDecode
binary; the `Read` tool needs poppler-utils, absent; `pdftotext`/`pdftohtml`/`mutool`/`gs`/`qpdf`
all absent while `python3` is permission-blocked. **Consequence: "ENISA never disclosed the AI
use" is established at landing-page level (re-verified cycle 16, both pages) and UNVERIFIABLE at
document level here.** `institutional-incident-real-world-impact` was raised to 3 partly on this,
so a T4 should treat the document-level claim as unestablished rather than pending. **Do not
re-spend budget on it the same way.**

**[15] — DISCHARGED cycle 16 by merge.** The curl/HackerOne case (bug bounty ended 31 January
2026 after a flood of AI-generated "slop" reports; ~20% of submissions AI slop by mid-2025;
confirmed-vulnerability rate falling from ~15% to under 5%;
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`)
is recorded as an **open_question on `automated-triage-under-refusal`**. **It is a question, not
evidence — no curl source exists in `index.json` and G1 forbids inventing one.** A future T1
should collect it.

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question any cycle has found. Verbatim from `https://gptzero.me/investigations/ey`: it
has "set up an automated pipeline to search for vibe citations by finding and scanning public
reports from major consulting firms", is releasing findings "one report at a time", and has
already investigated "a government publication, two different Deloitte reports, and prestigious
machine learning / artificial intelligence conferences like NeurIPS and ICLR". A T1 should chase
`gptzero.me/news/tag/investigations` for the Deloitte and government write-ups, taking the
incident count from 2 to 4–5 across three institution types. Caveats: GPTZero is a commercial
AI-detection vendor reporting on its own product's value, no *rate* is published, and the
scorecard widget renders as "0 of N" to automated fetch — read the body text, not the widget.
**Still the top T1 lead for the next collect cycle (cycle 22).**

**[17]** THE REFRESH RULE IS THE ESCAPE TO T2: `prompts/system.md` line 46 specifies `T1→T2`, the
refresh rule makes every seventh cycle's T5 emit a T1, so the chain is **T5 → T1 → T2**. This
corrects [12]. Confirmed end-to-end by cycles 14→15→16. Structural finding for the paper: the
only task type that can restructure the issue graph fires at most once every seven cycles and
only as a side effect of a rule whose stated purpose is refreshing evidence. **Next T2 is due at
cycle 23.** Anything structural found between now and then must be queued, not acted on.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly, but cite carefully. Body text
says "NeurIPS exhibiting the highest absolute count (391 papers)" while its own Table 3 gives
NeurIPS 391 invalid citations across 308 papers — the prose conflates the columns. No claim in
our base repeats the error and **no G3 entry was opened**: one source disagreeing with itself is
not two of our supported claims in conflict. Any cycle quoting src-0011's *counts* should take
them from Table 3's columns, not that sentence. *Cycle 17 note: this item's reasoning is the
precedent cycle 17 followed for [21].*

**[19] — DISCHARGED cycle 16.** src-0007's Table 4 Content: Threat Actor rubric block attached to
`attribution-confident-wrong-gap` as a **`proposed`** candidate. **The FT-column anomaly is
preserved as a re-pull instruction**: GPT-4o (FT) 3.964/3.655/2.967 tracks o3-mini 3.964/3.656/
2.968 to within 0.001 on all three rows. Still uncaptured from that table: the Deep Search
URLs-Extraction block (GPT-4o 6.22 avg URLs vs GPT-4o-mini-FT 1.25) and the full Triage
pass-rate/bias rows — the latter directly relevant to `automated-triage-under-refusal`.

**[20] — PRIORITY RAISED cycle 17.** THE FOUR SOURCES ADDED AT CYCLE 15 HAVE VERBATIM-CONFIRMED
ABSTRACTS BUT ONLY src-0015 HAD A TABLE PULLED WHOLE. src-0013's ECE/Brier/False-Trust values and
src-0014's F1/coverage values were returned as quoted body sentences, not pulled tables — **those
numbers are single-pass and should not be treated as load-bearing until a G2 pulls the tables
whole.** src-0013 additionally has an unreconciled internal discrepancy: False Trust for
GPT-4o-mini appears as 33.9% in one section and as "16.9% to 83.2%" in another — **do not quote
those two figures together** until the FT table is pulled. src-0013 is cited in a **supported**
candidate on `task-dependent-reliability-framing` (the ΔECE functional-vs-security figures), so a
load-bearing citation rests on single-pass numbers. **It was the recommended G2 target for cycle
17 and cycle 17 chose src-0006 instead; it is now the recommended target for cycle 18 and is two
cycles overdue.** Cycle 17's own experience is the argument for doing it: pulling a table whole
found a labelling error in a source verified nine cycles earlier.

**[21] — NEW cycle 17. src-0006.md CONTAINS A FACTUAL LABEL ERROR; the numbers are fine.** Key
claim 2 says Infrastructure Reuse peaks at "F1 0.754 for a specialized agent vs. 0.688 for a
general model". **ZYS (0.688) is a cybersecurity-SPECIALIZED model, not a general one** —
established from the paper's own body sentence "Source Reliability AUC tops out at ∼0.91 versus a
best cyber score of ∼0.74", where 0.738 in that row is ZYS. The true general-model peak on
Infrastructure Reuse is **G5 at 0.677**. Direction survives, label does not. **Also imprecise in
the same claim and in `index.json`: "F1 range roughly 0.20–0.90" — the true F1 span in Table 2 is
0.286 (False Flag Detection, LLY) to 0.882 (Affected Systems, LL70).** No contradiction entry was
opened (state defect, not source conflict — precedent [5] and [18]) and `src-0006.md` was not
edited (no cycle has ever touched a source file post-creation; a validator revert would cost the
whole cycle). **Anyone citing src-0006's general-vs-specialized comparisons must use the split
8 general (G5, Go4, CLD, GEM, LL70, MIX, QWN, GRK) / 7 cyber (FSC, CB0, ZYS, LLY, CBS, SPT,
DHT)**, which cycle 17 established from body text, *not* from the fetch tool's own answer — that
answer was self-contradictory (claimed 14 model columns while listing 15, split them 6/9).

**[22] — NEW cycle 17. AN UNEXPLAINED REGULARITY IN src-0006's TABLE 2, flagged because three
issues cite this source.** Eleven of its twenty-eight rows are **strictly monotone decreasing
across all eight general-purpose model columns in exactly the printed column order**, with
unusually smooth decrements: Malware Family Mapping, IOC Normalization, Campaign Attribution,
Language/Style Profiling, Relation Graph Building, Mitigation–TTP Mapping, Defensive Playbook
Gen, Countermeasure Ranking, Campaign Escalation, Event Timeline Construction, Infrastructure
Reuse. For independent measurements, one row matching a fixed eight-column order has probability
1/8! ≈ 1 in 40,320. **This is NOT a fetch artefact** — a second fetch against a different URL
form returned ten named rows identical cell-for-cell. Cycle 17 does not know the cause and does
not speculate. **Cycle 17's own finding is deliberately robust to it** (the headline rests on
non-monotone rows and survives excluding all four monotone F1 rows). A future cycle relying on
the *smooth* rows specifically — or on src-0006's aggregate ranges — should treat them with more
caution than the rest of the table.

**[23] — NEW cycle 17. A QUALIFICATION THAT `task-dependent-reliability-framing` SHOULD ABSORB,
for cycle 18's T4 and cycle 23's T2.** That issue's supported candidate cites src-0006's
"F1/AUC roughly 0.20–0.90 across tasks and models" as evidence that reliability varies sharply by
sub-task. Cycle 17 computed, from the same table's F1-commensurable subset, that mean
between-**model** range within a task (0.272) and mean between-**task** range within a model
(0.263) are equal to within 0.009. **This does NOT negate the supported claim** — sub-task
variation is real and substantial — but it qualifies the implication that sub-task is the
*privileged* explanatory variable. **No contradiction entry was opened**: both facts hold
simultaneously, so this is not two supported claims in conflict. A T3 has no standing to rewrite
another issue's open_questions, which is why this is a carry-forward rather than an edit.

**[A] — PASS-THROUGH from cycle 16 for the T4.** See [4]: apply the G3 gate as a **CEILING**
(max score `scale_max − g3_contradiction_demotion` = 3 while a contradiction is open), not a
subtraction, and state in the rationale both the ceiling and whether it bound.

**[B] — PASS-THROUGH from cycle 16 for the T4, and it is the most important one.** **The graph
has 8 issues; `scores.json` has 6 entries with `last_assessed_cycle` 13.**
`extraction-vs-reasoning-ordinal-axis` and `automated-triage-under-refusal` (both created cycle
16) have **never been scored at all**. `t4_assess.md` step 1 says score **every** issue in the
graph, not just recently touched ones.
