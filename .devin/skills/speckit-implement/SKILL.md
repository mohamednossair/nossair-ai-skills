---
name: speckit-implement
description: Execute the implementation plan with branch verification, checklist gating, and [X] task tracking
argument-hint: 'tasks="..."'
allowed-tools:
  - read
  - grep
  - glob
  - exec
  - edit
  - write
triggers:
  - user
  - model
---

Run the **speckit.implement** Speckit command.

1. Read and follow `.junie/commands/speckit.implement.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Apply the relevant technology standards from `.junie/skills/` (see `project-standards`) and `.junie/guidelines.md`.
4. Arguments: tasks="<path/to/tasks.md>" (optional)
