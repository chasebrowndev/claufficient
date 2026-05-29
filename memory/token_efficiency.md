---
name: token-efficiency
description: Concrete rules for reducing tokens per session, derived from 2024-2025 LLM efficiency research
metadata:
  type: feedback
---

## Prompt caching

- **Freeze the prefix.** Cache hits require byte-exact prefix match. No timestamps, UUIDs, or session-specific values in the system prompt. Move dynamic content to the user turn.
- **Cache placement order.** Claude processes: tools → system → messages. Put `cache_control` at the end of the last tool definition, then at the end of the system prompt.
- **Min thresholds.** Sonnet/Opus 3: 1,024 tokens. Haiku 4.5/Opus 4: 4,096 tokens. Below threshold = silently uncached.
- **Watch `cache_read_input_tokens`.** If it drops to zero mid-session, something in the prefix changed (model switch, tool added, system prompt edit).

**Why:** Claude Code's own cost model depends on caching. A 100-turn Opus session is ~$50-100 uncached vs $10-19 cached. Cache misses are the primary cost driver in agentic workflows.

## Context compaction

- **Compact at 60%, not 80%.** `/compact` manually when context hits ~60% of the window. Auto-trigger fires at ~83% — by then quality has already started degrading.
- **`autoCompactWindow: 120000`** (set in settings.json — 60% of 200K window).

**Why:** Quality degrades near the context limit, not at it. Early compaction preserves reasoning quality and frees room for the current task.

## Tool use

- **Strip tool descriptions.** Keep each description under 50 tokens. Move examples to the system prompt once, not per-tool. Tool definitions eat 50K+ tokens/session in agentic workloads.
- **Parallel independent tool calls.** If B doesn't need A's output, call them in the same message. 40-70% cost savings vs sequential, 3-5x latency reduction.
- **Batch over loop.** `fd … | while read f; do …; done` in one Bash call beats 3 sequential calls.

**Why:** Tool definition size grew ~4x from 2024-2025 as agentic workloads scaled. It's the dominant token cost in many sessions before any user content.

## Reasoning / CoT

- **Skip extended thinking for**: classification, extraction, routing, JSON formatting, simple lookups.
- **Reserve CoT for**: multi-hop reasoning, math, planning with hard constraints.
- Token-budget-aware phrasing ("respond in under N tokens") measurably reduces verbosity.

**Why:** Chain-of-Draft and NOWAIT methods show 27-67% output token reduction with no accuracy loss on non-reasoning tasks.

## System prompt / CLAUDE.md

- **3-5 examples max** — performance plateaus fast, cost scales linearly. k>5 shots can actively hurt weaker models (few-shot collapse).
- **Sentence-level relevance** — every line in CLAUDE.md earns its place. Pruning irrelevant context improves reasoning, not just cost.

**How to apply:** Before adding to CLAUDE.md or memory files, ask: does this change behavior in the next session? If not, it doesn't belong in the prompt.
