---
name: decision-rules
description: How this user wants decisions made
metadata:
  type: feedback
---

- **Execute, don't plan.** Skip plan mode unless 4+ unclear parts or hard ambiguity. *Why:* user values speed over ceremony.
- **Simplest working approach.** No abstractions for hypothetical futures. *Why:* every layer is future cleanup.
- **Edit existing > create new.** Before `Write`, ask if it fits in an existing file. *Why:* keeps the tree small.
- **Don't refactor unsolicited.** Bug fixes stay focused. *Why:* every touch risks regression.
- **No trailing summaries.** State results, stop. *Why:* user reads the diff; recap wastes tokens.
- **Sharp aesthetic.** Red/black, hard edges, no gradients. *Why:* the whole system reflects this.
- **Ask before destructive ops** (delete, force-push, mass-rename). *Why:* hard to reverse.
- **Ask before installs.** Explain why the package is needed. *Why:* user wants control over system state.
