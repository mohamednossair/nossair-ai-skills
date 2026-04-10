---
description: Generate a technical plan and atomic tasks from an existing spec.
---
Act as a Senior SDD Architect. Read the project's `.spec/constitution.md` and `.spec/spec.md`, then generate the technical plan and task breakdown.

## Actions

**Step 1: Generate `plan.md`**
- Architecture: describe layers/components aligned with constitution tech stack
- Data Model: table format (Field | Type | Constraints)
- Implementation Steps: numbered list of milestones
- Keep under 40 lines, bullet points only

**Step 2: Generate task files in `.spec/tasks/`**
- One file per milestone from the plan (e.g., `01-setup.md`, `02-model.md`)
- Each task max 20 lines with:
  - **Context**: reference to spec.md and plan.md sections
  - **Deliverables**: exact files/classes to create or modify
  - **Constraints**: applicable rules from constitution.md
- Each task must be completable in one AI prompt

**Step 3: Validate**
- Verify every spec requirement is covered by at least one task
- Verify no task exceeds 20 lines
- Flag any task that requires reading the full spec (should be self-contained)

## Output Format
1. Print `plan.md` content
2. List all generated task files with one-line summaries
3. Coverage matrix: requirement -> task mapping