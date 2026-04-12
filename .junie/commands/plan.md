---
name: plan
description: Create a detailed plan for a task or issue.
arguments:
  - name: task
    description: Description of the task to plan
    required: true
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
