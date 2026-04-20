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

1. Extract goals, non-goals, users, and constraints.
2. Capture success metrics and non-functional requirements (security, performance, availability, privacy).
3. Define acceptance criteria as bullet points, each verifiable.
4. Outline domain glossary, data model (entities, fields, IDs), and external/internal interfaces.
5. Note open questions (max 5) to resolve ambiguities.
6. Risks and assumptions (top 3) with mitigation or validation notes.
7. Keep it brief; link to `.windsurf/memories/*` and team standards where relevant.

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

1. Identify milestones (2–5), each outcome-oriented with a clear Definition of Done (DoD).
2. For each milestone, list key deliverables, primary risks, and validation method (demo, test, doc).
3. Map dependencies between milestones and on external teams/services; note critical path.
4. Assign tentative owners/skills needed (e.g., backend, frontend, DBA) if known.
5. Keep steps lean; avoid micro-tasks.

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

1. Create tasks grouped by milestone with stable IDs (e.g., M1-T1).
2. Order by dependencies; one owner per task if known.
3. Include acceptance criteria and Definition of Done (tests/docs/review) for each.
4. Add rough estimate (S/M/L) and risk flag where applicable.
5. Keep tasks concise; avoid repeating spec/plan text.

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

1. Build a traceability matrix: Spec ACs → Plan milestones → Tasks.
2. Validate NFR coverage (security, performance, availability, privacy) across plan/tasks.
3. Detect gaps: missing owners/estimates/DoD, orphan ACs/tasks, circular deps, unclear risks.
4. Flag hotspots: high-risk tasks without tests, critical-path slippage risk, ambiguous glossary.
5. Produce a concise report with prioritized fixes and suggested follow-up commands (`/speckit.clarify`, `/speckit.plan`, `/speckit.tasks`).
6. Optionally generate a review checklist with `/speckit.checklist` for critical areas.
```

## /speckit.checklist
```markdown
---
name: /speckit.checklist
---

**Usage**: `/speckit.checklist requirements="..."`

1. Turn requirements into short, verifiable checklist items.
2. Tag each with area: API, UI, Security, Perf, Data, Testing.
3. Keep to one line per check; avoid paragraphs.
4. Link to relevant skills or standards where helpful (e.g., `/java-review`, `/ts-review`, `/sql-review`).
5. Provide optional trace IDs to spec acceptance criteria or tasks (e.g., AC-3, M2-T4).
```

## /speckit.clarify
```markdown
---
name: /speckit.clarify
---

**Usage**: `/speckit.clarify context="path/to/spec-or-plan.md"`

1. Generate up to 5 concise, high-impact questions.
2. Cover these categories: scope, constraints, edge cases, data/glossary, interfaces, success metrics.
3. Avoid yes/no questions; prefer specific alternatives with trade-offs.
4. After answers, update spec/plan and re-run `/speckit.validate`.
```

## /speckit.implement
```markdown
---
name: /speckit.implement
---

**Usage**: `/speckit.implement tasks="path/to/tasks.md"`

1. Create an execution plan ordered by dependencies and risk.
2. Suggest branch strategy per milestone/task (feature/*, bugfix/*) consistent with repo rules.
3. For each task, propose: commit slices, test scaffolds (`/test-generate`), and review checkpoints (`/*-review`).
4. Track Definition of Done and link back to AC IDs for traceability.
5. Output a runbook with commands and checkpoints to execute safely.
```
