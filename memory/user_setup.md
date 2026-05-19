---
name: user-setup
description: "User's development environment, dotfiles, and workflow preferences"
metadata: 
  node_type: memory
  type: user
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## System & Environment
- OS: Arch Linux (7.0.5-arch1-1)
- Shell: zsh
- Home: /home/chase
- Email: brown10.chase@gmail.com
- Date (session): 2026-05-19

## Development Setup

### Theming System
- **Hyprland WM** with cyberpunk red/black theme
- Theme system: `~/.config/themes/` with symlinked active theme
- Current theme: cyberpunk (hard edges, minimal glow, tight gaps)
- Dotfiles repo: `~/dotfiles/` (cloned from github.com/chasebrowndev/dotfiles)

### Dotfiles Structure
- Main config: `~/.config/hypr/hyprland.conf` (sources `hypr.conf` symlink)
- Active theme: `~/.config/themes/cyberpunk/hypr.conf`
- Terminal: kitty (configured in `~/.config/kitty/kitty.conf`)
- Shell: zsh (configured in `~/.zshrc`)

### Terminal & Shell
- **Kitty** configured with:
  - Light gray foreground (#d0d0d0) for readability
  - Red cursor (#ff0000)
  - Separator tab bar style
  - Syntax highlighting via zsh-syntax-highlighting
  - Autosuggestions via zsh-autosuggestions

- **Zsh** configured with:
  - Simple prompt: `[~/path]$` in red
  - Syntax highlighting: commands red, builtins orange, aliases orange
  - Autosuggestions in dim red
  - Custom `scd` function for smart directory navigation
  - Pyenv integration
  - Local aliases from `~/scripts/aliases.sh`

## Aesthetic Preferences
- **Style**: Cyberpunk (red/black, sharp/minimal, serious not cute)
- **Colors**: Red (#ff0000), dark red (#880000), orange (#ff6600), black (#0a0000)
- **UI Philosophy**: Minimal, clean, hard edges, no soft blur/glow
- **Configuration**: Prefer direct editing over frameworks, minimal boilerplate

## Workflow Notes
- Uses git for version control and dotfiles management
- Active in home directory for most work
- Prefers short, focused prompts and direct execution over extensive planning
- Values efficiency and avoiding unnecessary setup/scaffolding
