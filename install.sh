#!/usr/bin/env bash
# claufficient - Claude Code efficiency setup
# Usage: bash install.sh

set -e

RED='\033[0;31m'
ORANGE='\033[0;33m'
NC='\033[0m'

info()    { echo -e "${ORANGE}[claufficient]${NC} $1"; }
success() { echo -e "${RED}[✓]${NC} $1"; }
prompt()  { echo -e "${ORANGE}[?]${NC} $1"; }

echo -e "${RED}"
echo "  ██████╗██╗      █████╗ ██╗   ██╗███████╗███████╗██╗ ██████╗██╗███████╗███╗   ██╗████████╗"
echo "  ██╔════╝██║     ██╔══██╗██║   ██║██╔════╝██╔════╝██║██╔════╝██║██╔════╝████╗  ██║╚══██╔══╝"
echo "  ██║     ██║     ███████║██║   ██║█████╗  █████╗  ██║██║     ██║█████╗  ██╔██╗ ██║   ██║   "
echo "  ██║     ██║     ██╔══██║██║   ██║██╔══╝  ██╔══╝  ██║██║     ██║██╔══╝  ██║╚██╗██║   ██║   "
echo "  ╚██████╗███████╗██║  ██║╚██████╔╝██║     ██║     ██║╚██████╗██║███████╗██║ ╚████║   ██║   "
echo "   ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝     ╚═╝ ╚═════╝╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   "
echo -e "${NC}"
info "Claude Code efficiency optimizer"
echo

# ── Gather user info ────────────────────────────────────────────────────────────
GIT_USER=$(git config --global user.name 2>/dev/null || echo "")
GIT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

prompt "GitHub username (default: chasebrowndev):"
read -r GITHUB_USER
GITHUB_USER="${GITHUB_USER:-chasebrowndev}"

prompt "Your email (default: ${GIT_EMAIL:-chase.brown.dev}):"
read -r USER_EMAIL
USER_EMAIL="${USER_EMAIL:-${GIT_EMAIL:-chase.brown.dev}}"

prompt "Dotfiles repo path (default: ~/dotfiles):"
read -r DOTFILES_PATH
DOTFILES_PATH="${DOTFILES_PATH:-$HOME/dotfiles}"

SANITIZED_HOME=$(echo "$HOME" | sed 's|/|-|g')

info "Setting up for: $GITHUB_USER ($USER_EMAIL)"
info "Home: $HOME  →  Memory path: $SANITIZED_HOME"
echo

# ── Detect package manager ──────────────────────────────────────────────────────
if command -v pacman &>/dev/null; then
    PKG_INSTALL="sudo pacman -S --noconfirm"
    PKG_QUERY="pacman -Q"
elif command -v apt &>/dev/null; then
    PKG_INSTALL="sudo apt install -y"
    PKG_QUERY="dpkg -l"
elif command -v dnf &>/dev/null; then
    PKG_INSTALL="sudo dnf install -y"
    PKG_QUERY="rpm -qa"
else
    info "Unknown package manager — install tools manually"
    PKG_INSTALL=""
fi

# ── Install tools ───────────────────────────────────────────────────────────────
info "Installing CLI tools..."
TOOLS=(ripgrep fd bat eza zoxide delta fzf jq tmux stow)

if [ -n "$PKG_INSTALL" ]; then
    for tool in "${TOOLS[@]}"; do
        # Map tool names for different distros
        pkg="$tool"
        [[ "$tool" == "ripgrep" ]] && cmd="rg"   || cmd="$tool"
        [[ "$tool" == "delta" && -n "$(command -v apt 2>/dev/null)" ]] && pkg="git-delta"

        if ! command -v "$cmd" &>/dev/null; then
            info "Installing $tool..."
            $PKG_INSTALL "$pkg" 2>/dev/null && success "$tool installed" || info "Failed to install $tool — install manually"
        else
            success "$tool already installed"
        fi
    done
fi
echo

# ── Set up Claude Code settings ─────────────────────────────────────────────────
info "Configuring Claude Code settings..."
mkdir -p "$HOME/.claude"

cat > "$HOME/.claude/settings.json" << EOF
{
  "theme": "dark",
  "permissions": {
    "allow": [
      "Read",
      "Bash(find *)",
      "Bash(grep *)",
      "Bash(rg *)",
      "Bash(fd *)",
      "Bash(ls *)",
      "Bash(bat *)",
      "Bash(eza *)",
      "Bash(git *)",
      "Bash(cat *)",
      "Bash(head *)",
      "Bash(tail *)",
      "Bash(wc *)",
      "Bash(file *)",
      "Bash(jq *)",
      "Bash(fzf *)",
      "Bash(zoxide *)",
      "Bash(delta *)",
      "Bash(stow *)",
      "Bash(git clone *)",
      "Bash(pacman -Q)",
      "Bash(gh *)",
      "Bash(sudo pacman *)",
      "Bash(kitty *)",
      "Skill(update-config)"
    ],
    "defaultMode": "acceptEdits"
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.file_path // .tool_response.filePath' | { read -r f; [[ \$f == */hypr/* ]] && { hyprctl reload 2>/dev/null || true; }; [[ \$f == */.config/* ]] && { git -C ${DOTFILES_PATH} add -A && git -C ${DOTFILES_PATH} commit -m 'Auto-sync: config changes' 2>/dev/null || true; }; }",
            "timeout": 5,
            "statusMessage": "Syncing changes..."
          }
        ]
      }
    ]
  },
  "companyAnnouncements": [
    "\u001b[38;5;208mClaude:\u001b[0m all systems nominal",
    "\u001b[38;5;208mClaude:\u001b[0m wayland compositor: stable — don't touch it",
    "\u001b[38;5;208mClaude:\u001b[0m uptime: suspiciously high",
    "\u001b[38;5;208mClaude:\u001b[0m kernel: happy, let's keep it that way",
    "\u001b[38;5;208mClaude:\u001b[0m disk space: reclaimed",
    "\u001b[38;5;208mClaude:\u001b[0m cache cleared, soul refreshed",
    "\u001b[38;5;208mClaude:\u001b[0m status: clean (for now)",
    "\u001b[38;5;208mClaude:\u001b[0m the dots are filed and committed",
    "\u001b[38;5;208mClaude:\u001b[0m merge conflicts are just opportunities",
    "\u001b[38;5;208mClaude:\u001b[0m no deprecated APIs were harmed",
    "\u001b[38;5;208mClaude:\u001b[0m venv: activated",
    "\u001b[38;5;208mClaude:\u001b[0m ksudo: locked and loaded",
    "\u001b[38;5;208mClaude:\u001b[0m zsh fast — you're faster",
    "\u001b[38;5;208mClaude:\u001b[0m bin/ scripts are underrated",
    "\u001b[38;5;208mClaude:\u001b[0m btw, we know",
    "\u001b[38;5;208mClaude:\u001b[0m pacman -Syu'd and ready",
    "\u001b[38;5;208mClaude:\u001b[0m kernel panic? not today",
    "\u001b[38;5;208mClaude:\u001b[0m compositor says hello",
    "\u001b[38;5;208mClaude:\u001b[0m cyberpunk theme: correct call",
    "\u001b[38;5;208mClaude:\u001b[0m your terminal is gorgeous",
    "\u001b[38;5;208mClaude:\u001b[0m zero segfaults (so far)",
    "\u001b[38;5;208mClaude:\u001b[0m skill issue detected: none",
    "\u001b[38;5;208mClaude:\u001b[0m it works on my machine",
    "\u001b[38;5;208mClaude:\u001b[0m less thinking, more shipping",
    "\u001b[38;5;208mClaude:\u001b[0m undefined behavior? undefined opportunity",
    "\u001b[38;5;208mClaude:\u001b[0m chaos mode: off (adjustable)",
    "\u001b[38;5;208mClaude:\u001b[0m erebus is watching",
    "\u001b[38;5;208mClaude:\u001b[0m blackbird has entered the chat",
    "\u001b[38;5;208mClaude:\u001b[0m the Yggdrasil holds",
    "\u001b[38;5;208mClaude:\u001b[0m orange is not a color — it's a lifestyle"
  ],
  "autoCompactEnabled": true,
  "autoCompactWindow": 200000,
  "cleanupPeriodDays": 30,
  "enabledPlugins": {
    "code-reviewer@claude-code-marketplace": true
  },
  "terminalProgressBarEnabled": true,
  "agentPushNotifEnabled": true
}
EOF
success "Claude Code settings written"

# ── Copy CLAUDE.md ───────────────────────────────────────────────────────────────
info "Installing CLAUDE.md..."
sed \
  -e "s|/home/chase|$HOME|g" \
  -e "s|chasebrowndev|$GITHUB_USER|g" \
  -e "s|chase.brown.dev|$USER_EMAIL|g" \
  "$(dirname "$0")/CLAUDE.md" > "$HOME/CLAUDE.md"
success "CLAUDE.md installed at ~/CLAUDE.md"

# ── Copy memory files ────────────────────────────────────────────────────────────
info "Installing memory files..."
MEMORY_DIR="$HOME/.claude/projects/${SANITIZED_HOME}/memory"
mkdir -p "$MEMORY_DIR"

for f in "$(dirname "$0")"/memory/*.md; do
    fname=$(basename "$f")
    sed \
      -e "s|/home/chase|$HOME|g" \
      -e "s|chasebrowndev|$GITHUB_USER|g" \
      -e "s|chase.brown.dev|$USER_EMAIL|g" \
      "$f" > "$MEMORY_DIR/$fname"
done
success "Memory files installed at $MEMORY_DIR"

# ── Add zsh aliases and zoxide ───────────────────────────────────────────────────
info "Configuring zsh..."
ZSHRC="$HOME/.zshrc"

add_if_missing() {
    grep -qF "$1" "$ZSHRC" 2>/dev/null || echo "$1" >> "$ZSHRC"
}

add_if_missing 'export COLORTERM=truecolor'
add_if_missing 'alias ls="eza"'
add_if_missing 'alias ll="eza -lhF --color=auto --git"'
add_if_missing 'alias cat="bat --style=plain"'
add_if_missing 'alias diff="delta"'
add_if_missing 'eval "$(zoxide init zsh)"'
add_if_missing 'alias cd=z'
add_if_missing 'alias cdi=zi'
add_if_missing 'export PATH="$HOME/.npm-global/bin:$HOME/.local/bin:$PATH"'

# sudo-term helper — opens interactive sudo in a new kitty window
if ! grep -qF 'sudo-term()' "$ZSHRC" 2>/dev/null; then
    cat >> "$ZSHRC" << 'SUDOTERM'

# ── sudo-term: run interactive sudo in a new kitty window ─────────────────────
sudo-term() {
    kitty bash -c "sudo $*; echo; read -p 'Done — press enter to close' _" &
}
SUDOTERM
fi

success "Zsh configured"

# ── npm global prefix (user-writable, enables Claude Code auto-updates) ─────────
info "Configuring npm global prefix..."
mkdir -p "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global" 2>/dev/null && success "npm prefix set to ~/.npm-global" || info "npm not found — skipping"

# ── Waybar claude usage module (optional) ───────────────────────────────────────
if command -v waybar &>/dev/null; then
    info "Installing waybar claude usage module..."
    mkdir -p "$HOME/.config/waybar/scripts"
    cp "$(dirname "$0")/waybar/claude_usage.py" "$HOME/.config/waybar/scripts/claude_usage.py"
    chmod +x "$HOME/.config/waybar/scripts/claude_usage.py"
    success "claude_usage.py installed — add custom/claude module to your waybar config"
    info "See waybar/waybar-module.jsonc for the module config snippet"
else
    info "waybar not found — skipping waybar module (copy waybar/ manually if needed)"
fi
echo

# ── Sudoers: NOPASSWD for pacman + long sudo timeout ─────────────────────────────
info "Configuring sudoers for Claude Code..."
SUDOERS_FILE="/tmp/claufficient-sudoers"
cat > "$SUDOERS_FILE" << SUDOEOF
Defaults timestamp_timeout=120
$(whoami) ALL=(ALL) NOPASSWD: /usr/bin/pacman -S *
$(whoami) ALL=(ALL) NOPASSWD: /usr/bin/pacman -Syu *
$(whoami) ALL=(ALL) NOPASSWD: /usr/bin/pacman -R *
SUDOEOF

if visudo -cf "$SUDOERS_FILE" &>/dev/null; then
    sudo cp "$SUDOERS_FILE" /etc/sudoers.d/claufficient
    sudo chmod 440 /etc/sudoers.d/claufficient
    rm "$SUDOERS_FILE"
    success "Sudoers configured (NOPASSWD: pacman, 2h timeout)"
else
    rm "$SUDOERS_FILE"
    info "sudoers validation failed — skipping (install manually)"
fi

# ── Create HANDOFF.md ────────────────────────────────────────────────────────────
cat > "$HOME/HANDOFF.md" << EOF
# Handoff Notes
- Last updated: $(date +%Y-%m-%d)
- Status: Fresh install via claufficient

## Running Tasks
(None)

## Setup Notes
- Installed via: https://github.com/${GITHUB_USER}/claufficient
- Dotfiles: ${DOTFILES_PATH}
- Memory: ${MEMORY_DIR}

## Next Steps
1. Set up GitHub MCP token (https://github.com/settings/tokens?type=beta)
2. Configure dotfiles repo if not already done
3. Source your zshrc: source ~/.zshrc
EOF
success "HANDOFF.md created"

echo
echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
success "claufficient setup complete"
echo -e "${ORANGE}  → Run 'source ~/.zshrc' to activate shell changes${NC}"
echo -e "${ORANGE}  → Run 'claude' to start an optimized Claude Code session${NC}"
echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
