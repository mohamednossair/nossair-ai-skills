---
description: Create a conventional commit for the current changes.
---
Create a git commit for the current staged or unstaged changes.
1. Run `git status --short`, `git diff --stat`, `git diff --cached`, `git diff`, and `git branch --show-current` to analyze changes and the current branch.
2. If there is nothing to commit, say so and stop.
3. If the current branch is `main`, `master`, or `develop`, create and switch to a new work branch before staging or committing.
4. Choose the branch prefix from the change set: `feature/`, `bugfix/`, `docs/`, or `chore/`.
5. If a Bitbucket/Jira issue ID such as `SE-123` is clearly available, include it in the branch name; otherwise use a descriptive slug without an ID.
6. Create the branch with `git switch -c <branch-name>` so local uncommitted changes stay attached to the new branch.
7. Identify the primary commit type: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`.
8. Identify the scope from the most-changed module or directory.
9. Write the message in format: `type(scope): description`.
10. Rules: imperative mood, max 72 chars, no trailing period.
11. If changes are large, add a body with a short bullet-point summary of key changes.
12. Stage the intended files if needed, then run `git commit` with the generated message.
13. Output only the created commit hash and final commit message.
