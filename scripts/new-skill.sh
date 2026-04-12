#!/bin/bash
# new-skill.sh
# Automates the creation of a new skill across Claude Code, Junie, and Windsurf.
# Usage: ./scripts/new-skill.sh <tech-name>

TECH_NAME=$1
if [ -z "$TECH_NAME" ]; then
    echo "Error: Please provide a technology name (e.g., rust, go, flutter)."
    exit 1
fi

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JUNIE_SKILL_DIR="$REPO_DIR/.junie/skills/$TECH_NAME"
CLAUDE_SKILL_FILE="$REPO_DIR/.claude/skills/$TECH_NAME-review.md"
WINDSURF_MEMORY_FILE="$REPO_DIR/.windsurf/memories/$TECH_NAME-standards.md"

# Helper for title case
CAP_TECH_NAME=$(echo "$TECH_NAME" | sed 's/./\U&/')

# 1. Create Junie Skill folder and file
if [ ! -d "$JUNIE_SKILL_DIR" ]; then
    mkdir -p "$JUNIE_SKILL_DIR"
    sed -e "s/\[technology-name\]/$TECH_NAME/g" \
        -e "s/\[Technology Name\]/$CAP_TECH_NAME/g" \
        "$REPO_DIR/templates/skill_template.md" > "$JUNIE_SKILL_DIR/SKILL.md"
    echo "  ✓ Created Junie Skill: .junie/skills/$TECH_NAME/SKILL.md"
else
    echo "  ! Junie Skill directory already exists: $JUNIE_SKILL_DIR"
fi

# 2. Create Claude Skill file
if [ ! -f "$CLAUDE_SKILL_FILE" ]; then
    sed "s/\[Technology\]/$CAP_TECH_NAME/g" \
        "$REPO_DIR/templates/claude_skill_template.md" > "$CLAUDE_SKILL_FILE"
    echo "  ✓ Created Claude Command: .claude/skills/$TECH_NAME-review.md"
else
    echo "  ! Claude Command file already exists: $CLAUDE_SKILL_FILE"
fi

# 3. Create Windsurf Memory file
if [ ! -f "$WINDSURF_MEMORY_FILE" ]; then
    echo "# $CAP_TECH_NAME Standards" > "$WINDSURF_MEMORY_FILE"
    echo "## Coding Standards" >> "$WINDSURF_MEMORY_FILE"
    echo "- Standard 1" >> "$WINDSURF_MEMORY_FILE"
    echo "- Standard 2" >> "$WINDSURF_MEMORY_FILE"
    echo "  ✓ Created Windsurf Memory: .windsurf/memories/$TECH_NAME-standards.md"
else
    echo "  ! Windsurf Memory file already exists: $WINDSURF_MEMORY_FILE"
fi

echo -e "\nSkill scaffolding complete for: $TECH_NAME"
echo "Next steps:"
echo "1. Edit the generated files to add specific rules."
echo "2. Add the technology to .junie/guidelines.md (Optional for core tech)."
echo "3. Update the relevant README sections if needed (for example: Tech Stack Covered or Claude tech-review commands)."
echo "4. Re-sync Claude Code with ./scripts/sync-claude.sh"
