---
name: speckit-analyze
description: Read-only cross-artifact analysis with severities and a PASS/PASS_WITH_WARNINGS/BLOCKED verdict
argument-hint: '[spec="..."] [plan="..."] [tasks="..."] [current_state="..."] [mode="pre|post-implementation"] [base_ref="main"] [test_report="..."]'
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
   - Windows: `.junie/scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `.junie/scripts/bash/check-prerequisites.sh --json`
3. Token discipline: do NOT read `.junie/guidelines.md` or tech skill files just to produce the artifact — reference them by name (e.g., in the plan's `## Standards` section). Read one only if the artifact genuinely needs its standards detail.
4. Arguments: all optional; defaults from feature.json
