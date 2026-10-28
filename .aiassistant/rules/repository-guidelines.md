---
apply: always
---

# JetBrains AI Assistant Project Rules

- This repository maintains shared AI workflows for Junie, JetBrains AI Assistant (AIR), and Devin.
- Single source of truth for technology standards: `.junie/skills/<tech>/SKILL.md` plus `.junie/guidelines.md`.
- Keep the 5 unified commands (`/review`, `/review-pr`, `/plan`, `/test-generate`, `/git-commit`) aligned across `.junie/commands/`, `.aiassistant/rules/project-rules.md`, and `.devin/skills/`.
- Junie custom slash commands live in `.junie/commands/*.md` and use `description` frontmatter only.
- Infer Junie command arguments from `$argumentName` placeholders in the prompt body; do not add `name` or `arguments` frontmatter.
- Devin skills live in `.devin/skills/<name>/SKILL.md` and may use `name`, `description`, `argument-hint`, `allowed-tools`, and `triggers` frontmatter.
- JetBrains AI Assistant Prompt Library prompts are configured manually in the IDE and are not loaded from `.junie/commands/`.
- Shared AI Assistant project guidance belongs in `.aiassistant/rules/*.md`.
- Git workflow rule: when work is on `main`, `master`, or `develop`, create a new branch with `git switch -c <branch-name>` before committing so local changes stay attached to that branch.
- Branch names should use `feature/`, `bugfix/`, `docs/`, or `chore/` as appropriate, and include a Bitbucket/Jira issue ID only when one is clearly available.
- After changing unified commands, run `powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1`.
- When Bash is available, also run `bash scripts/check-command-parity.sh`.