---
name: user-setup
description: User's machine, dotfiles layout, and workflow defaults
metadata:
  type: user
---

- OS: Arch Linux · Shell: zsh · Home: /home/chase
- Git: chasebrowndev / chase.brown.dev
- WM: Hyprland (cyberpunk red/black, sharp edges)
- Terminal: kitty   Editor: micro for manual edits

## Layout
- `~/.config/hypr/hyprland.conf` sources `theme.conf` (the real config)
- `~/.config/themes/<name>/` holds per-theme assets
- `~/dotfiles/` mirrors `~/.config/`; PostToolUse hook auto-commits on edits
- `~/scripts/aliases.sh`, `~/bin/scd.py` — personal helpers

## Workflow
- Direct execution > planning. No frameworks, no scaffolding.
- After hypr edits: `hyprctl reload`. After zshrc edits: open new shell.
- Aliases: `ls`→eza, `cat`→`bat --style=plain`, `diff`→delta, `cd`→zoxide
