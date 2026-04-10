---
name: git-commit
description: Generate a conventional commit message for current changes.
---
Generate a commit message for the current staged or unstaged changes.
1. Run `git diff --stat` and `git diff` to analyze changes.
2. Identify the primary type: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`.
3. Identify the scope from the most-changed module or directory.
4. Write the message in format: `type(scope): description`
5. Rules: imperative mood, max 72 chars, no trailing period.
6. If changes are large, add a body with bullet-point summary of key changes.
7. Output the complete commit command ready to run.
