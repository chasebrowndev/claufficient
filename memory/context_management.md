---
name: context-management
description: Context management and memory hygiene practices
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## Context Window Management

### Auto-Compaction Settings
- **Enabled**: true (automatic compaction when context fills)
- **Window size**: 200,000 tokens (triggers compaction when reached)
- **Cleanup period**: 30 days (old transcripts auto-deleted)

### When Compaction Happens
- Automatically when context approaches limit
- Removes old messages while preserving task state
- Summary inserted for continuity
- User can also trigger with `/compact`

## Memory Hygiene

### Memory System Location
`~/.claude/projects/-home-chase/memory/`

### Current Memories
- user_setup.md — Environment, theming, structure
- tools_available.md — CLI tools and usage
- decision_rules.md — How to make choices
- bash_patterns.md — Efficient bash techniques
- hyprland_patterns.md — WM configuration patterns
- dotfiles_management.md — Git sync and stow
- github_mcp_setup.md — GitHub integration
- context_management.md — This file

### Memory Maintenance
- Review and update when major changes occur (new tools, workflow changes)
- Remove stale information (old project structures, deprecated tools)
- Keep focused on what actually helps work (not historical context)

## Documentation Maintenance

### Files to Keep Updated
- **CLAUDE.md** — Master project instructions, filesystem structure, patterns
- **HANDOFF.md** — If created: running tasks, next steps, context for resuming

### Update Reminders
- After major tool installs or config changes
- When workflow patterns change
- Before long breaks (hand off knowledge to future self)

## Token Conservation Practices
1. Use memory system instead of re-explaining context
2. Trust CLAUDE.md for setup details, don't re-read configs
3. Use `/compact` proactively if context feels loaded
4. Rely on git history instead of searching old code
5. Use fd/rg/bat to search efficiently, not brute-force file reading
