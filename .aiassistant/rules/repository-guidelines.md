# JetBrains AI Assistant Project Rules

- This repository maintains shared AI workflows for Claude Code, Junie, Windsurf, and JetBrains AI Assistant project rules.
- Keep the 8 unified commands aligned across `.claude/skills/`, `.junie/commands/`, and `.windsurf/memories/commands-reference.md`.
- Junie custom slash commands live in `.junie/commands/*.md` and use `description` frontmatter only.
- Infer Junie command arguments from `$argumentName` placeholders in the prompt body; do not add `name` or `arguments` frontmatter.
- JetBrains AI Assistant Prompt Library prompts are configured manually in the IDE and are not loaded from `.junie/commands/`.
- Shared AI Assistant project guidance belongs in `.aiassistant/rules/*.md`.
- Reuse `.junie/guidelines.md` for technology-specific standards and `.junie/skills/global/SKILL.md` for general engineering principles.
- Git workflow rule: when work is on `main`, `master`, or `develop`, create a new branch with `git switch -c <branch-name>` before committing so local changes stay attached to that branch.
- Branch names should use `feature/`, `bugfix/`, `docs/`, or `chore/` as appropriate, and include a Bitbucket/Jira issue ID only when one is clearly available.
- After changing unified commands, run `powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1`.
- When Bash is available, also run `bash scripts/check-command-parity.sh`.