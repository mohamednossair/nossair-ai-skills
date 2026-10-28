---
name: speckit-analyze
description: Read-only cross-artifact analysis with CRITICAL/HIGH/MEDIUM/LOW severities and constitution alignment
argument-hint: 'spec="..." plan="..." tasks="..."'
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

Run the **speckit.analyze** Speckit command.

1. Read and follow `.junie/commands/speckit.analyze.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Apply the relevant technology standards from `.junie/skills/` (see `project-standards`) and `.junie/guidelines.md`.
4. Arguments: all optional; defaults from feature.json
