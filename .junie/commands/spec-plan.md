---
name: spec-plan
description: Generate technical plan and atomic tasks from an existing spec.
---
$task
1. Read `.spec/constitution.md` and `.spec/spec.md` to understand the project context.
2. Read `.spec/plan.md` if it exists, or generate it with: Architecture, Data Model, Implementation Steps (max 40 lines, bullets only).
3. Analyze the task description: $task.
4. Break it into atomic task files in `.spec/tasks/`, numbered sequentially (e.g., `01-setup.md`, `02-model.md`).
5. Each task file must follow this format (max 20 lines):
   - **Context**: Reference specific sections of spec.md and plan.md
   - **Deliverables**: Exact files/classes/methods to create or modify
   - **Constraints**: Rules from constitution.md that apply to this task
6. Each task must be implementable in a single AI prompt without needing the full spec.
7. If `.spec/tasks/` already has files, continue numbering from the last existing task.
8. Print the list of generated task files with a one-line summary of each.
