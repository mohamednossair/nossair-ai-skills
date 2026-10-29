---
name: speckit-clarify
description: Ask up to 5 targeted questions to resolve spec or plan ambiguities; preview-first mutation safety
argument-hint: '[spec="..."] [plan="..."] [mode="spec|plan"] [apply="preview|apply"]'
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
   - Windows: `.junie/scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `.junie/scripts/bash/check-prerequisites.sh --json`
3. Token discipline: do NOT read `.junie/guidelines.md` or tech skill files just to produce the artifact — reference them by name (e.g., in the plan's `## Standards` section). Read one only if the artifact genuinely needs its standards detail.
4. Arguments: spec="<path/to/spec.md>", plan="<path/to/plan.md>", mode="spec|plan" (default spec), apply="preview|apply" (default preview — never modify files in preview mode); context="<path>" is still accepted and infers the mode
