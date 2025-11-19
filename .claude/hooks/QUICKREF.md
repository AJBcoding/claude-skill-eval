# Integration Hooks - Quick Reference

## At a Glance

| Hook | When | Agent | Model | Time | Purpose |
|------|------|-------|-------|------|---------|
| **pre-implementation** | Before Edit/Write | consistency-agent | Haiku | 15-30s | Find & suggest patterns |
| **post-error** | After errors | debug-agent | Sonnet | 2-10m | Systematic debugging |
| **post-implementation** | After changes | quality-agent | Sonnet | 1-2m | Quality review |

---

## Common Commands

### Skip a Hook
```bash
# Skip consistency check
--skip-consistency-check

# Skip debug methodology
--skip-debug

# Skip quality review
--skip-quality-check

# Skip for minor changes
--minor-change
```

### Disable All Hooks
```bash
export CLAUDE_SKIP_HOOKS=true
```

### Re-enable Hooks
```bash
unset CLAUDE_SKIP_HOOKS
```

---

## Exit Codes

### Pre-Implementation
- `0` = Pattern applied or user proceeded
- `1` = No patterns found (warning)
- `2` = User declined to proceed

### Post-Error
- `0` = Bug resolved
- `1` = Partial progress
- `2` = External blocker
- `3` = Needs user expertise

### Post-Implementation
- `0` = All quality gates passed
- `1` = Non-blocking warnings
- `2` = Blocking issues found
- `3` = Security issues (blocks commit)

---

## Hook Priority

When hooks conflict:
1. **Debug Agent** (highest) - Correctness & security
2. **Quality Agent** - Quality standards
3. **Consistency Agent** (lowest) - Pattern preferences

---

## Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Hook not activating | Check `enabled: true` in YAML |
| Hook too frequent | Increase `min_lines` threshold |
| Hook too slow | Enable caching, reduce `max_file_reads` |
| False positives | Adjust checklist `required` flags |
| Can't bypass | Check flag syntax, verify in bypass conditions |

---

## Configuration Files

- **Hooks**: `.claude/hooks/*.yml`
- **Agents**: `.claude/agents/*/agent.yml`
- **Logs**: `.claude/logs/debug-sessions.jsonl`
- **Metrics**: `.claude/metrics/quality-metrics.json`
- **Reports**: `.claude/reports/quality-review-*.md`

---

## Quality Checklist Categories

1. **Test Coverage** (Critical) - Unit tests, integration tests, edge cases
2. **Documentation** (High) - Code comments, API docs, README
3. **Error Handling** (Critical) - Input validation, exception handling
4. **Performance** (Medium) - Efficiency, queries, caching
5. **Security** (Critical) - Sanitization, auth, no secrets
6. **Code Quality** (High) - Readability, DRY, conventions
7. **Integration** (High) - No breaking changes, migrations, builds

---

## Debug Methodology (6 Steps)

1. **Reproduce** - Establish reliable reproduction steps
2. **Isolate** - Narrow down to specific component/line
3. **Hypothesis** - Formulate theories about root cause
4. **Test** - Validate/invalidate each hypothesis
5. **Fix** - Implement solution for confirmed cause
6. **Verify** - Confirm error resolved, tests pass

---

## Example Workflows

### New Feature
```
1. User: "Add pagination to API"
2. Pre-hook: Finds similar paginated endpoints
3. User: Implements following pattern
4. Post-hook: Quality review passes
5. Commit ready
```

### Bug Fix
```
1. User: Runs tests
2. Tests fail
3. Post-error hook: Guides through 6 steps
4. Bug fixed
5. Post-implementation hook: Verifies quality
6. Commit ready
```

### Emergency Fix
```
1. Critical bug found
2. Use --skip-consistency-check
3. Fix implemented
4. Post-implementation hook: Security check only
5. Deploy
6. Follow up with full review later
```

---

## Best Practices

✓ **DO**:
- Review hook reports for learning
- Adjust thresholds to your project
- Use bypass for legitimate exceptions
- Keep quality checklist current

✗ **DON'T**:
- Disable hooks globally
- Ignore security warnings
- Skip all quality checks
- Bypass without good reason

---

## For More Information

- Full documentation: `README.md`
- Test scenarios: `test-scenarios.md`
- Agent specs: `/docs/agent-specifications.md`
- Config patterns: `/analysis/config-patterns.md`

---

**Version**: 1.0.0 | **Updated**: 2025-11-19
