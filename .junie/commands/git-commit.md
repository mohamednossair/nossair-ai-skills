---
description: Create a conventional commit for the current changes.
---
Create a git commit for the current staged or unstaged changes.
1. Run `git status --short`, `git diff --stat`, `git diff --cached`, and `git diff` to analyze changes.
2. If there is nothing to commit, say so and stop.
3. Identify the primary type: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`.
4. Identify the scope from the most-changed module or directory.
5. Write the message in format: `type(scope): description`.
6. Rules: imperative mood, max 72 chars, no trailing period.
7. If changes are large, add a body with a short bullet-point summary of key changes.
8. Stage the intended files if needed, then run `git commit` with the generated message.
9. Output only the created commit hash and final commit message.
