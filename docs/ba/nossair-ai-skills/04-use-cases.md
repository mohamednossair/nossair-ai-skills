[<- Back to Index](./README.md) | [Previous: Requirements](./03-requirements.md) | [Next: Acceptance Criteria ->](./05-acceptance-criteria.md)

# 4. Use Cases

**Project**: nossair-ai-skills | **Module**: nossair-ai-skills | **Version**: 1.0

## UC-01: Developer Reviews Code Using AI Assistant

**Actor**: Developer using any supported AI assistant (Claude Code, Codex, Junie, Windsurf)

**Preconditions**:
- AI assistant has been set up with the appropriate skills from this repository
- Developer has a code file to review

**Main Flow**:
1. Developer opens their AI assistant
2. Developer invokes the `/review` command with the file path (e.g., `/review file="src/Service.java"`)
3. AI assistant reads the review workflow from the agent-specific directory
4. AI assistant identifies the technology from the file extension
5. AI assistant loads the relevant coding standards and skill definition
6. AI assistant analyzes the code for correctness, security, performance, and readability
7. AI assistant groups findings by severity (Critical, Warning, Suggestion)
8. AI assistant outputs each finding with location, issue description, impact, and fix suggestion
9. Developer reviews the findings
10. Developer applies the suggested fixes to the code

**Alternative Flows**:
- **A1**: File extension not recognized - AI assistant applies global engineering principles instead
- **A2**: No issues found - AI assistant reports that code meets standards

**Postconditions**:
- Code has been reviewed against established standards
- Developer has actionable feedback to improve code quality

---

## UC-02: Developer Plans Feature Implementation

**Actor**: Developer using any supported AI assistant

**Preconditions**:
- AI assistant has been set up with the appropriate skills
- Developer has a feature requirement to implement

**Main Flow**:
1. Developer opens their AI assistant
2. Developer invokes the `/plan` command with the task description (e.g., `/plan task="Add user authentication"`)
3. AI assistant reads the plan workflow
4. AI assistant breaks the task into logical, actionable steps
5. For each step, AI assistant identifies files to create or modify
6. AI assistant identifies applicable coding standards and patterns
7. AI assistant identifies relevant skills to use during implementation
8. AI assistant estimates complexity and flags risks
9. AI assistant outputs a numbered plan with files, standards, skills, and risk per step
10. Developer reviews the plan
11. Developer follows the plan to implement the feature

**Alternative Flows**:
- **A1**: Task description is too vague - AI assistant asks clarifying questions
- **A2**: No relevant skills identified - AI assistant proceeds with general engineering principles

**Postconditions**:
- Developer has a structured implementation plan
- Developer knows which files to modify and which standards to apply
- Developer is aware of potential risks

---

## UC-03: Developer Generates Unit Tests

**Actor**: Developer using any supported AI assistant

**Preconditions**:
- AI assistant has been set up with the appropriate skills
- Developer has a source file that needs tests

**Main Flow**:
1. Developer opens their AI assistant
2. Developer invokes the `/test-generate` command with the file path (e.g., `/test-generate file="src/Service.java"`)
3. AI assistant reads the test generation workflow
4. AI assistant identifies the technology from the file extension
5. AI assistant selects the appropriate testing framework (JUnit 5 for Java, Jest for TypeScript/Python)
6. AI assistant loads testing standards and patterns
7. AI assistant analyzes the source code to understand public behavior
8. AI assistant generates test cases covering happy path, edge cases, and error paths
9. AI assistant applies the AAA pattern (Arrange, Act, Assert)
10. AI assistant names tests following the should<Behavior>_when<Condition> pattern
11. AI assistant outputs the complete test file
12. Developer reviews the generated tests
13. Developer runs the tests to verify they pass

**Alternative Flows**:
- **A1**: Technology not supported - AI assistant reports that test generation is not available for this technology
- **A2**: Source file has no testable behavior - AI assistant suggests what to test or reports that the file doesn't need tests

**Postconditions**:
- Developer has a complete test file following project standards
- Tests cover happy path, edge cases, and error paths

---

## UC-04: Developer Creates Git Commit

**Actor**: Developer using any supported AI assistant

**Preconditions**:
- AI assistant has been set up with the appropriate skills
- Developer has made code changes

**Main Flow**:
1. Developer opens their AI assistant
2. Developer invokes the `/git-commit` command
3. AI assistant reads the git commit workflow
4. AI assistant runs git status --short to see changed files
5. AI assistant runs git diff --stat to see summary of changes
6. AI assistant runs git diff --cached to see staged changes
7. AI assistant runs git diff to see unstaged changes
8. AI assistant runs git branch --show-current to see current branch
9. If current branch is main, master, or develop:
   a. AI assistant analyzes the changes to determine branch prefix (feature/, bugfix/, docs/, chore/)
   b. AI assistant checks if a Bitbucket/Jira issue ID is clearly available
   c. AI assistant creates a new branch with git switch -c <branch-name>
10. AI assistant analyzes the changes to determine commit type (feat, fix, refactor, test, docs, chore, perf, style)
11. AI assistant writes a commit message following Conventional Commits format
12. AI assistant stages the appropriate files
13. AI assistant runs git commit
14. AI assistant outputs the commit hash and final commit message

**Alternative Flows**:
- **A1**: No changes to commit - AI assistant reports that there are no changes and stops
- **A2**: Already on a feature branch - AI assistant skips branch creation and proceeds with commit

**Postconditions**:
- Changes are committed with a conventional commit message
- Commit is on an appropriate branch following team workflow

---

## UC-05: Engineering Lead Deploys Skills to Claude Code

**Actor**: Engineering lead or developer

**Preconditions**:
- Developer has access to the nossair-ai-skills repository
- Claude Code is installed on the developer's machine

**Main Flow**:
1. Developer navigates to the nossair-ai-skills repository
2. Developer runs the sync script for their operating system (Linux/macOS: bash scripts/sync-claude.sh, Windows: .\scripts\sync-claude.ps1)
3. Script copies files from .claude/skills/ to ~/.claude/skills/
4. Script reports which files were copied
5. Developer restarts Claude Code if it was running
6. Developer opens Claude Code and verifies commands are available

**Alternative Flows**:
- **A1**: Claude Code skills directory doesn't exist - Script creates the directory
- **A2**: Permission denied - Script reports error and suggests running with appropriate permissions

**Postconditions**:
- Claude Code has access to all unified commands and tech-specific review commands
- Skills are available globally for all projects

---

## UC-06: Engineering Lead Deploys Skills to Codex

**Actor**: Engineering lead or developer

**Preconditions**:
- Developer has access to the nossair-ai-skills repository
- Codex is installed on the developer's machine
- CODEX_HOME environment variable is set (optional)

**Main Flow**:
1. Developer navigates to the nossair-ai-skills repository
2. Developer runs the sync script for their operating system (Linux/macOS: bash scripts/sync-codex.sh, Windows: .\scripts\sync-codex.ps1)
3. Script copies folders from .junie/skills/ to $CODEX_HOME/skills/ or ~/.codex/skills/
4. Script reports which skills were copied
5. Developer restarts Codex if it was running
6. Developer opens Codex and verifies skills are loaded

**Alternative Flows**:
- **A1**: Codex skills directory doesn't exist - Script creates the directory
- **A2**: Permission denied - Script reports error and suggests running with appropriate permissions

**Postconditions**:
- Codex has access to all skills (global, java, spring-boot, typescript, python, angular, git, maven, oracle, mysql, junit, jest, speckit)
- Codex auto-loads skills based on request context

---

## UC-07: Developer Sets Up Junie for a Project

**Actor**: Developer starting a new project

**Preconditions**:
- Developer has access to the nossair-ai-skills repository
- Developer has a project directory

**Main Flow**:
1. Developer navigates to the nossair-ai-skills repository
2. Developer copies the .junie/ folder to their project directory (Linux/macOS: cp -r .junie /your-project/, Windows: Copy-Item -Path .junie -Destination C:\your-project\ -Recurse)
3. Developer verifies the .junie/ folder contains skills/, commands/, and guidelines.md
4. Developer opens Junie in their project
5. Developer invokes a unified command to verify setup

**Alternative Flows**:
- **A1**: .junie/ folder already exists in project - Developer is prompted to overwrite or merge

**Postconditions**:
- Junie has access to skills, commands, and guidelines for the project
- Junie reads guidelines.md automatically for all code generation and reviews

---

## UC-08: Developer Uses Speckit for Feature Development

**Actor**: Developer working on a feature

**Preconditions**:
- AI assistant has been set up with Speckit workflows
- Developer has a feature requirement

**Main Flow**:
1. Developer invokes `/speckit.specify feature="..."` with the feature description
2. AI assistant creates a structured specification with goals, acceptance criteria, data model, and open questions
3. AI assistant prompts to create or switch to a feature/spec/<id>-<slug> branch
4. Developer reviews and refines the specification
5. Developer invokes `/speckit.plan spec="..."` with the specification file
6. AI assistant creates an implementation plan with milestones, deliverables, dependencies, and risks
7. Developer reviews the plan
8. Developer invokes `/speckit.tasks plan="..."` with the plan file
9. AI assistant generates dependency-ordered tasks with acceptance criteria and definition of done
10. Developer invokes `/speckit.validate spec="..." plan="..." tasks="..."` to check consistency
11. AI assistant reports any gaps or inconsistencies
12. Developer addresses any issues
13. Developer invokes `/speckit.implement tasks="..."` to generate an execution runbook
14. AI assistant creates a runbook with branch strategy, commit slices, test scaffolds, and review checkpoints
15. Developer follows the runbook to implement the feature
16. Developer uses /test-generate and /review at each checkpoint
17. Developer uses /git-commit to commit work at appropriate points

**Alternative Flows**:
- **A1**: Validation fails - Developer addresses gaps before proceeding
- **A2**: Plan needs adjustment - Developer updates plan and regenerates tasks

**Postconditions**:
- Feature is implemented following a structured, traceable process
- All artifacts (spec, plan, tasks) are consistent
- Code has been tested and reviewed at each checkpoint
- Git history follows team workflow rules

---

## UC-09: Engineering Lead Adds Support for a New Technology

**Actor**: Engineering lead

**Preconditions**:
- Engineering lead has access to the nossair-ai-skills repository
- Engineering lead wants to add support for a new technology

**Main Flow**:
1. Engineering lead runs the scaffold script (Linux/macOS: bash scripts/new-skill.sh <tech>, Windows: .\scripts\new-skill.ps1 <tech>)
2. Script generates template files in .junie/skills/<tech>/, .claude/skills/<tech>-review.md, and .windsurf/memories/<tech>-standards.md
3. Engineering lead populates the skill definition with technology-specific principles and checklists
4. Engineering lead updates the Claude review command with technology-specific review points
5. Engineering lead updates the Windsurf memory with coding standards
6. Engineering lead adds relevant rules to .junie/guidelines.md
7. Engineering lead runs sync-claude script to deploy to Claude Code
8. Engineering lead runs sync-codex script to deploy to Codex
9. Engineering lead updates README.md and AGENTS.md to document the new technology
10. Engineering lead tests the new skill by invoking it in an AI assistant

**Alternative Flows**:
- **A1**: Script fails - Engineering lead checks error messages and resolves issues

**Postconditions**:
- New technology is supported across all AI assistants
- Documentation is updated
- Skills are deployed to Claude Code and Codex

---

## UC-10: Maintainer Validates Command Parity

**Actor**: Maintainer of the repository

**Preconditions**:
- Maintainer has made changes to unified command definitions
- Maintainer wants to ensure consistency across agents

**Main Flow**:
1. Maintainer runs the validation script (Linux/macOS: bash scripts/check-command-parity.sh, Windows: powershell -ExecutionPolicy Bypass -File scripts/check-command-parity.ps1)
2. Script compares command definitions across .claude/skills/, .junie/commands/, and .windsurf/workflows/
3. Script reports any inconsistencies in command names, descriptions, or parameters
4. Maintainer reviews the report
5. If inconsistencies found, Maintainer updates the affected files to restore parity
6. Maintainer re-runs the validation script to verify fixes

**Alternative Flows**:
- **A1**: No inconsistencies found - Script reports success
- **A2**: Script encounters errors - Maintainer investigates and resolves

**Postconditions**:
- Unified commands are consistent across all AI assistants
- CI checks (GitHub Actions, Bitbucket Pipelines) will validate parity automatically
