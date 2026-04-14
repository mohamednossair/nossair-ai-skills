---
description: Create a conventional commit
---

**Usage**: `/git-commit`

1. Analyze current changes with `git status --short`, `git diff --stat`, `git diff --cached`, `git diff`, and `git branch --show-current`.
2. If there is nothing to commit, say so and stop.
3. If the current branch is `main`, `master`, or `develop`, create and switch to a new work branch before staging or committing.
4. Choose the branch prefix from the change set: `feature/`, `bugfix/`, `docs/`, or `chore/`.
5. If a Bitbucket/Jira issue ID such as `SE-123` is clearly available, include it in the branch name; otherwise use a descriptive slug without an ID.
6. Create the branch with `git switch -c <branch-name>` so local uncommitted changes stay attached to the new branch.
7. Write message: `type(scope): description` (Conventional Commits).
8. Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`.
9. Rules: imperative mood, max 72 chars, no trailing period.
10. Stage the intended files if needed, then run `git commit`.
11. Output only the created commit hash and final commit message.
