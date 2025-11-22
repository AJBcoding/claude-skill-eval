# Priority 1 MCP Integration Design

**Date:** 2025-11-22
**Timeline:** 10 days
**Scope:** Context7, PostgreSQL, Playwright MCP integration
**Approach:** Parallel Foundation + Sequential Intelligence
**Target:** Multiple repositories (Python-focused)

## Executive Summary

Install three Priority 1 MCPs simultaneously (Context7, PostgreSQL, Playwright) following a lean-first, disabled-by-default strategy. Build intelligent integrator agents for complex workflows while keeping MCPs disabled globally and enabled per-project. Discover integration patterns by analyzing actual codebase workflows rather than pre-defining theoretical patterns.

## Architecture Overview

### Three-Layer Integration

**Layer 1: MCP Foundation (Days 1-3)**
All three MCPs installed in `settings.json` but disabled by default. Enable per-project only. Each MCP provides direct tool access:
- Context7: `mcp__context7__resolve-library-id`, `mcp__context7__get-library-docs`
- PostgreSQL: `mcp__postgres__query`, `mcp__postgres__schema`
- Playwright: `mcp__playwright__navigate`, `mcp__playwright__click`

**Layer 2: Intelligent Agents (Days 4-8)**
Three specialized integrator agents handle complex workflows:
- `mcp-context7-integrator.md`: Research sessions, documentation caching, version tracking
- `mcp-postgres-integrator.md`: Query optimization, schema analysis, migration assistance
- `mcp-playwright-integrator.md`: E2E test orchestration, complements existing playwright-skill

**Layer 3: Cross-MCP Workflows (Days 7-10)**
Discovery-driven integration patterns where MCPs collaborate. Patterns emerge from analyzing actual codebase workflows, not theoretical use cases.

**Philosophy:** Start simple (direct MCP tools), add intelligence incrementally (agents), enable sophisticated workflows (cross-MCP integration).

## Phase 1: Lean MCP Configuration (Day 1)

### Global Settings: Disabled by Default

Configure all three MCPs in `~/.claude/settings.json` but keep them disabled to prevent token pollution:

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {
        "UPSTASH_CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      },
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

### Per-Project Enabling

Create project-specific `.claude/settings.json` to enable only what you need:

```json
// Python/Database project - Context7 + PostgreSQL only
{
  "mcpServers": {
    "context7": { "disabled": false },
    "postgres": { "disabled": false }
  }
}

// Frontend testing project - Context7 + Playwright only
{
  "mcpServers": {
    "context7": { "disabled": false },
    "playwright": { "disabled": false }
  }
}
```

### Environment Setup

Create `.env` file (gitignored) with:
- `CONTEXT7_API_KEY`: Upstash API key from console.upstash.com
- `POSTGRES_CONNECTION_STRING`: Read-only connection first for safety
  `postgresql://user:pass@host:5432/db?sslmode=require`

### Cleanup Procedures

- Monitor `/mcp status` regularly
- Kill strays: `pkill -f "npx.*mcp|uvx.*postgres"` after sessions
- Use non-multiplexed terminal for long MCP streams
- Update Claude Code regularly for performance fixes

### Validation Checklist (Day 1)

- [ ] Claude Code restarts successfully
- [ ] All three MCPs appear in tool list (`/mcp list`)
- [ ] No connection errors in logs
- [ ] Environment variables load correctly

## Phase 2: Independent Validation (Days 2-3)

### Day 2: Smoke Tests

Enable each MCP individually to validate in isolation.

**Context7 Validation:**
1. Enable in project: `echo '{"mcpServers":{"context7":{"disabled":false}}}' > .claude/settings.json`
2. Test: "Use Context7 to look up FastAPI 0.115 Pydantic v2 patterns"
3. Verify: Tools `mcp__context7__resolve-library-id` and `get-library-docs` appear
4. Success metric: Latest docs retrieved, no hallucination
5. Disable after test: `rm .claude/settings.json`

**PostgreSQL Validation:**
1. Enable with read-only connection string (safety first)
2. Test: "Show me the schema for the users table"
3. Verify: Schema inspection works, queries execute safely
4. Success metric: Accurate schema returned, no write operations possible
5. Test query optimization: "Explain this query: SELECT * FROM users WHERE email = 'test@example.com'"

**Playwright Validation:**
1. Enable Playwright MCP
2. Test alongside existing playwright-skill: "Navigate to example.com and take screenshot using MCP"
3. Verify: MCP tools work independently from skill
4. Success metric: Screenshot captured, no conflicts with playwright-skill

### Day 3: Token Impact Measurement

Measure individual token footprints before enabling all three:
- Check `/context` with each MCP enabled alone
- Document baseline: "Context7 adds ~X tokens, PostgreSQL adds ~Y tokens, Playwright adds ~Z tokens"
- Ensure total < 10K tokens when all enabled (leaves room for conversation)

## Phase 3: Integrator Agents (Days 4-8)

### Why Integrator Agents?

Direct MCP tools handle simple queries well. Complex workflows need intelligence:
- Research sessions: Multi-step documentation exploration with context preservation
- Query optimization: PostgreSQL explains plans, suggests indexes, validates migrations
- E2E orchestration: Playwright coordinates with existing playwright-skill

### Agent Structure (Hybrid Pattern)

Each integrator follows this template:

```yaml
---
name: mcp-context7-integrator
description: "Use for: Multi-library research, documentation comparison, version tracking. Auto-triggers on: 'research X', 'compare Y docs', 'latest Z API'"
tools: Read, Write, mcp__context7__resolve-library-id, mcp__context7__get-library-docs
model: sonnet
---

# Context7 Research Specialist

**Direct usage (simple)**: "What's the FastAPI Pydantic docs?" → Main conversation uses MCP directly

**Agent usage (complex)**: "Research authentication patterns across FastAPI, Django, and Flask" → Agent orchestrates multi-library comparison

## Responsibilities
- Session management (save research to .moai/sessions/)
- Cross-library comparison workflows
- Version tracking (ensure latest docs)
- Fallback when Context7 unavailable (use WebSearch)

## Auto-trigger Keywords
research, compare, latest version, official docs, API reference
```

### Three Agents Built in Parallel

- Day 4-5: `mcp-context7-integrator.md`
- Day 5-6: `mcp-postgres-integrator.md`
- Day 6-7: `mcp-playwright-integrator.md`
- Day 8: Integration testing

## Phase 4: Workflow Discovery & Integration (Days 7-10)

### Discovery-First Approach

Analyze the target repository to discover actual integration opportunities rather than pre-defining theoretical patterns.

**Day 7: Codebase Analysis**
- Enable all three MCPs in target repository
- Explore: "Where are database queries concentrated?" (PostgreSQL MCP)
- Explore: "What external APIs/libraries are used?" (Context7 research candidates)
- Explore: "Where are frontend tests located?" (Playwright integration points)
- Output: List of 5-10 integration opportunities specific to that codebase

**Days 8-9: Custom Integration Patterns**
- Build 2-3 workflows based on discovery findings
- Test with real code, real data, real workflows
- Document what provides value

**Day 10: Workflow Documentation**
- Document discovered patterns in repository-specific `docs/mcp-workflows.md`
- Create runbooks for common tasks in that codebase
- Note what didn't work or wasn't useful

**Benefit:** Patterns tailored to actual needs, not theoretical use cases.

## Error Handling & Rollback

### Common Failure Modes

**Context7 Failures:**
- API key invalid → Fallback to WebSearch in integrator agent
- Rate limiting → Cache responses, exponential backoff
- Network issues → Graceful degradation, use cached docs
- Recovery: `pkill -f "npx.*context7"` then restart Claude Code

**PostgreSQL Failures:**
- Connection timeout → Check connection string, verify network/firewall
- Read-only violations → Ensure connection string includes read-only role
- Schema changes → Integrator agent detects stale schema, prompts refresh
- Recovery: Disable MCP, verify database health, re-enable with valid connection

**Playwright Failures:**
- Browser launch timeout → Increase timeout to 60s, check system resources
- Port conflicts → Kill Chrome: `pkill -f "chrome|chromium"`
- Skill vs MCP collision → Ensure playwright-skill and MCP use different ports/sessions
- Recovery: Clear browser cache, restart with fresh profile

### Rollback Strategy

Emergency rollback script if all fails:

```bash
cat > ~/.claude/mcp-disable-all.sh << 'EOF'
#!/bin/bash
# Disable all MCPs, kill strays
pkill -f "npx.*mcp|uvx.*postgres|playwright"
echo '{"mcpServers":{"context7":{"disabled":true},"postgres":{"disabled":true},"playwright":{"disabled":true}}}' > ~/.claude/settings-rollback.json
echo "All MCPs disabled. Restore from backup if needed."
EOF
chmod +x ~/.claude/mcp-disable-all.sh
```

### Monitoring Checklist

- `/mcp status` - Check MCP health
- `/context` - Monitor token usage
- Check logs: `~/.claude/logs/mcp-*.log`

## Success Metrics & Monitoring

### Context7 Success Metrics

- Hallucination reduction: Track incorrect API usage before/after (target: 80%+ reduction)
- Documentation accuracy: Verify docs match actual library version (target: 100% current)
- Research efficiency: Time to find API patterns (target: 5min vs 20min manual search)
- Token cost: Context7 queries vs WebSearch + manual verification
- Decision: Keep if saves >30min/week or prevents 1+ critical bug/month

### PostgreSQL Success Metrics

- Query optimization impact: Measure query performance improvements from MCP suggestions
- Schema accuracy: Eliminate manual schema inspection (psql usage drops to zero)
- Migration safety: Catch breaking changes before deployment (target: 100% detection)
- Workflow speed: Schema analysis time (target: 30sec vs 5min manual)
- Decision: Keep if used 3+ times/week or prevents 1 schema issue/month

### Playwright MCP Success Metrics

- Skill vs MCP usage: Track when MCP is faster than skill (simple tasks)
- Integration value: Count cross-MCP workflows (Context7 → Playwright tests)
- Test coverage: E2E tests created via MCP vs manual
- Decision: Keep if complements skill for 5+ quick tasks/week

### Overall Performance Baseline

- Pre-MCP: Session token avg, time per task, bug rate
- Post-MCP (Week 2): Compare same metrics
- Target: 20%+ efficiency gain or 50%+ error reduction

### Monthly Review

Day 30: Keep, adjust, or remove each MCP based on actual usage data.

## Implementation Checklist

### Day 1: Installation
- [ ] Add all three MCPs to `~/.claude/settings.json` (disabled)
- [ ] Create `.env` with API keys and connection strings
- [ ] Test Claude Code restart
- [ ] Verify `/mcp list` shows all three
- [ ] Create emergency rollback script

### Days 2-3: Validation
- [ ] Test Context7 individually
- [ ] Test PostgreSQL individually (read-only)
- [ ] Test Playwright individually
- [ ] Measure token footprint per MCP
- [ ] Document baseline metrics

### Days 4-8: Agent Creation
- [ ] Create `mcp-context7-integrator.md`
- [ ] Create `mcp-postgres-integrator.md`
- [ ] Create `mcp-playwright-integrator.md`
- [ ] Test each agent independently
- [ ] Integration testing

### Days 7-10: Workflow Discovery
- [ ] Analyze target codebase
- [ ] Identify 5-10 integration opportunities
- [ ] Build 2-3 custom workflows
- [ ] Test with real code
- [ ] Document in `docs/mcp-workflows.md`

### Day 30: Monthly Review
- [ ] Measure actual usage per MCP
- [ ] Compare metrics vs baseline
- [ ] Keep, adjust, or remove each MCP
- [ ] Update documentation

## Risk Mitigation

**Risk:** All three MCPs fail simultaneously
**Mitigation:** Emergency rollback script, disabled-by-default strategy
**Recovery:** 5 minutes to full rollback

**Risk:** Token pollution from verbose MCP descriptions
**Mitigation:** Disabled by default, per-project enabling, regular monitoring
**Recovery:** Disable unused MCPs immediately

**Risk:** PostgreSQL write operations in production
**Mitigation:** Read-only connection string enforced
**Recovery:** Connection string validation before enabling

**Risk:** Playwright conflicts with existing playwright-skill
**Mitigation:** Different ports/sessions, test both simultaneously
**Recovery:** Disable MCP, use skill only

## Next Steps

1. Review this design in target repository
2. Adjust timeline based on project complexity
3. Begin Day 1 implementation
4. Track metrics from Day 1 forward
5. Monthly review and optimization

## References

- Context7 MCP: `@upstash/context7-mcp`
- PostgreSQL MCP: `mcp-server-postgres` (uvx)
- Playwright MCP: `@playwright/mcp`
- MOAI-ADK integrator agent patterns
- Claude Code MCP best practices
