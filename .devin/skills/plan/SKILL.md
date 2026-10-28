---
name: plan
description: Create a detailed implementation plan for a task or feature
argument-hint: 'task="Describe the task"'
allowed-tools:
  - read
  - grep
  - glob
triggers:
  - user
  - model
---

Analyze the following task: $task.

1. Break down the task into logical, actionable steps.
2. For each step, identify which files need to be modified or created.
3. Identify applicable coding standards and patterns.
4. Identify which skills from `.junie/skills/` are relevant and should be used during implementation.
5. Estimate complexity and flag risks.
6. Format the final output as a numbered plan with:
   - **Step N**: [Action]
   - Files: [list]
   - Standards: [applicable rules]
   - Skills: [relevant skills]
   - Risk: [if any]

Before finalizing, state assumptions explicitly and ask about anything that would significantly change the design.
