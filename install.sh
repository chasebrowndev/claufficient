#!/usr/bin/env bash
# claufficient — Claude Code token-efficiency setup.
# Re-runnable. Preserves personal content above the CLAUDE.md sentinel marker.

set -euo pipefail

RED='\033[0;31m'; ORANGE='\033[0;33m'; NC='\033[0m'
info()    { echo -e "${ORANGE}[claufficient]${NC} $*"; }
success() { echo -e "${RED}[✓]${NC} $*"; }

CLAUFFICIENT_VERSION="1.0"
ROOT="$(cd "$(dirname "$0")" && pwd)"

# ── verify mode ────────────────────────────────────────────────────────────────
if [[ "${1:-}" == "verify" ]]; then
    fail=0
    for t in rg fd bat eza zoxide delta fzf jq tmux stow; do
        command -v "$t" >/dev/null && echo "✓ $t" || { echo "✗ $t"; fail=1; }
    done
    if [[ -f "$HOME/.claude/settings.json" ]] && jq -e . "$HOME/.claude/settings.json" >/dev/null 2>&1; then
        echo "✓ settings.json parses"
    else
        echo "✗ settings.json"; fail=1
    fi
    mdir="$HOME/.claude/projects/$(echo "$HOME" | sed 's|/|-|g')/memory"
    [[ -d "$mdir" ]] && echo "✓ memory dir: $mdir" || { echo "✗ memory dir"; fail=1; }
    grep -q "^<!-- #CLAUFFICIENT V" "$HOME/CLAUDE.md" 2>/dev/null \
        && echo "✓ CLAUDE.md sentinel present" || echo "✗ CLAUDE.md sentinel"
    exit $fail
fi

# ── prompts ────────────────────────────────────────────────────────────────────
GIT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")
read -rp "GitHub username [chasebrowndev]: " GITHUB_USER;  GITHUB_USER="${GITHUB_USER:-chasebrowndev}"
read -rp "Your email [${GIT_EMAIL:-chase.brown.dev}]: "    USER_EMAIL;  USER_EMAIL="${USER_EMAIL:-${GIT_EMAIL:-chase.brown.dev}}"
read -rp "Dotfiles repo path [~/dotfiles]: "               DOTFILES_PATH; DOTFILES_PATH="${DOTFILES_PATH:-$HOME/dotfiles}"

SANITIZED_HOME=$(echo "$HOME" | sed 's|/|-|g')
MEMORY_DIR="$HOME/.claude/projects/${SANITIZED_HOME}/memory"

info "user=$GITHUB_USER email=$USER_EMAIL dotfiles=$DOTFILES_PATH"

# ── package manager detection ──────────────────────────────────────────────────
if   command -v pacman &>/dev/null; then PKG="sudo pacman -S --noconfirm"
elif command -v apt    &>/dev/null; then PKG="sudo apt install -y"
elif command -v dnf    &>/dev/null; then PKG="sudo dnf install -y"
else PKG=""; info "unknown package manager — install tools manually"
fi

# ── install tools (idempotent) ─────────────────────────────────────────────────
TOOLS=(ripgrep fd bat eza zoxide delta fzf jq tmux stow)
if [[ -n "$PKG" ]]; then
    for tool in "${TOOLS[@]}"; do
        pkg="$tool"; cmd="$tool"
        [[ "$tool" == "ripgrep" ]] && cmd="rg"
        [[ "$tool" == "delta" && "$PKG" == *apt* ]] && pkg="git-delta"
        if command -v "$cmd" &>/dev/null; then
            success "$tool present"
        else
            info "installing $tool…"
            $PKG "$pkg" 2>/dev/null && success "$tool installed" || info "failed: $tool"
        fi
    done
fi

# ── settings.json ──────────────────────────────────────────────────────────────
info "writing ~/.claude/settings.json…"
mkdir -p "$HOME/.claude"
cat > "$HOME/.claude/settings.json" <<EOF
{
  "theme": "dark",
  "editorMode": "normal",
  "permissions": {
    "allow": [
      "Read",
      "Bash(bat *)", "Bash(cat *)", "Bash(cargo *)", "Bash(date)",
      "Bash(delta *)", "Bash(echo *)", "Bash(env)", "Bash(eza *)",
      "Bash(false)", "Bash(fd *)", "Bash(file *)", "Bash(find *)",
      "Bash(fzf *)", "Bash(gh *)", "Bash(git *)", "Bash(grep *)",
      "Bash(head *)", "Bash(hyprctl *)", "Bash(jq *)", "Bash(kitty *)",
      "Bash(ln -sf *)", "Bash(ls *)", "Bash(make *)", "Bash(node *)",
      "Bash(npm *)", "Bash(pacman -Q *)", "Bash(pacman -Qq *)",
      "Bash(pacman -Qs *)", "Bash(printf *)", "Bash(pwd)",
      "Bash(pyenv *)", "Bash(python *)", "Bash(python3 *)",
      "Bash(rg *)", "Bash(stow *)", "Bash(tail *)", "Bash(test *)",
      "Bash(tmux *)", "Bash(true)", "Bash(uname *)", "Bash(wc *)",
      "Bash(which *)", "Bash(zoxide *)",
      "Skill(update-config)", "Skill(verify)",
      "Skill(code-review)", "Skill(fewer-permission-prompts)"
    ],
    "defaultMode": "acceptEdits"
  },
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [{
          "type": "command",
          "command": "jq -r '.tool_input.file_path // .tool_response.filePath' | { read -r f; [[ \$f == */hypr/* ]] && hyprctl reload 2>/dev/null; [[ \$f == */.config/* ]] && git -C ${DOTFILES_PATH} add -A 2>/dev/null && git -C ${DOTFILES_PATH} commit -m 'Auto-sync: config changes' 2>/dev/null; true; }",
          "timeout": 5
        }]
      }
    ]
  },
  "companyAnnouncements": [
    "\u001b[38;5;208mClaude:\u001b[0m all systems nominal",
    "\u001b[38;5;208mClaude:\u001b[0m less thinking, more shipping",
    "\u001b[38;5;208mClaude:\u001b[0m skill issue detected: none",
    "\u001b[38;5;208mClaude:\u001b[0m btw, we know",
    "\u001b[38;5;208mClaude:\u001b[0m orange is not a color — it's a lifestyle"
  ],
  "autoCompactEnabled": true,
  "autoCompactWindow": 120000,
  "cleanupPeriodDays": 14,
  "terminalProgressBarEnabled": true,
  "agentPushNotifEnabled": true
}
EOF
success "settings.json written"

# ── CLAUDE.md sentinel merge ───────────────────────────────────────────────────
info "installing CLAUDE.md (sentinel merge)…"
TARGET="$HOME/CLAUDE.md"
NEW_BLOCK=$(sed \
    -e "s|/home/chase|$HOME|g" \
    -e "s|chasebrowndev|$GITHUB_USER|g" \
    -e "s|chase.brown.dev|$USER_EMAIL|g" \
    "$ROOT/CLAUDE.md")

if [[ ! -f "$TARGET" ]]; then
    echo "$NEW_BLOCK" > "$TARGET"
    success "CLAUDE.md created"
elif grep -q "^<!-- #CLAUFFICIENT V" "$TARGET"; then
    # Preserve user content above marker, replace marker block.
    awk '/^<!-- #CLAUFFICIENT V/{exit} {print}' "$TARGET" > "$TARGET.tmp"
    echo "$NEW_BLOCK" >> "$TARGET.tmp"
    mv "$TARGET.tmp" "$TARGET"
    success "CLAUDE.md merged (preserved content above marker)"
else
    # Existing file without marker: append, don't overwrite.
    printf '\n%s\n' "$NEW_BLOCK" >> "$TARGET"
    success "CLAUDE.md block appended (existing content preserved)"
fi

# ── memory files ───────────────────────────────────────────────────────────────
info "installing memory files → $MEMORY_DIR"
mkdir -p "$MEMORY_DIR"
for f in "$ROOT"/memory/*.md; do
    sed \
        -e "s|/home/chase|$HOME|g" \
        -e "s|chasebrowndev|$GITHUB_USER|g" \
        -e "s|chase.brown.dev|$USER_EMAIL|g" \
        "$f" > "$MEMORY_DIR/$(basename "$f")"
done
success "memory files installed ($(ls "$MEMORY_DIR" | wc -l) files)"

# ── zsh aliases (idempotent) ───────────────────────────────────────────────────
info "configuring ~/.zshrc…"
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"
add() { grep -qF "$1" "$ZSHRC" 2>/dev/null || echo "$1" >> "$ZSHRC"; }
add 'export COLORTERM=truecolor'
add 'alias ls="eza"'
add 'alias ll="eza -lhF --color=auto --git"'
add 'alias cat="bat --style=plain"'
add 'alias diff="delta"'
add 'eval "$(zoxide init zsh)"'
add 'alias cd=z'
add 'alias cdi=zi'
success "zsh configured"

# ── summary ────────────────────────────────────────────────────────────────────
echo
success "claufficient v${CLAUFFICIENT_VERSION} setup complete"
info    "  measure baseline: bash $ROOT/scripts/measure.sh --baseline"
info    "  verify install:   bash $ROOT/install.sh verify"
info    "  source new shell: source ~/.zshrc"
