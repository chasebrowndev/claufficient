---
name: bash-patterns
description: Efficient bash patterns to use for faster execution and lower token cost
metadata: 
  node_type: memory
  type: reference
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## Fast Discovery Patterns

### Finding Files
```bash
# ✓ Use fd (fast, respects .gitignore)
fd 'pattern' <path>
fd -e ts -e tsx <path>  # by extension

# ✗ Slow: find is verbose and slower
find <path> -type f -name 'pattern'
```

### Searching Code
```bash
# ✓ Use rg (ripgrep, fast, colored output)
rg 'pattern' <path>
rg -A3 -B3 'pattern'   # with context
rg -l 'pattern'        # list files only

# ✗ Slow: grep requires more flags and is slower
grep -r 'pattern' <path>
```

### Reading Files
```bash
# ✓ Use bat (syntax highlighting + line numbers)
bat <file>
bat --line-range 10:50 <file>

# ✓ Use cat for plain text (no highlighting needed)
cat <file>

# ✗ Avoid: head/tail for small explorations, just read the whole file
```

## Piping & Composition
```bash
# ✓ Chain commands efficiently
fd 'config' | rg 'color' | bat

# ✓ Use git for history (faster than searching logs)
git log --oneline -n 20
git log -p --grep='pattern'
git show <hash>
git diff <hash1> <hash2>

# ✓ Parse JSON
jq '.field.nested' <file>
echo '{"a":1}' | jq '.a'
```

## One-Liners vs Multiple Calls

### ✓ Combine when possible
```bash
# One call: faster, fewer token-expensive Bash invocations
fd pattern -e ts -e tsx | while read f; do bat "$f"; done
```

### ✗ Avoid unnecessary loops
```bash
# Bad: Multiple Bash calls for what could be one command
for f in $(find . -name "*.ts"); do cat "$f"; done
```

## Git Patterns
```bash
# ✓ Quick history overview (cheap, fast)
git log --oneline -n 20

# ✓ See a specific change
git show <commit-hash>

# ✓ See diff between commits
git diff <hash1>..<hash2>

# ✓ Blame for context
git blame <file>

# ✗ Avoid: Full log output without limiting
git log  # outputs everything, slow to read
```

## Listing & Inspection
```bash
# ✓ Concise listing
ls -la <dir>

# ✓ Count files
fd . --type f | wc -l

# ✓ Detect file type
file <file>

# ✗ Avoid: complex find with many flags
find . -type f -newer <file> -mtime -7 -name '*.ts'  # use fd instead
```

## Token Efficiency Strategy
1. **Use fd/rg first** — narrow search space before reading files
2. **Combine pipes** — one Bash call > three Bash calls
3. **Use git history** — cheaper than searching through code
4. **Read once, fully** — reading a whole file is cheaper than multiple head/tail calls
5. **Trust syntax** — once you understand pattern, don't read more examples
