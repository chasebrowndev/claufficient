#!/usr/bin/env bash
# measure.sh — quantify per-session token overhead from Claude-loaded files.
#
# What it measures:
#   Files Claude loads at session start: CLAUDE.md + memory/*.md (incl. MEMORY.md).
#   These hit the prompt cache after the first session, but bytes-in equals
#   tokens-out for the first uncached run and dictates ongoing cache size.
#
# Token estimate: bytes / 4 (English-text approximation; close enough to
# rank changes. For exact counts use Anthropic's tokenizer.)
#
# Usage:
#   bash scripts/measure.sh             # current size vs baseline (if any)
#   bash scripts/measure.sh --baseline  # write baseline file
#   bash scripts/measure.sh --json      # machine-readable

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASELINE="$ROOT/.baseline"

declare -a FILES=("$ROOT/CLAUDE.md")
while IFS= read -r f; do FILES+=("$f"); done < <(find "$ROOT/memory" -maxdepth 1 -name '*.md' | sort)

total_bytes=0
declare -a rows=()
for f in "${FILES[@]}"; do
    [[ -f "$f" ]] || continue
    b=$(wc -c < "$f")
    total_bytes=$((total_bytes + b))
    rel="${f#$ROOT/}"
    rows+=("$b|$rel")
done
total_tokens=$((total_bytes / 4))

mode="${1:-}"

if [[ "$mode" == "--baseline" ]]; then
    printf '%s %s\n' "$total_bytes" "$total_tokens" > "$BASELINE"
    echo "baseline written: $total_bytes bytes ≈ $total_tokens tokens"
    exit 0
fi

if [[ "$mode" == "--json" ]]; then
    printf '{"bytes":%d,"tokens_est":%d}\n' "$total_bytes" "$total_tokens"
    exit 0
fi

printf '%8s  %s\n' BYTES FILE
printf '%8s  %s\n' ----- ----
for r in "${rows[@]}"; do printf '%8s  %s\n' "${r%%|*}" "${r#*|}"; done
printf '%8s  %s\n' ----- ----
printf '%8d  total (≈ %d tokens)\n' "$total_bytes" "$total_tokens"

if [[ -f "$BASELINE" ]]; then
    read -r base_b base_t < "$BASELINE"
    delta_b=$((total_bytes - base_b))
    delta_t=$((total_tokens - base_t))
    pct=$(( base_b == 0 ? 0 : (delta_b * 100) / base_b ))
    printf '\nbaseline: %d bytes ≈ %d tokens\n' "$base_b" "$base_t"
    printf 'delta:    %+d bytes (%+d%%) ≈ %+d tokens\n' "$delta_b" "$pct" "$delta_t"
fi
