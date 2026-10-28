# nossair-ai-skills

Centralized repository for AI agent skills across **Junie**, **JetBrains AI Assistant (AIR)**, and **Devin**.
Single source of truth: add a skill once in `.junie/skills/`, reference it everywhere.

## Tech Stack Covered
Global, Java 21+, Spring Boot 3.2+, TypeScript, Python, Angular 20+, Maven, Git, Oracle, MySQL, JUnit, Jest, Security (OWASP/Spring Security), Performance, Accessibility, Speckit

---

## Project Structure

```
nossair-ai-skills/
|-- .junie/                <- Junie Agent Skills and commands
|   |-- skills/            <- SOURCE OF TRUTH: detailed skill folders per technology
|   |   `-- <tech>/SKILL.md
|   |-- commands/          <- Junie custom slash commands (unified + speckit)
|   `-- guidelines.md      <- Project-wide coding standards (one-page summary)
|-- .aiassistant/rules/    <- JetBrains AI Assistant (AIR) project rules
|-- .devin/skills/         <- Devin skills (unified commands + standards loader)
|-- templates/             <- Templates for new skills and commands
|-- scripts/               <- Helper scripts (install, parity check, scaffolding)
`-- docs/                  <- Guides and documentation
```

For detailed agent-specific usage, see [AGENTS.md](./AGENTS.md).

---

## Setup: Deploy Skills to Your Agents

### Quick Start (Recommended)
Install Junie, AI Assistant, and Devin project files in one command:

**Linux/macOS:**
```bash
bash scripts/install.sh /your-project-root/
```
**Windows (PowerShell):**
```powershell
.\scripts\install.ps1 C:\your-project-root\
```

### Junie (per project)
```bash
cp -r .junie /your-project/          # Linux/macOS
```
```powershell
Copy-Item -Path .junie -Destination C:\your-project\ -Recurse   # Windows
```

### JetBrains AI Assistant (per project)
```bash
cp -r .aiassistant /your-project/    # Linux/macOS
```
```powershell
Copy-Item -Path .aiassistant -Destination C:\your-project\ -Recurse   # Windows
```

> Note: `.aiassistant/rules/` provides shareable project rules for JetBrains AI Assistant. Prompt Library shortcuts are managed manually inside the IDE.

### Devin (per project)
```bash
cp -r .devin /your-project/          # Linux/macOS
```
```powershell
Copy-Item -Path .devin -Destination C:\your-project\ -Recurse   # Windows
```

> Note: Devin picks up `.devin/skills/` automatically (also available as `/review`, `/plan`, `/test-generate`, `/git-commit`, `/project-standards`). Devin additionally reads `AGENTS.md` at the repo root.

---

## Unified Commands (Same on All Agents)

All commands work the same way across Junie, AIR, and Devin.

| Command | Description | Usage |
|---------|-------------|-------|
| `/review` | Review code using relevant tech skill and guidelines | `/review file="src/App.java"` |
| `/review-pr` | Review a PR or branch diff (multi-file) with merge recommendation | `/review-pr main` |
| `/plan` | Create a detailed implementation plan for a task | `/plan task="Add user auth"` |
| `/test-generate` | Generate unit tests (JUnit/Jest/pytest) | `/test-generate file="src/Service.java"` |
| `/git-commit` | Create a work branch if needed, then a conventional commit for current changes | `/git-commit` |

Git workflow note:
- `/git-commit` should create a dedicated branch with `git switch -c <branch-name>` when invoked from `main`, `master`, or `develop`.
- Branch names should use `feature/`, `bugfix/`, `docs/`, or `chore/`, and include a Bitbucket/Jira issue ID only when one is clearly available.

### Cross-Agent Workflow (plan with one tool, implement with another)

Speckit artifacts are plain Markdown tracked in `.specify/feature.json` — any agent can continue the chain at any stage:

```
/speckit-specify ──► feature branch (feature/spec/<id>-<slug>) + specs/NNN-<name>/spec.md
/speckit-clarify ──► answers encoded back into spec.md
/speckit-plan    ──► plan.md (+ research.md, data-model.md, contracts/, quickstart.md)
                      plan.md includes a "## Standards" section listing the .junie/skills/ files
/speckit-tasks   ──► tasks.md (T### [P] [US#] checklist format)
/speckit-validate or /speckit-analyze ──► cross-artifact consistency report
/speckit-implement ──► verifies feature branch, loads plan Standards, executes tasks, marks [X]
/test-generate + /review + /review-pr ──► tests and reviews before merge
/speckit-taskstoissues ──► GitHub issues from tasks.md (GitHub remote required)
```

- Every command starts by running the prerequisite checker (`scripts/powershell/check-prerequisites.ps1 -Json` or `scripts/bash/check-prerequisites.sh --json`), which auto-locates the active feature.
- To hand off: plan with Junie, implement with Devin (`/speckit-implement`) or AIR — the implementing agent reads `.specify/feature.json`, the plan's `## Standards` section, and the listed `.junie/skills/` files.

### Speckit Toolkit (Spec → Plan → Tasks → Validate/Analyze → Implement)

Available as Junie commands (and usable from Devin/AIR by following `.junie/commands/`). In Devin, each subcommand is also an individual skill: `/speckit-specify`, `/speckit-clarify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-validate`, `/speckit-analyze`, `/speckit-checklist`, `/speckit-implement`, `/speckit-taskstoissues`, `/speckit-document-generate`, `/speckit-test-generate` (plus the `/speckit` orchestrator that lists them).

> Note: Devin skill identifiers allow only lowercase letters, digits, and hyphens — dots are rejected, so Devin subcommands are hyphenated (`/speckit-specify`). Junie/AIR keep the dotted `.junie/commands/speckit.<name>.md` files.
- `/speckit-specify feature="..."` — generates a short name, creates `specs/NNN-short-name/`, persists to `.specify/feature.json`, and produces a spec-quality checklist.
- `/speckit-clarify context="..."` — scans the spec against a structured taxonomy and asks up to 5 targeted questions with recommended answers, encoding responses back into the spec.
- `/speckit-plan spec="..."` — loads `.specify/feature.json`, cross-checks the constitution, generates `research.md`, `data-model.md`, and `contracts/`, then produces milestones with DoD.
- `/speckit-tasks plan="..."` — loads `.specify/feature.json`, organizes tasks by user story (P1, P2...), supports parallel markers `[P]`, and uses the strict checklist format (`T### [P] [US#]`).
- `/speckit-validate spec="..." plan="..." tasks="..."` — cross-artifact checks and traceability.
- `/speckit-analyze spec="..." plan="..." tasks="..."` — read-only cross-artifact analysis with severity assignment (CRITICAL / HIGH / MEDIUM / LOW) and constitution alignment checks.
- `/speckit-checklist domain="ux|api|security|..."` — generates domain-specific requirement-quality checklists (unit tests for English) under `checklists/<domain>.md`.
- `/speckit-implement tasks="..."` — executes the plan with constitution governance, checklist gating, project-setup verification (ignore files), and `[X]` task completion tracking.
- `/speckit-taskstoissues tasks="..."` — converts tasks into actionable GitHub issues (requires a GitHub remote).
- `/speckit-document-generate module="..." [project="..."] [parts="..."]` — generate an 11-file Business Analysis document set under `docs/ba/<module>/` (README + `01-overview` through `10-technical-map`). Always unified — treats all sub-projects as one system.
- `/speckit-test-generate file="..." [spec="..."] [ac="AC-1,AC-2"]` — generate spec-linked unit tests (JUnit/Jest/pytest) with AC traceability annotations.

### Prerequisite Scripts

Speckit commands can auto-locate the active feature directory and verify artifact presence using helper scripts:

- **Windows**: `scripts/powershell/check-prerequisites.ps1 [-Json] [-PathsOnly] [-RequireTasks] [-IncludeTasks]`
- **Linux/macOS**: `scripts/bash/check-prerequisites.sh [--json] [--paths-only] [--require-tasks] [--include-tasks]`

These scripts read `.specify/feature.json` (or fall back to the most recent `specs/` directory) and report:
- `FEATURE_DIR` — the active feature directory
- `FEATURE_SPEC_PATH` / `FEATURE_SPEC_EXISTS` — spec.md location and status
- `IMPL_PLAN_PATH` / `IMPL_PLAN_EXISTS` — plan.md location and status
- `TASKS_PATH` / `TASKS_EXISTS` — tasks.md location and status
- `AVAILABLE_DOCS` — list of all existing artifacts

Each Speckit command runs the prerequisite checker as Step 1 and auto-populates paths when the user does not provide them explicitly.

## Adding a New Technology

1. **Scaffold files**: Run the `new-skill` script to generate templates:
   - **Linux/macOS:** `bash scripts/new-skill.sh <tech>`
   - **Windows:** `.\scripts\new-skill.ps1 <tech>`
2. **Refine the skill**: Edit `.junie/skills/<tech>/SKILL.md` (source of truth) — fill in "When to Use", principles, guidelines, checklist, and example.
3. **Update Junie guidelines**: Add relevant rules to `.junie/guidelines.md`.
4. **Update AIR rules**: Add the tech to the Standards Map in `.aiassistant/rules/project-rules.md`.
5. **Update Devin skill**: Fill in `.devin/skills/<tech>/SKILL.md` (generated by the scaffold script).
6. **Validate**: Run the parity check (below).

## Validate Unified Command Parity
Run this after editing any unified command definitions:
```bash
# Linux/macOS
bash scripts/check-command-parity.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1
```

## Validate Installation Flow
Run this after changing install scripts or project-scoped agent assets:
```bash
# Linux/macOS
bash scripts/test-install.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File scripts/test-install.ps1
```

CI integration:
- GitHub Actions: [command-parity.yml](./.github/workflows/command-parity.yml)
- Bitbucket Pipelines: [bitbucket-pipelines.yml](./bitbucket-pipelines.yml)
