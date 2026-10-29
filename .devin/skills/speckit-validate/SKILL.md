---
name: speckit-validate
description: Compatibility alias for /speckit-analyze mode=pre — returns the same traceability matrix, findings, severities, semantic coverage statuses, and mutually exclusive verdict from the canonical analysis engine
argument-hint: '[spec="..."] [plan="..."] [tasks="..."] [current_state="..."]'
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

Run the **speckit.validate** Speckit command.

1. Read and follow `.junie/commands/speckit.validate.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `scripts/bash/check-prerequisites.sh --json`
3. Token discipline: do NOT read `.junie/guidelines.md` or tech skill files just to produce the artifact — reference them by name (e.g., in the plan's `## Standards` section). Read one only if the artifact genuinely needs its standards detail.
4. Arguments: all optional; defaults from feature.json
