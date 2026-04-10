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
## Rules
- No hardcoded secrets or URLs
- All public methods must have tests
- DTOs as Java records, never expose entities
## Testing
- JUnit 5 + Mockito + Testcontainers
- Jest for Angular
```
> **Tip**: Keep it under 30 lines. These are non-negotiable rules, not preferences.

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
Give the AI: **Constitution + Task file only**. Not the entire spec.
```
Use my constitution.md as project rules.
Implement Task 01 from tasks/01-setup.md.
```

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

## Agent-Specific Commands

### Junie
| Command | When to Use |
|---------|-------------|
| `/spec-init` | Start a new SDD project — generates `.spec/` folder and templates |
| `/spec-task task="..."` | Break a spec into atomic AI-ready tasks |
| `/spec-validate` | Validate all SDD artifacts for consistency and gaps |
| `/review file="spec.md"` | Review any SDD artifact against best practices |

### Claude Code
| Command | When to Use |
|---------|-------------|
| `/spec-kit-review` | Review and validate existing SDD artifacts |
| `/spec-start` | Initialize SDD structure with constitution template |
| `/spec-plan` | Generate technical plan from spec |

### Windsurf
Automatically loads SDD rules from `.windsurf/memories/spec-kit-standards.md`. No commands needed — just follow the workflow above.

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
2. GUARD    → Write constitution.md (rules, stack, constraints)
3. DEFINE   → Write spec.md (goals, non-goals, requirements)
4. PLAN     → Write plan.md (architecture, data model, steps)
5. BREAK    → Split into tasks/*.md (atomic, contextual)
6. BUILD    → Feed AI: constitution + one task at a time
7. VALIDATE → /spec-validate after each phase
```
