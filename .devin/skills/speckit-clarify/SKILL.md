---
name: speckit-clarify
description: Ask up to 5 targeted questions to resolve spec ambiguities and encode answers back into the spec
argument-hint: 'context="..."'
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

Run the **speckit.clarify** Speckit command.

1. Read and follow `.junie/commands/speckit.clarify.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Apply the relevant technology standards from `.junie/skills/` (see `project-standards`) and `.junie/guidelines.md`.
4. Arguments: context="<path/to/spec.md>" (optional)
