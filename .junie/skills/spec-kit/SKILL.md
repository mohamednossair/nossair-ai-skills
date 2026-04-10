---
name: spec-kit
description: Spec-Driven Development (SDD) methodology for structured AI implementation.
---

# Spec-Driven Development (SDD) Skill
Use this skill for all project lifecycle phases to ensure alignment between intent and implementation. This methodology prevents "vibe-coding" by enforcing structured thinking before code is written.

## When to Use
- **New Features**: When starting a new development task.
- **Refactoring**: When planning significant architectural changes.
- **Complex Bugs**: When the root cause requires structural changes.

## Key Principles
- **Intent over Implementation**: Clear specifications define the "what" and "why" before the "how".
- **Constitution First**: Non-negotiable principles (e.g., "no external APIs", "Must use Signals") are established upfront.
- **Phased Workflow**: Sequential progression (Constitution -> Spec -> Plan -> Tasks -> Code).
- **Validation Gates**: Each phase must be validated/analyzed before moving to the next.

## SDD Workflow (Phases)

### 1. Constitution (`constitution.md`)
Record project-wide guardrails.
- **Testing Standards**: e.g., JUnit 5, Mockito.
- **Tech Stack**: e.g., Java 21, Spring Boot 3.3.
- **Security/Performance**: e.g., "No hardcoded secrets", "Latency < 200ms".

### 2. Specification (`spec.md`)
Describe goals, requirements, and user stories.
- **Goals**: High-level objectives.
- **Non-Goals**: Explicit exclusions to avoid scope creep.
- **User Stories**: "As a [user], I want to [action], so that [benefit]".

### 3. Technical Plan (`plan.md`)
Architecture and data modeling.
- **Architecture**: Diagram-like descriptions (Mermaid or text).
- **Data Model**: Entities, relationships, and state transitions.
- **Implementation Steps**: High-level milestones.

### 4. Task Breakdown (`tasks/*.md`)
Atomic, executable units of work.
- **Small Scope**: Each task should be implementable in one AI step.
- **Contextual**: Reference relevant parts of the Spec and Plan.

### 5. Implementation
Code generation based on the task list.
- **Context-Aware**: Maintain alignment with all preceding artifacts.

## Checklist
- [ ] Is the Constitution defined and non-negotiable?
- [ ] Does the Spec explicitly state the "Why"?
- [ ] Has the Technical Plan been analyzed for potential bottlenecks?
- [ ] Are Tasks small enough to avoid context saturation?

## Example (Spec Snippet)
```markdown
## Goal
Create a reactive user profile service.
## Requirements
- Use Java 21 Virtual Threads.
- Persistence via PostgreSQL.
- Validation: Input must not be null or empty.
```

