# Global Engineering Principles

Apply these principles to ALL code reviews and development tasks across all languages.

## Core Principles
- **SOLID**: Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion
- **DRY (Don't Repeat Yourself)**: Extract common logic; avoid duplication
- **KISS (Keep It Simple)**: Favor simplicity over cleverness
- **YAGNI (You Ain't Gonna Need It)**: Don't implement features until actually needed
- **Clean Code**: Meaningful names, small functions, no side effects, self-documenting code

## LLM Behavioral Guidelines
- **Think Before Coding**: State assumptions explicitly, surface tradeoffs, ask when requirements are unclear
- **Simplicity First**: Prefer the minimum code that solves the problem; avoid speculative features and unnecessary abstractions
- **Surgical Changes**: Touch only what is required for the task, keep changes tightly scoped, match surrounding style
- **Goal-Driven Execution**: Turn vague requests into verifiable outcomes, ideally with a failing test or concrete success criteria before implementation

## Naming Conventions
- Use meaningful, searchable names
- Avoid abbreviations (`userRepository` not `uRepo`)
- Booleans start with `is`, `has`, or `can`

## Function & Method Design
- **Single Responsibility**: One function does one thing
- **Small Size**: Aim for < 20 lines; classes < 300 lines
- **Parameters**: Max 3-4; use an object/DTO if more needed
- **Pure Functions**: Favor functions without side effects

## Error Handling
- Never swallow exceptions silently
- Use specific exception types
- Fail fast: validate inputs at function start (Guard Clauses)

## Code Style
- **Guard Clauses**: Early returns instead of nested `if` blocks
- **Comments**: Code explains "how", comments explain "why" (only if code isn't clear)
- No hardcoded secrets, URLs, or env-specific values — use config/env vars
- No speculative abstractions — implement what's needed now

## Review Checklist
- [ ] Does the code follow SOLID principles?
- [ ] Is there any duplicated logic that could be extracted?
- [ ] Are variable and function names descriptive?
- [ ] Are functions small and focused?
- [ ] Does it avoid nested `if/else` where guard clauses could be used?
- [ ] Are exceptions handled properly with context?
