---
description: Generate a conventional commit message
---

**Usage**: `/git-commit`

1. Analyze current changes with `git diff --stat` and `git diff`.
2. Write message: `type(scope): description` (Conventional Commits).
3. Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`.
4. Rules: imperative mood, max 72 chars, no trailing period.
5. Output only the commit message text.
