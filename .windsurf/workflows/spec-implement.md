---
description: Implement one atomic Spec-Kit task
---

**Usage**: `/spec-implement task=".spec/tasks/01-setup.md"`

1. Read `.spec/constitution.md` and the task file referenced by `$task`.
2. Read `.spec/plan.md` only if the task references need extra context.
3. Read `.spec/spec.md` only when the task file is ambiguous or incomplete.
4. If `$task` is missing or unclear, stop and ask the user instead of guessing.
5. Implement only the selected task's deliverables and constraints.
6. Respect module boundaries and routing rules from `constitution.md`.
7. Run the smallest relevant build or tests needed to verify the changed files.
8. Output: Completed deliverables, Changed files, Tests run and results, Remaining blockers or follow-up tasks.
