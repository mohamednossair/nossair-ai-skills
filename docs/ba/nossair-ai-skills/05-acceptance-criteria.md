[<- Back to Index](./README.md) | [Previous: Use Cases](./04-use-cases.md) | [Next: Data & Reporting ->](./06-data-reporting.md)

# 5. Acceptance Criteria

**Project**: nossair-ai-skills | **Module**: nossair-ai-skills | **Version**: 1.0

## AC-001: Unified /review Command

**Given** a developer has set up their AI assistant with skills from this repository
**When** the developer invokes `/review file="src/Service.java"`
**Then** the AI assistant should:
- Identify the technology from the file extension
- Load the relevant coding standards and skill definition
- Analyze the code for correctness, security, performance, and readability
- Group findings by severity (Critical, Warning, Suggestion)
- Output each finding with location, issue description, impact, and fix suggestion
- Apply the same logic regardless of which AI assistant is used (Claude Code, Junie, Windsurf)

---

## AC-002: Unified /plan Command

**Given** a developer has set up their AI assistant with skills from this repository
**When** the developer invokes `/plan task="Add user authentication"`
**Then** the AI assistant should:
- Break the task into logical, actionable steps
- For each step, identify files to create or modify
- Identify applicable coding standards and patterns
- Identify relevant skills to use during implementation
- Estimate complexity and flag risks
- Output a numbered plan with files, standards, skills, and risk per step
- Apply the same logic regardless of which AI assistant is used

---

## AC-003: Unified /test-generate Command

**Given** a developer has set up their AI assistant with skills from this repository
**When** the developer invokes `/test-generate file="src/Service.java"`
**Then** the AI assistant should:
- Identify the technology from the file extension
- Select the appropriate testing framework (JUnit 5 for Java, Jest for TypeScript/Python)
- Load testing standards and patterns
- Analyze the source code to understand public behavior
- Generate test cases covering happy path, edge cases, and error paths
- Apply the AAA pattern (Arrange, Act, Assert)
- Name tests following the should<Behavior>_when<Condition> pattern
- Output the complete test file
- Apply the same logic regardless of which AI assistant is used

---

## AC-004: Unified /git-commit Command

**Given** a developer has set up their AI assistant with skills from this repository
**When** the developer invokes `/git-commit` with uncommitted changes
**Then** the AI assistant should:
- Run git status --short to see changed files
- Run git diff --stat to see summary of changes
- Run git diff --cached to see staged changes
- Run git diff to see unstaged changes
- Run git branch --show-current to see current branch
- If current branch is main, master, or develop:
  - Analyze changes to determine branch prefix (feature/, bugfix/, docs/, chore/)
  - Check if a Bitbucket/Jira issue ID is clearly available
  - Create a new branch with git switch -c <branch-name>
- Analyze changes to determine commit type (feat, fix, refactor, test, docs, chore, perf, style)
- Write a commit message following Conventional Commits format (type(scope): description)
- Stage the appropriate files
- Run git commit
- Output the commit hash and final commit message
- Apply the same logic regardless of which AI assistant is used

---

## AC-005: Claude Code Skill Deployment

**Given** a developer has access to the nossair-ai-skills repository and Claude Code is installed
**When** the developer runs the sync script (bash scripts/sync-claude.sh on Linux/macOS, .\scripts\sync-claude.ps1 on Windows)
**Then** the script should:
- Copy all files from .claude/skills/ to ~/.claude/skills/
- Create the target directory if it doesn't exist
- Report which files were copied
- Not fail if the target directory already exists

---

## AC-006: Codex Skill Deployment

**Given** a developer has access to the nossair-ai-skills repository and Codex is installed
**When** the developer runs the sync script (bash scripts/sync-codex.sh on Linux/macOS, .\scripts\sync-codex.ps1 on Windows)
**Then** the script should:
- Copy all folders from .junie/skills/ to $CODEX_HOME/skills/ or ~/.codex/skills/
- Create the target directory if it doesn't exist
- Report which skills were copied
- Not fail if the target directory already exists

---

## AC-007: Junie Project Setup

**Given** a developer has access to the nossair-ai-skills repository and a project directory
**When** the developer copies the .junie/ folder to their project directory
**Then** the project directory should contain:
- .junie/skills/ with technology-specific skill folders
- .junie/commands/ with unified command definitions
- .junie/guidelines.md with project-wide coding standards

---

## AC-008: Windsurf Project Setup

**Given** a developer has access to the nossair-ai-skills repository and a project directory
**When** the developer copies the .windsurf/ folder to their project directory
**Then** the project directory should contain:
- .windsurf/memories/ with persistent context files
- .windsurf/workflows/ with slash command definitions

---

## AC-009: JetBrains AI Assistant Setup

**Given** a developer has access to the nossair-ai-skills repository and a project directory
**When** the developer copies the .aiassistant/ folder to their project directory
**Then** the project directory should contain:
- .aiassistant/rules/ with project-specific rules for JetBrains AI Assistant

---

## AC-010: Speckit Specification Generation

**Given** a developer has set up their AI assistant with Speckit workflows
**When** the developer invokes `/speckit.specify feature="..."` with a feature description
**Then** the AI assistant should:
- Extract goals, non-goals, users, and constraints
- Define acceptance criteria as bullet points
- Outline data model and interfaces at a high level
- Note open questions (max 5) to resolve ambiguities
- Keep the specification brief
- Prompt to create or switch to a feature/spec/<id>-<slug> branch before writing

---

## AC-011: Speckit Plan Generation

**Given** a developer has a feature specification file
**When** the developer invokes `/speckit.plan spec="path/to/spec.md"`
**Then** the AI assistant should:
- Identify milestones (2-5), each outcome-oriented
- For each milestone, list key deliverables and risks
- Define dependencies and owners if known
- Keep steps lean and avoid micro-tasks

---

## AC-012: Speckit Tasks Generation

**Given** a developer has an implementation plan file
**When** the developer invokes `/speckit.tasks plan="path/to/plan.md"`
**Then** the AI assistant should:
- Create tasks grouped by milestone with IDs
- Order tasks by dependencies
- Assign one owner per task if known
- Include acceptance criteria and definition of done for each task
- Keep tasks concise and avoid repeating spec/plan text

---

## AC-013: Speckit Validation

**Given** a developer has spec, plan, and tasks files
**When** the developer invokes `/speckit.validate spec="..." plan="..." tasks="..."`
**Then** the AI assistant should:
- Perform cross-artifact checks for consistency
- Verify traceability between spec, plan, and tasks
- Report any gaps or inconsistencies
- Suggest fixes for identified issues

---

## AC-014: Speckit Implementation Runbook

**Given** a developer has a tasks file
**When** the developer invokes `/speckit.implement tasks="path/to/tasks.md"`
**Then** the AI assistant should:
- Create an execution plan ordered by dependencies and risk
- Suggest branch strategy per milestone/task consistent with repo rules (feature/*, bugfix/*)
- For each task, propose commit slices, test scaffolds (/test-generate), and review checkpoints (/*-review)
- Track Definition of Done and link back to AC IDs for traceability
- Output a runbook with commands and checkpoints to execute safely

---

## AC-015: Command Parity Validation

**Given** a maintainer has made changes to unified command definitions
**When** the maintainer runs the validation script (bash scripts/check-command-parity.sh on Linux/macOS, powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1 on Windows)
**Then** the script should:
- Compare command definitions across .claude/skills/, .junie/commands/, and .windsurf/workflows/
- Report any inconsistencies in command names, descriptions, or parameters
- Exit with success code if no inconsistencies found
- Exit with error code if inconsistencies found

---

## AC-016: New Technology Scaffolding

**Given** an engineering lead wants to add support for a new technology
**When** the engineering lead runs the scaffold script (bash scripts/new-skill.sh <tech> on Linux/macOS, .\scripts\new-skill.ps1 <tech> on Windows)
**Then** the script should:
- Create .junie/skills/<tech>/ folder with SKILL.md template
- Create .claude/skills/<tech>-review.md template
- Create .windsurf/memories/<tech>-standards.md template
- Report which files were created
- Not fail if the technology folder already exists

---

## AC-017: Java Coding Standards Application

**Given** a developer invokes an AI assistant on Java code
**When** the AI assistant reviews or generates Java code
**Then** the AI assistant should:
- Use constructor injection only (never @Autowired on fields)
- Return Optional<T> instead of null from public methods
- Use record for DTOs and value objects
- Use sealed classes for restricted type hierarchies
- Use pattern matching in switch and instanceof
- Use java.time only (no Date, Calendar, SimpleDateFormat)
- Use StringBuilder in loops, not string +
- Use try-with-resources for all Closeable resources
- Catch specific exceptions and include original cause in rethrows

---

## AC-018: TypeScript Coding Standards Application

**Given** a developer invokes an AI assistant on TypeScript code
**When** the AI assistant reviews or generates TypeScript code
**Then** the AI assistant should:
- Enforce strict: true in tsconfig.json
- Prohibit any type (use unknown with narrowing instead)
- Use explicit return types on public API functions
- Prefer named exports over default exports
- Use optional chaining (?.) and nullish coalescing (??) for null handling
- Use Promise.allSettled() for partial success scenarios

---

## AC-019: Python Coding Standards Application

**Given** a developer invokes an AI assistant on Python code
**When** the AI assistant reviews or generates Python code
**Then** the AI assistant should:
- Use type hints on all function signatures
- Use 4-space indentation and 88-character line limit
- Use specific except clauses (no bare except:)
- Use with statement for file/DB resources
- Use f-strings for formatting
- Use None for mutable defaults
- Use Protocol for structural typing

---

## AC-020: Spring Boot Pattern Application

**Given** a developer invokes an AI assistant on Spring Boot code
**When** the AI assistant reviews or generates Spring Boot code
**Then** the AI assistant should:
- Apply layered architecture (controller → service → repository)
- Use @Transactional on service layer only
- Use @Valid on @RequestBody with Bean Validation
- Use @RestControllerAdvice for global exception handling
- Never return JPA entity from controller (use DTO records)
- Use FetchType.LAZY on all JPA relations
- Use @EntityGraph for intentional eager loading
- Use Lombok @RequiredArgsConstructor, @Getter, @Slf4j
- Avoid @Data on entities
- Use API versioning via URI path (/api/v1/...)

---

## AC-021: Angular Pattern Application

**Given** a developer invokes an AI assistant on Angular code
**When** the AI assistant reviews or generates Angular code
**Then** the AI assistant should:
- Use standalone components only (NgModules deprecated)
- Use ChangeDetectionStrategy.OnPush on every component
- Use inject() function for all DI
- Use signal() for local mutable state
- Use computed() for derived values
- Use effect() for side effects only
- Use input.required<T>() / input<T>(default) for inputs
- Use output<T>() for outputs
- Use @if / @for / @switch / @defer in templates (not *ngIf / *ngFor)
- Use @for with track by unique ID
- Use async pipe in templates
- Type every HTTP call

---

## AC-022: Testing Standards Application

**Given** a developer invokes an AI assistant to generate tests
**When** the AI assistant generates test code
**Then** the AI assistant should:
- Apply AAA pattern (Arrange, Act, Assert)
- Name tests as should<ExpectedBehavior>_when<Condition>
- Cover happy path, edge cases, and error paths
- Test public behavior, not private methods
- For JUnit 5: use @ExtendWith(MockitoExtension.class), AssertJ assertions
- For Jest: use beforeEach(() => jest.clearAllMocks()), jest.spyOn() for mocks

---

## AC-023: SQL Standards Application

**Given** a developer invokes an AI assistant on SQL code
**When** the AI assistant reviews or generates SQL code
**Then** the AI assistant should:
- Always use bind variables (never concatenate user input)
- Never use SELECT * in production code (list columns explicitly)
- Index all foreign key columns
- Use FETCH FIRST N ROWS ONLY (Oracle) / LIMIT (MySQL) for pagination
- Design schema changes via Flyway migrations only

---

## AC-024: Security Standards Application

**Given** a developer invokes an AI assistant on any code
**When** the AI assistant reviews or generates code
**Then** the AI assistant should:
- Reject any hardcoded secrets, URLs, or environment-specific values
- Suggest externalizing secrets to environment variables or a vault
- Reject logging of passwords, tokens, or personally identifiable information (PII)
- Apply least privilege principles
- Validate inputs at boundaries

---

## AC-025: Git Workflow Compliance

**Given** a developer invokes /git-commit
**When** the current branch is main, master, or develop
**Then** the AI assistant should:
- Create a new branch before committing
- Use appropriate branch prefix (feature/, bugfix/, docs/, chore/)
- Include Bitbucket/Jira issue ID only when clearly available
- Attach local uncommitted changes to the new branch

---

## AC-026: Conventional Commits Compliance

**Given** a developer invokes /git-commit
**When** the AI assistant creates a commit message
**Then** the AI assistant should:
- Use format: type(scope): description
- Restrict type to: feat, fix, refactor, test, docs, chore, perf, style
- Use imperative mood
- Limit to 72 characters
- No trailing period

---

## AC-027: CI Integration for Command Parity

**Given** the repository has GitHub Actions or Bitbucket Pipelines configured
**When** a pull request is submitted
**Then** the CI pipeline should:
- Run the command parity validation script
- Fail the build if inconsistencies are detected
- Pass the build if all commands are consistent

---

## AC-028: Documentation Completeness

**Given** a reviewer examines the repository documentation
**When** checking for completeness
**Then** the documentation should include:
- README.md with setup instructions for all agents
- AGENTS.md with agent-specific usage details
- Coding standards for all supported technologies
- Testing standards for all supported frameworks
- Command definitions for all unified commands
- Workflow definitions for all Speckit commands
