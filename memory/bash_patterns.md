---
name: bash-patterns
description: Token-cheap bash patterns. Reach for these before the verbose default.
metadata:
  type: reference
---

## Default to the terse variant

| Task | Cheap | Avoid |
|------|-------|-------|
| recent commits | `git log --oneline -20` | `git log` |
| diff overview | `git diff --stat` | `git diff` (full) |
| find pattern in code | `rg -l pattern \| head` then targeted read | `rg -B3 -A3 pattern` on big trees |
| find files | `fd 'name' -t f` | `find . -name '*name*'` |
| list dir | `eza -1` (names only) | `ls -la` (only when permissions matter) |
| read large file | `Read` with `offset`/`limit` | full read of >500-line file |
| view JSON | `jq -c '.field' f` | `jq '.' f` (pretty, ~30% bigger) |
| installed pkgs | `pacman -Qq \| wc -l` then `pacman -Qs <name>` | `pacman -Q` (1500+ lines) |
| process tree | `ps -eo pid,comm --sort=-pcpu \| head -20` | `ps aux` |

## Composition

- Pipe to `head -N` after `rg`/`fd` if you only need a sample.
- Combine in one Bash call (`fd … \| while read f; do …; done`) rather than 3 calls.
- Parallel: independent reads/greps go in one assistant turn, not sequential turns.

## Edit > Write

- `Edit` sends the diff context only (~50 tokens). `Write` re-sends the whole file.
- Use `Write` only for new files or full rewrites.
- Never re-read a file after `Edit` — the harness tracks state.

## Subagent threshold

- If a question needs >5 read-only tool calls, spawn an `Explore` subagent.
- Cost of spinning one up < cost of carrying raw search output in main context.
