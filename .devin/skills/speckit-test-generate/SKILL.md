---
name: speckit-test-generate
description: Generate spec-linked unit tests (JUnit/Jest/pytest) with AC traceability annotations
argument-hint: 'file="..." [spec="..."] [ac="..."]'
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

Run the **speckit.test-generate** Speckit command.

1. Read and follow `.junie/commands/speckit.test-generate.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Apply the relevant technology standards from `.junie/skills/` (see `project-standards`) and `.junie/guidelines.md`.
4. Arguments: file="<path/to/source>"; spec and ac optional
