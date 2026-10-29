# Agent Usage Guide

This document explains how to use the skills in this repository for each AI agent: **Junie**, **JetBrains AI Assistant (AIR)**, and **Devin**.

All agents share 5 unified commands with identical names and behavior. See the [README](./README.md) for the full command table.

---

## Unified Commands (All Agents)

| Command | Description |
|---------|-------------|
| `/review` | Review code using relevant tech skill and guidelines |
| `/review-pr` | Review a PR or branch diff (multi-file) with merge recommendation |
| `/plan` | Create a detailed implementation plan |
| `/test-generate` | Generate unit tests (JUnit/Jest/pytest) |
| `/git-commit` | Create a work branch if needed, then a conventional commit for current changes |

Git workflow note:
- `/git-commit` should create a dedicated branch with `git switch -c <branch-name>` when invoked from `main`, `master`, or `develop`.
- Branch names should use `feature/`, `bugfix/`, `docs/`, or `chore/`, and include a Bitbucket/Jira issue ID only when one is clearly available.

---

## Setup: All Agents (Quick Start)
Set up Junie, AIR, and Devin project files for your project:

**Linux/macOS:**
```bash
bash scripts/install.sh /your-project-root/
```
**Windows (PowerShell):**
```powershell
.\scripts\install.ps1 C:\your-project-root\
```

---

## Source of Truth

`.junie/skills/<tech>/SKILL.md` is the single source of truth for technology standards. Every agent references these files:

| Skill | Covers |
|-------|--------|
| `global` | SOLID, DRY, Clean Code — base for all reviews and tasks |
| `java` | Java 21+ LTS: records, sealed classes, pattern matching, virtual threads |
| `spring-boot` | Spring Boot 3.2+: layers, DTOs, validation, transactions, Flyway |
| `typescript` | Strict mode, no `any`, explicit returns, async patterns |
| `angular` | Angular 20+: standalone, signals, OnPush, `inject()`, control flow |
| `python` | Type hints, PEP 8/Black, specific exceptions |
| `maven` | pom.xml, dependency management, lifecycle, multi-module |
| `git` | Branching, Conventional Commits, history hygiene |
| `oracle` | Oracle SQL: bind variables, indexing, pagination |
| `mysql` | MySQL SQL: InnoDB, utf8mb4, indexing, pagination |
| `junit` | JUnit 5 + Mockito + AssertJ test standards |
| `jest` | Jest test standards for TypeScript/Angular |
| `security` | OWASP Top 10, Spring Security, JWT, CORS/CSRF, secrets/PII |
| `performance` | N+1, caching, SQL tuning, bundle size, virtual threads |
| `accessibility` | Semantic HTML, keyboard nav, ARIA, focus management |
| `speckit` | Spec → plan → tasks → validate → implement toolkit |

`.junie/guidelines.md` is the consolidated one-page summary of all standards.

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

## JetBrains AI Assistant (AIR) (Project Rules + Prompt Library)

JetBrains AI Assistant uses shared project rules stored in `.aiassistant/rules/`.

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
1. Project rules: `.aiassistant/rules/*.md` provides project-shared guidance that AIR uses inside the IDE (`apply: always`).
2. The rules point to `.junie/skills/<tech>/SKILL.md` as the standards source — keep both in sync when adding technologies.
3. Prompt Library: custom prompt shortcuts are still configured in the IDE Prompt Library and are not auto-loaded from `.junie/commands/`.
4. Keep repo rules concise and project-specific so they are useful across chat and code actions.

---

## Devin (Project Skills)

Devin uses project skills in `.devin/skills/<name>/SKILL.md` and reads `AGENTS.md` automatically.

### Setup
Copy the `.devin/` folder to your project:

**Linux/macOS:**
```bash
cp -r .devin /your-project-root/
```
**Windows (PowerShell):**
```powershell
Copy-Item -Path .devin -Destination C:\your-project-root\ -Recurse
```

### Available Skills
| Skill | Purpose |
|-------|---------|
| `/review` | Full technical review report using the relevant `.junie/skills/` standard |
| `/review-pr` | Multi-file PR/branch-diff review with change inventory and merge recommendation |
| `/plan` | Numbered implementation plan with files, standards, skills, and Risk per step |
| `/test-generate` | Generate unit tests (JUnit 5/Jest/pytest) — thin unlinked wrapper around `/speckit-test-generate`; `action=preview` by default |
| `/git-commit` | Branch-then-commit workflow with Conventional Commits |
| `/security` | OWASP/Spring Security review for auth, input, secrets, PII |
| `/performance` | N+1, caching, SQL tuning, bundle size review |
| `/accessibility` | A11y review for Angular templates and forms |
| `/speckit` | Orchestrator — lists all `/speckit-*` subcommands; each subcommand also has its own skill |
| `/speckit-specify` `/speckit-clarify` `/speckit-plan` `/speckit-tasks` `/speckit-validate` `/speckit-analyze` `/speckit-checklist` `/speckit-implement` `/speckit-taskstoissues` `/speckit-document-generate` `/speckit-test-generate` | Individual speckit commands — each follows the matching `.junie/commands/speckit.<name>.md` |
| `/project-standards` | Standards map: which `.junie/skills/` file to load per file type |

### Usage
1. Type any command in Devin: `/review`, `/review-pr`, `/plan`, `/test-generate`, `/git-commit`, `/security`, `/performance`, `/accessibility`, `/speckit`, `/project-standards`.
2. Speckit subcommands are individually available: `/speckit-specify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-implement`, etc. — typing `/speckit` shows the full list.
3. Devin also auto-loads skills when the request matches their descriptions (e.g., "review this service" → `/review`).
4. Devin skill frontmatter supports `name`, `description`, `argument-hint`, `allowed-tools`, `permissions`, and `triggers`.

---

## Adding New Skills
1. Scaffold: `bash scripts/new-skill.sh <name>` or `.\scripts\new-skill.ps1 <name>`
2. Populate: Edit generated files in `.junie/skills/<name>/SKILL.md` (source of truth) and `.devin/skills/<name>/SKILL.md`.
3. Reference: Always refer to the `global` skill for core engineering principles.

## Maintenance Check
After changing unified command definitions, run:
- Linux/macOS: `bash scripts/check-command-parity.sh`
- Windows (PowerShell): `powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1`

CI files:
- GitHub Actions workflow: `.github/workflows/command-parity.yml`
- Bitbucket Pipelines config: `bitbucket-pipelines.yml`
