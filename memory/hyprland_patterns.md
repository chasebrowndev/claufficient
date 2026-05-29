---
name: hyprland-patterns
description: Where Hyprland config lives and how to change it
metadata:
  type: reference
---

- Entry point: `~/.config/hypr/hyprland.conf` (machine-local input overrides only)
- Real config: `~/.config/hypr/theme.conf` — all keybinds, decorations, animations, rules go here
- Per-theme assets: `~/.config/themes/<name>/{waybar.jsonc,waybar.css,wallpaper.jpg}`

## After editing theme.conf
```
hyprctl reload
```
The PostToolUse hook does this automatically for `*/hypr/*` edits.

## Don't edit
- `~/.config/hypr/hypr.conf` — legacy symlink, not sourced
- `~/.config/themes/*/hypr.conf` — not sourced; rework pending

## Common edits
- Colors/borders: `general`, `decoration` blocks
- Gaps: `general { gaps_in, gaps_out }`
- Binds: `bind` directives
