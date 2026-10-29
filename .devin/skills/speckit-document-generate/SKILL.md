---
name: speckit-document-generate
description: Generate a lean 6-file AI-optimized Business Analysis set under docs/ba/<module>/ (AI index, facts JSON, code map, Mermaid graphs) — two-pass evidence-driven scanning, .work/ checkpoints with interactive/auto/resume modes, stable fact-ID lifecycle, confidence+evidence per fact, ownership markers for human edits, scoped terminology validation, COMPLETE/COMPLETE_WITH_GAPS/BLOCKED verdict
argument-hint: 'module="..." [project="..."] [parts="..."] [mode="interactive|auto|resume"]'
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
   - Windows: `.junie/scripts/powershell/check-prerequisites.ps1 -Json`
   - Linux/macOS: `.junie/scripts/bash/check-prerequisites.sh --json`
3. Token discipline: build output from the inline templates in the command file — do NOT read the example set under `docs/ba/` and do NOT read `.junie/guidelines.md` (the output is business language, not code).
4. Arguments: module="<module-name>" (required); project, parts, mode="interactive|auto|resume" (default interactive) optional
5. Output must include the embedded Mermaid graphs, `00-ai-index.md` (AI navigation layer), `99-facts.json` (machine-readable fact base), and `11-code-map.md` (file-to-business map) exactly as templated in the command file — these are what let agents learn and analyze the system with minimal token usage.
