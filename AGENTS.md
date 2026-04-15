# Agent Usage Guide

This document explains how to use the skills in this repository for each AI agent: Codex, Claude Code, Junie, and Windsurf, plus the shared JetBrains AI Assistant project rules.

All agents share 4 unified commands with identical names and behavior. See the [README](./README.md) for the full command table.

---

## Unified Commands (All Agents)

| Command | Description |
|---------|-------------|
| `/review` | Review code using relevant tech skill and guidelines |
| `/plan` | Create a detailed implementation plan |
| `/test-generate` | Generate unit tests (JUnit/Jest/pytest) |
| `/git-commit` | Create a work branch if needed, then a conventional commit for current changes |

Git workflow note:
- `/git-commit` should create a dedicated branch with `git switch -c <branch-name>` when invoked from `main`, `master`, or `develop`.
- Branch names should use `feature/`, `bugfix/`, `docs/`, or `chore/`, and include a Bitbucket/Jira issue ID only when one is clearly available.

---

## Setup: All Agents (Quick Start)
Deploy Claude and Codex skills globally AND set up Junie, Windsurf, and AI Assistant project files for your project:

**Linux/macOS:**
```bash
bash scripts/install.sh /your-project-root/
```
**Windows (PowerShell):**
```powershell
.\scripts\install.ps1 C:\your-project-root\
```

---

## Claude Code (Slash Commands)

Claude Code uses slash commands stored as Markdown files in `.claude/skills/`. Deploy globally to `~/.claude/skills/`.

### Setup and Deployment
Run the sync script to deploy skills globally:

**Linux/macOS:**
```bash
bash scripts/sync-claude.sh
```
**Windows (PowerShell):**
```powershell
.\scripts\sync-claude.ps1
```

### Usage
Type any command in Claude Code:
- Unified: `/review`, `/plan`, `/test-generate`, `/git-commit`
- Tech-specific: `/java-review`, `/spring-api`, `/ts-review`, `/python-review`, `/angular-component`, `/sql-review`, `/maven-help`

---

## Codex (Global Skills)

Codex can use the existing `.junie/skills/` folders directly as installed global skills.

### Setup and Deployment
Sync the skills into `$CODEX_HOME/skills` (or `~/.codex/skills` if `CODEX_HOME` is not set):

**Linux/macOS:**
```bash
bash scripts/sync-codex.sh
```
**Windows (PowerShell):**
```powershell
.\scripts\sync-codex.ps1
```

Restart Codex after syncing to pick up new skills.

### Usage
Codex auto-loads installed skills when the request matches their descriptions. Available skills include:
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

The source of truth for Codex skills is `.junie/skills/`.

---

## Junie (Agent Skills and Guidelines)

Junie uses Agent Skills (via `agent_skill_read_doc`) and Junie custom slash commands in `.junie/commands/`.

### Setup
Copy the `.junie/` folder to your project:

**Linux/macOS:**
```bash
cp -r .junie /your-project-root/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .junie -Destination C:\your-project-root\ -Recurse
```

### Usage
1. Unified Commands: `/review file="..."`, `/plan task="..."`, `/test-generate file="..."`, `/git-commit`
2. Guidelines: Junie reads `.junie/guidelines.md` automatically for all code generation and reviews.
3. Skills: Ask Junie to use a specific skill:
   - "Use your Angular skill to review this component."
   - "Check this Java code against the project standards."
4. Important: `.junie/commands/` targets Junie custom slash commands. JetBrains AI Assistant prompt shortcuts are managed through the IDE Prompt Library and are not auto-loaded from this folder.

---

## JetBrains AI Assistant (Project Rules + Prompt Library)

JetBrains AI Assistant can use shared project rules stored in `.aiassistant/rules/`.

### Setup
Copy the `.aiassistant/` folder to your project:

**Linux/macOS:**
```bash
cp -r .aiassistant /your-project-root/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .aiassistant -Destination C:\your-project-root\ -Recurse
```

### Usage
1. Project rules: `.aiassistant/rules/*.md` provides project-shared guidance that JetBrains AI Assistant can use inside the IDE.
2. Prompt Library: custom prompt shortcuts are still configured in the IDE Prompt Library and are not auto-loaded from `.junie/commands/`.
3. Keep repo rules concise and project-specific so they are useful across chat and code actions.

---

## Windsurf (Persistent Context + Workflows)

Windsurf uses Memories in `.windsurf/memories/` for persistent context and Workflows in `.windsurf/workflows/` for slash commands.

### Setup
Copy the `.windsurf/` folder to your project:

**Linux/macOS:**
```bash
cp -r .windsurf /your-project-root/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .windsurf -Destination C:\your-project-root\ -Recurse
```

### Usage
Windsurf reads memory files automatically. Use the same unified commands:
- `/review file="src/App.java"` - Windsurf follows instructions from `commands-reference.md`

Memory files loaded automatically:
- `commands-reference.md` - Unified command definitions
- `tech-stack.md` - Project technology stack
- `coding-standards.md` - Coding standards
- `testing-standards.md` - Testing patterns
- `spring-angular-patterns.md` - Framework patterns

Workflow files (slash commands in `.windsurf/workflows/`):
- `review.md` → `/review`
- `plan.md` → `/plan`
- `test-generate.md` → `/test-generate`
- `git-commit.md` → `/git-commit`

---

## Adding New Skills
1. Scaffold: `bash scripts/new-skill.sh <name>` or `.\scripts\new-skill.ps1 <name>`
2. Populate: Edit generated files in `.junie/`, `.claude/`, and `.windsurf/`.
3. Deploy: Run `sync-claude` for Claude and `sync-codex` for Codex.
4. Reference: Always refer to the `global` skill for core engineering principles.

## Maintenance Check
After changing unified command definitions, run:
- Linux/macOS: `bash scripts/check-command-parity.sh`
- Windows (PowerShell): `powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1`

CI files:
- GitHub Actions workflow: `.github/workflows/command-parity.yml`
- Bitbucket Pipelines config: `bitbucket-pipelines.yml`
