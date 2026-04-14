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

## /spec-init
**Usage**: `/spec-init`
1. Analyze the current workspace first: detect modules, apps, libraries, or sibling repositories and infer each role.
2. Summarize the detected repository/module map and ask the user to confirm or correct it.
3. Ask targeted follow-up questions for repository/module rules, boundaries, forbidden changes, integration points, and best practices.
4. If repository roles or rules are still unclear, stop and wait for the user's answers — do not invent them.
5. Create `.spec/` directory with `tasks/` subdirectory after discovery is complete.
6. Generate `constitution.md` with Tech Stack, Workspace Map, Module Selection Rules, Rules, and Testing.
7. Generate `spec.md` template (Goal, Non-Goals, Requirements, Acceptance Criteria).
8. Generate `plan.md` template (Architecture, Data Model, Implementation Steps).
9. Generate `tasks/01-example.md` (Context, Deliverables, Constraints - max 20 lines).

## /spec-plan
**Usage**: `/spec-plan task="Describe the feature"`
1. Read `.spec/constitution.md` and `.spec/spec.md`.
2. Generate or update `plan.md` (Architecture, Data Model, Steps - max 40 lines).
3. Break into atomic task files in `.spec/tasks/` (max 20 lines each).
4. Each task: Context, Deliverables, Constraints - self-contained for one AI prompt.
5. Validate every spec requirement is covered by at least one task.
6. Output a coverage matrix: requirement -> task mapping.
7. Coverage matrix: requirement -> task mapping

## /spec-implement
**Usage**: `/spec-implement task=".spec/tasks/01-setup.md"`
1. Read `.spec/constitution.md` and the task file referenced by `$task`.
2. Read `.spec/plan.md` only if task references need extra context.
3. Read `.spec/spec.md` only when the task file is ambiguous or incomplete.
4. If `$task` is missing or unclear, stop and ask the user instead of guessing.
5. Implement only the selected task's deliverables and constraints.
6. Respect module boundaries and routing rules from `constitution.md`.
7. Run the smallest relevant build or tests needed to verify the changed files.
8. Output: Completed deliverables, Changed files, Tests run and results, Remaining blockers or follow-up tasks.

## /spec-validate
**Usage**: `/spec-validate`
1. Read all `.spec/` artifacts: `constitution.md`, `spec.md`, `plan.md`, `tasks/*.md`.
2. Check consistency, completeness, and token efficiency.
3. Flag: prose paragraphs, duplicate info, vague constraints, missing sections.
4. Output: [Critical] | [Warning] | [Suggestion] with fix for each.
