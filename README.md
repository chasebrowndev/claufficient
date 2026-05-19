# claufficient

> Spin up an optimized Claude Code environment on any machine in seconds.

## What it does

One script installs and configures everything needed to work efficiently with Claude Code:

- **CLI Tools** — ripgrep, fd, bat, eza, zoxide, delta, fzf, jq, tmux, stow
- **Claude Code Settings** — auto-accept read-only tools, auto-compaction, hooks
- **Hooks** — auto-reload Hyprland on config changes, auto-sync dotfiles to git
- **Memory System** — pre-loaded context: tools, patterns, decision rules, best practices
- **Zsh Aliases** — eza, bat, delta, zoxide wired in automatically
- **CLAUDE.md** — rich instructions so Claude understands your environment from session one

## Install

```bash
git clone git@github.com:chasebrowndev/claufficient.git
cd claufficient
bash install.sh
```

The script prompts for your GitHub username, email, and dotfiles path — then handles the rest.

## What gets installed

| Tool | Purpose |
|------|---------|
| `rg` | Fast code search (replaces grep) |
| `fd` | Fast file finder (replaces find) |
| `bat` | Syntax-highlighted cat |
| `eza` | Better ls with git integration |
| `zoxide` | Smart cd that learns your directories |
| `delta` | Enhanced git diffs |
| `fzf` | Fuzzy finder |
| `jq` | JSON processing |
| `tmux` | Terminal multiplexer |
| `stow` | Dotfiles symlink management |

## What gets configured

**`~/.claude/settings.json`**
- All read-only tools pre-allowed (no permission prompts)
- Auto-compaction at 200k tokens
- PostToolUse hooks for hyprland reload and dotfiles sync

**`~/CLAUDE.md`**
- Filesystem structure, decision rules, tool preferences
- Common operations and exploration strategy

**`~/.claude/projects/.../memory/`**
- `tools_available.md` — when to use each tool
- `decision_rules.md` — minimal, direct, sharp
- `bash_patterns.md` — efficient one-liners
- `hyprland_patterns.md` — WM config patterns
- `dotfiles_management.md` — stow and git workflow
- `context_management.md` — memory hygiene

**`~/.zshrc` additions**
- eza, bat, delta, zoxide aliases appended (safe, no overwrites)

## After install

```bash
source ~/.zshrc   # activate shell changes
claude            # start optimized session
```

## Package managers supported

- Arch Linux (pacman)
- Ubuntu/Debian (apt)
- Fedora/RHEL (dnf)

---

Made by [chasebrowndev](https://github.com/chasebrowndev)
