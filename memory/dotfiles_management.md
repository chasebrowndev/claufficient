---
name: dotfiles-management
description: How ~/dotfiles syncs to ~/.config
metadata:
  type: reference
---

- Repo: `~/dotfiles/` (github.com/chasebrowndev/dotfiles)
- Sync: PostToolUse hook auto-commits on `*/.config/*` edits via `git -C ~/dotfiles add -A && git commit -m 'Auto-sync: config changes'`
- Manual sync: `cd ~/dotfiles && ./sync.sh` (copies live → repo), then commit + push

## Don't version-control
- Secrets (tokens, passwords)
- Large generated files

## Stow (optional, not currently used)
`stow <package>` symlinks `~/dotfiles/<package>/` → `~/`. See `man stow` if adopting.
