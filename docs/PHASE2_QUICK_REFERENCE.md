# Phase 2 Quick Reference Card

**Version**: 1.0.0 | **Date**: 2025-11-19 | **Print & Keep Handy**

---

## The Three Agents

| Agent | When | Purpose | Model | Speed |
|-------|------|---------|-------|-------|
| **Debug** | Errors occur | 6-step systematic debugging | Sonnet | 2-10min |
| **Consistency** | Before code | Pattern matching & reuse | Haiku | 15-30s |
| **Quality** | After code | 7-category review | Sonnet | 1-2min |

---

## Agent Activation Keywords

### Debug Agent
```
debug, fix, error, bug, failing, broken, not working, issue, problem
```

### Consistency Agent
```
implement, add, create, build, write, develop, make, generate, new feature
```

### Quality Agent
```
done, complete, finished, ready, commit, ship, deploy, merge, review
```

---

## Automatic Triggers

| Trigger | Priority | When Fires |
|---------|----------|------------|
| Bash error | CRITICAL | Exit code != 0 |
| Test failure | CRITICAL | Tests fail |
| Stack trace | CRITICAL | Exception in output |
| Before Edit | MEDIUM | Edit tool called |
| Before Write | MEDIUM | Write tool called |
| After Write | MEDIUM | File created |
| Multiple edits | MEDIUM | 3+ edits in session |
| Before commit | HIGH | git commit |

---

## Bypass Commands

### Temporary (One Command)
```bash
--skip-triggers                  # All triggers
--skip-agent=debug-agent         # Specific agent
--skip-consistency-check         # Consistency
--skip-debug                     # Debug
--skip-quality-check             # Quality
--no-hooks                       # All hooks
```

### Session-Wide (Until Unset)
```bash
export CLAUDE_SKIP_AGENTS=true   # All agents
export CLAUDE_SKIP_TRIGGERS=true # Auto-triggers only
export CLAUDE_AGENT_MODE=manual  # Manual activation only

# To re-enable:
unset CLAUDE_SKIP_AGENTS
```

### File-Specific
```python
# @skip-triggers               # Top of file
# @skip-agent:consistency      # Skip specific
```

---

## Debug Agent: 6-Step Methodology

```
1. REPRODUCE (60s)   → Establish reliable reproduction
2. ISOLATE (120s)    → Narrow to specific component
3. HYPOTHESIS (60s)  → Generate theories about cause
4. TEST (120s)       → Validate/invalidate hypotheses
5. FIX (180s)        → Implement solution
6. VERIFY (60s)      → Confirm resolution, run tests
```

**Can't skip steps. All required.**

---

## Quality Agent: 7-Category Checklist

| Category | Blocking? | Key Checks |
|----------|-----------|------------|
| 1. Tests | ✓ (if fail) | Unit, integration, edge cases, all pass |
| 2. Docs | ✗ | Comments, function docs, README, API |
| 3. Error Handling | ✓ (critical) | Input validation, exceptions, messages |
| 4. Performance | ✗ | Efficiency, DB queries, memory, caching |
| 5. Security | ✓ (critical) | Sanitization, auth, no secrets |
| 6. Code Quality | ✗ | Readability, DRY, SOLID, conventions |
| 7. Integration | ✓ (breaking) | No breaking changes, migrations, builds |

**✓ = Blocks commit if failed | ✗ = Warning only**

---

## Priority Levels

When multiple triggers fire simultaneously:

```
1. CRITICAL (1000)  → Bash errors, test failures, stack traces
2. HIGH (100)       → Git commits, debug with evidence
3. MEDIUM (10)      → Keywords, tool events
4. LOW (1)          → Fallback patterns
5. OVERRIDE (∞)     → Explicit user request ("use debug-agent")
```

**Agent tie-breaker**: debug > quality > consistency

---

## Common Commands

### Validate Configuration
```bash
.claude/hooks/validate-hooks.sh
```

### Check Metrics
```bash
cat .claude/metrics/trigger-analytics.json
```

### View Recent Triggers
```bash
cat .claude/logs/trigger-events.jsonl | tail -20
```

### Test Trigger
```bash
.claude/config/test-trigger.sh "implement new feature"
```

---

## File Locations

### Agents
```
.claude/agents/debug-agent/       # Systematic debugging
.claude/agents/consistency-agent/  # Pattern matching
.claude/agents/quality-agent/      # Quality review
```

### Rules
```
.claude/rules/debugging-methodology.md    # 6 steps
.claude/rules/consistency-patterns.md     # Patterns
.claude/rules/quality-standards.md        # 7 categories
.claude/rules/skill-activation.md         # Skills
```

### Configuration
```
.claude/config/triggers.yml               # All triggers
.claude/hooks/*.yml                       # 3 hooks
.claude/metrics/                          # Analytics
```

---

## Troubleshooting Quick Fixes

### Agent not activating?
```bash
# 1. Check if disabled
cat .claude/agents/debug-agent/agent.yml | grep enabled

# 2. Check bypass flags
echo $CLAUDE_SKIP_AGENTS

# 3. Review trigger logs
cat .claude/logs/trigger-events.jsonl | tail -10
```

### Agent too slow?
```yaml
# Edit agent.yml
performance:
  enable_caching: true
  max_file_reads: 10  # Reduce from 20
```

### Too many false positives?
```yaml
# Edit triggers.yml
consistency-keyword-trigger:
  min_confidence: 0.85  # Increase from 0.7
```

### Quality agent blocking unfairly?
```yaml
# Edit quality-agent/checklist.md
#### problematic-check
blocking: false  # Change from true
required: false  # Make optional
```

---

## Emergency Procedures

### Disable Everything
```bash
export CLAUDE_SKIP_AGENTS=true
```

### Disable Specific Agent
```yaml
# Edit .claude/agents/{agent}/agent.yml
enabled: false
```

### Restore from Backup
```bash
git checkout HEAD~1 -- .claude/
.claude/hooks/validate-hooks.sh
```

---

## Quick Workflows

### Feature Implementation
```
1. "implement user login"
   → Consistency agent searches patterns
   → Suggests OAuth2 pattern
2. Implement following pattern
3. "done, ready to commit"
   → Quality agent reviews
   → All checks pass
4. Commit allowed ✓
```

### Bug Fix
```
1. npm test (fails)
   → Debug agent activates (auto)
   → Guides through 6 steps
2. Fix implemented
3. Tests pass
   → Quality agent reviews fix
4. Commit allowed ✓
```

---

## Pro Tips

1. **Use explicit keywords** - Say "debug this" not "this is broken"
2. **Bypass when prototyping** - `--skip-consistency-check` for rapid iteration
3. **Review metrics weekly** - Adjust thresholds based on usage
4. **Add patterns as you go** - Document reusable patterns
5. **Quality blocks are good** - Security/breaking changes should block

---

## Getting Help

**10-Minute Overview**: `PHASE2_README.md`
**Full Details**: `.claude/hooks/README.md`
**Modification Guide**: `docs/phase2-handoff.md`
**Examples**: `docs/examples/`

---

## Version Info

- **Phase**: 2
- **Version**: 1.0.0
- **Date**: 2025-11-19
- **Status**: Production Ready
- **Test Coverage**: 100% (62/62 trigger tests, 38/38 hook validations)

---

**Print this card and keep it at your desk for quick reference!**
