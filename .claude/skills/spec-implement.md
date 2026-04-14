---
description: Implement one atomic Spec-Kit task using the constitution and generated task file.
---
Act as a Senior Spec-Kit implementer. Read the constitution and one generated task file, then implement only that task.

## Actions

**Step 1: Load only the required context**
- Read `.spec/constitution.md` and the task file referenced by `$task`
- Read `.spec/plan.md` only if task references need extra implementation context
- Read `.spec/spec.md` only when the task file is ambiguous or incomplete

**Step 2: Confirm scope before coding**
- If `$task` is missing, unclear, or conflicts with the constitution, stop and ask the user
- Keep the implementation limited to the selected task's deliverables and constraints
- Respect module boundaries and routing rules from `constitution.md`

**Step 3: Implement and verify**
- Modify only the files required for the selected task
- Run the smallest relevant build or tests needed to verify the changed files
- Do not pull in future tasks unless it is required to make the current task work; explain any such dependency

## Output Format
1. Completed deliverables
2. Changed files
3. Tests run and results
4. Remaining blockers or follow-up tasks
