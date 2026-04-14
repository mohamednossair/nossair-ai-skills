---
description: Create a conventional commit
---

**Usage**: `/git-commit`

1. Analyze current changes with `git status --short`, `git diff --stat`, `git diff --cached`, and `git diff`.
2. If there is nothing to commit, say so and stop.
3. Write message: `type(scope): description` (Conventional Commits).
4. Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`.
5. Rules: imperative mood, max 72 chars, no trailing period.
6. Stage the intended files if needed, then run `git commit`.
7. Output only the created commit hash and final commit message.
