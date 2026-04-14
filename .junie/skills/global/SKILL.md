---
name: global
description: General software engineering principles (SOLID, DRY, Clean Code) applicable to all languages
---
# Global Engineering Skill
Use this skill for all code reviews and development tasks to ensure high-quality software engineering standards.

## Key Principles
- **SOLID**: Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion.
- **DRY (Don't Repeat Yourself)**: Avoid code duplication; extract common logic.
- **KISS (Keep It Simple, Stupid)**: Favor simplicity over cleverness.
- **YAGNI (You Ain't Gonna Need It)**: Don't implement features until they are actually needed.
- **Clean Code**: Meaningful names, small functions, no side effects, self-documenting code.

## LLM Behavioral Guidelines
- **Think Before Coding**: State assumptions explicitly, surface tradeoffs, and ask when requirements are unclear.
- **Simplicity First**: Prefer the minimum code that solves the problem; avoid speculative features and unnecessary abstractions.
- **Surgical Changes**: Touch only what is required for the task, keep changes tightly scoped, and match the surrounding style.
- **Goal-Driven Execution**: Turn vague requests into verifiable outcomes, ideally with a failing test or concrete success criteria before implementation.

## Guidelines

### Naming Conventions
- Use meaningful, searchable names.
- Avoid abbreviations (e.g., `userRepository` instead of `uRepo`).
- Boolean variables should start with `is`, `has`, or `can`.

### Function & Method Design
- **Single Responsibility**: Each function should do one thing and do it well.
- **Small Size**: Aim for < 20 lines.
- **Parameters**: Max 3-4 parameters. If more are needed, use an object/DTO.
- **Pure Functions**: Favor functions without side effects where possible.

### Error Handling
- Never swallow exceptions silently.
- Use specific exception types.
- Fail fast: Validate inputs at the start of functions (Guard Clauses).

### Code Style
- **Guard Clauses**: Use early returns instead of nested `if` blocks.
- **Comments**: Code should explain "how", comments should explain "why" (and only if the code isn't clear).
- **Formatting**: Maintain consistent indentation and line breaks.

## Checklist
- [ ] Does the code follow SOLID principles?
- [ ] Is there any duplicated logic that could be extracted?
- [ ] Are variable and function names descriptive?
- [ ] Are functions small and focused?
- [ ] Does it avoid nested `if/else` where guard clauses could be used?
- [ ] Are exceptions handled properly with context?
