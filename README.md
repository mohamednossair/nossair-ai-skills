# nossair-ai-skills

Centralized repository for AI agent skills across Claude Code, Junie, and Windsurf.
Single source of truth — add a skill once, deploy to all agents.

## Tech Stack Covered
Java · TypeScript · Python · Spring Boot · Angular · Maven · Git · Oracle · MySQL · JUnit · Jest

---

## Project Structure

```
nossair-ai-skills/
├── .claude/skills/        ← Claude Code slash commands (global deploy)
├── .junie/                ← Junie Agent Skills & Coding Guidelines
│   ├── skills/            ← Detailed skills folders per technology
│   │   ├── angular/
│   │   ├── java/
│   │   └── ...
│   ├── commands/          ← Junie-specific custom slash commands
│   └── guidelines.md      ← Project-wide coding standards
├── .windsurf/memories/    ← Windsurf persistent context
├── templates/             ← Templates for new skills/commands
├── scripts/               ← Sync scripts for deployment
│   ├── sync-claude.sh     ← Linux/macOS/Bash
│   └── sync-claude.ps1    ← Windows/PowerShell
└── ...
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
See [AGENTS.md](./AGENTS.md#claude-code) for details.

### Junie (per project)
**Linux/macOS:**
```bash
cp -r .junie /your-project/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .junie -Destination C:\your-project\ -Recurse
```
See [AGENTS.md](./AGENTS.md#junie) for details.

### Windsurf (per project)
**Linux/macOS:**
```bash
cp -r .windsurf /your-project/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .windsurf -Destination C:\your-project\ -Recurse
```
See [AGENTS.md](./AGENTS.md#windsurf) for details.

---

## Available Claude Code Commands

| Command | Description |
|---------|-------------|
| `/java-review` | Review Java code: SOLID, null safety, exceptions, performance |
| `/spring-api` | Review Spring Boot REST API: design, validation, error handling |
| `/ts-review` | Review TypeScript/Angular: type safety, RxJS, signals |
| `/python-review` | Review Python: PEP 8, type hints, idiomatic patterns |
| `/angular-component` | Review Angular component: CD, lifecycle, subscriptions |
| `/test-generate` | Generate JUnit or Jest tests for provided code |
| `/git-commit` | Write a conventional commit message for current changes |
| `/sql-review` | Review/write SQL for Oracle or MySQL |
| `/maven-help` | Help with Maven POM, dependencies, build config |

---

## Available Junie Slash Commands

| Command | Description |
|---------|-------------|
| `/review file="..."` | Review code using specific tech skills and guidelines |
| `/plan task="..."` | Create a detailed implementation plan for a task |

---

## Adding a New Technology

1. **Add reference skill** — Create a folder `.junie/skills/<tech>/` and copy `templates/skill_template.md` to `SKILL.md` inside it.
2. **Add Claude command** (optional) — Copy `templates/claude_skill_template.md` to `.claude/skills/<tech-action>.md`.
3. **Update Windsurf memory** (optional) — Add or update a file in `.windsurf/memories/`.
4. **Update Junie guidelines** — Add relevant rules to `.junie/guidelines.md`.
5. **Re-sync Claude** — Run `bash scripts/sync-claude.sh` (Linux) or `.\scripts\sync-claude.ps1` (Windows) to push Claude skills globally.

---

## Re-sync After Changes
Any time you update or add a `.claude/skills/` file:
```bash
# Linux/macOS
bash scripts/sync-claude.sh

# Windows (PowerShell)
.\scripts\sync-claude.ps1
```
