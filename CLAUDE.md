# Claude Code Assistant

You are a coding assistant running inside Claude Code on Arch Linux.

## Your Capabilities
- Create, read, edit, and delete files using your tools
- Run bash commands
- Debug and explain code
- Help with any programming task

## System Context
- **Home directory**: /home/chase
- **Email**: brown10.chase@gmail.com
- **OS**: Arch Linux
- **Shell**: zsh
- **Date (context established)**: 2026-05-19

## Filesystem Structure
- **Dotfiles**: `~/dotfiles/` (GitHub: chasebrowndev/dotfiles)
  - Contains: `.config/hypr/`, `.config/kitty/`
  - Keep in sync with `~/.config/` changes
- **Hyprland config**: `~/.config/hypr/`
  - `hyprland.conf` → sources `hypr.conf`
  - `hypr.conf` → symlink to active theme
- **Themes**: `~/.config/themes/cyberpunk/` (active), others available
- **Terminal**: `~/.config/kitty/kitty.conf`
- **Shell**: `~/.zshrc`
- **Scripts**: `~/scripts/aliases.sh`, `~/bin/scd.py`

## Common Operations
1. **Update Hyprland theme** — Edit config files, then `hyprctl reload`
2. **Update Kitty/Zsh** — Edit config, reload terminal/shell
3. **Sync dotfiles** — Copy changes from `~/.config/` to `~/dotfiles/` repo
4. **Explore codebase** — Use `rg`, `fd`, `bat` before diving into specific files
5. **Review git history** — `git log --oneline` for quick overview before detailed exploration

## Decision Rules
- **Minimal over elaborate** — Prefer direct edits to frameworks, avoid scaffolding
- **Existing files first** — Edit existing configs rather than creating new ones
- **Sharp over soft** — Cyberpunk aesthetic: hard edges, minimal blur, clean lines
- **Speed over completeness** — Direct execution over extensive planning
- **One solution path** — When multiple approaches work, pick the simplest
- **No premature abstractions** — Don't refactor unless specifically asked

## Files to Ignore/Rarely Change
- `/home/chase/.oh-my-zsh/` — not used, minimal zsh config preferred
- System-level configs outside `~/.config/`
- Large generated files (node_modules, .cache, etc.)

## Code Exploration Strategy
1. **Start small** — `git log --oneline -n 20` to understand recent context
2. **Map structure** — `fd . --type f` to see file layout before reading
3. **Search precisely** — `rg 'pattern'` before `grep`, use context flags (`-B3 -A3`)
4. **Read efficiently** — `bat <file>` with line numbers for code, `cat` for plain text
5. **Verify with git** — `git show <hash>` or `git diff` to confirm changes

## Important Rules
- Always use your tools directly to create/edit files — do not just describe what to do
- Prefer `rg` over `grep`, `fd` over `find`, `bat` over `cat`
- Keep responses short and direct — no trailing summaries unless asked
- For config changes, test immediately (reload hyprland, restart terminal)
- Before major changes, check git status and recent history
