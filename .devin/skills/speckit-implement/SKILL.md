---
name: speckit-implement
description: Execute the plan — mode=plan dry-run runbook (default) or mode=execute gated execution; selectors task_ids/phase/resume/checkpoint
argument-hint: '[tasks="..."] [mode="plan|execute"] [task_ids="..."] [phase="..."] [resume="true|false"] [checkpoint="phase|failure|none"]'
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

Run the **speckit.implement** Speckit command.

1. Read and follow `.junie/commands/speckit.implement.md` exactly — it is the source of truth for all agents.
2. Start with the prerequisite checker (Step 1 of the command):
   - Windows: `.junie/scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `.junie/scripts/bash/check-prerequisites.sh --json`
3. Token discipline: read ONLY the `.junie/skills/<tech>/SKILL.md` files listed in the plan's `## Standards` section; skip `.junie/guidelines.md` unless a listed standard requires it.
4. Arguments: tasks="<path/to/tasks.md>", mode="plan|execute" (default plan — read-only, never write in plan mode), task_ids="T012,T013", phase="Foundational", resume="true|false", checkpoint="phase|failure|none" (all optional)
