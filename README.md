# nossair-ai-skills

Centralized repository for AI agent skills across Claude Code, Junie, and Windsurf.
Single source of truth: add a skill once, deploy to all agents.

## Tech Stack Covered
Global, Java, TypeScript, Python, Spring Boot, Angular, Maven, Git, Oracle, MySQL, JUnit, Jest, Spec-Kit (SDD)

[Spec-Kit Usage Guide](./docs/speckit-guide.md): Step-by-step guide for token-efficient AI development with SDD.

---

## Project Structure

```
nossair-ai-skills/
|-- .claude/skills/        <- Claude Code slash commands (global deploy)
|-- .junie/                <- Junie Agent Skills and Coding Guidelines
|   |-- skills/            <- Detailed skills folders per technology
|   |-- commands/          <- Junie custom slash commands
|   `-- guidelines.md      <- Project-wide coding standards
|-- .windsurf/memories/    <- Windsurf persistent context and commands
|-- templates/             <- Templates for new skills and commands
|-- scripts/               <- Helper scripts
|   |-- sync-claude.sh     <- Sync Claude commands globally
|   |-- sync-claude.ps1    <- Sync Claude commands (PowerShell)
|   |-- new-skill.sh       <- Scaffold a new skill across all agents
|   `-- new-skill.ps1      <- Scaffold a new skill (PowerShell)
`-- docs/                  <- Guides and documentation
```

For detailed agent-specific usage, see [AGENTS.md](./AGENTS.md).

---

## Setup: Deploy Skills to Your Agents

### Claude Code (global, one-time)
**Linux/macOS:**
```bash
bash scripts/sync-claude.sh
```
**Windows (PowerShell):**
```powershell
.\scripts\sync-claude.ps1
```

### Junie (per project)
**Linux/macOS:**
```bash
cp -r .junie /your-project/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .junie -Destination C:\your-project\ -Recurse
```

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
| `/git-commit` | Generate a conventional commit message | `/git-commit` |
| `/spec-init` | Initialize SDD project structure with templates | `/spec-init` |
| `/spec-plan` | Generate technical plan and atomic tasks from spec | `/spec-plan task="User profile API"` |
| `/spec-validate` | Validate SDD artifacts for consistency and efficiency | `/spec-validate` |

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
5. **Add to Global** (optional): Update `.junie/skills/global/SKILL.md` for shared principles.

---

## Re-sync After Changes
Any time you update or add a `.claude/skills/` file:
```bash
# Linux/macOS
bash scripts/sync-claude.sh

# Windows (PowerShell)
.\scripts\sync-claude.ps1
```

## Validate Unified Command Parity
Run this after editing any unified command definitions:
```bash
# Linux/macOS
bash scripts/check-command-parity.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1
```

CI integration:
- GitHub Actions: [command-parity.yml](./.github/workflows/command-parity.yml)
- Bitbucket Pipelines: [bitbucket-pipelines.yml](./bitbucket-pipelines.yml)
