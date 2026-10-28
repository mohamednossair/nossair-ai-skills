---
name: speckit-document-generate
description: Generate the 11-file Business Analysis document set under docs/ba/<module>/ from the codebase
argument-hint: 'module="..." [project="..."] [parts="..."]'
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

Run the **speckit.document-generate** Speckit command.

1. Read and follow `.junie/commands/speckit.document-generate.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Apply the relevant technology standards from `.junie/skills/` (see `project-standards`) and `.junie/guidelines.md`.
4. Arguments: module="<module-name>"; project and parts optional
