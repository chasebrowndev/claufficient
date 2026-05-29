<!-- #CLAUFFICIENT V1 — managed by claufficient. Personal notes go ABOVE this marker. -->

# Environment

- Home: /home/chase   Shell: zsh on Arch   Editor: micro
- Git: chasebrowndev / chase.brown.dev
- Dotfiles: ~/dotfiles (mirror of ~/.config; auto-commit hook syncs `*/.config/*` edits)
- Hyprland: `~/.config/hypr/hyprland.conf` sources `theme.conf`; reload with `hyprctl reload`
- Terminal: kitty   WM: Hyprland   npm prefix: ~/.npm-global

# Decision rules

- Direct edits, no scaffolding. Existing files first.
- One solution path — pick the simplest of N working approaches.
- Don't refactor unless asked. Three similar lines is fine.
- Short responses. No trailing summaries; the diff speaks.
- Sharp aesthetic: cyberpunk red/black, hard edges, minimal.

# Tool preferences (terse-first)

- Search: `rg -l` then targeted read; never bare `rg pattern` on big trees
- Files: `fd` (respects .gitignore) over `find`
- Read: `Read` with `offset`/`limit` for >500-line files; never re-read after Edit
- History: `git log --oneline -20`; `git diff --stat` before full diff
- JSON: `jq -c` (compact); avoid pretty-printing into context
- List: `eza -1` for names; `ls -la` only when permissions matter

# Token efficiency

- Compact early: `/compact` at ~60% context, before auto-trigger at 80%.
- Parallel tool calls for independent ops — sequential only when B needs A's output.
- Skip extended thinking for extraction, routing, and classification tasks.
- Tool descriptions: 50 tokens max. No examples inside tool definitions.
- No dynamic values (timestamps, UUIDs) in the system prompt prefix — cache miss every call.

# Don't read

- `~/.oh-my-zsh/` (not used)   `node_modules/`, `.cache/`, build artifacts
- System configs outside `~/.config/`   Memory files (loaded already)
