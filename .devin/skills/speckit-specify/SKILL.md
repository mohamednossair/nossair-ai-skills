---
name: speckit-specify
description: Create or update a concise feature spec, create the feature branch, and persist .specify/feature.json
argument-hint: 'feature="..."'
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

Run the **speckit.specify** Speckit command.

1. Read and follow `.junie/commands/speckit.specify.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Apply the relevant technology standards from `.junie/skills/` (see `project-standards`) and `.junie/guidelines.md`.
4. Arguments: feature="<feature description>"
