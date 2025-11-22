# MCP Integration Quick Start

**Last Updated:** 2025-11-22
**Time to Setup:** 30 minutes (Day 1 only)
**Full Implementation:** 10 days

## One-Page Overview

This guide helps you integrate three Priority 1 MCPs (Context7, PostgreSQL, Playwright) into any repository using a lean, disabled-by-default approach.

## Prerequisites

- Claude Code installed and working
- Fully customized setup (agents, skills, hooks already configured)
- Python-focused workflow (or adaptable to your stack)

## Quick Setup (30 Minutes)

### Step 1: Install MCPs (Disabled by Default)

Add to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {"UPSTASH_CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"},
      "timeout": 30000,
      "disabled": true
    },
    "postgres": {
      "command": "uvx",
      "args": ["mcp-server-postgres", "${POSTGRES_CONNECTION_STRING}"],
      "timeout": 60000,
      "disabled": true
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"],
      "timeout": 45000,
      "disabled": true
    }
  }
}
```

### Step 2: Environment Variables

Create `.env` (gitignore this):
```bash
CONTEXT7_API_KEY=cak_xxx...  # Get from console.upstash.com
POSTGRES_CONNECTION_STRING=postgresql://user:pass@host:5432/db?sslmode=require
```

### Step 3: Enable Per-Project

Create `.claude/settings.json` in your project:

```json
{
  "mcpServers": {
    "context7": { "disabled": false },
    "postgres": { "disabled": false }
  }
}
```

### Step 4: Test

```bash
# Restart Claude Code
claude

# Check MCPs loaded
/mcp list

# Test Context7
"Use Context7 to look up FastAPI 0.115 Pydantic v2 patterns"

# Test PostgreSQL (read-only)
"Show me the schema for the users table"
```

## Usage Patterns

### Direct MCP Usage (Simple Queries)

```bash
# Context7 - Quick docs lookup
"What's the FastAPI async route syntax?"

# PostgreSQL - Schema inspection
"Show me all tables in the database"

# Playwright - Quick automation
"Navigate to example.com and take a screenshot"
```

### Integrator Agents (Complex Workflows)

```bash
# Multi-library research
"Research authentication patterns across FastAPI, Django, Flask"

# Query optimization
"Analyze and optimize all slow queries in the users table"

# E2E test orchestration
"Create E2E test for login flow using both playwright-skill and MCP"
```

## Performance Tips

**Keep it lean:**
- MCPs disabled by default globally
- Enable only what you need per-project
- Monitor `/context` for token usage
- Kill strays after sessions: `pkill -f "npx.*mcp|uvx.*postgres"`

**Use non-multiplexed terminal for long streams:**
- Prevents jitter during heavy MCP output
- Update Claude Code regularly

## When to Use Each MCP

| Need | Use This | Example |
|------|----------|---------|
| **Latest API docs** | Context7 | "FastAPI 0.115 Pydantic v2 patterns" |
| **Database schema** | PostgreSQL | "Show users table schema" |
| **Browser automation** | Playwright MCP | "Screenshot example.com" |
| **Complex tests** | playwright-skill | Custom test scripts |
| **Multi-library research** | context7-integrator agent | "Compare auth across frameworks" |
| **Query optimization** | postgres-integrator agent | "Optimize slow queries" |

## Emergency Rollback

If things go wrong:

```bash
# Disable all MCPs
~/.claude/mcp-disable-all.sh

# Or manually
pkill -f "npx.*mcp|uvx.*postgres|playwright"
echo '{"mcpServers":{"context7":{"disabled":true},"postgres":{"disabled":true},"playwright":{"disabled":true}}}' > ~/.claude/settings.json
```

## Success Metrics (Track These)

**Week 1:**
- [ ] All three MCPs working independently
- [ ] Token footprint measured per MCP
- [ ] No performance degradation

**Week 2:**
- [ ] Using Context7 3+ times/week
- [ ] Using PostgreSQL for schema work (no manual psql)
- [ ] Playwright MCP complements skill usage

**Month 1:**
- [ ] 20%+ efficiency gain or 50%+ error reduction
- [ ] Hallucination on APIs reduced by 80%+
- [ ] Cross-MCP workflows providing value

## What's Next?

**Full implementation:** See `docs/plans/2025-11-22-priority1-mcp-integration-design.md`

**10-day plan includes:**
- Days 1-3: Installation + validation
- Days 4-8: Build integrator agents
- Days 7-10: Discover workflow patterns in your codebase
- Day 30: Monthly review (keep/adjust/remove MCPs)

**Session details:** `docs/SESSION_2025-11-22_mcp-implementation-design.md`

## Troubleshooting

**Context7 not working:**
- Check API key in `.env`
- Verify: `echo $CONTEXT7_API_KEY`
- Restart Claude Code

**PostgreSQL connection failed:**
- Test connection string: `psql $POSTGRES_CONNECTION_STRING`
- Ensure read-only role
- Check firewall/network

**Playwright timeout:**
- Increase timeout to 60s
- Kill Chrome: `pkill -f "chrome|chromium"`
- Clear browser cache

**Token pollution:**
- Disable unused MCPs: `/mcp status`
- Check `/context` regularly
- Enable only per-project

## Resources

- **MCP Analysis:** `docs/FRAMEWORK_MCP_ANALYSIS_AND_STRATEGY.md`
- **Implementation Design:** `docs/plans/2025-11-22-priority1-mcp-integration-design.md`
- **Session Summary:** `docs/SESSION_2025-11-22_mcp-implementation-design.md`
- **Context7 Docs:** https://console.upstash.com/
- **PostgreSQL MCP:** https://github.com/stuzero/pg-mcp-server
- **Playwright MCP:** https://github.com/microsoft/playwright-mcp

## Quick Commands Reference

```bash
# MCP status
/mcp list
/mcp status

# Context usage
/context

# Enable MCP for current session
echo '{"mcpServers":{"context7":{"disabled":false}}}' > .claude/settings.json

# Disable after session
rm .claude/settings.json

# Kill all MCP processes
pkill -f "npx.*mcp|uvx.*postgres|playwright"

# Check logs
tail -f ~/.claude/logs/mcp-*.log
```

---

**Ready to start?** Copy this guide to your target repository and begin Day 1 setup!
