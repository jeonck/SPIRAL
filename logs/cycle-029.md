# Cycle 029 — T4 (Assess)

- **Cycle:** 29
- **Task type:** T4 — assess (score every issue in the graph)
- **Target issue:** none (a T4 scores all issues)
- **Prompt read at source:** `prompts/t4_assess.md` — read directly, not via the queue
  entry's description of it. The queue entry's summary matched the file.
- **Validator read at source:** `scripts/validate_state.py` lines 95–160.
- **Result:** one score moved (`ttp-attack-mapping-reliability` 3 → 2); seven held.
  One new contradiction opened (`ctr-0007`) by G2. One carry-forward item discharged
  after nineteen cycles (**[5]**).

---

## Task performed

Scored all **eight** issues in `state/issues/graph.json`, rewrote
`state/assessments/scores.json` in full (a T4's job is to rewrite it; the append-only rule
protects the knowledge base, not the assessments), and set `last_assessed_cycle: 29` and
`assessed_cycle: 29` on every entry.

### Scores

| Issue | c26 | c29 | Δ | Open contradictions | G3 ceiling | Ceiling bind? |
|---|---|---|---|---|---|---|
| `ttp-attack-mapping-reliability` | 3 | **2** | **−1** | ctr-0006 | 3 | no |
| `ioc-extraction-reliability` | 2 | 2 | — | ctr-0001, ctr-0004, **ctr-0007** | 3 | no |
| `consistency-calibration-as-failure-mode` | 2 | 2 | — | ctr-0003, ctr-0005 | 3 | no |
| `attribution-confident-wrong-gap` | 2 | 2 | — | **none** (ctr-0002 resolved c28) | 5 | n/a |
| `task-dependent-reliability-framing` | 3 | 3 | — | none | 5 | n/a |
| `extraction-vs-reasoning-ordinal-axis` | 3 | 3 | — | none | 5 | n/a |
| `institutional-incident-real-world-impact` | 3 | 3 | — | none | 5 | n/a |
| `automated-triage-under-refusal` | 2 | 2 | — | none | 5 | n/a |

**Full rationales are in `scores.json` and are not duplicated here.** What follows is the
reasoning a successor cannot reconstruct from the file.

### The one score that moved: `ttp-attack-mapping-reliability` 3 → 2

`ctr-0006` (opened cycle 28) attacks the text of this issue's **first** supported
candidate: `0.6388 … far below the ~71-72% accuracy the same models reach on
knowledge-recall tasks`. CTIBench defines CTI-MCQ/CTI-RCM as **multi-class classification
accuracy** and CTI-ATE as an **F1 over a 397-technique multi-label space**; those cannot be
differenced, `task difficulty` and `most challenging` are ABSENT from the paper, and a
fetch asked for every between-task comparison answered ABSENT. Its second sentence rests on
src-0005, which **reports no ATT&CK metric at all** (cycle 26). So candidate 1 carries
nothing, and **a T4 cannot rewrite it** — that is a T3's job and `ctr-0006` records the path.

I then read **candidate 2** in full rather than trusting cycle 26's account of it, because
cycle 26 said candidate 2 carried the 3 on its own. It is the better candidate and it does
**not** make the illegitimate subtraction — it explicitly disclaims commensurability
("different benchmark, different corpus, and a different metric decomposition"). Its two
distinctive contributions both weakened:

- **(b) the within-table control is compromised.** Candidate 2 argues that because the
  identical models reach 0.8240–0.8846 IoC precision in the same table, the ATT&CK deficit
  "cannot be attributed to corpus difficulty or prompt harness quality". `ctr-0004` (cycle
  27) read the released scorer: the IoC side is matched by **one-directional substring
  containment**, and the ATT&CK/TTP scorer has never been read. A control comparing a
  leniently-scored number against an unknown-scored number is not a control.
- **(a) independence delivers less than credited.** After `ctr-0006`, **neither leg has a
  stated ATT&CK correctness rule** (src-0002's is ABSENT in two fetches; src-0007's is
  unread), one leg's metric is **ambiguous between Micro-F1 and Macro-F1 by its own paper's
  text**, and the magnitudes differ by more than 2× (0.6388 F1 against 0.2787/0.2270
  precision/recall) in a way the candidate itself says cannot be reconciled.

What the two independent sources jointly establish is the **direction** of a claim computed
under two rules neither of which is known. I read level 3's "supported by ≥2 independent
sources" as requiring the sources to measure a *determinate* quantity, and per step 5 I took
the lower score. **This is a pointer to needed work, not a verdict that the issue is weak** —
the same framing cycle 26 used on `attribution-confident-wrong-gap`, which cycle 28 then
vindicated by acting on it and closing `ctr-0002`. A T3 executing `ctr-0006`'s path
plausibly restores the 3, and the decisive fetch (`stage3_ti_drafting/ttp/` via
`raw.githubusercontent.com`) is close to a one-fetch job.

### `ctr-0005` — I did NOT score it mechanically, and this is my answer to [41]

The queue entry was right that this needed saying. `ctr-0005`'s **content is that this base
was under-citing src-0018, not over-citing it**: the stored hedge "NO NUMBER ON THE PAGE IS
RECOVERABLE … supplies ZERO citable magnitudes" was too broad and fenced off, among other
things, `the LLM temperature parameter was set to 0 to minimize randomness and reduce
non-deterministic behavior`. That **strengthens** the consistency leg — both of its
independent sources now measure residual non-determinism *under a determinism setting*.

**I applied no demotion for it.** Treating that entry as evidence of weakness would penalise
an issue for a correction that improved it, and would create an incentive not to file such
corrections — a direct attack on the mechanism G2 exists to run. The issue stays at 2 for a
reason `ctr-0005` does not touch: the candidate answering **both** conjuncts of the title is
single-source (src-0001), and the two-source candidate answers only the **consistency**
conjunct and says so itself.

**For whoever decides [4]:** the G3 gate should distinguish a contradiction that
*undermines* a claim from one that *corrects an over-broad hedge*. Neither
`prompts/t4_assess.md` nor `scripts/validate_state.py` does.

### The G3 gate, and the new per-issue-vs-per-contradiction evidence

Verified at source this cycle. `scripts/validate_state.py` lines 144–156 error **only** when
an issue with an open contradiction scores **greater than** `scale_max −
g3_contradiction_demotion` = **3** (a *ceiling*). `prompts/t4_assess.md` step 3 and
`config.yml` line 35 say **subtract 2** (floor 0). These are different rules and the
conflict is unresolved — **twentieth cycle**, carry-forward **[4]**.

**I applied the ceiling**, as every T4 has. It **did not bind on any issue**: the three
contradicted issues all score 2, which is under 3.

**New this cycle, and it is the sharpest instance yet.** `ioc-extraction-reliability` now
carries **three** open contradictions (ctr-0001, ctr-0004, ctr-0007) — the most any issue
has held. Nobody has specified whether the gate is **per-issue** or **per-contradiction**.

- Under the **ceiling** reading the answer is **3 either way**, because a ceiling
  saturates. That is why the ceiling reading keeps working and why the question stays
  invisible.
- Under the **subtraction** reading the same issue reads **0** (per-issue) or **−6 floored
  to 0** (per-contradiction). Both stamp an issue holding four candidate_resolutions with
  the rubric label "no candidate resolutions", **silently**, because subtraction never trips
  the validator.

A human choosing a reading must answer both questions at once.

### How I handled "unmeasured" vs "answered negatively" (the [45] question)

`attribution-confident-wrong-gap`'s titular quantity — the gap between *plausible-sounding*
and *factually correct* attribution — is **unmeasured by every source it cites**, which
cycle 28 entered as a supported candidate. The rubric does not distinguish that from a
question answered in the negative.

**My resolution: the rubric scores the evidential state of an issue's
`candidate_resolutions`, so I applied it to the candidates, not to the title.** Candidate 1
is a supported resolution of the *error-rate* sub-question on **src-0002 alone** → exactly a
2. I considered 3 and rejected it: the only multi-source candidate is the **survey**
candidate, whose three ids are each cited for what they **lack** — that is one agent's audit
of the base, not independent measurement, and counting it would award a 3 for the finding
that nobody has measured the thing. I considered 1 and rejected it: a supported candidate
exists.

Note this issue's ceiling **lifted from 3 to 5** when `ctr-0002` closed. I did not use it.
The ceiling never bound at 2, so the lift changes nothing arithmetically — and cycle 26
recorded its demotion as a merit judgement explicitly *not* a gate artefact, with the
instruction that a successor must not restore a 3 by arguing the gate was misapplied.

`extraction-vs-reasoning-ordinal-axis` got the **opposite** treatment from the same
`ctr-0006` finding, and the asymmetry is principled: its supported claim is **evidential and
negative** (the ordering is unsupported), so every new non-commensurability finding *removes
evidence for the ordering* and cannot weaken it. I checked the reverse reading (route 1's own
commensurability is unverified) — the negative claim survives both ways.

---

## Retrospection

**Conclusion re-checked:** cycle 26's scored assessment of `ioc-extraction-reliability`,
specifically its citation of **src-0008** as evidence, and src-0008's three stored
`key_claims`. Chosen by **staleness**: G2 coverage is now complete for every source in the
base, src-0008 was last verified at **cycle 10** and was the stalest, carry-forward **[8]**
recommended it, and its own stored limitations section asked *in terms* for this pull
"before they are used to support a scored resolution" — which cycle 26 then did without the
pull. Carry-forward **[5]** predicted this needed PDF-level access that does not exist here.
**It did not.**

**Method:** three fetches — `arxiv.org/html/2605.06910v1`, `arxiv.org/html/2605.06910`
(different rendering) and `arxiv.org/abs/2605.06910` — each instructed to quote verbatim and
to write `ABSENT` or `CANNOT READ` rather than infer. I asked for the **whole** level-to-
transformation mapping, the **verbatim metric definitions**, whole tables, exact-string
searches on the stored numbers, and a full table/figure inventory with a readable-or-image
verdict on each. All seven parts of the methodological rule were applied.

### Verdict: FAILED on one stored claim, PASSED on two, and the source itself is defective in three places

**1. FAILED — `key_claims[0]` is over-general and omits the fifth of five evaluated models.**
The paper evaluates **five** models, not four. Verbatim:

> "ChatGPT, Claude, Gemini and Grok achieve 100% across all four phases without reporting
> uncertainties"

> "Cohere, however, shows progressive degradation: 1% missed detections in P1, 2% in P2, 5%
> in P3, and in P4, 65% misses plus 35% explicit 'Don't Know' responses"

P1–P4 contain **no cryptography** (Table 3: "1. Base64 encoding", "2. Identifier
obfuscation", "3. Dead code injection", "4. Structural obfuscation"). So the stored
generalisation that plain-text IoC recovery "is essentially free for **current LLMs**" is
contradicted by the paper's own legible body text, and the clean *encryption-is-the-boundary*
reading is not what the paper shows. Cohere's Table 6 aggregate (22.8% DR, 625 "Don't Know")
corroborates the same picture.

**`ctr-0007` opened** against `ioc-extraction-reliability`, whose third
candidate_resolution is the graph's only consumer of src-0008 and consumes exactly the
failing part: *"src-0008 finds an unscaffolded LLM recovers plaintext indicators ~100% of the
time but is defeated entirely by encryption it has no tooling for."* **I recorded that this
cuts both ways and asserted neither:** it defeats the tidy illustration, and it arguably
*strengthens* the scaffolding hypothesis, since regex pre-filtering and whitelisting would be
largely indifferent to dead-code injection and control-flow flattening while a bare LLM
evidently is not. That is a T3's call, not a T4's.

**2. DISCHARGED IN OUR FAVOUR — carry-forward [5], open since cycle 10, and it needed no PDF.**
It is a **self-contradiction in the source**. Table 3 assigns "5. XOR encryption", "6.
AES-256 encryption", "7. XOR + simple obfuscation", "8. AES + simple obfuscation", and the
body agrees twice — *"In P5 (XOR encryption with the key embedded in the code), all LLMs
transition from systematic success to near-complete failure"* and *"A similar pattern emerges
in P6 (AES-based encryption)"*. A third body sentence contradicts both: *"Both XOR (P5, P6)
and AES-256 (P7, P8) produce nearly identical failure rates."* **Two statements against one:
our stored mapping is the majority reading and stands.**

Probable cause, offered as inference and not fact: Table 3's own row descriptions
cross-reference level numbers shifted **+1** throughout — row 7 says "the XOR-encrypted IoC
(level 6)", row 8 "AES encryption (level 7)", row 9 "injected dead code (level 4)", row 11
"the advanced structural obfuscations of level 5" — all consistent with a numbering in which
the baseline is level 1. **No contradiction entry on this limb**, per **[32]**'s filing test:
the conflict is internal to the source and our state records the majority reading. Same test I
applied on `institutional-incident-real-world-impact` and cycle 12 applied to ENISA's silence.

**3. NEW DEFECT IN THE SOURCE — it defines its own metrics twice, incompatibly.**
Body: *"Detection rate, i.e., the proportion of samples in which the model correctly
identifies the presence of an IoC"* and *"Extraction accuracy, i.e., the proportion of samples
in which the recovered IP matches the ground truth exactly."* Table 6's caption: *"DR reflects
the detection rate, i.e., ratio of YES an answers. The Acc. reflects the percentage of correct
detections among those positive answers."* A ratio of YES answers **does not require
correctness**, and `Acc.`'s denominator moves from all samples to positive answers only.
**Whether this paper's "100% detection" means 100% correctly identified or 100% answered YES
is undetermined by the paper.** Second source in this base to contradict itself on a metric
definition, after src-0002's Micro-vs-Macro-F1.

**4. NEW READABLE CONTENT — Table 6, uncaptured for twenty cycles.** Anthropic 4,358 queries
/ DR 38.5% / Acc. 99.7% / 94 DK; ChatGPT 4,362 / 38.6% / 99.4% / 37; Gemini 4,358 / 38.5% /
87.7% / 0; Grok 4,357 / 35% / 100.0% / 0; Cohere 4,323 / 22.8% / 100.0% / 625. **Aggregates
over all thirteen phases — never quote as per-phase.** This is the src-0018 pattern again: a
source's readable quantitative content sitting unread behind an assumption.

**5. STILL IMAGE-LOCKED.** The per-phase **P0–P12** breakdown exists **only** inside Figure 2,
confirmed by two fetches instructed to write `CANNOT READ`. So the stored "roughly 0–1%" at
P5–P6 and "~95%+ misses" at P7–P12 are **figure-derived, not text-verified**. The body
supports only qualitative statements: "near-complete failure", "encrypted IoCs become
effectively opaque", "once the code is encrypted, detection of IoCs remains essentially zero
for all models". **Fourth** figure-locked-numbers instance after src-0003, src-0005, src-0018.

**PASSED:** `key_claims`/`src-0008.md` key claim 3's hallucination rates verified **exactly**
for the first time (Table 7: Anthropic 0.11, ChatGPT 0.23, Gemini 4.8, Grok 0, Cohere 0). The
abstract re-verified **word for word**. Authors, dataset size (336) and category confirmed.
**Version staleness checked** per **[39]**: `/abs` lists **v1 only**, 7 May 2026 — no
revision since collection.

**Repaired by append in BOTH places** (`index.json` key_claims 4–7 and a new dated section in
`src-0008.md`), per the pattern that has held since cycle 22. Nothing was deleted or rewritten.

**This is the eighth source-check in a row to surface a defect (nine checks, eight defects).**
And it is a *new* defect class again: not too-bold, not too-cautious, but **too general** —
a claim quantified over "current LLMs" when the paper's own fifth model refutes it.

---

## Changes made

| File | Change |
|---|---|
| `state/assessments/scores.json` | **Rewritten in full.** All 8 issues scored, `assessed_cycle: 29`, `last_assessed_cycle: 29`. One score moved (ttp 3 → 2). |
| `state/issues/graph.json` | **`ctr-0007` appended** to `contradictions` (7 entries now). No issue, candidate or open_question touched — a T4 has no standing there. |
| `state/knowledge/index.json` | **4 key_claims appended** to src-0008 (3 → 7). Nothing removed or altered. |
| `state/knowledge/src-0008.md` | **New dated section appended** ("Cycle-29 re-verification"). Nothing above it altered. |
| `logs/cycle-029.md` | This file. |
| `state/queue/next_task.json` | T5 (select) for cycle 30. |
| `state/queue/last_completed_task.txt` | `T4 assess` |

Every JSON edit was validated with `jq -e . <file> > /dev/null` **and** read back with
`jq -r` on the specific fields added — per **[24]**, because a file can parse perfectly while
silently missing fields (cycle 27). Confirmed: 7 contradictions with all five schema fields
each; src-0008 at 7 key_claims; 8 score entries, all `assessed_cycle: 29`, all with non-empty
`evidence` whose ids exist in `index.json` (validator lines 138–146); no contradicted issue
scoring above 3 (lines 144–156).

Insertion pattern used for `ctr-0007`: **[9](a)** — anchored on the *first* line of the
following element's body (`"id": "ctr-0001",`) and let the original trailing fields close the
last object. No brace errors, first attempt. **[9](b)** honoured: no backslash-escaped
structural quotes. All internal quotations written with single quotes to avoid escaping
entirely.

---

## Next task rationale

**Cycle 30 is a T5 (select).** State machine `T1→T2, T2→T3, T3→T4, T4→T5, T5→T3`; I am the
T4, so a T5 follows. **A T5 takes no `target_issue` — it chooses one.**

**Refresh rule does not fire:** 30 mod 7 = 2. Of the multiples of 7 ahead, 35 is not a T5
cycle and **42 is**, so the next T1 is **cycle 43** and the next T2 is **cycle 44** —
re-derived from `config.yml` (`collect_refresh_every: 7`) and the T5 landing pattern 30, 33,
36, 39, 42, not taken from the previous handoff.

**Precomputed ranking data for the T5, offered as input and not as a decision** — it must
apply `prompts/t5_select.md` itself:

| Issue | Score | Has dependents? (3a) | Attempts | (3b) if window = 25–29 | `created_cycle` (3c) |
|---|---|---|---|---|---|
| `ttp-attack-mapping-reliability` | 2 | yes | [16] | +0 → **2** | 2 |
| `ioc-extraction-reliability` | 2 | yes | [9, 21] | +0 → **2** | 2 |
| `automated-triage-under-refusal` | 2 | **no** | [] | +0 → 2 | 16 |
| `consistency-calibration-as-failure-mode` | 2 | yes | [3,15,16,**25**] | **+1 → 3** | 2 |
| `attribution-confident-wrong-gap` | 2 | yes | [16,**28**] | **+1 → 3** | 2 |
| `task-dependent-reliability-framing` | 3 | yes | [6,16] | +0 → 3 | 2 |
| `extraction-vs-reasoning-ordinal-axis` | 3 | no | [17,18] | +0 → 3 | 16 |
| `institutional-incident-real-world-impact` | 3 | no | [12] | +0 → 3 | 2 |

**Three warnings the T5 must handle rather than inherit:**

1. **The bottom tier is five issues wide** because I demoted `ttp`. That is honest scoring,
   not a convenience — but it makes the tie-breaks load-bearing, and **[11]**'s
   under-specification is now the binding constraint on selection twice in four cycles.
2. **The window in 3b has three defensible readings** (**[11](c)**). Under 25–29 the tier
   reduces to `ttp` and `ioc`; under 26–30 `consistency` (attempt at 25) rejoins at 2. The
   T5 must **state its reading**.
3. **A terminal tie is likely and there is still no deterministic break after 3c.** `ttp` and
   `ioc` are identical on score, dependents, penalty **and** `created_cycle` (both 2). Cycle
   27 hit exactly this and broke it on an explicitly extra-prompt criterion — which
   **paid off** (cycle 28 closed a contradiction, opened two and answered a ten-cycle
   question). If cycle 30 must invent one again, it should say so plainly for the human
   holding **[11]**.

**A substantive input, offered as evidence rather than as a thumb on the scale:** one fetch —
`stage3_ti_drafting/ttp/` in the src-0017 repo via `raw.githubusercontent.com` — is the named
next step for `ctr-0006` (**ttp**), for `ctr-0001`'s remaining path (**ioc**), and for
**[34]**'s route back to a 4 on `task-dependent-reliability-framing`. It is the highest
leverage-per-fetch action available anywhere in this graph. Against that, `ioc` now carries
**three** open contradictions and `ctr-0007` is fresh and unworked, and **[15]**'s
curl/HackerOne source is still the highest-value *uncollected* material in the project and
only reachable via `automated-triage-under-refusal`, which has now lost **four** consecutive
selections and would lose a fifth on 3a.

---

## Budget

- **WebFetch:** 3 (all src-0008: `/html/…v1`, `/html/…`, `/abs`). Zero fetches spent on
  known-blocked routes — no spiegel.de, no ENISA PDFs, no forward-citation sweeps, no
  re-attempt on src-0005's or src-0018's images.
- **WebSearch:** 0.
- **Bash:** 9 (all `jq` reads/validations, one `sed -n` on the validator, one heredoc append).
- **File reads:** 7. **Edits:** 2. **Writes:** 3.
- **Assistant turns:** ~13 of 50.
- **Efficiency note:** `jq -r` projections over `graph.json` (~130 KB) instead of `Read` kept
  the whole assessment inside budget while still reading three candidate texts *in full*
  rather than trusting rationales — which is what caught that cycle 26's account of
  candidate 2 was accurate but its *conclusion* no longer followed.

---

## Carry-forward items

All items from `logs/cycle-028.md` reproduced **including those I could not act on**, with
cycle-29 updates. Discharged items stay marked rather than deleted. **One new item: [46].**
**[5] is DISCHARGED after nineteen cycles.**

**[1] — DISCHARGED cycle 16.** Split `task-dependent-reliability-framing`. Narrow claim
stayed; ordinal axis moved to `extraction-vs-reasoning-ordinal-axis`. Still vindicated. Cited
as the precedent behind [37] and [45].

**[2] — DISCHARGED cycle 16, RESULT PARTLY WITHDRAWN cycle 26.** src-0005 reports **no ATT&CK
metric at all**. Blocker remains `open_question[1]`, the missing human-analyst baseline, now
in its **eighteenth** cycle. src-0018's 41 min/report vs ~3.3 min is **throughput, not
accuracy**, and does NOT discharge it. **[44] puts the 0.6388 itself in question.** *Cycle 29:
this item is now the single largest reason `ttp-attack-mapping-reliability` cannot reach 4,
and this cycle it contributed to the fall to 2 — with no human reference point and no stated
correctness rule on either leg, "hard, unsolved" is an interpretation.*

**[3] — DISCHARGED cycle 16.** `automated-triage-under-refusal`. Lost three consecutive
selections; still `attempts: []`. See [30]. *Cycle 29: it is now four, and 3a would make it
five.*

**[4] — DECIDED cycle 16, EXECUTION STILL DEFERRED, UNTESTED AFTER 20 CYCLES.** The G3 gate is
specified three ways: `prompts/t4_assess.md` step 3 (**subtraction**), `config.yml` line 35
comment (**subtraction**), `scripts/validate_state.py` lines 144–156 (**ceiling**, = 3). The
enforced reading is in the minority. Cycle 16 ruled for the **CEILING**; replacement text in
`logs/cycle-016.md` "Item 3". **NOT APPLIED** — `prompts/`, `config.yml`, `scripts/` are
outside this agent's output surface. **Until a human applies it, T4s must apply the ceiling.**
*Cycle 29 verified all three readings at source again and applied the ceiling; it bound on
nothing. **New and sharpest evidence yet:** `ioc-extraction-reliability` now carries **three**
open contradictions. Under the ceiling the answer is 3 **whether the gate is per-issue or
per-contradiction**, because a ceiling saturates — which is exactly why the question stays
invisible. Under subtraction the same issue reads **0** (per-issue) or **−6 floored to 0**
(per-contradiction), and nobody has said which. **A human must answer both questions at
once.** Awaiting a human, verbatim, with [11], [30] and [41].*

**[5] — DISCHARGED CYCLE 29, AND IT NEEDED NO PDF.** The src-0008 phase-label discrepancy is
a **self-contradiction in the source**, and our stored mapping is the **majority reading**.
Table 3 puts XOR at P5 and AES-256 at P6; two body sentences agree ("In P5 (XOR encryption
with the key embedded in the code)…", "A similar pattern emerges in P6 (AES-based
encryption)"); one stray body sentence disagrees ("Both XOR (P5, P6) and AES-256 (P7, P8)
produce nearly identical failure rates"). Probable cause: Table 3's row descriptions
cross-reference level numbers shifted **+1** throughout, consistent with a numbering in which
baseline is level 1. **No contradiction entry** on this limb per [32]'s test. *Standing
lesson: an item recorded as "blocked by an infrastructure limit" may only be blocked by the
route the recording cycle happened to try. Nineteen cycles.*

**[6] — UPDATED cycle 25.** Unfinished search directions: citation-graph sweep of arXiv
2506.11325; **third-party evaluations of the IoC Searcher / AlienVault OTX / VirusTotal
baselines**; the paywalled eLLM-CTI paper (ScienceDirect S0167739X26001482, HTTP 403 — do not
retry). **Forward-citation sweeps have FAILED on two arXiv ids.** **CTIArena is resolved and
dead for consistency/calibration purposes**; never re-propose it for
`consistency-calibration-as-failure-mode`. **SEvenLLM** uncollected and downgraded.
**AthenaBench** still has no URL. **No arXiv companion exists for src-0018.** Unavailable:
OpenReview, spiegel.de ([13]). **CTIBench's own released dataset/evaluation artefact has never
been sought** — cheapest route to `attribution-confident-wrong-gap`'s `open_question[1]` and to
[44]'s unstated ATT&CK correctness rule. *Cycle 29 adds nothing new here and spent no budget
on any blocked route.*

**[7] — WORKED AT CYCLE 21; PATH REDRAWN AT 22; ONE STEP ADVANCED AT 27.** `ctr-0001`'s
resolution path. **Done:** released-code route exhausted; **METRIC confound ELIMINATED**.
**Still open:** no head-to-head; the **CORPUS confound is completely untouched and is the
largest gap**. Remaining steps, cheapest first: src-0007's **TTP and rubric scorers** in the
src-0017 artefact (`stage3_ti_drafting/ttp/`, [34]);
`huggingface.co/datasets/xse/CyberThreat-Eval`; then corpus difficulty. *Cycle 29: unchanged,
and the TTP-scorer read is now the **single highest-leverage fetch in the whole graph** — it
is the named next step for `ctr-0006`, for this path, and for [34].*

**[8] — UPDATED cycle 29. G2 COVERAGE COMPLETE; NOW TRACKED BY STALENESS.** src-0004 (c4,
c12), src-0003 (c5; c22 — substance passed, provenance partial fail, [32]), src-0002 (c6; c23
— `ctr-0002`; c28 step (iii) — `ctr-0006`), src-0001 (c7; c25 — `ctr-0003`, peer-reviewed
after all, [39]), src-0006 (c8; c17 partial fail [21]; re-pulled c18), src-0005 (c9, c11;
c26), **src-0008 (c10; c29 — key_claims[0] over-general, `ctr-0007`; [5] discharged; Table 6
recovered; metric self-contradiction found)**, src-0012 (c13), src-0011 (c14), src-0007 (c15;
c21 Table 4 whole), src-0009/src-0010 (c16), src-0013 (c18), src-0014 (c19), src-0015 (c20),
src-0016 (c21 — provenance partial fail, [31]), src-0017 (c27 — `ctr-0004`), src-0018 (c28 —
`ctr-0005`). *Next G2 should prefer by staleness: **src-0012** (c13), then **src-0011** (c14),
then **src-0007** (c15). **src-0007 is the most valuable of the three** — it is in six of the
eight issues' evidence lists and its Table 4 rubric rows are still a **single unreplicated
pull from cycle 15** ([19] residue), which is the stated reason
`attribution-confident-wrong-gap`'s third candidate remains `proposed`. Not recommended next:
src-0008 and src-0002 (c29/c28), src-0018 (c28), src-0017 (c27), src-0005 (c26), src-0001
(c25), src-0003 (c22), src-0016 (c21), src-0015 (c20).*

**[9] — CORRECTED cycle 18, re-confirmed cycles 19–23, 25–29.** `python3` present but the
**permission layer** blocks it; compound/piped commands rejected if any segment is
unapproved. **No PDF text extraction exists** — prefer `/html` always; `/abs` carries the
abstract, which is why [38] works. `gh` not approved. `awk` refused. **`sed -n` and `cat >>`
heredoc ARE approved**; a heredoc append must be its **own** call. `jq -e . <file> >
/dev/null` approved, as is a compound `jq … && jq …` chain. Prefer **single-line `Edit`
anchors**. `scores.json` and `graph.json` are NOT protected by validator lines 105–107.
**`raw.githubusercontent.com` returns whole files.** *Cycle 29: all held. Both cycle-28
patterns re-confirmed on first attempt — **(a)** the safe insertion anchor is the **first**
line of the following element's body; **(b)** never backslash-escape structural quotes. A
third, cheaper trick: **write every internal quotation with single quotes** and the escaping
problem disappears entirely. A full-file `Write` of `scores.json` again worked cleanly (c26,
c29).*

**[10] — DISCHARGED CYCLE 26, AND THE ANSWER IS THAT IT WAS NEVER ACHIEVABLE.** src-0005's
per-model numbers do not exist in text at all — every per-model score is inside Figures 8, 9,
12–16. **Do not re-attempt without a new route.** See [40].

**[11] — APPLIED cycle 20, ENDORSED 23, BOUND FIRST AT 27.** Tie-break 3a in
`prompts/t5_select.md` is under-specified and there is **no deterministic tie-break after
3c**. For a human, in three parts: **(a)** cycle 27's bottom tier reduced to a genuine
two-way tie identical on score, penalty, dependency and `created_cycle`, broken on an
**explicitly extra-prompt** criterion — **a terminal tie-break must be written into the
prompt**; **(b)** the prompt lists **3a before 3b**, but 3b is an addition *to the score*, so
a literal a-then-b ordering lets them return **opposite verdicts on the same pair**;
**(c)** "within the last 5 cycles" has three defensible readings. *Cycle 29: **this is now
the binding constraint on selection, and cycle 30 will almost certainly hit it again.** My
demotion of `ttp` makes the bottom tier **five issues wide**, and after 3a and 3b it reduces
to `ttp` vs `ioc` — **identical on score (2), dependents (both upstream), penalty (0) and
`created_cycle` (both 2)**. That is [11](a) verbatim, twice in four cycles. And [11](c) now
decides whether `consistency-calibration-as-failure-mode` is in the tier at all: its attempt
at cycle 25 falls inside a 25–29 window and outside a 26–30 one.*

**[12]** THE STATE MACHINE'S PATH TO STRUCTURAL WORK IS NARROW. T2 is the only task type with
standing to split an issue, add an issue, or reconcile the prompt/validator disagreement. The
claim that the loop "never returns to T2" is false; cycle 16 disproved it. *Cycles 25–29: bit
again, twice over — [37] and [45] are both T2 jobs. Next T2 is **cycle 44 at the earliest**.
Cycle 29 adds the scoring consequence: **both bundled issues are held at 2 by their weaker
conjunct**, and I scored them consistently for it rather than treating either as unlucky. Two
of the five issues in the bottom tier are there for a **structural** reason that no T3 can
fix.*

**[13]** `spiegel.de` IS UNREACHABLE FROM THIS AGENT — WebSearch returns HTTP 400. Der Spiegel
is the upstream primary for the entire ENISA incident: a permanent structural gap. The
archived-PDF route is also closed ([14]). Prof. Christian Dietrich's / Institut für
Internet-Sicherheit's own writeup is the only remaining route known. OpenReview joins this
category ([6]). *Cycle 28 reclassified src-0004's evidential home to
`institutional-incident-real-world-impact`, so the un-strengthenable limb is no longer
load-bearing for `attribution-confident-wrong-gap`. Cycle 29 spent no budget here and confirms
the reclassification did **not** raise `institutional-incident-real-world-impact` — src-0004
was already in its evidence and three of its candidates, so nothing was added.*

**[14] — ATTEMPTED AND BLOCKED cycle 16; infrastructure limit, not a to-do.** The two ENISA
v1.2 PDFs cannot be opened. "ENISA never disclosed the AI use" is established at
landing-page level and UNVERIFIABLE at document level here. **Do not re-spend budget.**
*Cycle 29 caution from [5]: "blocked by an infrastructure limit" deserves one re-test by a
**different route** before being treated as permanent. This one has had several; PDFs really
are unreadable. But [5] was wrong for nineteen cycles about needing a PDF at all.*

**[15] — DISCHARGED cycle 16 by merge; STILL THE TOP COLLECTION TARGET, AND DEFERRED A FIFTH
TIME.** The curl/HackerOne case (bug bounty ended 31 January 2026 after a flood of
AI-generated "slop" reports; ~20% of submissions AI slop by mid-2025; confirmed-vulnerability
rate falling from ~15% to under 5%) is an `open_question` on `automated-triage-under-refusal`.
**It is a question, not evidence — no curl source exists in `index.json` and G1 forbids
inventing one.** Reported at
`bleepingcomputer.com/news/security/curl-ending-bug-bounty-program-after-flood-of-ai-slop-reports/`.
Cycles 19, 22, 26, 27, 28 and 29 all judge it the highest-value uncollected source. Earliest
route: the cycle-30 T5's target, i.e. cycle 31 — **but 3a would eliminate that issue again**,
so realistically cycle 43's T1.

**[16]** GPTZERO RUNS AN AUTOMATED SWEEP OVER THE RIGHT POPULATION and is the best lead on the
base-rate question. Verbatim from `https://gptzero.me/investigations/ey`: an "automated
pipeline to search for vibe citations by finding and scanning public reports from major
consulting firms". A T1 should chase `gptzero.me/news/tag/investigations`. Caveats:
commercial AI-detection vendor; no *rate* published; the scorecard widget renders as "0 of N"
to automated fetch. **Still the only route any cycle has found to a base rate**, the binding
constraint on `institutional-incident-real-world-impact` reaching 4.

**[17] — PARTIALLY WRONG AS INHERITED; CORRECTED cycle 20, see [28].** The refresh rule is the
escape to T2: the chain is **T5 → T1 → T2**. Confirmed end-to-end by cycles 14→15→16.
Structural finding for the paper: the only task type that can restructure the issue graph
fires when a T5 coincides with a multiple of 7 — under a clean three-cycle loop, **once every
21 cycles**.

**[18]** src-0011 CONTRADICTS ITSELF IN PROSE VS TABLE, harmlessly (NeurIPS "391 papers" in
text vs 391 invalid citations across 308 papers in Table 3). No claim in our base repeats the
error; **no G3 entry was opened**. Quote src-0011's *counts* from Table 3. *Cycle 29: this is
now a **class**, not an oddity. Sources in this base that contradict themselves: src-0011
(prose vs table), src-0002 (Micro-F1 text vs Macro-F1 header, [44]), **src-0008 twice — phase
labels ([5]) and its own metric definitions ([46])**. Ours is load-bearing in one case
(src-0002) and not in the others, which is the test [32] gives for whether to file.*

**[19] — FULLY DISCHARGED CYCLE 21; CONSUMED BY CYCLES 22, 26 AND 28.** src-0007's Table 4
pulled **whole and verbatim**. Triage rows: precision (Accepted) **0.2717–0.3982**, recall
(Accepted) **0.9091–1.0000**. **RESIDUE, UNRESOLVED AND REPRODUCED:** GPT-4o (FT) tracks
o3-mini to within 0.001 on **all six** `Content: Threat Actor` rubric rows, identically in two
independent pulls (c15, c21) — as-printed, not a fetch artefact. **Cause unknown; do not
guess.** *Cycle 29: the rubric rows are **still single-pull since c15** and that is the stated
reason `attribution-confident-wrong-gap`'s third candidate stays `proposed` — which in turn is
part of why that issue is at 2. **A re-pull of Table 4 is the cheapest thing that could raise
that issue's floor**, and it doubles as the [8] staleness G2 for src-0007.*

**[20] — DISCHARGED cycle 21; ALL FOUR CYCLE-15 SOURCES VERIFIED.** src-0013 (c18), src-0014
(c19), src-0015 (c20), src-0016 (c21). src-0013's FT discrepancy **narrowed but not closed** —
quote 33.9% and 16.9%→83.2% only with their scopes named. Gemini's 0.161 → 0.721 was **not**
re-checked. **Residue: src-0014's F1 figures (0.398/0.103/0.465/0.427) are still
body-sentence-only.**

**[21] — CONFIRMED BY A SECOND CYCLE AND PARTIALLY REPAIRED cycle 18; PATTERN NOW STANDARD.**
`src-0006.md` and `index.json` key claim 2 say Infrastructure Reuse peaks at "F1 0.754 … vs
0.688 for a general model". **ZYS (0.688) is cyber-SPECIALIZED**; the true general-purpose
peak is **G5 at 0.677**. Direction survives, label does not. Also imprecise: "F1 range roughly
0.20–0.90" against a true span of **0.286–0.882**. Cycle 18 appended a corrective key_claim to
`index.json`; **`src-0006.md` itself is still untouched and still contains the wrong sentence
— it is the only known source file still carrying an uncorrected sentence, and it is a cheap
fix.** *The repair-both-places pattern now holds for cycles 22, 23, 25, 26, 27, 28 and 29.*

**[22] — REPRODUCED A THIRD TIME cycle 18.** src-0006's Table 2: eleven of twenty-eight rows
are **strictly monotone decreasing across all eight general-purpose columns in exactly the
printed column order**; four are in the nine-row F1 subset
`extraction-vs-reasoning-ordinal-axis` depends on. One row matching a fixed eight-column
order has probability 1/8! ≈ 1 in 40,320. **Not a fetch artefact.** **Any finding resting on
that table must carry a robustness check excluding those rows** (cycle 18's: drop all four →
0.641 vs 0.592, gap 0.049, same direction).

**[23] — STANDS, for the next T2, AND ITS STATUS IS SETTLED.** Mean between-**model** range
within a task (0.272) and mean between-**task** range within a model (0.263) are equal to
within 0.009. This does **NOT** negate `task-dependent-reliability-framing`'s supported claim
— cycles 19, 22, 26 and 29 all tested it — it qualifies the implication that sub-task is the
*privileged* explanatory variable. A T2 should annotate rather than re-scope. No
contradiction: both facts hold.

**[24] — NEW cycle 18, USED THROUGHOUT cycles 19–23 AND 25–29. `jq` IS INSTALLED AND
APPROVED.** **Every cycle from 9 to 17 recorded that this agent cannot validate JSON and must
check "by construction". That advice is wrong and it is expensive** — cycle 17 lost its entire
`state/` output. **Every JSON edit should be followed by `jq -e`** *and* by a `jq -r`
read-back of the fields added. The permission layer is **not uniform** — probe once. The
`Grep` **tool** works on the big JSON files where Bash `grep -n` does not. Cheapest
append-only pattern: **`Grep` → `Read` with `offset`/`limit` → `Edit` → `jq -e` → `jq -r`
read-back.** *Cycle 29 used `jq -r` projections over `graph.json` as the primary **reading**
tool too, not just validation — three candidate texts in full for well under the cost of
`Read`ing the file.*

**[25] — DISCHARGED CYCLE 21.** `src-0007.md` contains the `Content: Threat Actor` rubric
block in full. **The two caveats must keep travelling:** the rubric's **absolute level is
uninterpretable** (1.140/5 → 0.228 or 0.035 depending on x/5 vs (x−1)/4, a normalisation the
paper never states), so **only within-table contrasts may be cited**; and the GPT-4o (FT)
column is suspect per [19]. Both are now written into the candidate's own text.

**[26] — NEW cycle 18, a question about the harness, not the research.** **Why cycle 17 failed
validation is unknown and unrecoverable.** Suggested harness fix for a human: tee
`python scripts/validate_state.py` output into `logs/cycle-NNN-validation.txt` before
reverting, and `git stash` the rejected `state/` diff. The mechanism is fine for **crashes**
(cycle 24 worked); it is blind to **validator rejections**.

**[27] — NEW cycle 20, STILL UNENTERED IN THE GRAPH AFTER NINE CYCLES.** src-0015's Table 1
has a **`Reward`** column no cycle has recorded in the graph: GPT-5.2 3.07, Sonnet 4.5
**2.37**, Gemini 3 2.61, DeepSeek 3.2 **3.45**. **The model the paper calls best-calibrated
earns the lowest reward.** Bears on `automated-triage-under-refusal`'s `open_questions[0]`.
Caveats: reward composition unstated; n=40 per model, no CIs; association not strictly
monotone. An observation about an **already-collected** source, so **no new citation is
needed**. Cycles 22, 26 and 29 recorded it in a `rationale`, but **a rationale is not the
graph**. Still unentered — that issue keeps losing selection, so still nobody with standing.

**[28] — NEW cycle 20, RE-DERIVED cycles 21–23, 25–29.** The state machine is T1→T2, T2→T3,
T3→T4, T4→T5, T5→T3. Cycle 24's T3 died before writing anything and cycle 25 re-ran it,
shifting the phase by one. Positions: **cycle 29 = T4 (this one, as predicted), cycle 30 =
T5**, T5 thereafter on 33, 36, 39, **42**. The refresh fires only when a T5 **runs on** a
multiple-of-7 cycle. *Cycle 29 re-derived from `config.yml`: 30 mod 7 = 2, nothing fires. Of
35 and 42, only **42** is a T5 cycle, so **the next T1 is cycle 43** and the next T2 is
**cycle 44**.* *The single most consequential structural fact in this project: **one
infrastructure failure, costing one cycle, pushed the next collection cycle back by
eight***. **Re-derive rather than trusting this if another cycle fails.**

**[29] — NEW cycle 20, ACTED ON AND VINDICATED cycles 21 AND 25.** A T3 **MAY** add sources
(`prompts/t3_investigate.md` step 2). Cycle 21 added src-0017; cycle 25 added src-0018, which
broke a blocker standing since cycle 3. **Standing lesson: read the task's own prompt file,
not only the queue entry's description of it.** *Cycle 29 did exactly that for
`prompts/t4_assess.md` and `prompts/t5_select.md` and for validator lines 95–160, and the
queue entry's summary held up on every point I checked — the first handoff in five cycles with
no rule misstated.*

**[30] — NEW cycle 20; PREDICTION CORRECT FOUR TIMES.** `automated-triage-under-refusal`, the
only issue never worked on (`attempts: []`, created cycle 16), has **lost four consecutive
selections**. **"Never attempted" is not a tie-break in `prompts/t5_select.md`**, and cycle
19's rationale wrongly asserted it was. **This is a prompt change for a human.** Note the
interaction with [11]: **both** readings of 3a bury it — it has no dependents, so 3a
eliminates it outright, and the fallback mechanism is `created_cycle`, so **the newest issues
in a graph are structurally disadvantaged forever, with no expiry**. *Cycle 29: it sits at 2
in a five-wide bottom tier and **3a will eliminate it a fifth time**. It also holds the
project's top uncollected source ([15]) and an unentered observation bearing on its own
central question ([27]). **The cost of this prompt defect is now concretely measurable** and
should go in the paper.*

**[31] — NEW cycle 21, EXTENDED cycles 22, 23, 25–29. THE VERBATIM CHECK HAS NOW RUN ON NINE
SOURCE-CHECKS; EIGHT PRODUCED A DEFECT.** (a) **src-0016** (c21): a stored "verbatim"
quotation **does not exist on the page**. (b) **src-0003** (c22): quotations passed, stored
*numbers* 76/72/86 are **figure-image-only**. (c) **src-0002** (c23): all 25 numbers exact,
**interpretation contradicted by the paper's own metric definition**; `ctr-0002`. (d)
**src-0001** (c25): numbers exact, protocol *stronger* than recorded, **calibration gloss
contradicted by the full table**; `ctr-0003`. (e) **src-0005** (c26): all claims and
quotations **PASS** — but stored with no task format, metric definition, sample counts,
limitations or numbers. (f) **src-0017** (c27): every stored string **PASSES**, the
**DOWNSTREAM PARAPHRASE** dropped the hedges; `ctr-0004`. (g) **src-0018** (c28): every stored
quotation **PASSES** — the stored **SCOPE** is wrong, and wrong by being **TOO RESTRICTIVE**;
`ctr-0005`. (h) **src-0002 again** (c28, step (iii)): two more glosses, one **FALSE against
the printed table**, plus a self-contradiction in the source; `ctr-0006`. **(i) NEW —
src-0008 (c29): every stored quotation and number PASSES, and one of the three claims is
OVER-GENERAL — quantified over "current LLMs" when the paper's own fifth model refutes it;
`ctr-0007`.** **The defect class is now eight-way: spliced quotations, unverifiable numbers,
unsupported interpretive glosses, partial table capture, correct-but-hollow entries,
correct-source-corrupted-downstream, over-restriction — and now OVER-GENERALISATION.**
*Note the shape of the last three: (g) claimed too little, (h) claimed something false, (i)
claimed something true of four cases and generalised it to a class. **All three passed every
exact-string check.** Standing lesson, upgraded again: **string-matching a claim's quotations
and numbers does not test its QUANTIFIER or its SCOPE. Ask what population the claim ranges
over and check every member the source reports.***

**[32] — NEW cycle 22, AND THE FILING TEST IS NOW USED ROUTINELY.** src-0003's three baseline
F1 values are figure-image-only; repaired by append. **Cite 76/72/86 as figure-derived and not
text-verified.** Also unverifiable: **`~0.88 F1 with Llama`**. **The test: file a contradiction
when the source's own legible text conflicts with the stored claim; do not file when the
stored claim is merely unverifiable.** *Cycle 28 used it to file `ctr-0005` and `ctr-0006`.
Cycle 29 used it **both ways in one cycle**: filed `ctr-0007` (the Cohere sentences are
legible text conflicting with the stored claim) and **declined** to file on src-0008's
phase-label inconsistency (the conflict is internal to the source and our state records the
majority reading). The rule is working and should be kept.*

**[33] — NEW cycle 22, THE STRONGEST TEXTUAL ANCHOR `ctr-0001`'s SYSTEM CONFOUND HAS EVER
HAD.** src-0003's 97.6% is measured on a **closed-set classification task over a
regex-extracted candidate set**, not free-form extraction — *"We assume a total of 1,789
candidate indicators, extracted using IoC Searcher"*; Figure 9's caption "… on IoC
Classification." **A difference in task format, stated by the paper.** **Companion finding:
src-0003 NEVER STATES ITS MATCHING RULE.** *Sources in this base with an unstated scoring
rule: src-0003 (IoC matching), src-0007 (ATT&CK/TTP task), src-0002 (ATT&CK correctness).
**Three**, and it is the strongest argument for [34].*

**[34] — NEW cycle 22, THE REASON `task-dependent-reliability-framing` FELL 4 → 3, AND IT IS
ACTIONABLE.** **A within-study design holds team, corpus, models and harness constant but does
NOT hold the scoring rule constant.** A cross-sub-task score spread is a task-difficulty fact
only if the sub-tasks are scored comparably. **The scoring rules for src-0007's ATT&CK and
rubric tasks have STILL never been pulled**, and neither have src-0006's per-task metric
definitions. **What restores the 4:** read `stage3_ti_drafting/ttp/` in the src-0017 repo and
src-0006's metric definitions, then state and answer the objection.
`raw.githubusercontent.com` makes this a **one-fetch job**. *Cycle 29: **this is now the
highest-leverage single fetch in the entire graph** — it is the named next step for `ctr-0006`
(ttp), for `ctr-0001`'s remaining path (ioc) **and** for this item. And the objection is now
anchored on **both** sides of the CTIBench comparison, not one ([44]). Four of the eight
sources in `task-dependent-reliability-framing`'s evidence list are known
non-commensurable.*

**[35] — NEW cycle 23; DISCHARGED CYCLE 28.** src-0002's CTI-TAA `Correct` and `Plausible`
columns are **nested, not disjoint**; the 86-vs-52 framing is retired; derived replacements
(incorrect = 100 − Plausible = **14 / 38 / 26 / 20 / 64%**) are in the graph **with their
derivation stated**; `ctr-0002` CLOSED.

**[36] — NEW cycle 23; DISCHARGED CYCLE 28.** `ctr-0002`'s three-step resolution path, all
three steps executed. **The consequences did not stay inside the issue: see `ctr-0006` and
[44].** *Cycle 29 confirms the discharge by inspection of the graph and priced the result:
the rewrite made the primary candidate honest, but the same cycle **removed src-0004 from its
evidence**, so the issue's net evidential position did not improve enough to move the score.*

**[37] — NEW cycle 25, ENDORSED 26, REINFORCED 28 AND 29. THE ISSUE ASKS TWO QUESTIONS AND
THE EVIDENCE IS ASYMMETRIC; THAT IS A T2 SPLIT.** `consistency-calibration-as-failure-mode`
asks about **consistency** *and* **calibration**. Consistency-on-CTI rests on **two
independent sources** (src-0001 + src-0018, **both at temperature 0**),
calibration-on-CTI on **one** (src-0001, gpt4o only), and `ctr-0003` sits on the calibration
half alone. Natural cut: `consistency-under-repeated-query` vs `confidence-calibration-on-CTI`.
**Only a T2 can split an issue** ([12]); **next T2 is cycle 44 at the earliest.** *Cycle 29:
the asymmetry is the **sole** reason this issue is at 2, and it is diverging, not converging.
Split, the consistency child would plausibly score 3 and the calibration child 2. Fifteen more
cycles of under-expressiveness.*

**[38] — NEW cycle 25, PAID OFF AT 26, 27 AND TWICE AT 28. A SINGLE FETCH'S "ABSENT" IS NOT
EVIDENCE OF ABSENCE.** **A PRESENT verdict may be trusted from one fetch; an ABSENT verdict
must be confirmed against a second URL form.** Before recording an absence check **(1)** the
abstract, **(2)** a different URL rendering, **(3)** that you fetched the file the claim
actually cites, **(4)** that the **VERSION** you fetched contains the material at all — an
arXiv paper's task list can change between versions (src-0002 v2 has no CTI-ATE task).
`raw.githubusercontent.com/<owner>/<repo>/main/<path>` returns whole files. *Cycle 29 used two
`/html` renderings plus `/abs` on src-0008 and recorded **no** absence as a defect; the two
renderings agreed, and the second one is what surfaced the "Both XOR (P5, P6)" sentence that
discharged [5]. Reading the same paper twice through different renderings remains cheap and
keeps paying.*

**[39] — NEW cycle 25, SECOND INSTANCE 26, THIRD PARTIALLY CLOSED 27, VERSION AXIS ADDED 28,
FIRST VERSION CHECK RUN 29. PROVENANCE LABELS IN THIS BASE WERE SET AT COLLECTION TIME AND
ARE MOSTLY STILL UNCHECKED.** src-0001 **is peer-reviewed** — ARES 2025, Springer, DOI
`10.1007/978-3-032-00627-1_17` — and this base called it a preprint for 24 cycles. src-0005
goes the other way: **an unreviewed preprint** whose CrowdStrike/Meta attribution rests on
recognising two author names. src-0017's `[TMLR '25]` badge against a March 2026 arXiv
submission is **unresolved and probably permanently so**. Still unchecked: src-0013
("ICSME 2026 Research Track"), src-0014 ("v1 preprint, no stated venue"), src-0015
("single-author preprint"). *Cycle 29 ran the **version** check on src-0008 for the first
time: `/abs` lists **v1 only**, 7 May 2026, unrevised since collection. **Cheap, and worth
running on every arXiv source at its next G2** — src-0002 gained an entire task between v2 and
v3 and nobody noticed for 22 cycles.*

**[40] — NEW cycle 26. src-0005 IS MULTI-SELECT MULTIPLE CHOICE WITH LLM-GENERATED QUESTIONS,
AND THIS BASE CITED IT FOR 26 CYCLES WITHOUT KNOWING THAT.** Metric verbatim: "the share of
questions for which the system selects all correct options and only the correct options." 609
malware-analysis cases; 588 threat-intel-reasoning pairs from 45 reports supplied "via a set
of images". Questions **generated by Llama 3.2 90B and Llama 4 Maverick**, then
human-validated; the paper concedes both that multiple choice "does not provide a perfect
proxy" and that there is "performance bias … where the model under test is the same, or has
similarities with the set of models that were used in synthetic data generation pipelines".
**(a)** Its percentages are not commensurable with src-0002's F1 or src-0007's
precision/recall. **(b)** It reports **no ATT&CK metric at all**. **(c)** 23–34% (MA) against
43–53% (TIR) is a within-paper cross-task spread but **NOT a controlled contrast** — different
corpora, generation pipelines and random baselines (0.63% vs 1.7%). **Anyone using it must
state those three confounds.**

**[41] — NEW cycle 26, REINFORCED 27, 28 AND ANSWERED IN PART BY 29. THE G3 CEILING BECOMES
*LESS* LIKELY TO BE TESTED THE BETTER THE LOOP WORKS.** An honest, stingy T4 demotes issues
carrying open contradictions, which moves them *away* from the ceiling. **So the validator's
G3 check is very nearly dead code, while the prompt's subtraction rule — which every T4 has
correctly refused to apply — would fire on multiple issues today and drive them toward 0
without tripping anything.** *Cycle 29: **six open contradictions across three issues**, one
issue carrying **three**. The ceiling bound on **nothing**, for the fourth T4 running —
that is now a robust empirical finding about this gate, not an accident. **And I answered the
`ctr-0005` wrinkle as a T4:** a contradiction whose content **strengthens** the issue it is
filed against must not be scored as a demotion, and I applied none. The gate should
distinguish a contradiction that **undermines** a claim from one that **corrects an over-broad
hedge**; neither the prompt nor the validator does. `ctr-0007` is a third shape again — its
content **cuts both ways** and a T4 has no standing to decide which. **Three shapes of
contradiction, one gate.***

**[42] — NEW cycle 27. src-0007's RELEASED IoC MATCHER IS ONE-DIRECTIONAL, NOT TWO;
`ctr-0004` OPENED; REPAIRED BY APPEND.** The executing code is
`any(pred.lower() in gt.lower() for gt in gt_set)` — **a prediction must be a SUBSTRING OF a
ground-truth entry**. The two-directional and exact-match variants are **inside triple-quoted
string literals and never run**. **Consequence — the bias is ASYMMETRIC:** lenient toward
short/fragmentary predictions, **strict against verbose predictions**, which is the
characteristic free-form-LLM failure mode. **"Substring-permissive, inflates true positives"
is half right and must not be repeated unqualified.** **A T3 on `ioc-extraction-reliability`
should rewrite the cycle-21 open_question and decide whether the asymmetry changes cycle 18's
arithmetic on `ctr-0001`'s METRIC confound.** *Cycle 29 discharged the T4 half of this item:
the **three `scores.json` rationales** that carried the wrong version
(`ttp-attack-mapping-reliability`, `task-dependent-reliability-framing`,
`extraction-vs-reasoning-ordinal-axis`) are **restated correctly** in this cycle's rewrite,
and the one-directional finding is now load-bearing in the ttp demotion. **Still unread in
that repo: the ATT&CK/TTP scorer (`stage3_ti_drafting/ttp/`) and any drafting-rubric/judge
scorer** — see [34].*

**[43] — NEW cycle 28. src-0018's STORED SCOPE IS WRONG BY BEING TOO RESTRICTIVE; `ctr-0005`
OPENED; REPAIRED BY APPEND IN BOTH PLACES.** The four PERFORMANCE artefacts really are images —
**confirmed a third time, and that ban stands.** But the page states in plain text: a **41
min/report human-analyst baseline** against ~**3.3 min**; **17 metrics each a ratio 0–1**;
and, most importantly, **"the LLM temperature parameter was set to 0"**. **The temperature-0
fact strengthens `consistency-calibration-as-failure-mode`** and was fenced off for three
cycles by an over-broad hedge. The page has **ten** figures, not four. **Standing lesson: a
hedge is a claim and must be scoped as precisely as an assertion.** *Cycle 29 gave it its
scoring effect: **no demotion applied for `ctr-0005`**, reasoning recorded in `scores.json` and
under [41].*

**[44] — NEW cycle 28. src-0002 CONTRADICTS ITSELF ON THE CTI-ATE METRIC, AND ITS OTHER TWO
key_claims CARRY UNSTATED GLOSS; `ctr-0006` OPENED AGAINST `ttp-attack-mapping-reliability`;
REPAIRED BY APPEND IN BOTH PLACES.** **(a)** Section 4.2 says *"We adopt the **Micro-F1**
score as the evaluation metric for the CTI-ATE task"*; Table 1's header reads **"CTI-ATE
(Macro-F1)"**. **0.6388's metric is ambiguous by the paper's own text.** **(b)** The
cross-task difficulty comparison is **ours** — `task difficulty` ABSENT, `most challenging`
ABSENT — and it subtracts multi-class **accuracy** from multi-label **F1**. **(c)**
key_claims[2] ("no evaluated model exceeded ~72% on any single task") is **FALSE against Table
1** (CTI-TAA Plausible: 86 / 80 / 74). **(d)** The **ATT&CK correctness rule is never
stated**. **(e)** **arXiv v2 has NO CTI-ATE task at all** — always fetch v3 or the latest
render. **A T3 on `ttp-attack-mapping-reliability` should rewrite its first supported
candidate.** *Cycle 29 priced it: **that issue fell 3 → 2**, and this item plus [42] are the
two findings that did it. The T3 job named here is now the most concrete
score-restoring action in the graph.*

**[45] — NEW cycle 28, ANSWERED FOR SCORING PURPOSES BY 29.**
`attribution-confident-wrong-gap` **bundles a well-evidenced question with an unevidenced
one, and only a T2 can fix it.** The **error-rate** half is well grounded (src-0002's derived
14–64% incorrect bucket on 50 alias-tolerant real reports, corroborated in direction by
src-0007's within-table rubric contrast). The **confidence** half has **no evidence at all**.
Natural cut: `attribution-error-rate` vs `attribution-confidence-calibration`, the second
probably merging into whatever [37] produces. **Next T2 is cycle 44 at the earliest.** *Cycle
29's answer to the note for a T4: **the rubric scores an issue's `candidate_resolutions`, not
its title**, so I applied it to the candidates — one supported candidate on one source = 2. I
explicitly refused to count the **survey** candidate's three ids as two-independent-source
support, because each is cited for what it **LACKS**; doing so would award a 3 for the finding
that nobody has measured the thing. **Both [37] and [45] issues are now held at 2 by their
weaker conjunct, and I scored them consistently for it.***

**[46] — NEW cycle 29. src-0008 CONTAINS TWO SELF-CONTRADICTIONS AND ITS PER-PHASE NUMBERS ARE
IMAGE-LOCKED; `ctr-0007` OPENED; REPAIRED BY APPEND IN BOTH PLACES.** **(a) THE STORED CLAIM
IS OVER-GENERAL.** The paper evaluates **five** models; *"Cohere, however, shows progressive
degradation: 1% missed detections in P1, 2% in P2, 5% in P3, and in P4, 65% misses plus 35%
explicit 'Don't Know' responses"* — and **P1–P4 contain no cryptography**. So plain-text IoC
recovery is **not** near-free "for current LLMs", and **encryption is not the boundary**. The
finding **cuts both ways** for `ioc-extraction-reliability`'s scaffolding candidate and cycle
29 asserted neither direction. **(b) IT DEFINES ITS METRICS TWICE, INCOMPATIBLY** — body *"the
proportion of samples in which the model correctly identifies the presence of an IoC"* against
Table 6's caption *"ratio of YES an answers"*. **Whether "100% detection" means 100% correct
or 100% YES is undetermined by the paper.** **(c) PHASE LABELS** — see [5], resolved in our
favour. **(d) PER-PHASE P0–P12 RESULTS EXIST ONLY IN FIGURE 2**, so "roughly 0–1%" and "~95%+
misses" are **figure-derived, not text-verified**; the body supports only *"near-complete
failure"*, *"encrypted IoCs become effectively opaque"*, *"once the code is encrypted,
detection of IoCs remains essentially zero for all models"*. **(e) TABLE 6 IS READABLE AND WAS
NEVER CAPTURED** — DR 38.5 / 38.6 / 38.5 / 35 / 22.8%, Acc. 99.7 / 99.4 / 87.7 / 100.0 /
100.0%, DK 94 / 37 / 0 / 0 / 625, over ~4,350 queries each; **aggregates over all thirteen
phases, never per-phase**. **(f) PASSED:** Table 7's hallucination rates now **text-confirmed
exactly** (0.11 / 0.23 / 4.8 / 0 / 0) and the abstract verbatim word for word. **A T3 on
`ioc-extraction-reliability` should rewrite the third candidate_resolution to state Cohere's
P1–P4 degradation, decide whether model-side variance under syntactic noise supports or
undercuts the scaffolding hypothesis, and relabel the figure-derived percentages.**
