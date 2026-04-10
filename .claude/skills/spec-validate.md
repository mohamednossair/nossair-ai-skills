---
description: Validate all SDD artifacts for consistency, gaps, and token efficiency.
---
Act as a Senior SDD Architect. Validate the Spec-Driven Development artifacts in `.spec/`.

## Actions
1. Read all files: `constitution.md`, `spec.md`, `plan.md`, and all `tasks/*.md`.
2. Check **Constitution**: rules specific & actionable, tech stack explicit, under 30 lines.
3. Check **Spec**: has Goal, Non-Goals, Requirements, Acceptance Criteria; criteria are measurable.
4. Check **Plan**: architecture aligns with constitution; data model explicit; steps ordered logically.
5. Check **Tasks**: each under 20 lines, references spec/plan sections, completable in one AI prompt.
6. Check **Token Efficiency**: flag prose paragraphs, duplicate info, vague constraints.

## Output Format
Group findings by severity: [Critical] | [Warning] | [Suggestion]
Each entry:
- **Artifact**: [file]
- **Issue**: [what is wrong]
- **Fix**: [concise correction]