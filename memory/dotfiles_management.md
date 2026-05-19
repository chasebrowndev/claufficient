---
name: dotfiles-management
description: Best practices for managing dotfiles with stow and git
metadata: 
  node_type: memory
  type: reference
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## Current Setup
- **Repo**: `~/dotfiles/` (GitHub: chasebrowndev/dotfiles)
- **Method**: Manual copying + git sync (via auto-commit hook)
- **Email**: chase.brown.dev (GitHub context)

## GNU Stow for Cleaner Management

### What stow does
Creates symlinks from `~/dotfiles/<package>/` → `~/` without cluttering repo root.

Example structure:
```
~/dotfiles/
├── hyprland/
│   └── .config/hypr/hyprland.conf
├── kitty/
│   └── .config/kitty/kitty.conf
├── zsh/
│   └── .zshrc
└── README.md
```

Then: `stow hyprland kitty zsh` creates symlinks:
- `~/.config/hypr/hyprland.conf` → `~/dotfiles/hyprland/.config/hypr/hyprland.conf`
- `~/.config/kitty/kitty.conf` → `~/dotfiles/kitty/.config/kitty/kitty.conf`
- `~/.zshrc` → `~/dotfiles/zsh/.zshrc`

### Benefits
- Repo structure mirrors `~` structure (intuitive)
- Easy to stow/unstow individual packages
- No manual copying needed
- Scales well for multi-machine setups

### Adopting stow (optional)
```bash
# Restructure dotfiles/
mkdir -p ~/dotfiles/{hyprland,kitty,zsh}
mv ~/dotfiles/.config ~/dotfiles/hyprland/.config
# etc.

# Stow packages
cd ~/dotfiles
stow hyprland kitty zsh

# Test: verify symlinks exist
ls -la ~/.config/hypr/hyprland.conf  # should show ->
```

## Current Auto-Sync Workflow

### How it works
1. Edit config file in `~/.config/`
2. Auto-commit hook detects change
3. Hook runs: `git -C ~/dotfiles add -A && git commit -m 'Auto-sync: config changes'`
4. Changes committed to `~/dotfiles`

### Manual workflow (if needed)
```bash
cp ~/.config/hypr/hyprland.conf ~/dotfiles/.config/hypr/
cd ~/dotfiles
git add -A
git commit -m "Update hyprland config"
git push
```

## Best Practices

### What to version control
- ✓ Config files (hyprland, kitty, zsh, etc.)
- ✓ Scripts (`~/scripts/`)
- ✗ Machine-specific secrets (tokens, passwords)
- ✗ Large generated files

### Organization
- Keep `.gitignore` in dotfiles root
- Use meaningful commit messages ("Update hyprland colors", not "config change")
- Tag releases for machine snapshots: `git tag machine-setup-2026-05`

### Multi-machine setup
With stow, easy to selectively apply packages:
- `Machine A`: `stow hyprland kitty`
- `Machine B`: `stow hyprland kitty zsh vim`

## References
- [Stow manual](https://www.gnu.org/software/stow/manual/)
- **Popular dotfiles repos**: Search GitHub #dotfiles for patterns and inspiration
