---
name: speckit-plan
description: Turn the spec into an outcome-oriented implementation plan with milestones, research, technical data model, contracts, a machine-readable ## Standards section (with parse validation), TR-### technical requirements, and a ## Planning Result verdict (READY | READY_WITH_WARNINGS | BLOCKED)
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
3. Token discipline: do NOT read `.junie/guidelines.md` or tech skill files just to produce the artifact — reference them by name (e.g., in the plan's `## Standards` section). Read one only if the artifact genuinely needs its standards detail.
4. Arguments: spec="<path/to/spec.md>" (optional)
