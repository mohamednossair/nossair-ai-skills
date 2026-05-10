---
description: Execute the implementation plan with governance, gating, and setup verification
---

**Usage**: `/speckit.implement [tasks="path/to/tasks.md"]`

1. **Prerequisite check** — Run `scripts/powershell/check-prerequisites.ps1 -Json -RequireTasks -IncludeTasks` (Windows) or `scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` (Linux/macOS). If `tasks` is not provided, use `TASKS_PATH` from the script output. If tasks.md does not exist, error and ask the user to run `/speckit.tasks` first.
2. **Checklist gate** — Scan `checklists/` under the feature directory. If any checklist has incomplete items, display a status table and ask whether to proceed before continuing.
3. **Load governance context** — Read `/memory/constitution.md` and enforce MUST principles during implementation.
4. **Project-setup verification** — Detect the tech stack from `plan.md` and create/verify ignore files (`.gitignore`, `.dockerignore`, `.eslintignore`, `.prettierignore`, etc.) with essential patterns for the detected technology.
5. **Parse tasks.md** — Extract phases (Setup, Tests, Core, Integration, Polish), task IDs, parallel markers `[P]`, and dependencies.
6. **Execute phase-by-phase**:
   - Respect dependencies: sequential tasks in order, parallel `[P]` tasks together.
   - Follow TDD: test tasks before their corresponding implementation tasks.
   - File-based coordination: tasks touching the same files must run sequentially.
   - Mark completed tasks as `[X]` in `tasks.md`.
7. For each task, propose: commit slices, test scaffolds (`/test-generate`), and review checkpoints (`/*-review`).
8. Track Definition of Done and link back to AC IDs for traceability.
9. **Extension hooks** — If `.specify/extensions.yml` exists, check `hooks.before_implement` and `hooks.after_implement` and execute registered hooks accordingly.
