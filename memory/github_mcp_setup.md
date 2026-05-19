---
name: github-mcp-setup
description: GitHub MCP server setup for Claude Code integration
metadata: 
  node_type: memory
  type: reference
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## GitHub MCP Setup

### What it does
- Access GitHub repos, issues, PRs, discussions directly
- Read repository content without cloning
- Query pull requests, issue comments, workflows
- Significantly speeds up GitHub-related work

### Setup Steps

1. **Create a GitHub Personal Access Token**
   - Go to: https://github.com/settings/tokens?type=beta
   - Create "Fine-grained personal access token"
   - Name: "Claude Code"
   - Expiration: 90 days (or as desired)
   - Repository access: "All repositories" (or specific ones)
   - Permissions needed:
     - Repository: read (contents, metadata, pull requests)
     - Account: read (email)
   - Generate and copy token

2. **Configure in Claude Code**
   - Save token to environment or secure storage
   - Claude Code will use it for GitHub API calls

3. **Verify it works**
   - Ask me to read a GitHub issue or PR from your repos
   - Should be able to access chasebrowndev/* repos

### Usage Examples (once configured)
```
"Read my latest PRs from chasebrowndev/dotfiles"
"Show me the issues in my repo"
"What's in the GitHub Actions workflows?"
```

### Token Scope (recommended)
- Minimum: read-only access to your repos
- Broader: read access to public repos you contribute to
- Don't share token — keep it secure

## Status
- [ ] Token created and available
- [ ] Added to Claude Code configuration
- [ ] Verified working

Contact: chase.brown.dev (GitHub email)
Handle: chasebrowndev
