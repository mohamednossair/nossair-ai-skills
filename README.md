# nossair-ai-skills

Centralized repository for AI agent skills across **Junie**, **JetBrains AI Assistant (AIR)**, and **Devin**.
Single source of truth: add a skill once in `.junie/skills/`, reference it everywhere.

## Tech Stack Covered
Global, Java 21+, Spring Boot 3.2+, TypeScript, Python, Angular 20+, Maven, Git, Oracle, MySQL, JUnit, Jest, Security (OWASP/Spring Security), Performance, Accessibility, Speckit, Graphify (knowledge graph)

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
/speckit-specify ──► specs/NNN-<name>/spec.md (mode=draft: no branch; mode=feature: branch feature/spec/<id>-<slug>)
/speckit-clarify ──► answers encoded back into spec.md
/speckit-plan    ──► plan.md (+ research.md, data-model.md, contracts/, quickstart.md)
                      plan.md includes a machine-readable "## Standards" section listing the .junie/skills/ files
/speckit-tasks   ──► tasks.md (T### [P] [US#] + Depends on/Covers/Validate; test tasks precede implementation tasks)
/speckit-validate (= /speckit-analyze mode=pre) or /speckit-analyze ──► cross-artifact consistency report with PASS / PASS_WITH_WARNINGS / BLOCKED verdict
/speckit-implement ──► mode=plan: dry-run runbook; mode=execute: verifies feature branch, loads plan Standards,
                       runs each task's Validate command, marks [X]
/speckit-test-generate (or /test-generate) + /review + /review-pr ──► tests and reviews before merge
/speckit-taskstoissues ──► GitHub issues from tasks.md (GitHub remote required)
```

- Every command resolves artifacts via the shared Artifact Resolution Contract (explicit parameter → `.specify/feature.json` → prerequisite checker → single-candidate discovery → structured missing-input error); the prerequisite checker (`.junie/scripts/powershell/check-prerequisites.ps1 -Json` or `.junie/scripts/bash/check-prerequisites.sh --json`) auto-locates the active feature.
- To hand off: plan with Junie, implement with Devin (`/speckit-implement`) or AIR — the implementing agent reads `.specify/feature.json`, the plan's `## Standards` section, and the listed `.junie/skills/` files.

### Speckit Toolkit (Spec → Plan → Tasks → Validate/Analyze → Implement)

Available as Junie commands (and usable from Devin/AIR by following `.junie/commands/`). In Devin, each subcommand is also an individual skill: `/speckit-specify`, `/speckit-clarify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-validate`, `/speckit-analyze`, `/speckit-checklist`, `/speckit-implement`, `/speckit-taskstoissues`, `/speckit-document-generate`, `/speckit-test-generate` (plus the `/speckit` orchestrator that lists them).

> Note: Devin skill identifiers allow only lowercase letters, digits, and hyphens — dots are rejected, so Devin subcommands are hyphenated (`/speckit-specify`). Junie/AIR keep the dotted `.junie/commands/speckit.<name>.md` files.
- `/speckit-specify feature="..." [mode="draft|feature|refine"]` — generates a short name, creates `specs/NNN-short-name/`, persists to `.specify/feature.json`, and produces a spec-quality checklist. `mode=draft` (default) skips branching; `mode=feature` creates the `feature/spec` branch (after a stable-scope readiness gate); `mode=refine` verifies the current branch and creates a `chore/spec` branch only when required. Acceptance criteria use stable `AC-###` IDs (statement, validation, priority, source); NFRs use `NFR-SEC/PERF/AVL/PRV/OPS-###` IDs; an optional `current_state` links the BA fact base (with a structured error when required evidence cannot be resolved). Ends with a `## Specification Status` block (`draft` → `ready-for-clarification` → `ready-for-planning`, plus `deprecated`).
- `/speckit-clarify [spec="..."] [plan="..."] [mode="spec|plan"] [apply="preview|apply"]` — scans the artifact against a structured taxonomy and asks up to 5 targeted questions with recommended answers (each with a stated basis and confidence), encoding responses back into the spec or plan. Defaults: `mode=spec`, `apply=preview` (read-only until explicitly applied). Preserves AC/NFR IDs (invalidated requirements are marked `Deprecated` with a new replacement ID) and ends with a COMPLETE / PARTIAL / BLOCKED verdict.
- `/speckit-plan spec="..."` — loads `.specify/feature.json`, cross-checks the constitution and the spec's `ready-for-planning` status, generates `research.md`, `data-model.md` (technical storage representation), and `contracts/` when applicable, then produces milestones with DoD and `Covers` traceability (every Must AC maps to a milestone; changed `BR-###` rules and `TR-###` technical requirements carry forward) and a machine-readable `## Standards` section with a parse validation (one heading, valid YAML, resolvable skills, `## Missing Standards` for the rest). Ends with a `## Planning Result` verdict (READY | READY_WITH_WARNINGS | BLOCKED).
- `/speckit-tasks plan="..."` — loads `.specify/feature.json`, organizes tasks by user story (P1, P2...), and uses the strict task contract: first line `T### [P] [US#]` plus `Depends on` (`None` for root tasks), `Covers` (AC/NFR/TR IDs; `FEATURE-FOUNDATION` for setup tasks — never omitted), `Capability`, `Estimate`, `Risk`, `Validate` (command + expectation contract: `Expected result: PASS | FAIL`, with expected failing test/reason when FAIL), and `Done when`. Test tasks precede their implementation tasks (test-first tasks may end with an expected failing test); `TR-###` IDs are consumed from `plan.md`, never invented; `[P]` requires file/artifact/interface/migration conflict checks; ends with a Task Generation Validation verdict (PASS | BLOCKED — blocking on uncovered Must ACs, circular or missing dependencies, missing validation commands, or undefined identifiers).
- `/speckit-validate [spec="..."] [plan="..."] [tasks="..."] [current_state="..."]` — compatibility alias for `/speckit-analyze mode="pre"`: one canonical analysis engine, returning the same traceability matrix, findings, severities, semantic coverage statuses, and mutually exclusive verdict.
- `/speckit-analyze [spec="..."] [plan="..."] [tasks="..."] [current_state="..."] [mode="pre|post-implementation"] [base_ref="main"] [test_report="..."]` — read-only cross-artifact analysis with severity assignment (CRITICAL / HIGH / MEDIUM / LOW), bidirectional traceability with semantic statuses (COMPLETE / PARTIAL / MISSING / CONFLICTING / UNVERIFIABLE), semantic-drift checks, evidence-backed findings, and a required mutually exclusive PASS / PASS_WITH_WARNINGS / BLOCKED verdict ending in a machine-readable `## Analysis Result` summary (severity and semantic-coverage counts). Post-implementation mode inspects committed (`base_ref...HEAD`), staged, unstaged, and relevant untracked changes separately, honors the `Expected result: FAIL` red-test contract, reads test reports when supplied (never executes tests), and marks unverifiable completion claims HIGH (Must ACs) or MEDIUM (other claims).
- `/speckit-checklist domain="ux|api|security|..."` — generates domain-specific requirement-quality checklists (unit tests for English) under `checklists/<domain>.md`.
- `/speckit-implement [tasks="..."] [mode="plan|execute"] [task_ids="..."] [phase="..."] [resume="true|false"] [checkpoint="phase|failure|none"]` — `mode=plan` (default) outputs a read-only dry-run runbook under a strict Mode Safety Invariant (no branches, no file writes, no hooks, no installs; read-only inspection commands allowed); `mode=execute` performs gated execution with constitution governance, checklist gating, dirty-worktree auto-block on overlapping paths, branch resolution preferring the feature-associated branch, scope-drift and unrelated-file protection (command-owned artifacts exempt), dependency-aware validation-failure handling, per-task `Validate` commands, project-setup verification (ignore files, restricted to affected technologies), and `[X]` task completion tracking, ending with an `Execution Result` verdict (COMPLETED / PARTIALLY_COMPLETED / BLOCKED / FAILED_VALIDATION). Selectors (`task_ids`, `phase`, `resume`, `checkpoint`) choose what runs and when to pause; only `mode` controls write permission.
- `/speckit-taskstoissues tasks="..."` — converts tasks into actionable GitHub issues (requires a GitHub remote).
- `/speckit-document-generate module="..." [project="..."] [parts="..."] [mode="interactive|auto|resume"]` — generate a lean 6-file AI-optimized Business Analysis set under `docs/ba/<module>/` (`00-ai-index` + README + `02-scope-context` + `10-technical-map` + `11-code-map` + `99-facts.json`) with Mermaid graphs and a machine-readable fact base. Always unified — treats all sub-projects as one system. Two-pass evidence-driven scanning (structural classification of every file + deep reads of business-relevant files only), `.work/` checkpoints with resume, stable fact-ID lifecycle (never renumber; deprecate + replace), `confidence` + `evidence` on every fact, ownership markers protecting human-edited regions, scoped terminology validation (business-language ban only on business-facing files), and a final COMPLETE / COMPLETE_WITH_GAPS / BLOCKED quality verdict.
- `/speckit-test-generate file="..." [spec="..."] [plan="..."] [tasks="..."] [task="T012"] [ac="..."] [action="preview|write"] [allow_unlinked="false|true"] [run_tests="false|true"]` — the canonical spec-linked test generator: task linkage is the preferred path (auto-selects when exactly one candidate test task matches; structured ambiguity error on multiple), spec is resolved via the shared chain but never auto-discovered when `allow_unlinked=true` is set without an explicit spec (BLOCKED by default otherwise), AC scoping never defaults to every AC (target-symbol mapping with BLOCKED on no reliable mapping; requested AC IDs validated — BLOCKED on missing/invalid/deprecated), framework resolved repo-first with no new dependencies in write mode without plan approval, existing tests inspected before generating, risk-based case selection, expected-red tests generated with exact intent (assertions never weakened), atomic writes with rollback in `action=write`, tests executed only with `run_tests=true` (interpreted against `Expected result`), and a `## Test Traceability` summary at the end. `/test-generate` is its thin unlinked wrapper.

### Prerequisite Scripts

Speckit commands can auto-locate the active feature directory and verify artifact presence using helper scripts:

- **Windows**: `.junie/scripts/powershell/check-prerequisites.ps1 [-Json] [-PathsOnly] [-RequireTasks] [-IncludeTasks]`
- **Linux/macOS**: `.junie/scripts/bash/check-prerequisites.sh [--json] [--paths-only] [--require-tasks] [--include-tasks]`

These scripts read `.specify/feature.json` (or fall back to the most recent `specs/` directory) and report:
- `FEATURE_DIR` — the active feature directory
- `FEATURE_SPEC_PATH` / `FEATURE_SPEC_EXISTS` — spec.md location and status
- `IMPL_PLAN_PATH` / `IMPL_PLAN_EXISTS` — plan.md location and status
- `TASKS_PATH` / `TASKS_EXISTS` — tasks.md location and status
- `AVAILABLE_DOCS` — list of all existing artifacts

Each Speckit command runs the prerequisite checker as Step 1 and auto-populates paths when the user does not provide them explicitly.

### Graphify (Codebase Knowledge Graph)

The `/graphify` skill (Devin) / `graphify` skill (Junie, AIR via `.junie/skills/graphify/SKILL.md`) maps the codebase — code, docs, SQL schemas, configs, PDFs — into a queryable knowledge graph using the [Graphify CLI](https://github.com/Graphify-Labs/graphify). Code is parsed locally with tree-sitter AST (no LLM, no vector store); query it instead of grepping files.

```bash
uv tool install graphifyy      # PyPI package is "graphifyy" (double y); CLI command is "graphify"
graphify .                     # build graphify-out/ (graph.html, GRAPH_REPORT.md, graph.json)
graphify query "what connects X to the database?"
graphify path "UserService" "DatabasePool"
graphify explain "RateLimiter"
```

Speckit integration: when `graphify-out/graph.json` exists, `/speckit-plan` research, `/speckit-tasks` impact/conflict checks, and `/speckit-implement` dependency checks use graph queries instead of broad grep sweeps (see the speckit Integration Map). Graphify complements — does not replace — vector stores (e.g., Qdrant) for document retrieval.

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
