---
name: spec-validate
description: Validate all SDD artifacts for consistency, gaps, and token efficiency.
---
Validate the Spec-Driven Development artifacts in `.spec/` directory.
1. Read all files: `constitution.md`, `spec.md`, `plan.md`, and all files in `tasks/`.
2. Use the spec-kit skill from `.junie/skills/spec-kit/SKILL.md` as the validation reference.
3. Check **Constitution**:
   - Are all rules specific and actionable (not generic)?
   - Is the tech stack explicitly defined?
   - Is it under 30 lines?
4. Check **Spec**:
   - Does it have Goal, Non-Goals, Requirements, and Acceptance Criteria?
   - Are non-goals present to prevent scope creep?
   - Are acceptance criteria measurable?
5. Check **Plan**:
   - Does architecture align with constitution tech stack?
   - Is the data model explicit (types, constraints)?
   - Are implementation steps ordered logically?
6. Check **Tasks**:
   - Is each task under 20 lines?
   - Does each task reference specific spec/plan sections?
   - Can each task be implemented in one AI prompt?
7. Check **Token Efficiency**:
   - Flag any prose paragraphs (should be bullet points)
   - Flag duplicate information across artifacts
   - Flag vague constraints (`reasonable`, `good`, `clean`)
8. Output a report grouped by: [Critical] | [Warning] | [Suggestion]
