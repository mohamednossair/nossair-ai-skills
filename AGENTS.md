# Agent Usage Guide

This document explains how to use the skills in this repository for each AI agent: Claude Code, Junie, and Windsurf.

---

## 🛠️ Claude Code (Slash Commands)

Claude Code uses **slash commands** for skills. These are stored as Markdown files in the `.claude/skills/` directory and must be deployed to your home directory to be available globally.

### 📋 Setup & Deployment
1. Run the sync script to deploy skills to your `~/.claude/skills/` folder:
   **Linux/macOS:**
   ```bash
   bash scripts/sync-claude.sh
   ```
   **Windows (PowerShell):**
   ```powershell
   .\scripts\sync-claude.ps1
   ```
2. Any new `.md` file added to `.claude/skills/` will automatically become a slash command (e.g., `java-review.md` → `/java-review`).

### 🚀 Usage
Inside any project, type the command in Claude Code:
- `/java-review` — Review Java code for best practices.
- `/spring-api` — Analyze Spring Boot REST controllers and services.
- `/ts-review` — Review TypeScript and Angular code (Signals, RxJS).
- `/sql-review` — Review Oracle or MySQL queries.
- `/test-generate` — Generate JUnit or Jest tests for the current file.
- `/git-commit` — Generate a conventional commit message.

---

## 👩‍💻 Junie (Agent Skills & Guidelines)

Junie uses **Agent Skills** (via the `agent_skill_read_doc` tool) and **Guidelines** to maintain consistency.

### 📋 Setup
For each new project, copy the `.junie/` folder:

**Linux/macOS:**
```bash
cp -r .junie /your-project-root/
```

**Windows (PowerShell):**
```powershell
Copy-Item -Path .junie -Destination C:\your-project-root\ -Recurse
```

### 🚀 Usage
1. **Guidelines**: Junie automatically reads `.junie/guidelines.md` at the start of a session. It uses these rules for all code generation and reviews.
2. **Skills**: You can ask Junie to use a specific skill:
   - *"Junie, use your Angular skill to review this component."*
   - *"Check this Java code against the project standards."*
   Junie will use the `agent_skill_read_doc` tool to read the corresponding `SKILL.md` from `.junie/skills/<name>/`.

---

## 🌊 Windsurf (Persistent Context)

Windsurf uses **Memories** to maintain persistent context across sessions. It automatically loads all Markdown files in the `.windsurf/memories/` directory.

### 📋 Setup
For each new project, copy the `.windsurf/` folder:

**Linux/macOS:**
```bash
mkdir -p /your-project-root/.windsurf/memories
cp .windsurf/memories/*.md /your-project-root/.windsurf/memories/
```

**Windows (PowerShell):**
```powershell
New-Item -Path C:\your-project-root\.windsurf\memories -ItemType Directory -Force
Copy-Item -Path .windsurf\memories\*.md -Destination C:\your-project-root\.windsurf\memories\
```

### 🚀 Usage
Windsurf reads these files automatically. No manual command is needed. The agent will "remember" the coding standards, tech stack, and testing patterns defined in:
- `tech-stack.md`
- `coding-standards.md`
- `testing-standards.md`
- `spring-angular-patterns.md`

---

## 🔄 Adding New Skills
To add a new skill for all agents:
1. **Reference**: Add a file to `.junie/skills/<tech>/SKILL.md`.
2. **Claude**: Add a prompt to `.claude/skills/<tech>-action.md`.
3. **Windsurf**: Update a relevant memory in `.windsurf/memories/`.
4. **Guidelines**: Update `.junie/guidelines.md` if needed.
