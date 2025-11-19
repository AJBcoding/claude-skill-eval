# Claude Code Integration Hooks System

## Overview

The integration hooks system provides automatic activation of specialized agents at appropriate points in the development workflow. This ensures consistent quality, pattern adherence, and systematic debugging without requiring manual agent invocation.

**Version**: 1.0.0
**Last Updated**: 2025-11-19

---

## Philosophy

The hooks system is designed around three core principles:

1. **Enhance, Don't Block**: Hooks should improve the development experience, not create friction
2. **Context-Aware**: Hooks activate based on file types, change significance, and user signals
3. **Transparent**: Clear feedback about what hooks are doing and why

---

## Hook System Architecture

### Three-Hook Workflow

```
User Request / Code Change
         ↓
   ┌─────────────────────────────────┐
   │  PRE-IMPLEMENTATION HOOK        │
   │  (consistency-agent)            │
   │  • Search for similar patterns  │
   │  • Suggest pattern reuse        │
   │  • Ensure architectural coherence│
   └─────────────────────────────────┘
         ↓
   Implementation / Execution
         ↓
   ┌─────────────────────────────────┐
   │  POST-ERROR HOOK (if error)     │
   │  (debug-agent)                  │
   │  • Capture error context        │
   │  • Enforce 6-step methodology   │
   │  • Systematic debugging         │
   └─────────────────────────────────┘
         ↓
   ┌─────────────────────────────────┐
   │  POST-IMPLEMENTATION HOOK       │
   │  (quality-agent)                │
   │  • Review against checklist     │
   │  • Validate quality gates       │
   │  • Generate review report       │
   └─────────────────────────────────┘
         ↓
   Complete / Commit
```

---

## Hook Specifications

### 1. Pre-Implementation Hook

**File**: `pre-implementation.yml`
**Agent**: `consistency-agent`
**Priority**: High
**Model**: Haiku (fast pattern matching)

#### Purpose
Activates before Edit/Write operations to check for similar patterns in the codebase. Ensures new implementations follow established architectural patterns and conventions.

#### Triggers
- **Before**: Edit, Write, MultiEdit operations
- **Conditions**:
  - Code files only (`.js`, `.ts`, `.py`, `.go`, etc.)
  - New implementation keywords detected (`create`, `add`, `implement`)
  - Changes ≥ 5 lines (skip trivial edits)

#### Workflow
1. **Identify Task Type**: Classify what's being implemented
2. **Search Similar Patterns**: Use Grep/Glob to find similar code
3. **Analyze Patterns**: Extract common conventions
4. **Suggest Reuse**: Present patterns to user for approval

#### Exit Codes
- `0`: Pattern found and applied, or user chose to proceed
- `1`: Warning - no similar patterns found
- `2`: Block - user declined after pattern review
- `130`: User cancelled

#### Bypass Options
- Flag: `--skip-consistency-check`
- Env var: `CLAUDE_SKIP_HOOKS=true`
- Test files: `**/test/**` (relaxed standards)

#### Example Activation

```
User: "Add a new POST endpoint for user registration"

✓ Pre-implementation hook activated
→ Searching for similar POST endpoints...
→ Found 5 similar implementations
→ Common pattern detected:
  • Express route handler
  • Joi validation middleware
  • Database transaction wrapper
  • Standard error responses
  • Unit test structure

⚠ Suggestion: Follow the same pattern?
  [Y] Yes, apply pattern  [N] No, custom implementation  [V] View pattern details
```

---

### 2. Post-Error Hook

**File**: `post-error.yml`
**Agent**: `debug-agent`
**Priority**: Critical
**Model**: Sonnet (complex reasoning for debugging)

#### Purpose
Automatically activates when errors occur (test failures, bash errors, runtime exceptions). Enforces systematic 6-step debugging methodology to ensure thorough problem resolution.

#### Triggers
- **After**: Bash errors (non-zero exit), test failures, build failures, runtime errors
- **Conditions**:
  - Non-zero exit codes
  - Error patterns in output (`Error`, `Exception`, `FAILED`, `Traceback`)
  - Test framework failures (`pytest FAILED`, `npm ERR!`, `jest FAIL`)
  - Minimum severity: Warning level

#### Error Context Captured
- Exact command that failed
- Exit code and error output
- Stack trace (if available)
- Files being modified when error occurred
- Git status and recent changes
- Environment variables (sanitized)

#### 6-Step Debugging Methodology

1. **Reproduce** (60s timeout)
   - Establish reliable reproduction steps
   - Document exact conditions
   - Output: Clear reproduction instructions

2. **Isolate** (120s timeout)
   - Narrow down scope
   - Identify specific component/function/line
   - Output: Minimal reproduction case

3. **Hypothesis** (60s timeout)
   - Formulate theories about root cause
   - Consider multiple explanations
   - Output: Ordered list of potential causes

4. **Test** (120s timeout)
   - Design experiments to validate hypotheses
   - Use targeted logging/breakpoints
   - Output: Evidence for/against each hypothesis

5. **Fix** (180s timeout)
   - Implement solution for confirmed root cause
   - Address underlying issue, not symptoms
   - Output: Code changes with explanation

6. **Verify** (60s timeout)
   - Confirm error is resolved
   - Run full test suite
   - Output: Verification evidence

#### Exit Codes
- `0`: Bug resolved and verified
- `1`: Partial progress made
- `2`: External blocker encountered
- `3`: Needs user expertise
- `130`: User cancelled

#### Bypass Options
- Flag: `--skip-debug`
- Expected failures: TDD red phase
- Info-level messages only

#### Example Activation

```
$ npm test
[Exit code 1: 3 tests FAILED]

🔍 Error detected. Activating debug-agent...

ERROR CONTEXT CAPTURED:
  Command: npm test
  Exit Code: 1
  Failed Tests: user-auth.test.js (3 failures)
  Recent Changes: auth.js (modified 2 min ago)

STEP 1/6: Reproduce
→ Can you reliably reproduce these test failures?
→ [Guides through establishing reproduction steps]

STEP 2/6: Isolate
→ Which specific assertions are failing?
→ [Narrows down to specific test cases]

STEP 3/6: Hypothesis
→ Potential causes:
  1. Missing validation in auth middleware (high probability)
  2. Database mock not properly reset (medium)
  3. Race condition in async test (low)

[Continues through all 6 steps...]

✅ Bug resolved! All verification tests passed.
   Root cause: Missing email validation
   Fix: Added validation middleware
   Tests: All passing (12/12)
```

---

### 3. Post-Implementation Hook

**File**: `post-implementation.yml`
**Agent**: `quality-agent`
**Priority**: High
**Model**: Sonnet (nuanced quality judgment)

#### Purpose
Activates after code changes to perform comprehensive quality review. Ensures all quality gates pass before marking work as complete or committing.

#### Triggers
- **After**: Edit, Write, MultiEdit operations
- **Before**: Git commit operations
- **On**: Completion signals (`done`, `complete`, `ready`, `commit`, `ship`)
- **Conditions**:
  - Code files only
  - Changes ≥ 10 lines (skip trivial)
  - User signals completion

#### Quality Checklist

##### 1. Test Coverage (Critical)
- ✓ Unit tests present for new functions
- ✓ Integration tests for workflows
- ✓ Edge cases and error paths covered
- ✓ All tests pass (BLOCKING)

##### 2. Documentation (High)
- ✓ Complex logic explained
- ✓ Function parameters/returns documented
- ✓ README updated for user-facing changes
- ✓ API documentation complete

##### 3. Error Handling (Critical)
- ✓ Input validation (BLOCKING)
- ✓ Exceptions caught appropriately
- ✓ Clear error messages
- ✓ Graceful degradation (BLOCKING)

##### 4. Performance (Medium)
- ✓ No obvious bottlenecks
- ✓ Efficient database queries
- ○ Memory management optimized
- ○ Caching used appropriately

##### 5. Security (Critical)
- ✓ Input sanitization (BLOCKING)
- ✓ Authentication/authorization (BLOCKING)
- ✓ No hardcoded secrets (BLOCKING)
- ✓ No dependency vulnerabilities

##### 6. Code Quality (High)
- ✓ Readable, clear variable names
- ✓ DRY principle followed
- ○ SOLID principles applied
- ✓ Project conventions followed

##### 7. Integration (High)
- ✓ No breaking changes (BLOCKING)
- ✓ Backward compatible migrations
- ✓ Builds cleanly

**Legend**: ✓ = Required, ○ = Recommended, (BLOCKING) = Prevents commit

#### Exit Codes
- `0`: All quality gates passed
- `1`: Warnings (non-blocking issues)
- `2`: Blocking issues found
- `3`: Security issues (blocks commit)
- `130`: User override

#### Bypass Options
- Flag: `--skip-quality-check` (not recommended)
- Flag: `--minor-change` (for docs/comments)
- Test files: Relaxed standards
- Documentation-only changes

#### Example Activation

```
User: "I'm done implementing the payment processing feature. Let's commit it."

✓ Post-implementation hook activated
→ Running quality checklist...

QUALITY REVIEW REPORT
=====================

Test Coverage: ✓ PASSED
  ✓ Unit tests present (8 new tests)
  ✓ Integration tests complete
  ✓ All tests passing (45/45)

Documentation: ✗ INCOMPLETE
  ✗ API documentation missing for /api/payments endpoint

Error Handling: ✓ PASSED
  ✓ Input validation implemented
  ✓ Proper error catching

Security: ✗ CRITICAL ISSUE
  ✗ Hardcoded API key found on line 45 (stripe_api_key)

Code Quality: ✓ PASSED
  ✓ Clean, readable code
  ✓ No duplication

Overall: BLOCKED
  2 issues must be resolved before committing

❌ Quality review failed. 2 critical issues must be resolved:
  1. CRITICAL: Hardcoded API key (line 45) - move to environment variable
  2. REQUIRED: Add API documentation for /api/payments endpoint

Cannot proceed with commit until these are resolved.
```

---

## Hook Execution Order

When multiple hooks could apply, they execute in this order:

1. **Pre-Implementation** (before code changes)
2. **Implementation** (user makes changes)
3. **Post-Error** (if error occurs during implementation)
4. **Post-Implementation** (after changes complete)

### Conflict Resolution Priority

If hooks have conflicting guidance:

1. **Debug Agent** (highest priority) - Security and correctness
2. **Quality Agent** - Quality standards
3. **Consistency Agent** (lowest priority) - Pattern preferences

**Example**: If Consistency Agent suggests a pattern that Quality Agent identifies as having security issues, Quality Agent overrides.

---

## Integration with obra superpowers

All hooks are designed to complement, not conflict with, obra/superpowers workflow:

- **Compatible**: Hooks work alongside superpowers skills
- **Enhancing**: Adds automated quality gates to superpowers workflow
- **Non-Blocking** (mostly): Only critical issues (security, data loss) block workflow
- **Transparent**: Clear feedback about what's being checked

### Combined Workflow Example

```
User: "Implement user authentication using best practices"

1. Superpowers skill activated: "systematic-implementation"
2. Pre-implementation hook: Searches for existing auth patterns
3. Implementation guided by superpowers + consistency patterns
4. [If error] Post-error hook: Systematic debugging
5. Post-implementation hook: Quality review
6. Superpowers: Final review and commit
```

---

## Configuration

### Enabling/Disabling Hooks

Edit the YAML files to enable/disable:

```yaml
enabled: true  # Change to false to disable hook
```

### Adjusting Priority

```yaml
priority: critical  # Options: critical, high, medium, low
```

### Modifying Thresholds

Each hook has configurable thresholds:

**Pre-Implementation**:
```yaml
conditions:
  - type: file_size
    min_lines: 5  # Adjust minimum change size
```

**Post-Error**:
```yaml
conditions:
  - type: severity
    min_level: "warning"  # Options: info, warning, error, critical
```

**Post-Implementation**:
```yaml
conditions:
  - type: change_significance
    min_lines_changed: 10  # Adjust minimum lines
```

---

## Troubleshooting Guide

### Hook Not Activating

**Problem**: Expected hook didn't trigger

**Solutions**:
1. Check `enabled: true` in hook YAML file
2. Verify conditions are met (file type, line count, etc.)
3. Check if bypass flag is set (`--skip-*-check`)
4. Ensure environment variable `CLAUDE_SKIP_HOOKS` is not set
5. Review trigger conditions in hook YAML

### Hook Activating Too Often

**Problem**: Hook triggering on every small change

**Solutions**:
1. Increase `min_lines` threshold in conditions
2. Add more specific file type patterns
3. Use bypass for specific directories (e.g., tests)
4. Adjust `change_significance` threshold

### Hook Blocking When It Shouldn't

**Problem**: Hook blocking legitimate work

**Solutions**:
1. Review blocking vs. warning issues in report
2. Use bypass flag for exceptional cases: `--skip-quality-check`
3. Check if issue is actually critical (security, data loss)
4. Adjust `required` flags in checklist items
5. Use `--minor-change` flag for documentation updates

### Hook Performance Issues

**Problem**: Hooks taking too long to execute

**Solutions**:
1. Check `max_execution_time` settings
2. Review `max_file_reads` limits
3. Enable `cache_results` where appropriate
4. Use Haiku model for faster, simpler checks
5. Enable `parallel_checks` in quality hook

### Multiple Hooks Conflicting

**Problem**: Different hooks giving contradictory guidance

**Solution**: Follow priority order:
1. Debug Agent (highest) - correctness and security
2. Quality Agent - quality standards
3. Consistency Agent (lowest) - pattern preferences

### Bypass Not Working

**Problem**: Bypass flag not skipping hook

**Check**:
1. Correct flag syntax: `--skip-consistency-check`
2. Flag in bypass conditions list
3. Environment variable set correctly: `export CLAUDE_SKIP_HOOKS=true`
4. File pattern matches (e.g., `**/test/**`)

---

## Advanced Usage

### Custom Quality Checklists

Modify `post-implementation.yml` to add project-specific checks:

```yaml
checklist:
  categories:
    - name: custom_project_standards
      weight: high
      checks:
        - id: design_system_components
          description: "UI components use design system"
          required: true

        - id: accessibility_compliance
          description: "WCAG 2.1 AA compliance verified"
          required: true
```

### Error Pattern Learning

Post-error hook can learn from debugging sessions:

```yaml
learning:
  enabled: true
  patterns_file: ".claude/data/error-patterns.json"
```

This builds a database of:
- Common error types in your codebase
- Typical resolutions
- Time to resolve
- Effective debugging strategies

### Quality Metrics Tracking

Post-implementation hook tracks quality trends:

```yaml
metrics:
  enabled: true
  track:
    - quality_gate_pass_rate
    - issues_detected
    - avg_test_coverage
    - most_common_issues
  output_file: ".claude/metrics/quality-metrics.json"
```

Review metrics periodically to identify:
- Frequently missed quality checks
- Areas needing better documentation
- Common security issues
- Performance patterns

---

## Best Practices

### 1. Don't Disable Hooks Globally

Instead of disabling hooks, use targeted bypasses:

**Good**:
```bash
# Bypass for specific minor change
--minor-change --skip-quality-check
```

**Bad**:
```bash
# Disabling all hooks
export CLAUDE_SKIP_HOOKS=true
```

### 2. Review Hook Reports Thoroughly

Hook reports contain valuable insights:
- **Pre-Implementation**: Learn established patterns
- **Post-Error**: Understand debugging methodology
- **Post-Implementation**: Identify quality gaps

### 3. Adjust Thresholds Based on Project Maturity

**Early Stage Project** (rapid prototyping):
- Lower quality requirements
- Relaxed consistency checks
- Focus on critical security/correctness

**Mature Project** (production code):
- Stricter quality gates
- Strong consistency enforcement
- Comprehensive testing requirements

### 4. Use Hooks as Learning Tools

Pay attention to:
- Patterns suggested by consistency-agent
- Debugging methodology from debug-agent
- Quality gaps identified by quality-agent

Over time, you'll internalize these standards and need less automated enforcement.

### 5. Customize for Your Team

Modify checklists to match your team's standards:
- Coding conventions
- Documentation requirements
- Testing strategies
- Security policies

---

## Hook Performance

### Execution Time Benchmarks

| Hook | Typical Duration | Model | Cost |
|------|------------------|-------|------|
| Pre-Implementation | 15-30s | Haiku | Low |
| Post-Error | 2-10min | Sonnet | Medium |
| Post-Implementation | 1-2min | Sonnet | Medium |

### Optimization Tips

1. **Enable Caching**: Pre-implementation pattern cache (5min TTL)
2. **Parallel Checks**: Quality checks run in parallel
3. **Smart Triggers**: Conditions prevent unnecessary activations
4. **Fast Models**: Haiku for pattern matching, Sonnet for complex analysis

---

## Examples of Hooks in Action

### Example 1: Full Workflow with All Hooks

```
User: "Add pagination to the user list API endpoint"

--- PRE-IMPLEMENTATION HOOK ---
✓ Consistency check activated
→ Found 3 existing paginated endpoints
→ Common pattern:
  • Query params: ?page=1&limit=20
  • Response format: { data: [], pagination: { page, totalPages } }
  • Sequelize limit/offset
  • Unit tests for edge cases (page=0, limit=1000)
→ Apply this pattern? [Y]es

--- IMPLEMENTATION ---
[User implements following pattern]

--- POST-IMPLEMENTATION HOOK ---
✓ Quality review activated
→ Test Coverage: ✓ PASSED (unit tests added)
→ Documentation: ✗ WARNING (consider adding pagination example to README)
→ Error Handling: ✓ PASSED (validates page/limit params)
→ Performance: ✓ PASSED (efficient query with limit/offset)
→ Security: ✓ PASSED (prevents excessive limits)
→ Code Quality: ✓ PASSED (follows conventions)
→ Integration: ✓ PASSED (backward compatible)

Overall: PASSED with 1 warning
⚠ Consider adding pagination example to README

✅ All quality gates passed! Code is ready to commit.
```

### Example 2: Error Handling with Debug Hook

```
User: "Run the test suite"
$ npm test

[Exit code 1: AuthenticationError]

--- POST-ERROR HOOK ---
🔍 Error detected. Activating debug-agent...

STEP 1: Reproduce
→ Error occurs every time on auth.test.js
→ Reproduction: Run `npm test auth.test.js`

STEP 2: Isolate
→ Specific test: "should validate JWT tokens"
→ Failure: JWT verification throwing error

STEP 3: Hypothesis
→ Possible causes:
  1. JWT secret missing from test env (HIGH)
  2. Token expiration in test (MEDIUM)
  3. Invalid test token format (LOW)

STEP 4: Test
→ Checking .env.test file...
→ ✗ JWT_SECRET not found in test environment
→ Hypothesis #1 confirmed!

STEP 5: Fix
→ Added JWT_SECRET to .env.test
→ Updated test setup to load test env vars

STEP 6: Verify
→ Re-running tests...
→ ✅ All tests passing (12/12)

✅ Bug resolved! All verification tests passed.
```

### Example 3: Quality Gate Blocking Security Issue

```
User: "Done with the password reset feature, let's ship it"

--- POST-IMPLEMENTATION HOOK ---
✓ Quality review activated

QUALITY REVIEW REPORT
=====================

Security: ✗ CRITICAL ISSUES
  ✗ Password reset tokens not expiring (security risk)
  ✗ No rate limiting on reset endpoint (DoS vulnerability)
  ✗ Tokens sent via URL parameter (insecure, should use POST body)

Error Handling: ✗ BLOCKING
  ✗ No validation on email parameter (injection risk)

Overall: BLOCKED

❌ SECURITY ISSUES DETECTED!
Cannot proceed until security vulnerabilities are resolved:

CRITICAL:
1. Add expiration to password reset tokens (max 15 minutes)
2. Implement rate limiting on /api/auth/reset endpoint
3. Move token from URL to POST body
4. Add email validation and sanitization

These are security vulnerabilities that could compromise user accounts.
Please resolve before committing.
```

---

## Maintenance

### Updating Hook Configurations

1. Edit YAML files in `.claude/hooks/`
2. Changes take effect immediately (no rebuild needed)
3. Version control hook configurations
4. Document customizations in this README

### Adding New Checks

To add custom quality checks:

1. Edit `post-implementation.yml`
2. Add check to appropriate category
3. Set `required: true/false`
4. Set `blocking: true/false` for critical checks
5. Test with sample code changes

### Monitoring Hook Effectiveness

Review these periodically:
- `.claude/logs/debug-sessions.jsonl` - Debug session history
- `.claude/metrics/quality-metrics.json` - Quality trends
- `.claude/data/error-patterns.json` - Common error patterns
- `.claude/reports/quality-review-*.md` - Individual quality reports

---

## FAQ

**Q: Can I disable a specific hook temporarily?**
A: Yes, set `enabled: false` in the hook's YAML file, or use bypass flags per-execution.

**Q: Do hooks slow down my workflow?**
A: Pre-implementation (15-30s) and post-implementation (1-2min) are quick. Debug hook (2-10min) only activates on errors. The time saved by catching issues early outweighs the overhead.

**Q: Can I use hooks without the agents?**
A: No, hooks are designed to activate specific agents. However, agents can be used independently without hooks.

**Q: What happens if a hook fails or crashes?**
A: Hooks fail gracefully. You'll see a warning message and can proceed manually. The failure is logged for investigation.

**Q: Can I create custom hooks?**
A: Yes! Follow the YAML pattern in existing hooks. Ensure your hook specifies an existing agent.

**Q: How do hooks interact with git operations?**
A: Post-implementation hook can activate before commits. Post-error hook doesn't directly interact with git. Both respect git ignore patterns.

**Q: Are hooks project-specific or global?**
A: Hooks are project-specific (in `.claude/hooks/`). Each project can customize hooks independently.

**Q: Can multiple hooks run simultaneously?**
A: No, hooks run sequentially in priority order. However, quality checks within post-implementation hook can run in parallel.

---

## Support and Feedback

### Reporting Issues

If hooks behave unexpectedly:
1. Check this README's troubleshooting section
2. Review hook YAML configuration
3. Check logs in `.claude/logs/`
4. Verify agent configurations in `.claude/agents/*/agent.yml`

### Contributing Improvements

To improve hooks:
1. Test changes thoroughly
2. Document modifications
3. Update this README
4. Version control all changes

---

## Version History

### v1.0.0 (2025-11-19)
- Initial release
- Three core hooks: pre-implementation, post-error, post-implementation
- Integration with debug-agent, consistency-agent, quality-agent
- Comprehensive quality checklists
- 6-step debugging methodology
- Pattern matching and reuse
- Bypass mechanisms
- Performance optimizations

---

## Summary

The integration hooks system provides:

- **Automated Quality Gates**: Catch issues before they reach production
- **Pattern Consistency**: Ensure architectural coherence automatically
- **Systematic Debugging**: Enforce methodology for thorough problem resolution
- **Transparent Feedback**: Clear communication about what's being checked
- **Flexible Configuration**: Customize for your team's needs
- **Performance Optimized**: Fast checks with appropriate model selection

Use hooks to build better code with less manual oversight, while maintaining the flexibility to bypass when needed.

---

**Next Steps**:
1. Review hook configurations in `.claude/hooks/*.yml`
2. Customize quality checklists for your project
3. Test hooks with sample implementations
4. Adjust thresholds based on your workflow
5. Monitor hook effectiveness via metrics

For more information, see:
- Agent specifications: `/docs/agent-specifications.md`
- Configuration patterns: `/analysis/config-patterns.md`
- Agent configurations: `.claude/agents/*/agent.yml`
