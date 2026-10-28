---
name: speckit-plan
description: Turn the spec into an outcome-oriented implementation plan with milestones, research, data model, and contracts
argument-hint: 'spec="..."'
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

Run the **speckit.plan** Speckit command.

1. Read and follow `.junie/commands/speckit.plan.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Apply the relevant technology standards from `.junie/skills/` (see `project-standards`) and `.junie/guidelines.md`.
4. Arguments: spec="<path/to/spec.md>" (optional)
