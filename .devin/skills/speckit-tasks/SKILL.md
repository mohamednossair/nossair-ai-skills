---
name: speckit-tasks
description: Generate dependency-ordered tasks grouped by user story (T### [P] [US#] + all-fields-mandatory contract — Depends on/Covers/Capability/Estimate/Risk/Standards/Validate/Done when/Evidence — with an Expected result PASS|FAIL expectation contract; AC/NFR/TR coverage; test-first semantics; ends with a Task Generation Validation verdict)
argument-hint: 'plan="..."'
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

Run the **speckit.tasks** Speckit command.

1. Read and follow `.junie/commands/speckit.tasks.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `.junie/scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `.junie/scripts/bash/check-prerequisites.sh --json`
3. Token discipline: do NOT read `.junie/guidelines.md` or tech skill files just to produce the artifact — reference them by name (e.g., in the plan's `## Standards` section). Read one only if the artifact genuinely needs its standards detail.
4. Arguments: plan="<path/to/plan.md>" (optional)
