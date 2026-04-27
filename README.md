# nossair-ai-skills

Centralized repository for AI agent skills across Codex, Claude Code, Junie, and Windsurf, plus shared JetBrains AI Assistant project rules.
Single source of truth: add a skill once, deploy to all agents.

## Tech Stack Covered
Global, Java, TypeScript, Python, Spring Boot, Angular, Maven, Git, Oracle, MySQL, JUnit, Jest


---

## Project Structure

```
nossair-ai-skills/
|-- .claude/skills/        <- Claude Code slash commands (global deploy)
|-- .aiassistant/rules/    <- JetBrains AI Assistant project rules
|-- .junie/                <- Junie Agent Skills and Codex-compatible skill sources
|   |-- skills/            <- Detailed skill folders per technology
|   |-- commands/          <- Junie CLI custom slash commands
|   `-- guidelines.md      <- Project-wide coding standards
|-- .windsurf/memories/    <- Windsurf persistent context and commands
|-- templates/             <- Templates for new skills and commands
|-- scripts/               <- Helper scripts
|   |-- install.sh         <- Install all skills for all agents (unified)
|   |-- install.ps1        <- Install all skills (PowerShell unified)
|   |-- sync-claude.sh     <- Sync Claude commands globally
|   |-- sync-claude.ps1    <- Sync Claude commands (PowerShell)
|   |-- new-skill.sh       <- Scaffold a new skill across all agents
|   `-- new-skill.ps1      <- Scaffold a new skill (PowerShell)
`-- docs/                  <- Guides and documentation
```

For detailed agent-specific usage, see [AGENTS.md](./AGENTS.md).

---

## Setup: Deploy Skills to Your Agents

### 🚀 Quick Start: All Agents (Recommended)
Install Claude Code and Codex skills globally AND set up Junie, Windsurf, and AI Assistant project files in one command:

**Linux/macOS:**
```bash
bash scripts/install.sh /your-project-root/
```
**Windows (PowerShell):**
```powershell
.\scripts\install.ps1 C:\your-project-root\
```

---

### Claude Code (global, one-time)
**Linux/macOS:**
```bash
bash scripts/sync-claude.sh
```
**Windows (PowerShell):**
```powershell
.\scripts\sync-claude.ps1
```

### Codex (global, one-time)
Codex can use the existing `.junie/skills/` folders directly. Sync them to `$CODEX_HOME/skills` (or `~/.codex/skills` if `CODEX_HOME` is not set):

**Linux/macOS:**
```bash
bash scripts/sync-codex.sh
```
**Windows (PowerShell):**
```powershell
.\scripts\sync-codex.ps1
```

Restart Codex after syncing to pick up newly installed skills.

Installed skills include:
- `global`
- `java`
- `spring-boot`
- `typescript`
- `python`
- `angular`
- `git`
- `maven`
- `oracle`
- `mysql`
- `junit`
- `jest`

 - `speckit`

### Junie (per project)
**Linux/macOS:**
```bash
cp -r .junie /your-project/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .junie -Destination C:\your-project\ -Recurse
```

> Note: `.junie/commands/` is loaded by Junie custom slash commands. JetBrains AI Assistant prompt shortcuts are configured separately through the IDE Prompt Library, so these files are not auto-imported there as generic prompts.

### JetBrains AI Assistant (per project rules)
**Linux/macOS:**
```bash
cp -r .aiassistant /your-project/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .aiassistant -Destination C:\your-project\ -Recurse
```

> Note: `.aiassistant/rules/` provides shareable project rules for JetBrains AI Assistant. Prompt Library shortcuts are still managed manually inside the IDE.

### Windsurf (per project)
**Linux/macOS:**
```bash
cp -r .windsurf /your-project/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .windsurf -Destination C:\your-project\ -Recurse
```

See [AGENTS.md](./AGENTS.md) for details.

---

## Unified Commands (Same on All Agents)

All commands work the same way across Claude Code, Junie, and Windsurf.

| Command | Description | Usage |
|---------|-------------|-------|
| `/review` | Review code using relevant tech skill and guidelines | `/review file="src/App.java"` |
| `/plan` | Create a detailed implementation plan for a task | `/plan task="Add user auth"` |
| `/test-generate` | Generate unit tests (JUnit/Jest/pytest) | `/test-generate file="src/Service.java"` |
| `/git-commit` | Create a work branch if needed, then a conventional commit for current changes | `/git-commit` |

Git workflow note:
- `/git-commit` should create a dedicated branch with `git switch -c <branch-name>` when invoked from `main`, `master`, or `develop`.
- Branch names should use `feature/`, `bugfix/`, `docs/`, or `chore/`, and include a Bitbucket/Jira issue ID only when one is clearly available.

### Speckit Toolkit (Spec → Plan → Tasks → Validate/Analyze → Implement)

Available as Junie commands and Windsurf workflows, and as a Codex skill:
- `/speckit.specify feature="..."` — captures goals, NFRs, ACs, glossary/data model, risks. Prompts to create/switch to a `feature/spec/<id>-<slug>` branch before writing.
- `/speckit.clarify context="..."` — generates up to 5 targeted questions.
- `/speckit.plan spec="..."` — milestones with DoD, dependencies, owners.
- `/speckit.tasks plan="..."` — dependency-ordered tasks with DoD, estimates, risk flags.
- `/speckit.validate spec="..." plan="..." tasks="..."` — cross-artifact checks and traceability.
- `/speckit.analyze spec="..." plan="..." tasks="..."` — automated gap detection and prioritized fixes.
- `/speckit.implement tasks="..."` — dependency-ordered execution runbook with branch/commit/test/review gates.
- `/speckit.document-generate module="..." [project="..."] [parts="..."]` — generate a 10-file Business Analysis document set under `docs/ba/<module>/` (README + 01-overview through 09-page-catalog). Always unified — treats all sub-projects as one system.
- `/speckit.test-generate file="..." [spec="..."] [ac="AC-1,AC-2"]` — generate spec-linked unit tests (JUnit/Jest/pytest) with AC traceability annotations.

### Additional Claude Code Tech-Review Commands

| Command | Description |
|---------|-------------|
| `/java-review` | Review Java code: SOLID, null safety, exceptions, performance |
| `/spring-api` | Review Spring Boot REST API: design, validation, error handling |
| `/ts-review` | Review TypeScript/Angular: type safety, RxJS, signals |
| `/python-review` | Review Python: PEP 8, type hints, idiomatic patterns |
| `/angular-component` | Review Angular component: CD, lifecycle, subscriptions |
| `/sql-review` | Review/write SQL for Oracle or MySQL |
| `/maven-help` | Help with Maven POM, dependencies, build config |

---

## Adding a New Technology

1. **Scaffold files**: Run the `new-skill` script to generate templates for all agents:
   - **Linux/macOS:** `bash scripts/new-skill.sh <tech>`
   - **Windows:** `.\scripts\new-skill.ps1 <tech>`
2. **Refine skills**: Edit the generated files:
   - `.junie/skills/<tech>/SKILL.md` (Detailed reference)
   - `.claude/skills/<tech>-review.md` (Review command)
   - `.windsurf/memories/<tech>-standards.md` (Context memory)
3. **Update Junie guidelines**: Add relevant rules to `.junie/guidelines.md`.
4. **Re-sync Claude**: Run `bash scripts/sync-claude.sh` or `.\scripts\sync-claude.ps1`.
5. **Re-sync Codex**: Run `bash scripts/sync-codex.sh` or `.\scripts\sync-codex.ps1`.
6. **Add to Global** (optional): Update `.junie/skills/global/SKILL.md` for shared principles.

---

## Re-sync After Changes
Any time you update or add a `.claude/skills/` file:
```bash
# Linux/macOS
bash scripts/sync-claude.sh

# Windows (PowerShell)
.\scripts\sync-claude.ps1
```

Any time you update or add a `.junie/skills/` folder for Codex:
```bash
# Linux/macOS
bash scripts/sync-codex.sh

# Windows (PowerShell)
.\scripts\sync-codex.ps1
```

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
