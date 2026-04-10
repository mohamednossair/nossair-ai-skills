# Agent Usage Guide

This document explains how to use the skills in this repository for each AI agent: Claude Code, Junie, and Windsurf.

All agents share 7 unified commands with identical names and behavior. See the [README](./README.md) for the full command table.

---

## Unified Commands (All Agents)

| Command | Description |
|---------|-------------|
| `/review` | Review code using relevant tech skill and guidelines |
| `/plan` | Create a detailed implementation plan |
| `/test-generate` | Generate unit tests (JUnit/Jest/pytest) |
| `/git-commit` | Generate a conventional commit message |
| `/spec-init` | Initialize SDD project structure |
| `/spec-plan` | Generate technical plan and atomic tasks |
| `/spec-validate` | Validate SDD artifacts for consistency |

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
- Unified: `/review`, `/plan`, `/test-generate`, `/git-commit`, `/spec-init`, `/spec-plan`, `/spec-validate`
- Tech-specific: `/java-review`, `/spring-api`, `/ts-review`, `/python-review`, `/angular-component`, `/sql-review`, `/maven-help`

---

## Junie (Agent Skills and Guidelines)

Junie uses Agent Skills (via `agent_skill_read_doc`) and custom commands in `.junie/commands/`.

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
1. Unified Commands: `/review file="..."`, `/plan task="..."`, `/test-generate file="..."`, `/git-commit`, `/spec-init`, `/spec-plan task="..."`, `/spec-validate`
2. Guidelines: Junie reads `.junie/guidelines.md` automatically for all code generation and reviews.
3. Skills: Ask Junie to use a specific skill:
   - "Use your Angular skill to review this component."
   - "Check this Java code against the project standards."

---

## Windsurf (Persistent Context)

Windsurf uses Memories in `.windsurf/memories/` for persistent context. Commands are defined in `commands-reference.md`.

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
- `/spec-init` - Same behavior as Claude and Junie

Memory files loaded automatically:
- `commands-reference.md` - Unified command definitions
- `tech-stack.md` - Project technology stack
- `coding-standards.md` - Coding standards
- `testing-standards.md` - Testing patterns
- `spring-angular-patterns.md` - Framework patterns
- `spec-kit-standards.md` - SDD methodology

---

## Adding New Skills
1. Scaffold: `bash scripts/new-skill.sh <name>` or `.\scripts\new-skill.ps1 <name>`
2. Populate: Edit generated files in `.junie/`, `.claude/`, and `.windsurf/`.
3. Deploy: Run `sync-claude` script to update Claude's global commands.
4. Reference: Always refer to the `global` skill for core engineering principles.

## Maintenance Check
After changing unified command definitions, run:
- Linux/macOS: `bash scripts/check-command-parity.sh`
- Windows (PowerShell): `powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1`

CI files:
- GitHub Actions workflow: `.github/workflows/command-parity.yml`
- Bitbucket Pipelines config: `bitbucket-pipelines.yml`
