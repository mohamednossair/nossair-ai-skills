[<- Back to Index](./README.md) | [Previous: Scope & Context](./02-scope-context.md) | [Next: Use Cases ->](./04-use-cases.md)

# 3. Requirements

**Project**: nossair-ai-skills | **Module**: nossair-ai-skills | **Version**: 1.0

## User Stories

### Unified Commands

**UR-001: Code Review**
- **As a** developer using an AI coding assistant
- **I want** to invoke a unified `/review` command that works consistently across all AI assistants
- **So that** I can get consistent code quality feedback regardless of which AI tool I use

**UR-002: Implementation Planning**
- **As a** developer starting a new feature
- **I want** to invoke a unified `/plan` command that breaks down tasks into actionable steps
- **So that** I can approach implementation systematically with clear guidance

**UR-003: Test Generation**
- **As a** developer writing new code
- **I want** to invoke a unified `/test-generate` command that produces tests following project standards
- **So that** I can quickly generate comprehensive test coverage without manually writing boilerplate

**UR-004: Git Commit Creation**
- **As a** developer committing code
- **I want** to invoke a unified `/git-commit` command that creates conventional commits with proper branching
- **So that** I can maintain consistent Git history and follow team workflow rules

### Speckit Toolkit

**UR-005: Feature Specification**
- **As a** developer receiving a feature request
- **I want** to invoke `/speckit.specify` to create a structured specification from natural language
- **So that** I can capture requirements, acceptance criteria, and data model in a consistent format

**UR-006: Implementation Planning**
- **As a** developer with a feature specification
- **I want** to invoke `/speckit.plan` to convert the spec into a concrete implementation plan
- **So that** I can identify milestones, deliverables, dependencies, and risks

**UR-007: Task Generation**
- **As a** developer with an implementation plan
- **I want** to invoke `/speckit.tasks` to generate dependency-ordered task lists
- **So that** I can execute tasks in the correct order with clear acceptance criteria

**UR-008: Validation**
- **As a** developer before implementation
- **I want** to invoke `/speckit.validate` to check consistency across spec, plan, and tasks
- **So that** I can identify gaps and ensure traceability before writing code

**UR-009: Gap Analysis**
- **As a** developer reviewing project artifacts
- **I want** to invoke `/speckit.analyze` to detect gaps and prioritize fixes
- **So that** I can systematically identify missing or inconsistent elements

**UR-010: Execution Runbook**
- **As a** developer ready to implement
- **I want** to invoke `/speckit.implement` to generate an execution runbook with test and review gates
- **So that** I can follow a structured approach with proper quality checkpoints

**UR-011: Document Generation**
- **As a** developer or business analyst
- **I want** to invoke `/speckit.document-generate` to generate Business Analysis documents from code
- **So that** I can quickly create project documentation that explains the system in business terms

### Skill Deployment

**UR-012: Claude Code Deployment**
- **As a** developer using Claude Code
- **I want** to run a sync script to deploy skills globally
- **So that** I can use unified commands without manually copying files

**UR-013: Codex Deployment**
- **As a** developer using Codex
- **I want** to run a sync script to deploy skills globally
- **So that** Codex can auto-load skills based on request context

**UR-014: Junie Project Setup**
- **As a** developer setting up a new project for Junie
- **I want** to copy the `.junie/` folder to my project
- **So that** Junie can access skills, commands, and guidelines

**UR-015: Windsurf Project Setup**
- **As a** developer setting up a new project for Windsurf
- **I want** to copy the `.windsurf/` folder to my project
- **So that** Windsurf can load memories and workflows automatically

**UR-016: JetBrains AI Assistant Setup**
- **As a** developer using JetBrains IDE
- **I want** to copy the `.aiassistant/` folder to my project
- **So that** JetBrains AI Assistant can apply project-specific rules

### Technology-Specific Guidance

**UR-017: Java Standards**
- **As a** Java developer
- **I want** AI assistants to apply Java 21+ LTS standards (virtual threads, records, sealed classes)
- **So that** my code follows modern Java best practices

**UR-018: TypeScript Standards**
- **As a** TypeScript developer
- **I want** AI assistants to enforce strict typing and modern TypeScript patterns
- **So that** my code is type-safe and maintainable

**UR-019: Python Standards**
- **As a** Python developer
- **I want** AI assistants to follow PEP 8 and require type hints
- **So that** my code is consistent and properly typed

**UR-020: Spring Boot Patterns**
- **As a** Spring Boot developer
- **I want** AI assistants to apply layered architecture and Spring best practices
- **So that** my application is well-structured and follows Spring conventions

**UR-021: Angular Patterns**
- **As a** Angular developer
- **I want** AI assistants to use Angular 20+ patterns (signals, standalone components, OnPush)
- **So that** my components are performant and follow modern Angular practices

### Maintenance

**UR-022: Adding New Technologies**
- **As a** engineering lead
- **I want** to run a scaffold script to generate templates for a new technology
- **So that** I can quickly add support for new technologies across all AI assistants

**UR-023: Command Parity Validation**
- **As a** maintainer
- **I want** to run a validation script to check unified command parity across agents
- **So that** I can ensure commands work consistently across all AI assistants

## Business Rules

### Command Consistency

**BR-001**: All unified commands (/review, /plan, /test-generate, /git-commit) must have identical behavior across Claude Code, Junie, and Windsurf.

**BR-002**: Command definitions must be stored in agent-specific locations (.claude/skills/, .junie/commands/, .windsurf/workflows/) but reference the same underlying logic.

**BR-003**: When a unified command is updated, all agent-specific implementations must be updated to maintain parity.

### Git Workflow

**BR-004**: When `/git-commit` is invoked from main, master, or develop branches, it must create a new work branch before committing.

**BR-005**: Branch names must use prefixes (feature/, bugfix/, docs/, chore/) based on the nature of the work.

**BR-006**: Branch names should include a Bitbucket/Jira issue ID only when one is clearly available.

**BR-007**: Commit messages must follow Conventional Commits format: type(scope): description

**BR-008**: Commit message types are restricted to: feat, fix, refactor, test, docs, chore, perf, style.

**BR-009**: Commit messages must be in imperative mood, maximum 72 characters, with no trailing period.

### Coding Standards

**BR-010**: Java code must use constructor injection only; field @Autowired is prohibited.

**BR-011**: Java public methods must return Optional<T> instead of null.

**BR-012**: TypeScript must have strict: true in tsconfig.json; any type is prohibited.

**BR-013**: Python functions must have type hints on all signatures.

**BR-014**: Spring Boot controllers must be thin with no business logic; business logic belongs in services.

**BR-015**: Angular components must use standalone components only; NgModules are deprecated.

**BR-016**: Angular components must use ChangeDetectionStrategy.OnPush.

**BR-017**: SQL queries must use bind variables; string concatenation of user input is prohibited.

**BR-018**: SELECT * is forbidden in production SQL code; columns must be listed explicitly.

### Testing Standards

**BR-019**: All tests must follow the AAA pattern (Arrange, Act, Assert).

**BR-020**: Test names must follow the pattern: should<ExpectedBehavior>_when<Condition>.

**BR-021**: Tests must cover happy path, edge cases, and error paths.

**BR-022**: Tests must test public behavior, not private methods.

### Security

**BR-023**: No hardcoded secrets, URLs, or environment-specific values are allowed in code.

**BR-024**: Secrets must be externalized to environment variables or a vault.

**BR-025**: Logging must not include passwords, tokens, or personally identifiable information (PII).

### Speckit Workflow

**BR-026**: /speckit.specify must prompt to create or switch to a feature/spec/<id>-<slug> branch before writing.

**BR-027**: /speckit.implement must suggest branch strategy consistent with repo rules (feature/*, bugfix/*).

**BR-028**: /speckit.implement must include test scaffolds (/test-generate) and review checkpoints for each task.

**BR-029**: /speckit.validate must check cross-artifact consistency and traceability between spec, plan, and tasks.

### Deployment

**BR-030**: Claude Code skills must be deployed globally to ~/.claude/skills/.

**BR-031**: Codex skills must be deployed globally to $CODEX_HOME/skills/ or ~/.codex/skills/.

**BR-032**: Junie assets must be deployed per-project by copying the .junie/ folder.

**BR-033**: Windsurf assets must be deployed per-project by copying the .windsurf/ folder.

**BR-034**: JetBrains AI Assistant rules must be deployed per-project by copying the .aiassistant/ folder.

### Documentation

**BR-035**: All skill definitions must be written in markdown format.

**BR-036**: Skill definitions must reference related memory files for consistency.

**BR-037**: Workflow files must include a description in frontmatter for agent discovery.

**BR-038**: Junie command arguments must be inferred from $argumentName placeholders in the prompt body; no name or arguments frontmatter allowed.
