---
name: tools-available
description: Pre-installed CLI tools and their preferred invocation
metadata:
  type: reference
---

Installed by claufficient and pre-allowed in settings.json. Reach for the terse flags by default.

- **rg** — `rg -l pattern` to locate, then targeted read. `-A3 -B3` only when needed.
- **fd** — `fd 'name' -t f`. Respects .gitignore. Faster than `find`.
- **bat** — aliased to `cat`. Use `bat --style=plain` to skip header/grid noise.
- **eza** — aliased to `ls`. `eza -1` for cheapest listing.
- **delta** — used automatically by `git diff` (aliased `diff`).
- **jq** — `jq -c` for compact output; pretty form wastes ~30% tokens.
- **zoxide** — `z partial` jumps; `zi` for fuzzy.
- **fzf** — interactive selection from pipes.
- **stow** — symlink-based dotfiles management (already set up in ~/dotfiles).
- **gh** — GitHub CLI. `gh pr list`, `gh issue view`, `gh run watch`.
- **git** — full read access pre-allowed. Use `--oneline`, `--stat`, `-n N` aggressively.
- **tmux** — multi-pane workflows; persistent sessions.

For modifications use `Edit`/`Write` — not bash redirection.
