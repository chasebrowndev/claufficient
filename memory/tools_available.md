---
name: tools-available
description: Available CLI tools for efficient code exploration and analysis
metadata: 
  node_type: memory
  type: reference
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## Installed Read-Only Tools (auto-allowed)

### Searching & Grepping
- **`rg`** (ripgrep) — Fast regex grep with colors. Prefer over `grep` when searching code.
  - Usage: `rg 'pattern' <path>` or `rg -A3 -B3 'pattern'` for context
  - Much faster than find+grep for large codebases

- **`grep`** — Standard grep, acceptable but slower than rg
  - Usage: `grep -r 'pattern' <path>` with flags like `-n` (line nums), `-i` (ignore case)

### Finding Files
- **`fd`** — Fast, intuitive find alternative. Prefer over `find` when possible.
  - Usage: `fd 'pattern' <path>` or `fd -e ts -e tsx` for extensions
  - Respects .gitignore by default
  - Much cleaner syntax than find

- **`find`** — Standard find, slower but always available
  - Usage: `find <path> -name 'pattern'` or `-regex` for complex patterns

### Viewing Files
- **`bat`** — Cat with syntax highlighting and git diffs
  - Usage: `bat <file>` instead of `cat <file>`
  - Shows line numbers and highlights code
  - Aliased as `cat` in zsh (transparent replacement)
  - Use `bat --style=plain` for plain output

- **`delta`** — Enhanced git diff with syntax highlighting
  - Usage: `git diff` automatically uses delta (aliased as `diff`)
  - Shows word-level changes, colors, side-by-side mode
  - Much better than standard diff

### Git Operations
- **`git`** — Version control (all read operations auto-allowed)
  - Usage: `git status`, `git log`, `git diff`, `git show`, `git blame`
  - For code history, context, and change review

### JSON Processing
- **`jq`** — JSON query/parse tool
  - Usage: `jq '.field' <file>` or pipe JSON to parse structured output
  - Essential for parsing tool output, API responses, config files

### Directory Navigation
- **`zoxide`** — Smart cd that learns your visited directories
  - Usage: `z <partial-dir-name>` or `zi` for interactive fuzzy picker
  - Automatically jumps to most-visited matching directory
  - Replaces `cd` via alias

### File Listing
- **`eza`** — Better `ls` with colors, git integration, and icons
  - Usage: `ls` is aliased to `eza`, `ll` uses `eza -lhF --git`
  - Shows git status inline
  - Much more readable than standard ls

### Dotfiles Management
- **`stow`** — GNU stow for symlink-based dotfiles management
  - Usage: `stow <package>` to symlink config directories
  - Cleaner than manual copying, organizes dotfiles hierarchically
  - Can stow individual packages (hyprland, kitty, etc.)

### Fuzzy Finding
- **`fzf`** — Fuzzy finder for interactive searching
  - Usage: Can pipe lists to fzf for interactive selection
  - Useful when needing to pick from multiple options

### Text Processing
- **`head`**, **`tail`**, **`wc`** — Standard utilities for inspecting file portions
- **`file`** — Detect file types

## Strategy
- **First choice for searching**: `rg` (fast, clean)
- **First choice for finding files**: `fd` (respects gitignore, intuitive)
- **First choice for reading code**: `bat` (syntax highlighted, aliased as `cat`)
- **For directory jumping**: `z` (zoxide, learns visited dirs)
- **For listing files**: `ls` (aliased to `eza`, shows git status)
- **For diffs**: `git diff` (uses delta for highlighting automatically)
- **For structured data**: `jq` (JSON parsing)
- **For history/changes**: `git log/show/diff` (authoritative source)
- **For dotfiles management**: `stow` (symlink-based organization)

## When Not to Use (prefer Bash tool call instead)
- Writing/modifying files → use Edit or Write tools
- Running builds/tests → use Bash tool
- Complex shell pipelines → use Bash tool (these tools are just components)
