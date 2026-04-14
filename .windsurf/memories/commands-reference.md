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
1. Analyze current changes with `git status --short`, `git diff --stat`, `git diff --cached`, and `git diff`.
2. If there is nothing to commit, say so and stop.
3. Write message: `type(scope): description` (Conventional Commits).
4. Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `style`.
5. Rules: imperative mood, max 72 chars, no trailing period.
6. Stage the intended files if needed, then run `git commit`.
7. Output only the created commit hash and final commit message.

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

## /spec-validate
**Usage**: `/spec-validate`
1. Read all `.spec/` artifacts: `constitution.md`, `spec.md`, `plan.md`, `tasks/*.md`.
2. Check consistency, completeness, and token efficiency.
3. Flag: prose paragraphs, duplicate info, vague constraints, missing sections.
4. Output: [Critical] | [Warning] | [Suggestion] with fix for each.
