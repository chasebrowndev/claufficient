---
name: decision-rules
description: Rules for making decisions efficiently and matching user preferences
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## Execution Style
**Rule**: Prefer direct action over extensive planning.
**Why**: User values speed and minimal ceremony. Planning is only for complex multi-part tasks.
**How to apply**: Unless the task has 4+ unclear parts or requires user clarification, just start executing. Skip EnterPlanMode for straightforward work.

## Design Choices
**Rule**: When multiple valid approaches exist, pick the simplest.
**Why**: Complexity creates future burden. User prefers minimal, clean implementations.
**How to apply**: Always ask: "Is there a simpler way?" Default to fewer files, fewer abstractions, fewer configuration layers.

## Refactoring & Cleanup
**Rule**: Don't refactor unless explicitly asked.
**Why**: Every change risks regression. Don't improve code that's already working.
**How to apply**: Bug fixes stay focused. Enhancements don't include surrounding cleanup. Three similar lines is fine.

## File Operations
**Rule**: Edit existing files, don't create new ones.
**Why**: Keeps codebase minimal. User prefers to consolidate, not scatter.
**How to apply**: Before creating a new file, ask: "Can this go in an existing file?" Only create new if truly necessary.

## Aesthetic Choices
**Rule**: Cyberpunk sharp > soft/cute. Hard edges > blur. Minimal > ornate.
**Why**: User's entire setup reflects this. Red/black, no gradients, tight spacing, precision.
**How to apply**: When styling anything (terminal, UI, config), favor contrast, hardness, minimalism. No soft colors, no bloat.

## Response Length
**Rule**: Short and direct. No trailing summaries.
**Why**: User can read diffs. Unnecessary recap wastes tokens and attention.
**How to apply**: State results directly. Only add summary if the user's request specifically asked for one or if there's genuine ambiguity about what changed.

## Configuration Philosophy
**Rule**: Direct edits to config files, minimal frameworks/abstractions.
**Why**: User's zsh, hyprland, and kitty configs are all hand-written and minimal. No oh-my-zsh, no fancy frameworks.
**How to apply**: When suggesting config changes, keep them minimal. Prefer setting one variable to adding a new layer.
