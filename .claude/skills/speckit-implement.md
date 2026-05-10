---
description: Execute the implementation plan with governance, gating, and setup verification
---
Act as a Lead Developer. Create an execution runbook from tasks.

## Actions
1. **Checklist gate** — Scan `checklists/` under the feature directory. If any checklist has incomplete items, display a status table and ask whether to proceed before continuing.
2. **Load governance context** — Read `/memory/constitution.md` and enforce MUST principles during implementation.
3. **Project-setup verification** — Detect the tech stack from `plan.md` and create/verify ignore files (`.gitignore`, `.dockerignore`, `.eslintignore`, `.prettierignore`, etc.) with essential patterns for the detected technology.
4. **Parse tasks.md** — Extract phases (Setup, Tests, Core, Integration, Polish), task IDs, parallel markers `[P]`, and dependencies.
5. **Execute phase-by-phase**:
   - Respect dependencies: sequential tasks in order, parallel `[P]` tasks together.
   - Follow TDD: test tasks before their corresponding implementation tasks.
   - File-based coordination: tasks touching the same files must run sequentially.
   - Mark completed tasks as `[X]` in `tasks.md`.
6. Suggest branch strategy per milestone/task (feature/*, bugfix/*) consistent with repo rules.
7. For each task, propose: commit slices, test scaffolds (`/test-generate`), and review checkpoints.
8. Track Definition of Done and link back to AC IDs for traceability.
9. Output a runbook with commands and checkpoints to execute safely.
10. **Extension hooks** — If `.specify/extensions.yml` exists, check `hooks.before_implement` and `hooks.after_implement` and execute registered hooks accordingly.

## Output Format
```markdown
# Implementation Runbook

## Phase 1: Setup
### Task T-01: [Name]
```bash
# Branch
git switch -c feature/T-01-short-name

# Commands
[Specific commands to execute]

# Test
/test-generate file="..."

# Review
/review file="..."

# Commit
git commit -m "type(scope): description"
```

## Definition of Done Checklist
- [ ] AC-1: [Criteria met?]
```
