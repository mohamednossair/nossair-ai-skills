# Unified AI Commands Reference

These commands are consistent across all AI agents (Claude Code, Junie, Windsurf).
When the user invokes any of these commands, follow the instructions exactly.

---

## /review
**Usage**: `/review file="path/to/file"`
1. Identify the technology from the file extension.
2. Apply coding standards from `coding-standards.md` and `tech-stack.md`.
3. Analyze: correctness, security, performance, readability, SOLID/DRY.
4. Output findings grouped by: [Critical] | [Warning] | [Suggestion]
   - **Location**: [File:line]
   - **Issue**: [What is wrong]
   - **Why**: [Impact]
   - **Fix**: [Corrected code]

## /plan
**Usage**: `/plan task="Describe your task"`
1. Break the task into logical, actionable steps.
2. For each step, identify files to create or modify.
3. Identify applicable coding standards and patterns.
4. Estimate complexity and flag Risk per step.
5. Output a numbered plan with files, standards, and Risk per step.

## /test-generate
**Usage**: `/test-generate file="path/to/file"`
1. Identify the technology from the file extension.
2. Choose framework: JUnit 5 + AssertJ (Java), Jest (TypeScript/Angular), pytest (Python).
3. Apply AAA pattern. Name tests: `should<Behavior>_when<Condition>`.
4. Cover: happy path, edge cases, error paths.
5. Output the complete test file.

## /git-commit
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
