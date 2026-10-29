---
description: Ask up to 5 targeted questions to resolve ambiguities and encode answers back into the spec or plan
---

**Usage**:

    /speckit.clarify
      [spec="path/to/spec.md"]
      [plan="path/to/plan.md"]
      [mode="spec|plan"]
      [apply="preview|apply"]

`context="path/to/spec-or-plan.md"` is still accepted — the artifact type infers `mode`. Defaults: `mode=spec`, `apply=preview`.

> All examples below are format templates — generate real content as normal Markdown without the example indentation.

## Input Validation

- `mode=spec` requires a resolved specification; `mode=plan` requires a resolved plan.
- If both `spec` and `plan` are supplied, use the artifact matching `mode`.
- If `context` is supplied together with `spec` or `plan`, the explicit typed parameter wins.
- Return a structured input error when the resolved artifact conflicts with `mode`.

1. **Artifact resolution** — explicit parameter → `.specify/feature.json` → prerequisite script (`.junie/scripts/powershell/check-prerequisites.ps1 -Json` / `.junie/scripts/bash/check-prerequisites.sh --json`) → single-candidate discovery → structured missing-input error; never guess with multiple candidates.
2. **Mode selection** —
   - `mode=spec`: clarify business scope, users, behavior, ACs, NFRs, terminology, conceptual entities, and edge cases; update `spec.md`; run specification validation.
   - `mode=plan`: clarify architecture decisions, dependencies, interfaces, technical data representation, migration strategy, operational readiness, and validation. Authorized outputs: `plan.md`, `research.md`, `data-model.md`, files under `contracts/`, `quickstart.md` — modify a supporting artifact only when the accepted answer directly affects it, report every modified artifact after each accepted answer, and never modify `spec.md` in `mode=plan` (nor `plan.md` in `mode=spec`). Never silently convert a technical decision into a business requirement (or vice versa).
3. **Mutation safety** —
   - `apply=preview` (default): scan ambiguity, generate the prioritized question queue, and display the first recommended question — do not modify files.
   - `apply=apply`: ask questions interactively and update the artifact after each accepted answer.
4. Scan the artifact against a structured taxonomy: Functional Scope, Domain & Data Model, Interaction & UX, Non-Functional Attributes, Integration & Dependencies, Edge Cases, Constraints, Terminology, and Acceptance Criteria.
5. Generate a prioritized queue of max 5 questions. Only ask questions whose answers materially impact architecture, data modeling, task decomposition, test design, UX behavior, or compliance.
6. Present **one question at a time** with a **recommended option**. Format options as a compact Markdown table. Every recommendation states its basis and confidence.

Use the following recommendation structure:

    Recommendation: Option B

    Basis:

    - Existing rule: BR-014
    - Existing integration constraint: INT-003
    - Security standard: security/SKILL.md

    Confidence: Confirmed | Derived | General best practice

`Confirmed` = supported by an existing artifact (BA fact base, plan decision, standard); `Derived` = inferred from project context; `General best practice` = default with no project evidence. Never present a general default as an existing application requirement.

7. Accept short answers (<= 5 words) or option letters. The user may reply `yes` / `recommended` / `suggested` to accept your recommendation.
8. After each accepted answer (apply mode only), incrementally update the artifact:
   - Ensure a `## Clarifications` section exists with a `### Session YYYY-MM-DD` subheading; if a same-date heading already exists, append to it instead of creating a duplicate.
   - Append the entry with basis and confidence, using the entry structure shown below this list.
   - Apply the clarification to the most appropriate section (Functional Requirements, User Stories, Data Model, Success Criteria, Edge Cases — or the corresponding plan sections in `mode=plan`).
   - Preserve existing requirement and plan identifiers — never renumber. In `mode=spec`: preserve AC and NFR IDs. In `mode=plan`: preserve milestone (`M#`) and `TR-###` IDs as well. If an answer invalidates a requirement, decision, or technical requirement, mark it `Deprecated` and add the replacement with a new stable ID; record the affected IDs in the clarification entry.
   - Save the file after each integration to minimize context-loss risk.

Append accepted answers using this structure:

    - Q: Should expired links remain usable?
      → A: No, reject after 24 hours.
      → Affects: AC-007, NFR-SEC-003
      → Basis: BR-014
      → Confidence: Confirmed

9. Bounded completion — after 5 questions (or when the queue is empty), re-scan the artifact, list unresolved material ambiguities, and report a verdict:
   - **COMPLETE** — no material ambiguity remains.
   - **PARTIAL** — material ambiguity remains, but planning can continue with documented assumptions.
   - **BLOCKED** — a remaining ambiguity prevents reliable planning or acceptance testing.
   Do not pretend all ambiguity was resolved; recommend another clarification session when the verdict is PARTIAL or BLOCKED.
10. Validate: total asked questions ≤ 5, no contradictory statements, terminology is consistent, and no NEW vague placeholders were introduced by answers (pre-existing unresolved ambiguities are reported through the Bounded Completion verdict instead).
11. After all answers, run the mode-specific validation fallback:
    - `mode=spec`: run `/speckit.analyze` when it is available in the target project; otherwise perform the Specification Quality Validation defined by `/speckit.specify` and report that the dedicated validation command was unavailable.
    - `mode=plan`: run `/speckit.analyze` with plan scope when supported; otherwise rerun the plan's constitution, traceability, milestone coverage, standards, and artifact-consistency checks and report that the dedicated validation command was unavailable.
