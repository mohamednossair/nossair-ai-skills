# JetBrains AI Assistant Prompt Library (Mirror of .junie/commands)

Use these prompts to configure JetBrains AI Assistant's Prompt Library so it mirrors the repo's Junie commands. For each entry:
- Title: use the command name (e.g., `/plan`)
- Content: copy the Markdown block

## /git-commit
```markdown
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
```

## /plan
```markdown
---
description: Create a detailed plan for a task or issue.
---
Analyze the following task: $task.
1. Break down the task into logical, actionable steps.
2. For each step, identify which files need to be modified or created.
3. Identify applicable coding standards and patterns.
4. Identify which skills from `.junie/skills/` are relevant and should be used during implementation.
5. Estimate complexity and flag risks.
6. Format the final output as a numbered plan with:
   - **Step N**: [Action]
   - Files: [list]
   - Standards: [applicable rules]
   - Skills: [relevant skills]
   - Risk: [if any]
```

## /review
```markdown
---
description: Review code in a file using the relevant skill and guidelines.
---
Review the code in $file.
1. Identify the technology used (Java, TypeScript, Python, etc.) from the file extension.
2. Read the relevant skill from `.junie/skills/<tech>/SKILL.md` and the project guidelines in `.junie/guidelines.md`.
3. Analyze the code against the principles, guidelines, and checklist from the skill.
4. Provide findings grouped by severity: [Critical] | [Warning] | [Suggestion].
5. For each finding, include:
   - **Location**: [File:line]
   - **Issue**: [What is wrong]
   - **Why**: [Impact: security, performance, maintainability]
   - **Fix**: [Concrete correction or snippet]
```

## /test-generate
```markdown
---
description: Generate unit tests for provided code using the appropriate testing framework.
---
Generate tests for $file.
1. Identify the technology from the file extension.
2. Read the relevant skill from `.junie/skills/<tech>/SKILL.md` and guidelines in `.junie/guidelines.md`.
3. Choose the correct framework: JUnit 5 + AssertJ (Java), Jest (TypeScript/Angular), pytest (Python).
4. Apply AAA pattern (Arrange, Act, Assert) for all tests.
5. Name tests: `should<Behavior>_when<Condition>`.
6. Cover: happy path, edge cases, error paths.
7. Use mocks/spies only for external dependencies - test real behavior.
8. Output the complete test file ready to save.
```

## /speckit.specify
```markdown
---
name: /speckit.specify
---

**Usage**: `/speckit.specify feature="..."`

1. Generate a short feature name (2–4 words, action-noun format, e.g. `user-auth`).
2. Create the spec directory under `specs/` (e.g. `specs/NNN-short-name`) and persist the path to `.specify/feature.json` so downstream commands can locate it.
3. Extract goals, non-goals, users, and constraints.
4. Capture success metrics and non-functional requirements (security, performance, availability, privacy).
5. Define acceptance criteria as bullet points, each verifiable.
6. Outline domain glossary, data model (entities, fields, IDs), and external/internal interfaces.
7. Note open questions with `[NEEDS CLARIFICATION]` markers — max 3 total. Use only for decisions that significantly impact scope, security, or UX.
8. After writing the spec, run **spec-quality validation**: create `specs/<dir>/checklists/requirements.md` and check for testable criteria, measurable success metrics, and no implementation leaks. Iterate up to 3 times if items fail.
9. Risks and assumptions (top 3) with mitigation or validation notes.
10. Keep it brief; link to `.windsurf/memories/*` and team standards where relevant.

Follow-ups:
- Run `/speckit.clarify` to resolve open questions.
- Run `/speckit.plan` to convert this spec into milestones.
- Use tech reviews after drafting: `/java-review`, `/ts-review`, `/sql-review`, `/maven-help` as applicable.

Git Branching (before writing files):
- Prompt for a branch name and create/switch to it. Recommend:
  - `feature/spec/<id>-<short-slug>` for new specs
  - `chore/spec/<id>-<short-slug>` for refinements
- If an ID exists (Jira/issue), include it. Otherwise, generate a short slug from the feature description.
- Examples: `feature/spec/SE-123-auth-refresh`, `feature/spec/auth-refresh`.
- Ensure alignment with repo rules from `/.junie/skills/git/`.
```

## /speckit.plan
```markdown
---
name: /speckit.plan
---

**Usage**: `/speckit.plan spec="path/to/spec.md"`

1. Locate the active feature via `.specify/feature.json` or the provided spec path.
2. Read `/memory/constitution.md` and cross-check against the spec — flag MUST-principle violations before planning.
3. Identify milestones (2–5), each outcome-oriented with a clear Definition of Done (DoD).
4. For each milestone, list key deliverables, primary risks, and validation method (demo, test, doc).
5. Map dependencies between milestones and on external teams/services; note critical path.
6. Assign tentative owners/skills needed (e.g., backend, frontend, DBA) if known.
7. Phase 0 — Generate `research.md` to resolve any `[NEEDS CLARIFICATION]` markers.
8. Phase 1 — Generate `data-model.md`, `contracts/` (API/interface specs), and `quickstart.md`.
9. Keep steps lean; avoid micro-tasks.

Follow-ups:
- Run `/speckit.tasks` to expand milestones into dependency-ordered tasks.
- Trigger repo review early with `/git-review` to align on branch/commit strategy.
```

## /speckit.tasks
```markdown
---
name: /speckit.tasks
---

**Usage**: `/speckit.tasks plan="path/to/plan.md"`

1. Locate the active feature via `.specify/feature.json` or the provided plan path.
2. Load `plan.md` (tech stack, structure) and `spec.md` (user stories with priorities P1, P2, P3...).
3. Organize tasks by user story — each story becomes its own phase. Map models, services, and interfaces to the story that needs them.
4. Use the strict checklist format for every task:
   ```
   - [ ] T001 [P] [US1] Description with exact file path
   ```
   - `T###` — sequential task ID
   - `[P]` — include ONLY if the task can run in parallel (different files, no incomplete dependencies)
   - `[US#]` — required for user-story phases (omit for Setup, Foundational, and Polish)
5. Phase 1: Setup (project initialization). Phase 2: Foundational (blocking prerequisites). Phase 3+: One phase per user story in priority order. Final phase: Polish & cross-cutting concerns.
6. Include acceptance criteria and Definition of Done (tests/docs/review) for each.
7. Add rough estimate (S/M/L) and risk flag where applicable.
8. Keep tasks concise; avoid repeating spec/plan text.

Follow-ups:
- Generate tests with `/test-generate` after tasks with testing DoD are identified.
- Use tech reviewers: `/java-review`, `/ts-review`, `/sql-review` for risky or core tasks.
```

## /speckit.validate
```markdown
---
name: /speckit.validate
---

**Usage**: `/speckit.validate spec="..." plan="..." tasks="..."`

1. Check alignment of goals and acceptance criteria across artifacts; ensure each acceptance criterion traces to a milestone and tasks.
2. Verify non-functional requirements (security, performance, availability, privacy) have corresponding plan/tasks.
3. Flag missing dependencies, owners, estimates, or unclear DoD.
4. Identify ambiguous or conflicting requirements and surface assumptions.
5. Output gaps with suggested fixes or clarifying questions; consider running `/speckit.clarify`.
6. Generate a short review guide with `/speckit.checklist` for critical areas.
```

## /speckit.analyze
```markdown
---
name: /speckit.analyze
---

**Usage**: `/speckit.analyze spec="..." plan="..." tasks="..."`

1. **STRICTLY READ-ONLY** — Do not modify any files. Output a structured Markdown report only.
2. Build a traceability matrix: Spec ACs → Plan milestones → Tasks.
3. Validate NFR coverage (security, performance, availability, privacy) across plan/tasks.
4. **Constitution alignment** — Load `/memory/constitution.md` and flag MUST-principle violations as **CRITICAL**.
5. Detect gaps: missing owners/estimates/DoD, orphan ACs/tasks, circular deps, unclear risks.
6. Flag hotspots: high-risk tasks without tests, critical-path slippage risk, ambiguous glossary.
7. **Severity assignment** — Classify each finding:
   - **CRITICAL**: Constitution MUST violation, missing core artifact, or zero-coverage requirement blocking baseline functionality.
   - **HIGH**: Duplicate/conflicting requirement, ambiguous security/performance attribute, untestable acceptance criterion.
   - **MEDIUM**: Terminology drift, missing non-functional task coverage, underspecified edge case.
   - **LOW**: Style/wording improvements, minor redundancy.
8. Produce a concise report (max 50 findings; summarize overflow) with prioritized fixes and suggested follow-up commands (`/speckit.clarify`, `/speckit.plan`, `/speckit.tasks`).
9. Optionally generate a review checklist with `/speckit.checklist` for critical areas.
```

## /speckit.checklist
```markdown
---
name: /speckit.checklist
---

**Usage**: `/speckit.checklist domain="ux|api|security|performance|..."`

> **Core concept**: Checklists are **unit tests for requirements writing** — they validate the quality, clarity, and completeness of requirements, NOT the implementation.

1. Derive up to 3 clarifying questions from the user's phrasing + spec/plan context to calibrate scope, depth, and risk emphasis.
2. Create `checklists/<domain>.md` under the feature directory (append if it exists). Use globally incrementing IDs: `CHK001`, `CHK002`, etc.
3. Write checklist items that test the **requirements themselves** for:
   - **Completeness** — Are all necessary requirements present?
   - **Clarity** — Are they unambiguous and specific?
   - **Consistency** — Do they align without conflicts?
   - **Measurability** — Can they be objectively verified?
   - **Coverage** — Are all scenarios/edge cases addressed?
4. Use question format, not verification format:
   - ✅ CORRECT: `"Are error response formats specified for all failure scenarios? [Completeness]`"
   - ❌ WRONG: `"Verify the API returns 400 on bad input"`
5. Tag each item with its quality dimension and traceability reference (e.g., `[Clarity, Spec §FR-2]` or `[Gap]`).
6. Link to relevant skills or standards where helpful (e.g., `/java-review`, `/ts-review`, `/sql-review`).
7. Keep to one line per check; avoid paragraphs. Soft cap at ~40 items; merge near-duplicates.
```

## /speckit.clarify
```markdown
---
name: /speckit.clarify
---

**Usage**: `/speckit.clarify context="path/to/spec-or-plan.md"`

1. Scan the spec against a structured taxonomy: Functional Scope, Domain & Data Model, Interaction & UX, Non-Functional Attributes, Integration & Dependencies, Edge Cases, Constraints, Terminology, and Acceptance Criteria.
2. Generate a prioritized queue of max 5 questions. Only ask questions whose answers materially impact architecture, data modeling, task decomposition, test design, UX behavior, or compliance.
3. Present **one question at a time** with a **recommended option** based on best practices and project context. Format options as a compact Markdown table.
4. Accept short answers (<= 5 words) or option letters. The user may reply `yes` / `recommended` / `suggested` to accept your recommendation.
5. After each accepted answer, incrementally update the spec:
   - Ensure a `## Clarifications` section exists with a `### Session YYYY-MM-DD` subheading.
   - Append `- Q: <question> → A: <answer>`.
   - Apply the clarification to the most appropriate section (Functional Requirements, User Stories, Data Model, Success Criteria, Edge Cases).
   - Save the spec file after each integration to minimize context-loss risk.
6. Validate: total asked questions ≤ 5, no lingering vague placeholders remain, no contradictory statements, terminology is consistent.
7. After all answers, re-run `/speckit.validate`.
```

## /speckit.implement
```markdown
---
name: /speckit.implement
---

**Usage**: `/speckit.implement tasks="path/to/tasks.md"`

1. **Checklist gate** — Scan `checklists/` under the feature directory. If any checklist has incomplete items, display a status table and ask whether to proceed before continuing.
2. **Load governance context** — Read `/memory/constitution.md` and enforce MUST principles during implementation.
3. **Project-setup verification** — Detect the tech stack from `plan.md` and create/verify ignore files (`.gitignore`, `.dockerignore`, `.eslintignore`, `.prettierignore`, etc.) with essential patterns for the detected technology.
4. **Parse tasks.md** — Extract phases (Setup, Tests, Core, Integration, Polish), task IDs, parallel markers `[P]`, and dependencies.
5. **Execute phase-by-phase**:
   - Respect dependencies: sequential tasks in order, parallel `[P]` tasks together.
   - Follow TDD: test tasks before their corresponding implementation tasks.
   - File-based coordination: tasks touching the same files must run sequentially.
   - Mark completed tasks as `[X]` in `tasks.md`.
6. Suggest branch strategy per milestone/task (feature/*, bugfix/*) consistent with repo rules.
7. For each task, propose: commit slices, test scaffolds (`/test-generate`), and review checkpoints (`/*-review`).
8. Track Definition of Done and link back to AC IDs for traceability.
9. Output a runbook with commands and checkpoints to execute safely.
10. **Extension hooks** — If `.specify/extensions.yml` exists, check `hooks.before_implement` and `hooks.after_implement` and execute registered hooks accordingly.
```

## /speckit.taskstoissues
```markdown
---
name: /speckit.taskstoissues
---

**Usage**: `/speckit.taskstoissues tasks="path/to/tasks.md"`

1. Locate the active feature via `.specify/feature.json` or the provided tasks path.
2. Get the Git remote by running `git config --get remote.origin.url`.
3. **CAUTION**: Only proceed if the remote is a GitHub URL. Under no circumstances create issues in repositories that do not match the remote URL.
4. For each task in `tasks.md`, create a GitHub issue with:
   - Title derived from the task description
   - Labels mapped from story tags (`US1`, `US2`, etc.) and phase (Setup, Core, Polish)
   - Body including: task ID, acceptance criteria, definition of done, file paths, and dependencies
5. Respect parallel markers `[P]` by grouping independent tasks into the same milestone/issue epic where appropriate.
6. Report: total issues created, issue numbers, and any tasks skipped (e.g., already completed `[X]`).

> **Prerequisite**: The `github/github-mcp-server/issue_write` tool must be available, or use the GitHub CLI (`gh issue create`).
```
