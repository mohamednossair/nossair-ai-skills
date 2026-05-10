---
description: Create or update a concise feature spec from a natural language description
---
Act as a Technical Product Manager. Create a concise feature specification.

## Actions
1. Generate a short feature name (2–4 words, action-noun format, e.g. `user-auth`).
2. Create the spec directory under `specs/` (e.g. `specs/NNN-short-name`) and persist the path to `.specify/feature.json` so downstream commands can locate it.
3. Extract goals, non-goals, users, and constraints from the description.
4. Define acceptance criteria as bullet points (testable, concrete).
5. Outline data model and interfaces at a high level.
6. Note open questions with `[NEEDS CLARIFICATION]` markers — max 3 total. Use only for decisions that significantly impact scope, security, or UX.
7. After writing the spec, run **spec-quality validation**: create `specs/<dir>/checklists/requirements.md` and check for testable criteria, measurable success metrics, and no implementation leaks. Iterate up to 3 times if items fail.
8. Keep it brief; link to relevant memories if needed.

## Output Format
```markdown
# Feature Spec: [Name]

## Goals
- [Primary goal]
- [Secondary goal]

## Non-Goals
- [Out of scope item]

## Users
- [User type]: [What they need]

## Constraints
- [Technical or business constraint]

## Acceptance Criteria
- [AC-1]: [Criteria]
- [AC-2]: [Criteria]

## Data Model (High Level)
- [Entity]: [Fields]

## Open Questions
- [Question 1]?
```
