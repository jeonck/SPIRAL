# Cycle 028 — T3 Investigate — `attribution-confident-wrong-gap`

Model `claude-opus-5`, CLI `2.1.220`, run date 2026-07-30.

Task from `state/queue/next_task.json` (written by cycle 27's T5): run T3 on
`attribution-confident-wrong-gap`, executing the three-step resolution path written into
`ctr-0002` at cycle 23 and carried as item **[36]**.

I read `prompts/t3_investigate.md` myself rather than relying on the queue entry's summary of
it, per the standing lesson in [29]. The queue entry's summary was accurate this time.

---

## Task performed

**All three steps of `ctr-0002`'s resolution path are done, and `ctr-0002` is closed.** Step
(iii) — the one nobody had scoped — did **not** come back clean, and produced a second
contradiction against a different issue. The G2 also produced one, so this cycle opened two and
closed one.

### Step (i) — the primary candidate is rewritten, and the 86-vs-52 framing is retired

The old primary candidate said: *"every one of the 5 tested models' 'plausible-sounding'
attribution rate substantially exceeds its 'correct' attribution rate (e.g. GPT-4-turbo: 86%
plausible vs 52% correct; Gemini-1.5: 74% vs 38%)"*, status `supported`, evidence
`[src-0002, src-0004]`.

CTIBench defines Plausible Accuracy as *"the fraction of correct and plausible answers
combined"*. It **contains** Correct Accuracy, so that inequality is true by construction for
every model on every dataset and evidenced nothing. **I retired the framing rather than
repairing it**, and said so inside the candidate's own text so a reader of the graph alone sees
the withdrawal.

What replaces it is the paper's own third bucket — *"incorrect answer (when the LLM misattributes
the threat actor due to misjudgment, hallucination, or spurious correlation)"* — which is
hallucination-inclusive by the paper's own definition and equals `100 − Plausible Accuracy`:

| Model | incorrect (derived) |
|---|---|
| GPT-4-turbo | 14% |
| GPT-3.5-turbo | 38% |
| Gemini-1.5 | 26% |
| LLAMA3-70B | 20% |
| LLAMA3-8B | 64% |

**These five values are derived by subtraction and are not printed anywhere in the paper.** The
candidate says so in its own text, as the queue entry required. I did not re-derive them; they
were already stored in `index.json` src-0002 key_claims[5] and in `ctr-0002`. I did re-confirm
the ChatGPT-4 row of Table 1 (71.0 / 72.0 / 1.31 / 0.6388 / 52 / 86) as a by-product of step
(iii) — a third independent confirmation.

**src-0004 was removed from this candidate's evidence.** See open_question[2] below.

### Step (ii) — the reading, decided and recorded in the graph

`ctr-0002` offered two readings. **My answer is (a) for the number and (b) for the issue as
titled**, and I entered it as a new `supported` candidate so a T4 scoring the graph alone can see
it.

- **(a) holds for the fact.** A 14–64% outright misattribution rate on 50 real threat reports,
  scored with the authors *"manually verify[ing] each LLM response to account for the multiple
  aliases that threat actors often use"*, is a real and citable finding.
- **(b) holds for the issue.** What made src-0002 compelling *for this issue* was the **size** of
  the 86-vs-52 gap read as plausible-sounding-but-wrong output. That reading is gone and cannot
  be recovered.

The substance of the (b) half is a survey finding I checked deliberately: **no source in this
knowledge base measures expressed confidence on threat-actor attribution.** src-0002 partitions
by correctness only — its metrics section defines accuracy for MCQ/RCM, MAD for VSP, F1 for ATE
and the three-bucket partition for TAA, and nothing else. src-0007's `Content: Threat Actor`
block is an LLM-judged 1–5 **quality** rubric. src-0004 attaches no measurement at all. The
nearest confidence measurements in the base (src-0001's and src-0013's ECE/Brier) are on other
task sets and belong to `consistency-calibration-as-failure-mode`, which this issue already
`depends_on`.

**So this issue's titular quantity is unmeasured by every source it cites.** That is a finding
about the evidence, not about the world: it does not show the gap is small, it shows nobody here
has measured it.

**I record explicitly that I did not adopt (a) alone because it scores better.** Cycle 26's T4
wrote that adopting (a) "returns this issue to 3 immediately and I would expect it to". That was
an expectation, not an instruction, and I have not used it as a reason in either direction. The
honest position is that the issue now has one well-grounded error-rate leg and **zero** legs on
the confidence half that gives it its name — which is a *worse* position on the titular question
than a bare reading of (a) would suggest.

### Step (iii) — the unscoped step, and it found two defects and a third in the source

Checked src-0002's other two key_claims for unstated interpretive gloss, from two fetches of
`arxiv.org/html/2406.07599v3` and one of `arxiv.org/html/2406.07599`.

1. **The paper contradicts itself on the CTI-ATE metric.** Section 4.2: *"We adopt the
   **Micro-F1** score as the evaluation metric for the CTI-ATE task."* Table 1's header:
   **"CTI-ATE (Macro-F1)"**. Both PRESENT verbatim in two independent fetches; the header was
   also established independently at cycle 23. Micro and Macro F1 diverge substantially in
   multi-label settings with a long tail, and the dataset *"comprises 397 unique attack
   techniques"*. **0.6388 is a number whose metric the paper itself does not settle.** This is a
   defect *in the source*, not in our state, and it is unresolvable from the paper.
2. **The cross-task difficulty comparison is ours, not the paper's, and it subtracts
   non-commensurable metrics.** The paper's metrics paragraph gives *accuracy* for CTI-MCQ /
   CTI-RCM ("equivalent to multi-class classification"), *Micro-F1* for a multi-label extraction
   task over 397 technique IDs, and *MAD* against CVSS scores for CTI-VSP. Exact strings
   `task difficulty` and `most challenging` are **ABSENT**; a fetch asked for every sentence
   comparing performance *between* tasks answered **ABSENT**. The only adjacent sentence is
   cross-**model**: *"ChatGPT-4 significantly outperforms other models on the CTI-ATE task,
   underscoring the complexity of the task."* So *ATT&CK-mapping-is-hard* has a weak textual
   anchor; the **quantified** cross-task gap has none.
3. **src-0002 key_claims[2] is false against the paper's own printed table.** It says no
   evaluated model *"exceeded ~72% on any single task"*. Table 1's CTI-TAA **Plausible** column
   reads ChatGPT-4 **86**, LLAMA3-70B **80**, Gemini-1.5 **74**. Exact string `no model` is
   ABSENT (three fetches, two URL forms). It holds only under an unstated restriction to
   CTI-MCQ, CTI-RCM and CTI-TAA-Correct — and it is mutually inconsistent with key_claims[1] of
   the *same entry*, which foregrounds the 86% figure.
4. **The ATT&CK correctness rule is never stated** (exact ID / parent / sub-technique / partial
   credit) — ABSENT in two fetches. Same gap as src-0003's IoC matching rule ([33]); bears on
   [34].
5. **Provenance, new and consequential: arXiv v2 of this paper has no CTI-ATE task at all.** It
   evaluates four tasks, has no F1 metric anywhere and no ATE column in Table 1. CTI-ATE was
   added in v3. **Always fetch v3 or the latest render — a v2 fetch returns spurious ABSENTs.**
   I hit this myself: my v2 fetch, intended as the second URL form for the Micro-F1 check,
   returned ABSENT for everything ATE-related. The third fetch (latest render) is what actually
   confirmed it.

These findings propagate: `ttp-attack-mapping-reliability`'s first supported candidate says
*"far below the ~71–72% accuracy the same models reach on knowledge-recall tasks"* — the exact
non-commensurable subtraction. **`ctr-0006` is filed against that issue.**
`task-dependent-reliability-framing` is exposed more weakly (src-0002 is one of five sources
there and that candidate does not itself perform the subtraction); the entry says so.

### The ten-cycle open question, answered

`open_question[2]` asked whether ENISA's APT29/"Midnight Blizzard" error is the same phenomenon
as src-0002's measured attribution error, or a distinct citation/naming-fabrication sub-type. It
had been merely articulated since cycle 18. **The answer is: distinct sub-type.**

The deciding argument comes from src-0002's own scoring rule, already stored verbatim here:
*"To further ensure accuracy, we manually verify each LLM response to account for the multiple
aliases that threat actors often use"*, with the correct bucket defined as *"when the LLM
accurately identifies the threat actor **or one of its aliases**"*. **CTI-TAA scores an alias as
correct.** APT29 and Midnight Blizzard are two names for one group; the ENISA passage names the
right group, and its error is a false claim about *which vendor uses which name* — naming
provenance, not attribution judgement. **Under CTI-TAA's own rule the ENISA sentence would score
CORRECT.** The defect is invisible to the instrument this issue's quantified leg rests on, so
the two cannot be instances of one measured phenomenon.

This **cuts against this issue's own interest** and I recorded it anyway: src-0004's evidential
home is `institutional-incident-real-world-impact`, and it must not be counted as an independent
second source here. That is why the primary candidate now cites src-0002 alone.

**Deliberately not attempted:** strengthening src-0004's AI-causation limb. `spiegel.de` is
unreachable and the ENISA v1.2 PDFs cannot be opened ([13], [14]) — a permanent structural gap,
not a to-do. **No budget was spent there.**

**Honestly deferred:** `open_question[1]` (is attribution error correlated with how
well-documented a group is?). Not worked. I rewrote it to say so and to record what I *did*
establish by inspection: no source here publishes a per-report or per-actor breakdown, so it
needs new material, and the cheapest untried route is CTIBench's own released artefact — the
same route that worked for src-0007 at cycle 21.

**No new sources added.** The three steps needed none, and after they were done the remaining
budget went to writing the corrections into both `index.json` and both `.md` files rather than
to a search. `open_question[0]`'s missing datapoint (a correct/plausible/incorrect partition for
a post-2024 model) is flagged as the top collection target instead.

---

## Retrospection

**Target: src-0018** (SentinelLabs, "From Narrative to Knowledge Graph", added cycle 25) — the
**only source in the base that had never been verified**, per [8]. Chosen over src-0008 on
never-checked-before-stale. My main task had me fetching src-0002, which per the queue entry does
**not** count as a G2, and I did not treat it as one.

**Method:** two fetches — the article URL, and a `?print=1` rendering. The second was instructed
to quote every sentence containing a digit, to report every image's alt text / caption / URL, and
to write "IMAGE - CANNOT READ" rather than infer.

**Result: PASS on every stored quotation, FAIL on the stored scope. `ctr-0005` opened.**

**Positive half.** Every stored verbatim quotation re-verified **PRESENT and exact**: the
343/1859 ground-truth sentence, the 95%-confidence repeated-execution protocol, the `P_o`
definition, the `D̄_o` definition, the "value class `None`" abstention sentence, the FDR and FNR
definitions, the "not to provide conclusive performance comparisons" limitation, the five model
names, byline and date. The four **performance** artefacts are **IMAGE - CANNOT READ for a third
independent time**, so the ban on quoting/estimating/ranking those magnitudes **stands in full**.

**Corrective half — and this is the first defect in this base that is *too cautious*, not too
bold.** key_claims[1] says, in capitals, **"NO NUMBER ON THE PAGE IS RECOVERABLE"**, "Every
quantitative artefact is an IMAGE", "supplies **ZERO citable magnitudes**", and "No cycle may
quote, estimate, rank or compare numbers from it". The page carries these in plain body text:

> "In all cases, the use of LLMs substantially reduced report processing time compared with human
> analysts, whose average was 41 minutes per report."

> "On average, the extractors required about 3.3 minutes per report, corresponding to an
> aggregate speed-up of more than 18 times."

> "Even the slowest LLM-based setup processed reports approximately 6 times faster than the human
> baseline, while the fastest reduced average processing time by more than 97% relative to the
> human baseline."

> "The analysis is based on 17 individual metrics, each expressed as a ratio between 0 and 1 …"

It is also **internally inconsistent with key_claims[0] of its own entry**, which already cites
343 and 1859 — numbers on the page.

**Two substantive things the over-broad ban locked out.**

1. **Temperature was set to 0**: *"…the LLM temperature parameter was set to 0 to minimize
   randomness and reduce non-deterministic behavior."* So src-0018's repeat-run decision
   inconsistency is **residual non-determinism under a determinism setting** — the same property
   cycle 25 found strengthened src-0001 ("temperature=0 and the same seed"). **Two independent
   teams now report CTI-task output instability at temperature 0.** That is a real strengthening
   of `consistency-calibration-as-failure-mode`'s consistency half, and it was fenced off by a
   hedge.
2. **A human-analyst baseline exists here**: 41 min/report against ~3.3 min. It is a
   **throughput** baseline, **not** an accuracy baseline, so it does **not** answer
   `ttp-attack-mapping-reliability`'s sixteen-cycle `open_question[1]` (human-analyst *F1* on
   ATT&CK extraction). But it is the only human-vs-LLM comparison of any kind in this base and no
   cycle knew it was here. **I am flagging it precisely so nobody over-claims it.**

**Also corrected:** the stored text says "its four images"; the page carries **ten** figures, six
quantitative — including "Prediction and error diversity (GPT‑4.1 and Claude Sonnet 4.5)" and
"LLM Performance in Playbook and knowledge graph assembly", neither previously known here.

**Methodological by-product — the fourth instance of [38] and it caught me again.** My **first**
fetch returned the `P_o` and `D̄_o` definitions as **ABSENT**. The second URL form returned both
**PRESENT and exact**. Had I recorded that first verdict I would have filed a false defect
against a clean source. **A single fetch's ABSENT is still not evidence of absence.** It caught
me a second time in the same cycle on the v2/v3 CTI-ATE question.

**Reporting this plainly, as the rules require:** a re-checked conclusion failed. That is the
system working. This is the fifth of six checked sources to yield a defect, and the defect class
now has a seventh member — **over-restriction**: a hedge written so broadly that it forbids
citing things the source actually states. Every prior member of the class was an over-claim. This
one cost the base a strengthening of a live issue for three cycles.

---

## Changes made

**`state/issues/graph.json`**

- `attribution-confident-wrong-gap`:
  - `open_questions[0]` **rewritten** — the old question is malformed (the gap it asks about is
    true by construction) and is retired with the well-posed replacement stated: does CTIBench's
    own *incorrect* (hallucination-inclusive) rate fall for post-2024 models? Status: no source
    here answers it; flagged as the top collection target.
  - `open_questions[1]` **rewritten to record an honest deferral** plus what is known by
    inspection and the cheapest untried route.
  - `open_questions[2]` **answered** — distinct sub-type, with the argument from CTI-TAA's own
    alias-tolerant scoring rule, and the consequence recorded against this issue's interest.
  - `candidate_resolutions[0]` **rewritten**: 86-vs-52 retired by name; derived incorrect-bucket
    rates 14/38/26/20/64% with derivation and not-printed-in-the-paper status stated in the
    candidate's own text; evidence narrowed `[src-0002, src-0004]` → `[src-0002]`; explicit
    statement that it evidences **wrongness, not confidence**.
  - **New `candidate_resolutions[1]`, status `supported`**, evidence
    `[src-0002, src-0007, src-0004]`: the step-(ii) decision and the survey finding that no
    source here measures expressed confidence on threat-actor attribution.
  - `candidate_resolutions[2]` (the src-0007 rubric candidate, formerly [1]) **annotated**:
    status **stays `proposed`**; it evidences wrongness not confidence; GPT-4o (FT) column still
    suspect; rubric absolute level still uninterpretable.
  - `attempts`: `[16]` → `[16, 28]`.
- **`ctr-0002` RESOLVED**, `resolved_cycle: 28`, with an appended bracket recording all three
  steps, the decision, and the note that the new defects it uncovered are held in `ctr-0006`
  rather than here.
- **`ctr-0005` OPENED** against `consistency-calibration-as-failure-mode` — src-0018's
  over-restriction (G2 finding).
- **`ctr-0006` OPENED** against `ttp-attack-mapping-reliability` — src-0002's Micro/Macro
  self-contradiction, the non-commensurable cross-task gloss, and the false key_claims[2].

**`state/knowledge/index.json`** (append-only respected; nothing removed or rewritten)

- src-0002: **key_claims[6] appended** — the six step-(iii) findings, including sample counts
  never previously stored (2500 / 1,000 / 1,000 / 60 with 397 techniques / 50).
- src-0018: **key_claims[4] appended** — the cycle-28 G2, positive and corrective halves.

**`state/knowledge/src-0002.md`** and **`state/knowledge/src-0018.md`** — matching sections
appended to both. **Repairing only `index.json` is how src-0016's defect survived six cycles**
([21], [31]); the both-places pattern now holds for cycles 22, 23, 25, 26, 27 and 28.

**Validation.** `jq -e .` run after every JSON edit, plus `jq -r` read-back of the specific
fields added — which caught one real error: my first `ctr-0002` edit wrote backslash-escaped
quotes into the file and `jq` rejected it immediately. Read-backs confirm: 3 open_questions, 3
candidate_resolutions with correct `status`/`evidence` on each, `attempts [16,28]`, six
contradictions with correct ids/issues/cycles, 18 sources intact, and every `evidence` id in the
graph present in `index.json` (validator lines 130–134, 140–142).

**Not done, and deliberately:** no rescore. A T3 has no standing. `scores.json` is untouched.

---

## Next task rationale

**Next task is T4 (assess).** The state machine is T3→T4 and I re-derived the position from
`config.yml` rather than trusting [28]: cycle 25 T3, 26 T4, 27 T5, 28 T3 (this one), **29 T4**,
30 T5. `collect_refresh_every: 7` fires only when a T5 *runs on* a multiple of 7; 28 is a
multiple of 7 but is a T3, so nothing fires, and of 35 and 42 only 42 is a T5. **The next T1 is
still cycle 43.** A T4 scores **all** issues, so it takes no `target_issue`.

Three things the cycle-29 T4 must weigh, stated here so they are not lost:

1. **`attribution-confident-wrong-gap` now carries no open contradiction.** Its G3 ceiling lifts
   from 3 to 5. **That is a lifted constraint, not an argument for a score.** Cycle 26 recorded
   its demotion to 2 as a merit judgement, explicitly *not* a gate artefact. The honest input is
   that the issue gained a well-grounded error-rate leg and **lost** its second source (src-0004
   reclassified) and its only claim on the confidence half.
2. **`ttp-attack-mapping-reliability` now carries `ctr-0006`** and is scored 3 against a ceiling
   of 3 — so it does not break validation, but its first supported candidate contains a
   comparison the source's own metric definitions do not license.
3. **`consistency-calibration-as-failure-mode` now carries `ctr-0005`** as well as `ctr-0003`.
   Ceiling unchanged at 3. But note the direction: `ctr-0005`'s content is that the base has been
   **under**-citing that source, and the temperature-0 fact strengthens the issue's consistency
   half. **A second contradiction on an issue is not automatically a second reason to demote** —
   and, per [4]/[41], nobody has specified whether the G3 gate is per-issue or per-contradiction.
   `ioc-extraction-reliability` has carried two since cycle 27 and now a second issue does too.

---

## Budget

- **Web fetches: 5.** src-0018 ×2 (article URL, `?print=1`); `arxiv.org/html/2406.07599v3` ×1,
  `…v2` ×1 (wasted — v2 has no CTI-ATE task), `arxiv.org/html/2406.07599` ×1.
- **Web searches: 0.**
- **New sources added: 0** of `max_new_sources: 5`. Permitted by [29]; not needed by the task,
  and I judged writing the corrections into all four files worth more than a speculative search.
- **Bash/jq calls: 8.** Edits: 11. Reads: 6. Turns: roughly 30 of `max_turns: 50`.
- One wasted edit (backslash-escaped quotes into a JSON string) caught immediately by `jq -e`.
- One wasted fetch (v2), which produced a useful provenance finding anyway.

---

## Carry-forward items

All items from `logs/cycle-027.md` reproduced **including those I could not act on**, with
cycle-28 updates. Discharged items stay marked rather than deleted. **Three new items: [43],
[44], [45].**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim stayed;
ordinal axis moved to `extraction-vs-reasoning-ordinal-axis`. Still vindicated. Cited again as
the precedent behind [37] and now [45].

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK
metric at all**. The issue is a two-team claim (src-0002 CTI-ATE 0.6388; src-0007
precision/recall). Blocker remains `open_question[1]`, the missing human-analyst baseline, now in
its **seventeenth** cycle. *Cycle 28: src-0018 turns out to carry a **human-analyst baseline of a
different kind** — 41 min/report vs ~3.3 min. It is **throughput, not accuracy**, so it does NOT
discharge this item, and nobody may treat it as if it did. But it is the only human-vs-LLM
comparison in the base and it was hidden behind [43]'s over-broad hedge.* **And [44] now puts the
0.6388 itself in question: the paper says Micro-F1 in text and Macro-F1 in the table header.**

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. Lost three consecutive
selections; still `attempts: []`. See [30].

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 19 CYCLES.** The G3 gate is
specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35
comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The
enforced reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in
`logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are outside
this agent's output surface. **Until a human applies it, T4s must apply the ceiling.** *Cycle 28:
the per-issue-versus-per-contradiction question [41] raised is now **more** urgent, not less —
after this cycle **two** issues carry two contradictions each (`ioc-extraction-reliability`:
ctr-0001, ctr-0004; `consistency-calibration-as-failure-mode`: ctr-0003, ctr-0005). Under
subtraction, is a doubly-contradicted issue −2 or −4? Still unspecified. Awaiting a human,
verbatim, with [11], [30] and [41].*

**[5]** src-0008 phase-label discrepancy: `src-0008.md` key claim 2 says AES-256 is at P5–P6, the
paper body says "Both XOR (P5, P6) and AES-256 (P7, P8)". Needs a PDF-level check, blocked by
[14]. Not touched at cycles 25–28. **src-0008 (c10) is now the stalest verified source and, with
src-0018 checked, the natural G2 target for cycle 29** — see [8].

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv
2506.11325; **third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal
baselines**; the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not
retry). **Forward-citation sweeps have FAILED on two arXiv ids** — unavailable infrastructure.
**CTIArena is resolved and dead for consistency/calibration purposes**; never re-propose it for
`consistency-calibration-as-failure-mode`. **SEvenLLM** uncollected and downgraded.
**AthenaBench** still has no URL. **No arXiv companion exists for src-0018.** Unavailable:
OpenReview, spiegel.de ([13]). *Cycle 28 adds one: **CTIBench's own released dataset/evaluation
artefact has never been sought**, and it is the cheapest route to both `open_question[1]` (per-actor
breakdown) and [44]'s unstated ATT&CK correctness rule — the same route that worked for src-0007
at cycle 21.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT CYCLE 22; ONE STEP ADVANCED AT CYCLE 27.**
`ctr-0001`'s resolution path. **Done:** released-code route exhausted; **METRIC confound
ELIMINATED**. **Still open:** no head-to-head; the **CORPUS confound is completely untouched and
is the largest gap**. src-0003 matching-rule limb **closed as unanswerable**; the src-0007 side
read at cycle 27 ([42]). Remaining steps, cheapest first: src-0007's **TTP and rubric scorers**
in the src-0017 artefact (`stage3_ti_drafting/ttp/`, [34]);
`huggingface.co/datasets/xse/CyberThreat-Eval`; then corpus difficulty. *Cycle 28: unchanged, but
[44] raises the value of the TTP-scorer read — it would give **one** of the two ATT&CK comparands
a stated correctness rule, where the CTIBench side has none.*

**[8] — UPDATED cycle 28. G2 COVERAGE IS NOW COMPLETE FOR EVERY SOURCE IN THE BASE.** src-0004
(c4, c12), src-0003 (c5; c22 — substance passed, provenance partial fail, [32]), src-0002 (c6;
c23 — numbers exact, interpretation failed, `ctr-0002`; **and c28 step (iii) — two more
interpretation failures plus a self-contradiction in the source, `ctr-0006`**), src-0001 (c7; c25
— `ctr-0003`, peer-reviewed after all, [39]), src-0006 (c8; c17 partial fail [21]; re-pulled
c18), src-0005 (c9, c11; c26 — full pass plus six appended key_claims), src-0008 (c10), src-0012
(c13), src-0011 (c14), src-0007 (c15; c21 Table 4 whole), src-0009 / src-0010 (c16), src-0013
(c18), src-0014 (c19), src-0015 (c20), src-0016 (c21 — provenance partial fail, [31]), src-0017
(c27 — source clean, downstream corrupted, `ctr-0004`), **src-0018 (c28 — every quotation exact,
stored SCOPE wrong, `ctr-0005`)**. *Next G2 should prefer by staleness, since nothing is now
unchecked: **src-0008** (c10, and [5] wants a check it probably cannot get), then **src-0012**
(c13), **src-0011** (c14), **src-0007** (c15). Not recommended next: src-0002 and src-0018 (c28),
src-0017 (c27), src-0005 (c26), src-0001 (c25), src-0003 (c22), src-0016 (c21), src-0015 (c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25–28.** `python3` present but the
**permission layer** blocks it; compound/piped commands rejected if any segment is unapproved.
**No PDF text extraction exists** — prefer `/html` always; `/abs` carries the abstract, which is
why [38] works. `gh` not approved. `awk` refused. **`sed -n` and `cat >>` heredoc ARE approved**;
a heredoc append must be its **own** call. `jq -e . <file> > /dev/null` approved, as is a compound
`jq … && jq …` chain. Prefer **single-line `Edit` anchors**. `scores.json` and `graph.json` are
NOT protected by validator lines 105–107. **`raw.githubusercontent.com` returns whole files.**
Inserting an array element by anchoring on the *previous element's last fields* lets that
element's closing `}` close the NEW element — always `jq -r` the new element's own fields back.
*Cycle 28: all held. Two working patterns confirmed. (a) The **safe insertion anchor** is the
**first** line of the following element's body (here the long unique `summary` line): replace it
with `<new element(s)> , { <the original line>` and let the ORIGINAL trailing
`evidence`/`status`/`}` lines close the last object. Two new candidates and two new contradictions
went in this way with no brace errors. (b) **New trap, cost me one edit:** writing
`\"opened_cycle\"` — backslash-escaped quotes — into an `Edit` `new_string` puts literal
backslashes in the file. `jq -e` caught it on the first try. Do not escape quotes that are JSON
structure; only escape quotes *inside* a string value.*

**[10] — DISCHARGED CYCLE 26, AND THE ANSWER IS THAT IT WAS NEVER ACHIEVABLE.** src-0005's
per-model numbers do not exist in text at all — every per-model score is inside Figures 8, 9,
12–16. **Do not re-attempt without a new route** (published raw results, the CyberSecEval 4 repo,
or OCR). See [40].

**[11] — APPLIED cycle 20, ENDORSED cycle 23, BOUND FOR THE FIRST TIME AT CYCLE 27.** Tie-break
3a in `prompts/t5_select.md` is under-specified and there is **no deterministic tie-break after
3c**. Cycle 27's residue, for a human, in three parts: **(a)** the bottom tier reduced to a
genuine two-way tie identical on score, penalty, dependency and `created_cycle`, broken on an
**explicitly extra-prompt** criterion; **a terminal tie-break must be written into the prompt**;
**(b)** the prompt lists **3a before 3b**, but 3b is an addition *to the score*, so a literal
a-then-b ordering lets them return **opposite verdicts on the same pair**; **(c)** the "within the
last 5 cycles" window has three defensible readings. *Cycle 28: no new information — a T3 does not
select. But note that cycle 27's extra-prompt tie-break **paid off**: the issue it chose yielded a
closed contradiction, two new ones and a ten-cycle open question answered. That is evidence the
criterion was a good one, and an argument for writing it into the prompt rather than leaving each
T5 to invent it.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with
standing to split an issue, add an issue, or reconcile the prompt/validator disagreement. The
claim that the loop "never returns to T2" is false; cycle 16 disproved it. *Cycles 25–28: bit
again, now twice over — the consistency/calibration split ([37]) **and** the new
error-rate/confidence split ([45]) are both T2 jobs and nothing else can do them. The next T2 is
reachable only via a T1, i.e. **cycle 44 at the earliest**.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel is
the upstream primary for the entire ENISA incident: a permanent structural gap. The archived-PDF
route is also closed ([14]). Prof. Christian Dietrich's / Institut für Internet-Sicherheit's own
writeup is the only remaining route known. OpenReview joins this category ([6]). *Cycle 28 met
this wall exactly where cycle 27 predicted and **spent no budget on it**. It also changed the
stakes: `open_question[2]` is now answered, and the answer moves src-0004's evidential weight to
`institutional-incident-real-world-impact`. So the un-strengthenable limb is **no longer
load-bearing for `attribution-confident-wrong-gap`** — it was reclassified rather than propped
up.*

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA v1.2
PDFs cannot be opened. "ENISA never disclosed the AI use" is established at landing-page level and
UNVERIFIABLE at document level here. **Do not re-spend budget.**

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, AND DEFERRED A FOURTH
TIME.** The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of AI-generated
"slop" reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability rate falling from
~15% to under 5%) is an `open_question` on `automated-triage-under-refusal`. **It is a question,
not evidence — no curl source exists in `index.json` and G1 forbids inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26 and 27 all judged it the highest-value uncollected source; cycle 28 agrees.
Earliest route: the **cycle-30** T5's target, i.e. cycle 31 — or cycle 43's T1. **Four cycles have
now called it the top target and none has reached it.**

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question. Verbatim from `https://gptzero.me/investigations/ey`: an "automated pipeline to
search for vibe citations by finding and scanning public reports from major consulting firms". A T1
should chase `gptzero.me/news/tag/investigations`. Caveats: commercial AI-detection vendor; no
*rate* published; the scorecard widget renders as "0 of N" to automated fetch. **Still the only
route any cycle has found to a base rate**, the binding constraint on
`institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16. Structural
finding for the paper: the only task type that can restructure the issue graph fires when a T5
coincides with a multiple of 7 — under a clean three-cycle loop, **once every 21 cycles**.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly (NeurIPS "391 papers" in text
vs 391 invalid citations across 308 papers in Table 3). No claim in our base repeats the error;
**no G3 entry was opened**. Quote src-0011's *counts* from Table 3. *Cycle 28 note: [44] is now a
**second** instance of a source contradicting itself — CTIBench's Micro-F1 text against its
Macro-F1 header. Unlike src-0011's, ours **is** load-bearing, which is why it got an entry.*

**[19] — FULLY DISCHARGED CYCLE 21; CONSUMED BY CYCLES 22, 26 AND 28.** src-0007's Table 4 pulled
**whole and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall (Accepted)
**0.9091–1.0000**. **RESIDUE, UNRESOLVED AND REPRODUCED:** GPT-4o (FT) tracks o3-mini to within
0.001 on **all six** `Content: Threat Actor` rubric rows, identically in two independent pulls
(c15, c21) — as-printed, not a fetch artefact. **Cause unknown; do not guess.** *Cycle 28 carried
the warning into the rubric candidate's own text and did **not** re-pull the table; it is still
single-pull since c15 and that is the stated reason its candidate remains `proposed`.*

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014
(c19), src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy **narrowed but not closed** —
quote 33.9% and 16.9%→83.2% only with their scopes named. Gemini's 0.161 → 0.721 was **not**
re-checked. **Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are still
body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs 0.688
for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose peak is **G5
at 0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly 0.20–0.90"
against a true span of **0.286–0.882**. Cycle 18 appended a corrective key_claim to `index.json`;
**`src-0006.md` itself is still untouched and still contains the wrong sentence — it is the only
known source file still carrying an uncorrected sentence, and it is a cheap fix.** *The
repair-both-places pattern now holds for cycles 22, 23, 25, 26, 27 and 28.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows are
**strictly monotone decreasing across all eight general-purpose columns in exactly the printed
column order**; four are in the nine-row F1 subset `extraction-vs-reasoning-ordinal-axis` depends
on. One row matching a fixed eight-column order has probability 1/8! ≈ 1 in 40,320. **Not a fetch
artefact.** **Any finding resting on that table must carry a robustness check excluding those
rows** (cycle 18's: drop all four → 0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.** Mean between-**model** range within
a task (0.272) and mean between-**task** range within a model (0.263) are equal to within 0.009.
This does **NOT** negate `task-dependent-reliability-framing`'s supported claim — cycles 19, 22
and 26 all tested it — it qualifies the implication that sub-task is the *privileged* explanatory
variable. A T2 should annotate rather than re-scope. No contradiction: both facts hold.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–23 AND 25–28. `jq` IS INSTALLED AND APPROVED.**
**Every cycle from 9 to 17 recorded that this agent cannot validate JSON and must check "by
construction". That advice is wrong and it is expensive** — cycle 17 lost its entire `state/`
output. **Every JSON edit should be followed by `jq -e`** *and* by a `jq -r` read-back of the
fields added. The permission layer is **not uniform** — probe once. The `Grep` **tool** works on
the big JSON files where Bash `grep -n` does not. Cheapest append-only pattern: **`Grep` →
`Read` with `offset`/`limit` → `Edit` → `jq -e` → `jq -r` read-back.** *Cycle 28: `jq -e` caught a
malformed edit on the first attempt; see [9](b).*

**[25] — DISCHARGED CYCLE 21.** `src-0007.md` contains the `Content: Threat Actor` rubric block in
full. **The two caveats must keep travelling:** the rubric's **absolute level is uninterpretable**
(1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a normalisation the paper never states), so
**only within-table contrasts may be cited**; and the GPT-4o (FT) column is suspect per [19].
*Cycle 28 wrote both caveats into the candidate's own text so they cannot be stripped by a
paraphrase.*

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** Suggested harness fix for a human: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before reverting,
and `git stash` the rejected `state/` diff. The mechanism is fine for **crashes** (cycle 24
worked); it is blind to **validator rejections**.

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH.** src-0015's Table 1 has a **`Reward`**
column no cycle has recorded: GPT-5.2 3.07, Sonnet 4.5 **2.37**, Gemini 3 2.61, DeepSeek 3.2
**3.45**. **The model the paper calls best-calibrated earns the lowest reward.** Bears on
`automated-triage-under-refusal`'s `open_questions[0]`. Caveats: reward composition unstated; n=40
per model, no CIs; association not strictly monotone. An observation about an **already-collected**
source, so **no new citation is needed**. Cycles 22 and 26 recorded it in a `rationale`, but a
rationale is not the graph. **Still unentered** — that issue keeps losing selection, so still
nobody with standing.

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–28.** The state machine is T1→T2, T2→T3, T3→T4,
T4→T5, T5→T3. Cycle 24's T3 died before writing anything and cycle 25 re-ran it, shifting the
phase by one. Positions: **cycle 28 = T3 (this one, as predicted), cycle 29 = T4, cycle 30 = T5**,
and T5 thereafter lands on 33, 36, 39, **42**. The refresh fires only when a T5 **runs on** a
multiple-of-7 cycle. *Cycle 28 re-derived from `config.yml`: 28 mod 7 = 0 but 28 is a T3, so
nothing fires.* Of 35 and 42, only **42** is a T5 cycle, so **the next T1 is cycle 43** and the
next T2 is cycle 44. *The single most consequential structural fact in this project: **one
infrastructure failure, costing one cycle, pushed the next collection cycle back by eight***.
**Re-derive rather than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21 AND 25.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018, which
broke a blocker standing since cycle 3. **Standing lesson: read the task's own prompt file, not
only the queue entry's description of it.** *Cycle 28 read the prompt and **chose not to** add a
source — the three assigned steps needed none, and the corrections needed writing into four files.
Recording the non-use as deliberate so no successor reads it as an oversight.*

**[30] — NEW cycle 20; PREDICTION CORRECT THREE TIMES.** `automated-triage-under-refusal`, the
only issue never worked on (`attempts: []`, created cycle 16), has **lost three consecutive
selections**. **"Never attempted" is not a tie-break in `prompts/t5_select.md`**, and cycle 19's
rationale wrongly asserted it was. **This is a prompt change for a human.** Note the interaction
with [11]: **both** readings of 3a bury it — the mechanism is `created_cycle`, and **the newest
issues in a graph are structurally disadvantaged forever, with no expiry**.

**[31] — NEW cycle 21, EXTENDED cycles 22, 23, 25, 26, 27 AND 28. THE VERBATIM CHECK HAS NOW RUN
ON EIGHT SOURCE-CHECKS; SEVEN PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim"
quotation **does not exist on the page** — it splices a real sentence to a table cell. (b)
**src-0003** (c22): quotations passed, stored *numbers* 76/72/86 are **figure-image-only**. (c)
**src-0002** (c23): all 25 numbers exact, **interpretation contradicted by the paper's own metric
definition**; `ctr-0002`. (d) **src-0001** (c25): numbers exact, protocol *stronger* than recorded,
**calibration gloss contradicted by the full table**; `ctr-0003`. (e) **src-0005** (c26): all
claims and quotations **PASS** — but the source was stored with no task format, no metric
definition, no sample counts, no limitations and no numbers. (f) **src-0017** (c27): every stored
string **PASSES** and the source file's hedges are **correct** — the **DOWNSTREAM PARAPHRASE**
dropped them; `ctr-0004`. (g) **src-0018** (c28): every stored quotation **PASSES** — the stored
**SCOPE** is wrong, and wrong by being **TOO RESTRICTIVE**; `ctr-0005`. (h) **src-0002 again**
(c28, step (iii) rather than a G2): **two more glosses, one of them FALSE against the printed
table, plus a self-contradiction in the source itself**; `ctr-0006`. **The defect class is now
seven-way: spliced quotations, unverifiable numbers, unsupported interpretive glosses, partial
table capture, correct-but-hollow entries, correct-source-corrupted-downstream — and now
OVER-RESTRICTION, a hedge so broad it forbids citing what the source actually says.** *(g) is
newly alarming for the opposite reason to (f): every previous defect made the base claim too much,
and this one made it claim too little for three cycles while looking maximally rigorous.*
**Standing lesson, upgraded again: pull the whole file/table AND the metric definition AND the
task format AND the paper's own limitations — then check what the rest of the state claims the
source shows, in BOTH directions.**

**[32] — NEW cycle 22. src-0003's THREE BASELINE F1 VALUES ARE FIGURE-IMAGE-ONLY; REPAIRED BY
APPEND.** On `arxiv.org/html/2506.11325v2` the exact strings **`76` and `72` do not occur** and
the only `86%` is LANCE's own per-type recall. **Cite 76/72/86 as figure-derived and not
text-verified.** Also unverifiable: **`~0.88 F1 with Llama`**. **No contradiction entry — file
when the source's own legible text conflicts with the stored claim; do not file when the stored
claim is merely unverifiable.** *Cycle 28 applied exactly this test to decide `ctr-0005` and
`ctr-0006`: both stored claims conflict with legible text, so both were filed. The rule is
working and should be kept. Caveat from [38] still not discharged: the exact-string limb rests on
a **single fetch's ABSENT** and should be re-confirmed against a second URL form.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER HAD.**
src-0003's 97.6% is measured on a **closed-set classification task over a regex-extracted
candidate set**, not free-form extraction — *"We assume a total of 1,789 candidate indicators,
extracted using IoC Searcher"*; *"LANCE labeled over 99% of all extracted indicators"*; Figure 9's
caption "… on IoC Classification." **A difference in task format, stated by the paper.**
**Companion finding: src-0003 NEVER STATES ITS MATCHING RULE.** *Cycle 28 found the **same gap in
src-0002**: it never states how a predicted ATT&CK technique is counted as correct. That is now
**three** sources in this base whose scoring rule is unstated, and it is the strongest argument for
[34].*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE.** **A within-study design holds team, corpus, models and harness constant but does NOT
hold the scoring rule constant.** A cross-sub-task score spread is a task-difficulty fact only if
the sub-tasks are scored comparably. Cycle 27 corrected the premise: src-0007's IoC matcher is
**one-directional**, not two ([42]) — the objection is unaffected and sharper. **The scoring rules
for src-0007's ATT&CK and rubric tasks have STILL never been pulled**, and neither have src-0006's
per-task metric definitions. **What restores the 4:** read `stage3_ti_drafting/ttp/` in the
src-0017 repo and src-0006's metric definitions, then state and answer the objection.
`raw.githubusercontent.com` makes this a **one-fetch job**. *Cycle 28 supplies the strongest
evidence yet for this item and it comes from the OTHER side of the comparison: **CTIBench defines
CTI-MCQ/RCM as multi-class-classification accuracy and CTI-ATE as F1 over a 397-technique
multi-label space, and states neither an ATT&CK correctness rule nor consistently which F1
variant** — see [44]. So the non-commensurability objection is now anchored in **both** benchmarks
being compared, not one. **Note the asymmetry:** the same finding is neutral-to-favourable for
`extraction-vs-reasoning-ordinal-axis`, whose supported claim is *negative*.*

**[35] — NEW cycle 23. src-0002's CTI-TAA `Correct` AND `Plausible` COLUMNS ARE NESTED, NOT
DISJOINT; `ctr-0002` OPENED; REPAIRED BY APPEND.** **Plausible ⊇ Correct**, so "the plausible rate
is far higher than the correct rate" is **true by construction**. "Plausible" is the
**underdetermined-input** case and hallucination lives in the separate `incorrect` category. The
string `plausible-sounding` **does not occur in the paper**. Derived replacements, to be labelled
as derived wherever used: plausible-but-not-correct = 34 / 18 / 36 / 28 / 8 pp; the paper's own
incorrect (hallucination-inclusive) rate = `100 − Plausible Accuracy` = **14 / 38 / 26 / 20 /
64%**. **All 25 stored numbers are exact.** *Cycle 26: cost the issue a point (3 → 2). Cycle 27: the
reason it was selected. **Cycle 28: acted on — the framing is retired, the derived rates are in the
graph with their derivation stated, and `ctr-0002` is CLOSED.** This item is now DISCHARGED.*

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s resolution path: **(i)** rewrite the
primary candidate — **done**, framing retired by name; **(ii)** decide between readings (a) and
(b) — **done**, answer is (a) for the number and (b) for the issue as titled, entered as a new
supported candidate; **(iii)** check src-0002's other two key_claims for similar gloss — **done,
and it failed**: two glosses, one of them false against the printed table, plus a self-contradiction
in the source. `ctr-0002` `resolved_cycle: 28`. **The consequences did not stay inside the issue:
see `ctr-0006` and [44].**

**[37] — NEW cycle 25, ENDORSED cycle 26, REINFORCED cycle 28. THE ISSUE ASKS TWO QUESTIONS AND
THE EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode` asks
about **consistency** *and* **calibration**. consistency-on-CTI rests on **two independent
sources** (src-0001 + src-0018), calibration-on-CTI on **one** (src-0001, gpt4o only), and
`ctr-0003` sits on the calibration half alone. The natural cut is `consistency-under-repeated-query`
vs `confidence-calibration-on-CTI`. **Only a T2 can split an issue** ([12]); **the next T2 is
cycle 44 at the earliest**. *Cycle 28: the consistency half got **stronger** — src-0018 ran at
**temperature 0**, so both of its independent sources now measure residual non-determinism under a
determinism setting. The asymmetry the split would fix is therefore **widening**, and the issue
took a second contradiction (`ctr-0005`) whose content is that the base was under-citing the
consistency half. Sixteen more cycles of under-expressiveness.*

**[38] — NEW cycle 25, PAID OFF AT CYCLES 26, 27 AND TWICE AT 28. A SINGLE FETCH'S "ABSENT" IS NOT
EVIDENCE OF ABSENCE.** **Rule: a PRESENT verdict may be trusted from one fetch; an ABSENT verdict
must be confirmed against a second URL form before it is recorded as a defect.** Before recording
an absence, check **(1) the abstract**, **(2) a different URL rendering**, **(3) that you fetched
the file the claim actually cites**. *Cycle 28 hit it twice. (a) src-0018's `P_o` and `D̄_o`
definitions came back **ABSENT** from the article URL and **PRESENT and exact** from `?print=1` —
had I trusted the first, I would have filed a false defect against a clean source. (b) A fourth
variant, now generalised: **`arxiv.org/html/<id>v2` of src-0002 has no CTI-ATE task at all**, so
every ATE-related string returned ABSENT from a version that legitimately lacks them. **Add (4):
confirm the VERSION you fetched contains the material the claim is about — an arXiv paper's task
list can change between versions.*** For code repositories,
`raw.githubusercontent.com/<owner>/<repo>/main/<path>` returns whole files.

**[39] — NEW cycle 25, SECOND INSTANCE cycle 26, THIRD PARTIALLY CLOSED cycle 27. PROVENANCE
LABELS IN THIS BASE WERE SET AT COLLECTION TIME AND HAVE NEVER BEEN RE-CHECKED.** src-0001 **is
peer-reviewed** — ARES 2025, Springer, DOI `10.1007/978-3-032-00627-1_17` — and this base called it
a preprint for 24 cycles. src-0005 goes the other way: **an unreviewed preprint** whose
CrowdStrike/Meta attribution rests on recognising two author names. src-0017's `[TMLR '25]` badge
against a March 2026 arXiv submission is **unresolved and probably permanently so** (OpenReview
unreachable). Still unchecked: src-0013, src-0014, src-0015. **Provenance staleness is a cheap,
unworked check.** *Cycle 28 adds a related axis: **version staleness**. src-0002 has been cited
since cycle 1 by `/abs`, and its task list changed between v2 and v3. Nobody has checked whether
any other arXiv source in this base has been revised since collection.*

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS, AND
THIS BASE CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "the share of questions
for which the system selects all correct options and only the correct options." 609
malware-analysis cases; 588 threat-intel-reasoning pairs from 45 reports supplied "via a set of
images". Questions **generated by Llama 3.2 90B and Llama 4 Maverick**, then human-validated; the
paper concedes both that multiple choice "does not provide a perfect proxy" and that there is
"performance bias … where the model under test is the same, or has similarities with the set of
models that were used in synthetic data generation pipelines". **(a) src-0005's percentages are not
commensurable with src-0002's F1 or src-0007's precision/recall.** **(b) src-0005 reports no ATT&CK
metric at all.** **(c) 23–34% (MA) against 43–53% (TIR) is a within-paper cross-task spread but NOT
a controlled contrast** — different corpora, different generation pipelines, different random
baselines (0.63% vs 1.7%). **Anyone using it must state those three confounds.**

**[41] — NEW cycle 26, REINFORCED cycles 27 AND 28. THE G3 CEILING BECOMES *LESS* LIKELY TO BE
TESTED THE BETTER THE LOOP WORKS.** An honest, stingy T4 demotes issues carrying open
contradictions, which moves them *away* from the ceiling. **So the validator's G3 check is very
nearly dead code, while the prompt's subtraction rule — which every T4 has correctly refused to
apply — would fire on multiple issues today and drive them toward 0 without tripping anything.**
*Cycle 28: now **five open contradictions across four issues**, with **two** issues carrying two
each. Under subtraction, is a doubly-contradicted issue −2 or −4? **Neither the prompt nor the
validator says whether the gate is per-issue or per-contradiction**, and the ceiling reading hides
the question. A human choosing a reading must answer both questions at once — see [4]. **A new
wrinkle from this cycle:** `ctr-0005` is a contradiction whose content **strengthens** the issue it
is filed against (the base was under-citing the source). Under either reading, filing it
mechanically **penalises** the issue. Neither the prompt nor the validator distinguishes a
contradiction that undermines a claim from one that corrects a hedge, and after this cycle that
distinction is live.*

**[42] — NEW cycle 27. src-0007's RELEASED IoC MATCHER IS ONE-DIRECTIONAL, NOT TWO; `ctr-0004`
OPENED; REPAIRED BY APPEND.** The executing code is `any(pred.lower() in gt.lower() for gt in
gt_set)` — **a prediction must be a SUBSTRING OF a ground-truth entry**. The two-directional and
exact-match variants are **inside triple-quoted string literals and never run**. Confirmed by the
IoC sub-README's own prose. **Consequence — the bias is ASYMMETRIC:** lenient toward
short/fragmentary predictions, **strict against verbose predictions**, which is the characteristic
free-form-LLM failure mode. **"Substring-permissive, inflates true positives" is half right and
must not be repeated unqualified.** Where the wrong version lives and cannot be edited
(append-only): `ioc-extraction-reliability`'s cycle-21 `open_question`, and the `scores.json`
rationales for `ttp-attack-mapping-reliability`, `task-dependent-reliability-framing` and
`extraction-vs-reasoning-ordinal-axis`. **A T3 on `ioc-extraction-reliability` should rewrite the
open_question and decide whether the asymmetry changes cycle 18's arithmetic on `ctr-0001`'s METRIC
confound; a future T4 must restate the three rationales.** **Still unread in that repo: the
ATT&CK/TTP scorer (`stage3_ti_drafting/ttp/`) and any drafting-rubric/judge scorer.**

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005`
OPENED; REPAIRED BY APPEND IN BOTH PLACES.** key_claims[1] says "NO NUMBER ON THE PAGE IS
RECOVERABLE … supplies ZERO citable magnitudes. No cycle may quote, estimate, rank or compare
numbers from it." **The four PERFORMANCE artefacts really are images — confirmed a third time, and
that ban stands.** But the page states in plain text: a **41 min/report human-analyst baseline**
against ~**3.3 min** (>18× aggregate speed-up, >97% reduction for the fastest); **17 metrics each a
ratio 0–1**; and, most importantly, **"the LLM temperature parameter was set to 0"**. **The
temperature-0 fact strengthens `consistency-calibration-as-failure-mode` and was fenced off for
three cycles by an over-broad hedge.** The claim was also internally inconsistent with
key_claims[0] of its own entry. The page has **ten** figures, not four. **Standing lesson: a hedge
is a claim and must be scoped as precisely as an assertion. "No numbers" should have read "no
performance magnitudes".**

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC, AND ITS OTHER TWO
key_claims CARRY UNSTATED GLOSS; `ctr-0006` OPENED AGAINST `ttp-attack-mapping-reliability`;
REPAIRED BY APPEND IN BOTH PLACES.** **(a)** Section 4.2 says *"We adopt the **Micro-F1** score as
the evaluation metric for the CTI-ATE task"*; Table 1's header reads **"CTI-ATE (Macro-F1)"**. Both
PRESENT verbatim in two independent fetches. **0.6388's metric is ambiguous by the paper's own
text**, over a 397-technique multi-label space where Micro and Macro diverge. **(b)** The cross-task
difficulty comparison in key_claims[0] is **ours** — `task difficulty` ABSENT, `most challenging`
ABSENT, and a fetch asked for every between-task comparison answered ABSENT; the only adjacent
sentence is cross-**model** ("underscoring the complexity of the task"). And it subtracts
multi-class **accuracy** from multi-label **F1**. **(c)** key_claims[2] ("no evaluated model
exceeded ~72% on any single task") is **FALSE against Table 1** — CTI-TAA Plausible reads 86 / 80 /
74 for three models; `no model` is ABSENT from the paper. It is also mutually inconsistent with
key_claims[1] of the same entry. **(d)** The **ATT&CK correctness rule is never stated** (exact ID /
parent / sub-technique / partial credit) — the third source in this base with an unstated scoring
rule, after src-0003 and src-0007's TTP task. **(e)** **arXiv v2 has NO CTI-ATE task at all** —
always fetch v3 or the latest render. **A T3 on `ttp-attack-mapping-reliability` should rewrite its
first supported candidate to drop the "far below the ~71–72% accuracy" comparison or restate it
qualitatively, and record the metric ambiguity.**

**[45] — NEW cycle 28. `attribution-confident-wrong-gap` BUNDLES A WELL-EVIDENCED QUESTION WITH AN
UNEVIDENCED ONE, AND ONLY A T2 CAN FIX IT.** The issue asks about the gap between **plausible-
sounding** and **factually correct** attribution. After this cycle: the **error-rate** half is well
grounded (src-0002's derived 14–64% incorrect bucket on 50 alias-tolerant real reports, corroborated
in direction by src-0007's within-table rubric contrast). The **confidence** half has **no evidence
at all** — src-0002 partitions by correctness only, src-0007's rubric grades quality not confidence,
src-0004 attaches no measurement, and the base's only confidence measurements (src-0001, src-0013
ECE/Brier) are on other task sets and belong to `consistency-calibration-as-failure-mode`, which
this issue already `depends_on`. **This is the same shape as [37]** and the natural cut is
`attribution-error-rate` vs `attribution-confidence-calibration` — with the second probably merging
into whatever [37] produces rather than standing alone. **A T3 cannot split an issue and cycle 28
did not try;** it recorded the finding as a supported candidate so the graph carries it. **Next T2
is cycle 44 at the earliest.** *Note for a T4: an issue whose titular question no source measures is
not the same as an issue whose titular question is answered negatively, and the scoring rubric does
not distinguish them.*
