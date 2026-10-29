---
description: Create or update a concise feature spec from a natural language description
---

**Usage**: `/speckit.specify feature="..." [mode="draft|feature|refine"] [current_state="docs/ba/<module>/99-facts.json"]`

**Modes** (default `draft`):
- `draft` — create or update spec artifacts only. No branch is created; mark the spec `Status: draft`. Use for exploring an idea.
- `feature` — stable scope required (readiness gate below). Create the branch before writing files.
- `refine` — update an existing specification. Verify the current branch is safe before writing; create a `chore/spec` branch only when required.

Branch prefix is resolved from the mode — never hardcoded: `feature` → `feature/spec` · `refine` → `chore/spec` · `draft` → no branch.

1. **Artifact resolution** — apply the shared resolution priority: explicit parameter → `.specify/feature.json` → prerequisite script (`.junie/scripts/powershell/check-prerequisites.ps1 -Json` / `.junie/scripts/bash/check-prerequisites.sh --json`) → repository discovery when exactly one candidate exists → structured missing-input error. Never guess when multiple candidates exist. For `refine`, the existing spec must resolve; for `draft`/`feature`, create `specs/NNN-short-name/` and persist the path to `.specify/feature.json`.
2. Generate a short feature name (2–4 words, action-noun format, e.g. `user-auth`).
3. Extract goals, non-goals, users, and constraints.
4. Capture success metrics and non-functional requirements with stable IDs — `NFR-SEC-###`, `NFR-PERF-###`, `NFR-AVL-###`, `NFR-PRV-###`, `NFR-OPS-###`. Each NFR must be measurable (threshold + condition).
5. Define acceptance criteria with stable IDs (Given/When/Then wording optional, but actor, action, and outcome must be explicit).

Use this structure for every acceptance criterion. Generate this as normal Markdown without the example indentation:

    ### AC-001: <short name>
    - Statement: <verifiable behavior>
    - Validation: <API test | UI journey test | manual check | metric>
    - Priority: Must | Should | Could
    - Source: user-requested | existing-system | business-policy | regulatory | technical-constraint | assumption

IDs are stable — never renumber an existing AC; mark removed requirements as `Deprecated` rather than deleting them.

6. Data model: conceptual business entities only — attributes, relationships, lifecycle states. Do NOT select database types, table names, indexes, or persistence frameworks; technical storage representation belongs in `data-model.md` during `/speckit.plan`.
7. **Current-State References** (required when the feature changes an existing application; link the BA set from `/speckit.document-generate`). Add this section to the spec.

Generate this as normal Markdown without the example indentation:

    ## Current-State References

    - Documentation source: `docs/ba/<module>/99-facts.json`
    - Affected journeys: <names or "none">
    - Affected business rules: <BR-### list or "none">
    - Affected screens: <names or "none">
    - Affected integrations: <names or "none">

    ### Rules Changed by This Feature

    | Existing rule | Changed by | Intended change |
    |---|---|---|
    | BR-001 | AC-003 | <intended change> |

    ### Rules Remaining Unchanged

    - BR-002

No AC may contradict a rule listed as unchanged. If current-state evidence is required but `current_state` cannot be resolved, stop with a structured `MISSING_INPUT` error — never generate claims about an existing application without evidence.

8. Note open questions with `[NEEDS CLARIFICATION]` markers — max 3 total. Use only for decisions that significantly impact scope, security, or UX.
9. After writing the spec, run **spec-quality validation**: create `specs/<dir>/checklists/requirements.md` and check for testable criteria, measurable success metrics, no implementation leaks, and every AC carrying ID + validation + priority + source. Iterate up to 3 times if items fail. Then set the specification status using this model: `draft` → `ready-for-clarification` → `ready-for-planning` (plus `deprecated`).

Generate the status block as normal Markdown without the example indentation:

    ## Specification Status

    - Status: ready-for-planning
    - Last validated: <YYYY-MM-DD>
    - Blocking clarifications: <IDs or None>

`Status` must be exactly one of `draft`, `ready-for-clarification`, `ready-for-planning`, `deprecated` — no synonyms or prose in the value. `Last validated` uses the execution environment's local calendar date in ISO format (`YYYY-MM-DD`). `mode=draft` writes `Status: draft`; `mode=feature`/`refine` may advance to `ready-for-planning` only when validation passes and no blocking clarifications remain. `/speckit.plan` starts freely only from `ready-for-planning`.

10. Risks and assumptions (top 3) with mitigation or validation notes.
11. Keep it brief; link to `.junie/guidelines.md` and team standards where relevant.

Readiness gate (mode=`feature` only, before branch creation) — stop unless ALL of:
- The feature goal is present.
- At least one Must acceptance criterion exists.
- No scope-level `[NEEDS CLARIFICATION]` remains unresolved.
- The affected application or module is identifiable.

If the gate fails, do not create the branch — report the missing items and ask the user to resolve them or re-run with `mode="draft"`.

Creating the specification branch does not imply that the specification is approved or ready for planning. If post-write validation fails, retain the branch, set the status to `ready-for-clarification`, and report the failed checklist items.

Git Branching (mode=`feature` or `refine` only, before writing files; `draft` never branches):
- Prompt the user: *"Do you have a Jira / Bitbucket issue ID? (e.g., SE-123) Enter it, or press Enter to skip."*
- Resolve the prefix from the mode: `feature` → `feature/spec`, `refine` → `chore/spec`.
- Pass the issue ID (if any), the mode-resolved prefix, and the short feature name to the helper script:
  - Windows: `.junie/scripts/powershell/create-branch.ps1 -Prefix "<mode prefix>" -ShortName "<short-name>" [-IssueId "<id>"]`
  - Linux/macOS: `.junie/scripts/bash/create-branch.sh --prefix "<mode prefix>" --short-name "<short-name>" [--issue-id "<id>"]`
- If already on a non-protected branch, the script returns `created: false` and continues safely.
- Ensure alignment with repo rules from `/.junie/skills/git/`.

Follow-ups:
- Run `/speckit.clarify` to resolve open questions.
- Run `/speckit.plan` to convert this spec into milestones — technology standards are resolved once there (machine-readable `## Standards` section), not guessed here.
