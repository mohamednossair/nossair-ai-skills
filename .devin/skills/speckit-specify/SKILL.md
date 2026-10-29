---
name: speckit-specify
description: Create or update a concise feature spec (modes draft/feature/refine — draft skips branching) and persist .specify/feature.json; ends with a ## Specification Status block (draft → ready-for-clarification → ready-for-planning)
argument-hint: 'feature="..." [mode="draft|feature|refine"] [current_state="..."]'
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
3. Token discipline: do NOT read `.junie/guidelines.md` or tech skill files just to produce the artifact — reference them by name (e.g., in the plan's `## Standards` section). Read one only if the artifact genuinely needs its standards detail.
4. Arguments: feature="<feature description>"
