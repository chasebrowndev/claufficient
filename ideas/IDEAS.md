# Claufficient — Parking Lot

Features and capability additions kept out of the main repo. Claufficient's mandate is *token efficiency*; anything else lives here until it earns its way in.

---

## Features extracted from the original install.sh

### Waybar Claude usage widget
Python script that hits `https://api.anthropic.com/api/oauth/usage` for 5h/7d limits, caches in `/tmp/claude_usage_cache.json` (300s TTL), renders gradient bar (orange → red).

- Original location: `waybar/claude_usage.py` + `waybar/waybar-module.jsonc`
- Why removed: system monitoring widget, not a Claude-token improvement. Add back as a standalone repo if wanted.

### Sudoers config (passwordless pacman)
`/etc/sudoers.d/claufficient` with `Defaults timestamp_timeout=120` and NOPASSWD on `pacman -S/-Syu/-R`.

- Why removed: machine-level convenience. Belongs in dotfiles or a separate `arch-setup` script.

### npm global prefix
`npm config set prefix "$HOME/.npm-global"` + PATH append. Enables Claude Code self-update.

- Why removed: machine config, not Claude efficiency. Re-add only if `claude update` becomes a tracked workflow.

### HANDOFF.md template
Auto-generated session-handoff scratchpad at `~/HANDOFF.md`.

- Why removed: feature, not efficiency. The file rots without an update mechanism. Could be re-added as a Stop hook later.

### sudo-term zsh function
Opens interactive sudo in a new kitty window:
```bash
sudo-term() {
    kitty bash -c "sudo $*; echo; read -p 'Done — press enter to close' _" &
}
```
- Why removed: terminal UX helper, unrelated to Claude. Belongs in `~/.zshrc` or `~/scripts/aliases.sh` directly.

### 30 ANSI-orange company announcements
Cute "Claude: all systems nominal" lines in `settings.json:.companyAnnouncements`.

- Why removed: shown in welcome banner only (no Claude-context cost), but they clutter `settings.json` and aren't an efficiency lever. Replaced with a minimal 5-line set in install (keep some flavor).

### ASCII art banner in install.sh
Big `CLAUFFICIENT` block lettering at script start.

- Why removed: install-time visual, no functional impact. Removed to keep `install.sh` lean and diffable.

### code-reviewer plugin
`"code-reviewer@claude-code-marketplace": true` in `enabledPlugins`.

- Why removed: feature, not efficiency. Re-enable manually if used. Plugins load context per invocation; default-on costs nothing but defaults-off is the principle here — only what's measured.

### sudo pacman pre-allowed
`Bash(sudo pacman *)` permission.

- Why removed: paired with the sudoers removal — without NOPASSWD it'd hang on a password prompt anyway. Belongs in a system-setup profile.

---

## Speculative additions (from earlier Ultraplan output)

Captured for record; none of these are claufficient's job.

### System control surface
- `xdg-open`/`gtk-launch` wrappers, browser deep-links
- `hyprctl dispatch` window/workspace wrappers
- `grim`/`slurp`/`hyprshot` screenshot wrappers, `wl-copy`/`wl-paste` clipboard
- `wpctl`/`pactl`/`playerctl`/`brightnessctl`/`bluetoothctl`/`nmcli` permissions
- Kitty remote control (`allow_remote_control yes`, `kitten @ launch`)
- `systemctl --user`/`udisksctl`/`busctl`/`gdbus` permissions
- `ydotool`/`wtype` input simulation (gated)
- Sub-agent `desktop-controller` bundling all of the above

→ This is "give Claude desktop control", not "make Claude cheaper". Out of scope.

### Force multipliers
- SSH multiplexing helper (`ssh-do.sh`) + `remote-runner` subagent
- Persistent always-on Claude session via tmux + systemd-user unit
- Ollama local triage (`triage.sh` wrapping Qwen2.5-3B)
- Vector recall over memory files (sqlite-vss + sentence-transformers)
- Hyprland workspace snapshot/restore
- Whisper.cpp STT + Piper TTS voice I/O
- `pr-driver` subagent for full git→PR→CI cycle
- Audit log + selective rollback
- Session-resume helper

→ Mostly capability features. Vector recall over memory is the only one with a *plausible* efficiency angle (search instead of full-load), but the model download + reindex cost almost certainly dwarfs the savings.

### Capability primitives
- Custom subagents (`dotfiles-syncer`, `pkg-installer`, `hyprland-debugger`, `config-auditor`, `memory-curator`)
- Custom slash commands (`/sync`, `/handoff`, `/audit`, `/theme`, `/usage`, `/pkg`)
- `UserPromptSubmit` hook that prepends git status / theme / usage % every turn
- Global `~/.claude/CLAUDE.md` for cross-project preferences
- `bash install.sh bootstrap` project-scoping subcommand
- MCP skeleton (`~/.claude.json`) with github/filesystem/context7/sequential-thinking commented out
- `cache-cmd` wrapper for stable-output memoization
- `bash install.sh self-update`
- `terse` output style preset

→ Some of these (UserPromptSubmit, terse output style, bootstrap) have an *efficiency* story; they're parked here because they're feature surface, not minimal token-saving edits. Reconsider if measured baseline isn't budging.

---

## Re-entry criteria

Anything in this file gets back into the main repo only if:

1. It directly reduces tokens-per-session or tokens-per-task (measurable via `scripts/measure.sh` or a session-cost log), AND
2. It doesn't expand install.sh by more than ~20 lines, AND
3. Its absence is currently costing real friction (a working `git log -20 \| less` is not friction).
