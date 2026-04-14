---
description: Implement one atomic Spec-Kit task using constitution rules and the generated task file.
---
Implement the Spec-Kit task: `$task`.
1. Read `.spec/constitution.md` and the task file referenced by `$task`.
2. Read `.spec/plan.md` only for additional context needed to interpret task references.
3. Read `.spec/spec.md` only if the task file is ambiguous or missing required context; otherwise stay task-focused.
4. If `$task` does not exist or the scope is unclear, stop and ask the user instead of guessing.
5. Implement only the deliverables listed in the selected task file and follow all constraints from `constitution.md`.
6. Respect module boundaries, repository-routing rules, and non-negotiable standards from `constitution.md`.
7. Run the smallest relevant build or tests needed to verify the files changed by this task.
8. Do not expand scope into future tasks unless it is required to make the current task work; if you must, explain why.
9. Output:
   - Completed deliverables
   - Changed files
   - Tests run and results
   - Remaining blockers or follow-up tasks
