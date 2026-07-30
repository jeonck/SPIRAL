# Cycle 031 — T3 Investigate — `ttp-attack-mapping-reliability`

Queue entry: `state/queue/next_task.json` (written cycle 30), task type **T3**,
`target_issue: ttp-attack-mapping-reliability`, `attempt_count: 0`.

I read `prompts/t3_investigate.md` myself rather than trusting the queue entry's account of
it, per carry-forward [29]. **The handoff was accurate on every point I checked** — a T3 may
add sources (step 2), may not split an issue and may not rescore. That is **three clean
handoffs in a row** after five bad ones.

**No new source was added.** Everything read this cycle lives at URLs already covered by
`src-0017` (the `github.com/xschen-beb/CyberThreat-Eval` artefact) or `src-0012`. The
`max_new_sources` budget is untouched and `index.json` still holds **18** sources.

---

## Task performed

Three jobs, in the order the queue set them: G2 first, then `ctr-0006`'s resolution path,
then the cheap bolt-on for `ctr-0008`.

### Primary — `ctr-0006`'s resolution path, all three steps executed

**Step (iii) first, because it was the fetch everything else depended on.**
`stage3_ti_drafting/ttp/eval/compute.py` in the `src-0017` artefact — the ATT&CK/TTP scorer
that carry-forward [34] has wanted since cycle 22, that `ctr-0006` step (iii) named, that
`ctr-0001`'s remaining path needs, and that cycles 29 and 30 both called the highest-leverage
single fetch in the graph — **was retrieved whole and read for which lines execute**, per the
`ctr-0004` trap in which the IoC evaluator's documented rule turned out to sit inside dead
triple-quoted string literals.

**The executing rule is exact technique-ID set intersection.** Verbatim from live code:

```
article_ttps_set = {ttp.split(" - ")[0].strip() for ttp in raw_ttps if " - " in ttp}
validated_ttps_set = set(validated_ttps_final.keys())
tp = len(article_ttps_set.intersection(validated_ttps_set))
fp = len(validated_ttps_set - article_ttps_set) + missing_in_mapping_count
fn = len(article_ttps_set - validated_ttps_set)
overall_precision = total_tp / (total_tp + total_fp) if (total_tp + total_fp) > 0 else 0
overall_recall    = total_tp / (total_tp + total_fn) if (total_tp + total_fn) > 0 else 0
```

No substring matching, no parent-technique credit, no sub-technique credit, no partial credit
anywhere in the executing path. **This is a different *kind* of rule from the IoC scorer in the
same artefact, not a stricter setting of the same dial.**

Directly assertable consequence: `TTP_Mapping.csv` verifiably contains sub-technique IDs
(`T1548.001`, `.002`, `.003`, `.004` quoted verbatim), so a prediction of `T1548.002` against a
ground truth of `T1548` is admitted by the mapping check, fails the intersection, and is scored
a **false positive** while `T1548` is simultaneously scored a **false negative**. One answer at
the wrong granularity is penalised twice.

**And the same defect as `ctr-0004` appeared again, by a different mechanism.** The scorer's
own docstring says, verbatim, *"If a TTP's description does not match the expected mapping,
issue a warning and do NOT add this TTP to the final validated TTPs. (Such TTPs will be treated
as false positives.)"*, and `ttp/README.md` agrees — *"**Filtering**: Only TTPs with matching
descriptions are included"*, worked example *"Result: **Rejected** (counted as false positive)"*.

**The live `else` branch does the opposite.** It prints the warning, then runs
`corrected_details = ttp_mapping[ttp_id]` and `validated_ttps_final[ttp_id] = corrected_details`
— overwriting the model's description with the canonical one and **keeping** the entry. Unlike
`ctr-0004` there is no dead string literal here: **the live code contradicts the docstring
sitting directly above it.**

Operative consequence: **the description check is inert for scoring.** A predicted technique ID
counts on the sole condition that the ID appears in the mapping file, whatever the model wrote
about it. **The scorer measures ID selection only.**

I also recorded a leniency running the *other* way, so nobody assumes the bias is one-signed: a
`json5` parse failure executes `continue` and the whole per-article block sits inside a bare
`except Exception`, so an article whose model output is malformed is **dropped entirely** — no
false negatives for its ground truth, no false positives, silently gone from the micro-average.

**Steps (i) and (ii)** then followed, and they are the score-restoring half. The first supported
candidate was **rewritten in place** (permitted — `graph.json` is not append-only-protected, and
its prior text survives quoted in full inside `ctr-0006` and inside the cycle-29 `scores.json`
rationale, so nothing is lost). The quantified `far below the ~71-72%` comparison is gone,
`src-0005` is removed from that candidate's evidence list because it reports no ATT&CK metric at
all, and the Micro-F1/Macro-F1 ambiguity plus the never-stated correctness rule are now
**inside** the claim rather than footnotes to it.

One point cycle 28 did not make, which I added because it kills the comparison from a second
direction: **the ordering does not hold even naively.** Table 1's CTI-TAA `Correct` column reads
**52** for the same model, **below 63.88** — so "ATT&CK mapping is the worst CTIBench task" is
false on the paper's own printed numbers as well as unsupported by its text. Checking every
member of the population the claim ranges over is carry-forward [31]'s rule (viii), and it paid.

### Secondary — carry-forward [47] / `ctr-0008`

Found it, in the same artefact. `stage3_ti_drafting/score_evaluation/` holds `README.md`,
`__init__.py`, `data/`, `eval/`, `example/`; `eval/` holds `evaluation_runner.py`,
`root_cause.py`, `threat_actor.py`, `utils.py`. Cycle 27 recorded that the top-level README
"names no path" for this; it is one directory level down from where that search stopped.

**The code confirms `ctr-0008` rather than dissolving it.** `eval/root_cause.py` was retrieved
verbatim and its `Attribution` anchors are unambiguously **actor identification** — 1
*"Attribution is completely incorrect; no connection between the malware and the actual threat
actor or root cause."*, 5 *"Perfect attribution; accurately identifies the threat actor, their
objectives, and the precise relationship to the incident's root cause."* Both evaluators score
the same six dimensions, each 1–5, in one JSON object.

**A third finding bearing on `ctr-0008`'s judge-identity half: no judge model is hardcoded.**
`--model` is *required* with no default, help text verbatim `Model name to run (e.g., gpt-4o,
o3-mini, etc.)`. src-0007 Appendix C.2's *"We evaluate the results using GPT-4o"* is therefore a
statement about how the authors **ran** the harness, not a property of the released code, which
can neither corroborate nor refute it.

**Trust label, stated because it constrains what the next cycle may do with this.**
`eval/root_cause.py` is verbatim and trustworthy. `eval/threat_actor.py` **is not** — the fetch
declined verbatim reproduction and returned a *summary*, which under rule (ix) is as
untrustworthy as a bare ABSENT. Its reported anchors (source linking, matching Appendix C.2 and
the strings already held in this state) are consistent with everything else, **and must still be
re-fetched verbatim before any candidate rests on them.** That re-fetch is step 1 of `ctr-0008`'s
repair, which remains a job for a T3 targeting `attribution-confident-wrong-gap`. **I opened no
candidate on this material and rescored nothing.**

---

## Retrospection

**G2 subject: `src-0012`** (EY Canada / GPTZero, `consulting.ca`), chosen by **staleness** — last
verified cycle 13, the longest gap of any source in the base, and the queue's first
recommendation. **Result: PASSES CLEANLY.** Second consecutive clean G2, after eight of the
preceding ten source-checks produced a defect.

Method: `consulting.ca` re-fetched with an instruction to reproduce the whole article verbatim
and then answer eight exact-string checks, writing ABSENT rather than inferring; then
`goingconcern.com` — recorded in `src-0012.md` since cycle 12 as the corroborating outlet —
fetched as a second form to close the one gap the first fetch left.

All four `index.json` key_claims re-verified PRESENT and exact. The load-bearing sentence matched
verbatim for the **third** consecutive cycle: *"GPTZero's investigations branch on May 14
published a report that found 16 of 27 references in the EY study were hallucinated and that 72%
of the study was AI."* The half-dozen-footnotes sentence, the removal sentence, and the EY
statement all re-verified, the last at Going Concern verbatim, which also confirms it is the
**only** direct EY quote in its article. Cycle 13's second EY quote re-verified too.

**One check no prior cycle had run — and it clears.** Both `src-0012.md` and `key_claims[0]` date
the EY study to **2025**, and the `consulting.ca` article states **no year for it anywhere**: the
whole article was reproduced verbatim and its only date is its own, 19 May 2026. So the year is
not supported by this source's own URL. It **is** supported verbatim by Going Concern — *"the
2025 EY Canada report titled 'Points of Attack: Uncovering Cyber Threats and Fraud in Loyalty
Systems'"*. The detail is sourced, just to the corroborating outlet rather than to the headline
URL. **No contradiction opened**, and I checked before concluding rather than after.

One provenance-granularity note, recorded and not scored on: `src-0012.md` carries the Going
Concern URL in full, but `index.json`'s `key_claims[3]` names the outlet without its URL and
`key_claims[0]` attributes "2025" with no outlet at all, so a reader working only from
`index.json` can resolve neither. That is a granularity weakness, not a fabrication — the `.md`
file has disclosed the split honestly since cycle 12, including the explicit limitation that no
direct EY quote appears in the `consulting.ca` article. New carry-forward [48].

### The near-miss, which is the more useful part of this cycle's methodology

**I nearly recorded a spectacular false finding, and rule (v) caught it.**

Reading the TTP scorer, I fetched `data/TTP_Mapping.csv` — the file whose contents decide which
predicted technique IDs are admitted. The first fetch reported it as **57 lines**. A second
fetch, at a different URL form, listed **59 distinct TechniqueID values** running alphabetically
from `T1548` (Abuse Elevation Control Mechanism) to `T1197` (BITS Jobs), and returned **ABSENT**
for `T1204`, `T1189`, `T1036` and `T1055`.

Taken at face value that is a devastating result: a scorer whose authoritative mapping covers
only the A–B slice of ATT&CK would count nearly every real prediction as `missing_in_mapping`,
i.e. as a false positive, and the published TTP precision/recall figures would be measuring
mostly the alphabet.

**It is false.** The GitHub contents API reports `TTP_Mapping.csv` at **1,083,078 bytes**. Both
readings were **fetch truncation artefacts** — and the second fetch had in fact flagged its own
truncation, which the first had not. The four ABSENT verdicts are **void** and I have made no
claim about the mapping's coverage anywhere in the state.

What survives are the **positive** verdicts, which rule (v) says may be trusted from one fetch:
the header line verbatim, the presence of sub-technique IDs, the presence of double-quoted
multi-line fields, and `T1071` PRESENT as `Application Layer Protocol`. The sub-technique
observation is the one that does real work, and it survives.

**Generalisable lesson, new and cheap: a byte-size check from the hosting API is a decisive guard
against mistaking fetch truncation for file content, and it should precede any ABSENT verdict
taken over a large file.** Rule (v) told me to confirm the absence at a second URL form; it did
not tell me that *both* forms can fail the same way for the same reason. New carry-forward [49].
