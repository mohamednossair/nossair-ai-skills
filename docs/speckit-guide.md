# Spec-Kit (SDD) — Practical Usage Guide

Fast, token-efficient workflow for AI-assisted development using Spec-Driven Development.

---

## Why Spec-Kit?

| Problem | SDD Solution |
|---------|-------------|
| AI generates wrong code from vague prompts | Constitution + Spec define exact constraints |
| Long back-and-forth wastes tokens | Plan + Tasks give AI precise, atomic instructions |
| Context window overflow on large features | Tasks are small, self-contained units |
| Inconsistent output across sessions | Constitution enforces the same rules every time |

---

## Quick Start (5 Minutes)

### Step 1: Create Project Folder Structure
```
your-project/
├── .spec/
│   ├── constitution.md    ← Project guardrails (create once)
│   ├── spec.md            ← Feature specification
│   ├── plan.md            ← Technical plan
│   └── tasks/
│       ├── 01-setup.md
│       ├── 02-model.md
│       └── ...
```

### Step 2: Write Constitution (One-Time)
```markdown
# Constitution
## Tech Stack
- Java 21, Spring Boot 3.3, PostgreSQL
- Angular 20, Signals, Standalone Components
## Workspace Map
- `frontend/` — Angular UI and page composition
- `backend-api/` — Spring APIs, validation, business rules
- `shared-contracts/` — shared DTOs, schemas, generated clients
## Module Selection Rules
- UI behavior changes go to `frontend/`
- API and domain logic go to `backend-api/`
- Cross-repo contracts start in `shared-contracts/`
## Rules
- No hardcoded secrets or URLs
- All public methods must have tests
- DTOs as Java records, never expose entities
## Testing
- JUnit 5 + Mockito + Testcontainers
- Jest for Angular
```
> **Tip**: Keep it concise. Capture non-negotiable rules plus a repo/module map so future AI agents choose the right module before writing code.

### Step 3: Write Spec for a Feature
```markdown
# Spec: User Profile Service
## Goal
REST API for CRUD operations on user profiles.
## Non-Goals
- No social login (future scope)
- No file upload
## Requirements
- POST /api/v1/profiles — Create profile (validated)
- GET /api/v1/profiles/{id} — Get by ID
- PUT /api/v1/profiles/{id} — Update profile
- DELETE /api/v1/profiles/{id} — Soft delete
## Acceptance Criteria
- All inputs validated with Bean Validation
- 404 for missing profiles, 409 for duplicate email
- Response time < 200ms
```
> **Tip**: Non-Goals save the most tokens — they prevent AI from building things you don't need.

### Step 4: Write Technical Plan
```markdown
# Plan: User Profile Service
## Architecture
Controller → Service → Repository (standard Spring layers)
## Data Model
| Field | Type | Constraints |
|-------|------|------------|
| id | UUID | PK, auto-generated |
| email | String | Unique, not null |
| name | String | Not null, max 100 |
| active | boolean | Default true |
## Implementation Steps
1. Entity + Repository
2. Service layer + validation
3. Controller + error handling
4. Tests (unit + integration)
```

### Step 5: Break into Tasks
Each task = one AI prompt. Keep under 20 lines.
```markdown
# Task 01: Entity + Repository
## Context
See: spec.md#Data-Model, constitution.md#Tech-Stack
## Deliverables
- `UserProfile` JPA entity with fields from plan
- `UserProfileRepository` extends `JpaRepository<UserProfile, UUID>`
- Flyway migration `V1__create_user_profile.sql`
## Constraints
- Use `@Entity`, not Lombok `@Data`
- UUID generated with `@GeneratedValue(strategy = GenerationType.UUID)`
```

### Step 6: Feed to AI
Give the AI: **Constitution + Task file only**. Not the entire spec. The unified command for this is `/spec-implement`.
```
/spec-implement task=".spec/tasks/01-setup.md"
```
> **Before Step 2**: If your workspace has multiple modules or repositories, make `/spec-init` inspect the workspace, summarize the detected roles, then ask you for missing ownership rules, boundaries, and best practices before it writes `constitution.md`. If anything is unclear, the agent should stop and ask instead of guessing.

---

## Token Optimization Tips

| Technique | Savings | Example |
|-----------|---------|---------|
| Non-Goals in spec | ~30% fewer corrections | "No file upload" prevents AI from adding it |
| Atomic tasks (1 task = 1 prompt) | ~50% less context | 15-line task vs 200-line full spec |
| Constitution as system prompt | Reuse across all tasks | Set once, reference always |
| Bullet points over paragraphs | ~40% fewer tokens | `- Use UUID PK` vs "The primary key should be..." |
| Explicit constraints | ~20% fewer retries | `max 100 chars` vs "reasonable length" |

---

## Unified Commands Across All Agents

Use the same Spec-Kit commands in Junie, Claude Code, and Windsurf:

| Command | When to Use |
|---------|-------------|
| `/spec-init` | Start a new SDD project by mapping the workspace, asking for repository and module rules, then generating `.spec/` |
| `/spec-plan task="..."` | Generate or update the technical plan and break the spec into atomic AI-ready task files |
| `/spec-implement task="..."` | Implement a single generated task file using `constitution.md` as the execution guardrail |
| `/spec-validate` | Validate all SDD artifacts for consistency, gaps, and token efficiency |
| `/review file="spec.md"` | Review any specific SDD artifact against project standards and best practices |

### Agent Notes
- **Junie**: Uses Junie custom slash commands in `.junie/commands/`.
- **JetBrains AI Assistant**: Can use shared project rules from `.aiassistant/rules/`; Prompt Library shortcuts are still configured in the IDE.
- **Claude Code**: Uses slash command files in `.claude/skills/`.
- **Windsurf**: Uses the same command definitions from `.windsurf/memories/commands-reference.md`.

If you are using JetBrains AI Assistant prompt shortcuts instead of Junie custom slash commands, configure those in the IDE Prompt Library; they are not loaded from `.junie/commands/`.

Legacy names such as `/spec-task`, `/spec-start`, and `/spec-kit-review` are replaced by the unified commands above.

---

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Writing spec as prose | Use bullet points and tables |
| Skipping Non-Goals | Always list 3-5 things you're NOT building |
| Tasks too large (>30 lines) | Split until each task is one logical unit |
| Including full spec in every prompt | Send Constitution + current Task only |
| No acceptance criteria | Add measurable criteria: status codes, response times |
| Generic constitution ("write clean code") | Be specific: "Java 21 records for DTOs" |

---

## Workflow Cheat Sheet

```
1. INIT     → /spec-init or create .spec/ manually
2. DISCOVER → Map modules/repos and confirm their roles
3. GUARD    → Write constitution.md (rules, stack, routing constraints)
4. DEFINE   → Write spec.md (goals, non-goals, requirements)
5. PLAN     → Write plan.md (architecture, data model, steps)
6. BREAK    → Split into tasks/*.md (atomic, contextual)
7. BUILD    → /spec-implement task=".spec/tasks/01-setup.md"
8. VALIDATE → /spec-validate after each phase
```
