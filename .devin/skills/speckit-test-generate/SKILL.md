---
name: speckit-test-generate
description: Canonical spec-linked test generator — task linkage preferred (auto-select single candidate, ambiguity error on many), spec never auto-discovered with allow_unlinked=true, AC scoping by target-symbol mapping (never all ACs), validates AC IDs (BLOCKED on invalid), repo-first framework resolution with no unapproved dependency adds, existing-test inspection, risk-based case selection, expected-red generation, action=preview|write with atomic rollback, run_tests=false by default, ends with a Test Traceability summary
argument-hint: 'file="..." [spec="..."] [plan="..."] [tasks="..."] [task="T012"] [ac="..."] [action="preview|write"] [allow_unlinked="false|true"] [run_tests="false|true"]'
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
3. Token discipline: read only the single `.junie/skills/<tech>/SKILL.md` matching the file's technology; skip `.junie/guidelines.md` unless that skill requires it.
4. Arguments: file="<path/to/source>" (required); spec, plan, tasks, task, ac, action="preview|write" (default preview), allow_unlinked="false|true" (default false), run_tests="false|true" (default false) optional
