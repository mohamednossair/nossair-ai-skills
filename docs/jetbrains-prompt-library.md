# JetBrains AI Assistant Prompt Library (from .junie/commands)

Use this guide to configure JetBrains AI Assistant's Prompt Library so it mirrors the repo's Junie commands.

> **Source of truth:** `.junie/commands/*.md`. Do not copy command content into this file — it would drift. Import from the source files instead.

## How to Import a Prompt

For each command below:

1. Open the IDE: **Settings → Advanced Settings → AI Assistant → Enable Prompt Library** (or the Prompt Library action).
2. Create a new prompt with the **Title** listed below.
3. Paste the **full content** of the linked source file (including its `description` frontmatter — the IDE uses it as the prompt description).
4. Set a shortcut if desired.

## Prompts to Import

| Title | Source file | Purpose |
|-------|-------------|---------|
| `/review` | `.junie/commands/review.md` | Technical review report for a file using the relevant `.junie/skills/` standard |
| `/review-pr` | `.junie/commands/review-pr.md` | Multi-file PR/branch-diff review with merge recommendation |
| `/plan` | `.junie/commands/plan.md` | Numbered implementation plan with files, standards, skills, and Risk |
| `/test-generate` | `.junie/commands/test-generate.md` | Complete runnable tests (JUnit 5/Jest/pytest) with AAA pattern |
| `/git-commit` | `.junie/commands/git-commit.md` | Branch-then-commit workflow with Conventional Commits |
| `/speckit.specify` | `.junie/commands/speckit.specify.md` | Create/update a concise feature spec + spec-quality checklist |
| `/speckit.clarify` | `.junie/commands/speckit.clarify.md` | Up to 5 targeted questions; encode answers back into the spec |
| `/speckit.plan` | `.junie/commands/speckit.plan.md` | Milestones with DoD, research.md, data-model.md, contracts/ |
| `/speckit.tasks` | `.junie/commands/speckit.tasks.md` | Dependency-ordered tasks grouped by user story |
| `/speckit.analyze` | `.junie/commands/speckit.analyze.md` | Read-only analysis with CRITICAL/HIGH/MEDIUM/LOW severities |
| `/speckit.checklist` | `.junie/commands/speckit.checklist.md` | Domain requirement-quality checklists (unit tests for English) |
| `/speckit.implement` | `.junie/commands/speckit.implement.md` | Execute the plan with constitution governance and checklist gating |
| `/speckit.taskstoissues` | `.junie/commands/speckit.taskstoissues.md` | Convert tasks into GitHub issues (GitHub remote required) |
| `/speckit.document-generate` | `.junie/commands/speckit.document-generate.md` | Lean 6-file AI-optimized Business Analysis set under `docs/ba/<module>/` (AI index + facts JSON + code map + graphs) |
| `/speckit.test-generate` | `.junie/commands/speckit.test-generate.md` | Spec-linked unit tests with AC traceability annotations |

## Notes

- Junie command arguments are inferred from `$argumentName` placeholders in the prompt body (e.g., `$file`, `$task`); the Prompt Library uses the same convention.
- Prompt Library prompts are configured manually in the IDE and are not auto-loaded from `.junie/commands/`.
- After editing any command in `.junie/commands/`, re-import it here (or re-paste its content) to stay in sync.
- Run `powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1` (or the `.sh` variant) after changing unified command definitions.
