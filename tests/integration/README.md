# Phase 2 Integration Testing

## Overview

This directory contains comprehensive integration tests for the Phase 2 Configuration Systems, which includes three specialized agents (debug, consistency, and quality), three hooks (pre-implementation, post-error, post-implementation), and a sophisticated trigger system.

**Purpose**: Validate that all Phase 2 components work together seamlessly to enhance the development workflow.

**Status**: ✅ Test plan complete, ready for execution

---

## Quick Navigation

### Primary Documents

| Document | Purpose | Status |
|----------|---------|--------|
| **[full-workflow.md](full-workflow.md)** | Complete integration test plan with 3 scenarios | ✅ Ready |
| **[TEST-EXECUTION-STATUS.md](TEST-EXECUTION-STATUS.md)** | Test execution tracking and status | 🔴 Not Started |
| **[ISSUES.md](ISSUES.md)** | Issue tracking for problems found | 📝 Empty (ready) |
| **[README.md](README.md)** | This file - overview and navigation | ✅ Complete |

### Supporting Documents

| Document | Purpose |
|----------|---------|
| `../debug-agent-test.md` | Individual debug agent tests |
| `../consistency-agent-test.md` | Individual consistency agent tests |
| `../quality-agent-test.md` | Individual quality agent tests |
| `../../.claude/hooks/test-scenarios.md` | Hook-specific test scenarios |

---

## What Is Being Tested?

### System Components

**Agents** (3):
1. **Debug Agent**: Enforces 6-step debugging methodology
   - Reproduce → Isolate → Hypothesis → Test → Fix → Verify
   - Activated on errors, test failures, debugging keywords

2. **Consistency Agent**: Finds and suggests existing patterns
   - Searches codebase for similar implementations
   - Recommends following established patterns
   - Activated on create/implement keywords

3. **Quality Agent**: Reviews code against 7-category checklist
   - Tests, Documentation, Error Handling, Performance, Security, Code Quality, Integration
   - Activated on completion keywords or pre-commit

**Hooks** (3):
1. **Pre-Implementation**: Runs before Edit/Write operations
   - Triggers consistency agent to find patterns
   - Prevents pattern divergence

2. **Post-Error**: Runs on non-zero exit codes
   - Triggers debug agent for systematic debugging
   - Captures error context automatically

3. **Post-Implementation**: Runs after implementation complete
   - Triggers quality agent for comprehensive review
   - Ensures quality gates before commit

**Trigger System**:
- **Keyword Triggers**: Detect user intent from natural language
- **Tool Triggers**: Detect events from Bash, Edit, Write tools
- **Precedence Rules**: Debug > Quality > Consistency
- **Bypass Mechanisms**: Multiple ways to skip agents when needed

---

## Test Scenarios

### Scenario 1: Bug Fix Workflow (30-45 min)

**Flow**: Error → Debug Agent → Fix → Quality Review → Commit

**Tests**:
- Error detection and agent activation
- 6-step methodology enforcement
- Fix verification
- Quality review of fix
- End-to-end metrics

**Success Criteria**:
- All 6 debug steps executed in order
- Bug fixed correctly
- Quality review passes
- Total time < 10 minutes

**Details**: See [full-workflow.md](full-workflow.md#test-scenario-1-bug-fix-workflow)

---

### Scenario 2: Feature Implementation (30-45 min)

**Flow**: Request → Pattern Search → Implementation → Quality Review → Commit

**Tests**:
- Pattern detection from existing code
- Recommendation quality
- Implementation consistency
- Quality review of new code
- Pattern adherence verification

**Success Criteria**:
- Pattern search successful
- Pattern correctly identified
- Implementation follows pattern
- Quality review thorough
- Total time < 15 minutes

**Details**: See [full-workflow.md](full-workflow.md#test-scenario-2-feature-implementation-workflow)

---

### Scenario 3: Obra Integration & Bypass Testing (45-60 min)

**Flow**: Various workflows testing edge cases

**Tests**:
- **Part A**: Standard workflow compatibility
  - Simple edits (no agent activation)
  - Minor changes (minimal impact)
  - Multi-step implementation (coordination)

- **Part B**: Bypass mechanisms
  - Environment variable bypass
  - File pattern bypass
  - Explicit skip flags

- **Part C**: Error handling
  - Missing configuration
  - YAML syntax errors
  - Agent timeouts

- **Part D**: Performance benchmarks
  - Agent activation overhead
  - Pattern search speed
  - Quality review speed
  - E2E workflow overhead

**Success Criteria**:
- No workflow blocking
- Bypasses work correctly
- Graceful degradation
- Performance targets met

**Details**: See [full-workflow.md](full-workflow.md#test-scenario-3-obra-integration-and-bypass-testing)

---

## How to Run Tests

### Prerequisites

1. **Verify Configuration**:
   ```bash
   # Check agents exist
   ls -la .claude/agents/*/instructions.md

   # Check hooks exist
   ls -la .claude/hooks/*.md

   # Check triggers configured
   cat .claude/config/triggers.yml | head -20
   ```

2. **Set Up Test Environment**:
   ```bash
   # Create test project directory
   mkdir -p test-project/{src,tests,api/routes}
   ```

3. **Install Dependencies**:
   ```bash
   # Python for pytest scenarios
   pip install pytest

   # Node.js scenarios (if needed)
   npm install
   ```

### Execution Steps

**Step 1: Read Test Plan**
```bash
cat tests/integration/full-workflow.md
```

**Step 2: Execute Scenario 1**
- Follow detailed steps in `full-workflow.md`
- Document results in the document
- Update `TEST-EXECUTION-STATUS.md`
- Log any issues in `ISSUES.md`

**Step 3: Execute Scenario 2**
- Follow detailed steps in `full-workflow.md`
- Document results
- Update status
- Log issues

**Step 4: Execute Scenario 3**
- Follow detailed steps in `full-workflow.md`
- Document results
- Update status
- Log issues

**Step 5: Compile Final Report**
- Fill in "Final Integration Test Report" section
- Summarize findings
- Provide recommendations

### Quick Test

For a quick smoke test (not comprehensive):

```bash
# 1. Test debug agent activation
echo "debug this test failure"

# 2. Test consistency agent
echo "add a new API endpoint"

# 3. Test quality agent
echo "done, ready to commit"
```

---

## Test Coverage

### What Is Covered

✅ **Agent Functionality**:
- All three agents activate correctly
- Agents execute their workflows
- Agents produce expected output

✅ **Hook Integration**:
- Pre-implementation hook triggers
- Post-error hook triggers
- Post-implementation hook triggers
- Hooks call correct agents

✅ **Trigger System**:
- Keyword triggers detect correctly
- Tool triggers fire on events
- Precedence rules work
- Conflicts resolved properly

✅ **Bypass Mechanisms**:
- Environment variables respected
- File patterns recognized
- Explicit flags honored
- Bypass doesn't break system

✅ **Error Handling**:
- Missing configurations handled
- YAML errors detected
- Graceful degradation works
- Clear error messages

✅ **Performance**:
- Activation overhead measured
- Pattern search speed measured
- Quality review speed measured
- E2E overhead acceptable

✅ **End-to-End Workflows**:
- Complete bug fix workflow
- Complete feature workflow
- No component conflicts
- Metrics collection works

### What Is NOT Covered

These are out of scope for integration tests:

❌ **Unit Testing**: Individual functions (use agent-specific tests)
❌ **Load Testing**: High-volume scenarios
❌ **Security Testing**: Penetration testing, vulnerability scanning
❌ **Multi-User Testing**: Concurrent users
❌ **Platform Testing**: Different OS, Claude versions
❌ **Network Testing**: Network failures, latency

---

## Success Metrics

### Quantitative Metrics

| Metric | Target | Measured | Status |
|--------|--------|----------|--------|
| Agent activation time | < 2s | - | - |
| Pattern search time | < 30s | - | - |
| Quality review time | < 2min | - | - |
| E2E overhead | < 20% | - | - |
| Test pass rate | 100% | - | - |
| Issue count | < 5 | 0 | ✅ |

### Qualitative Metrics

- **User Experience**: Smooth, non-intrusive, helpful
- **Workflow Enhancement**: Adds value, doesn't block
- **Error Messages**: Clear, actionable, specific
- **Documentation**: Complete, accurate, helpful

### Acceptance Criteria

For the integration tests to pass:

✅ All three test scenarios complete successfully
✅ No critical (P0) issues found
✅ Performance targets met
✅ All workflows complete end-to-end
✅ Bypass mechanisms functional
✅ Error handling graceful
✅ Metrics collection working

---

## Known Limitations

### Current Limitations

1. **No Obra Superpowers**: Cannot test actual obra integration without obra installed
   - Workaround: Test compatibility with standard workflow

2. **Manual Execution**: Tests must be run manually (no automated test harness)
   - Workaround: Detailed step-by-step instructions provided

3. **Subjective Measures**: Some metrics (UX) are subjective
   - Workaround: Use consistent evaluation criteria

4. **Environment Specific**: Tests may behave differently in different environments
   - Workaround: Document environment details

### Future Enhancements

- Automated test harness
- Obra superpowers integration
- Performance profiling tools
- Regression test suite
- CI/CD integration

---

## Troubleshooting

### Agent Doesn't Activate

**Possible Causes**:
- Keyword doesn't match trigger definition
- File type excluded by filter
- Trigger configuration syntax error
- Environment variable blocking

**Solutions**:
1. Check `.claude/config/triggers.yml` for keyword match
2. Verify file type in trigger filters
3. Validate YAML syntax
4. Check for `CLAUDE_SKIP_AGENTS` environment variable

### Pattern Search Finds Nothing

**Possible Causes**:
- No similar patterns in codebase
- Glob/Grep patterns too restrictive
- Search scope incorrect
- File type filters excluding matches

**Solutions**:
1. Manually verify similar patterns exist
2. Review glob patterns in agent config
3. Check working directory
4. Review file type filters

### Quality Review Incomplete

**Possible Causes**:
- File size exceeds limits
- Timeout reached
- Checklist categories not loaded
- Configuration error

**Solutions**:
1. Check file size limits in config
2. Increase timeout if needed
3. Verify checklist.md exists
4. Check agent instructions file

### Performance Too Slow

**Possible Causes**:
- Large codebase
- Too many files analyzed
- Network calls (shouldn't happen)
- Inefficient searches

**Solutions**:
1. Note file count and sizes in report
2. Optimize glob/grep patterns
3. Verify no network calls
4. Enable caching if available

### Metrics Not Logged

**Possible Causes**:
- Log directory doesn't exist
- Insufficient permissions
- Monitoring disabled
- Log format error

**Solutions**:
1. Create `.claude/logs/` directory
2. Check write permissions
3. Verify monitoring enabled in triggers.yml
4. Check log file format

---

## File Structure

```
tests/integration/
├── README.md                    # This file - overview
├── full-workflow.md             # Complete test plan (MAIN)
├── TEST-EXECUTION-STATUS.md     # Execution tracking
└── ISSUES.md                    # Issue tracker

tests/
├── debug-agent-test.md          # Individual debug agent tests
├── consistency-agent-test.md    # Individual consistency tests
└── quality-agent-test.md        # Individual quality tests

.claude/
├── agents/
│   ├── debug-agent/
│   │   └── instructions.md
│   ├── consistency-agent/
│   │   └── instructions.md
│   └── quality-agent/
│       └── instructions.md
├── hooks/
│   ├── pre-implementation.md
│   ├── post-error.md
│   ├── post-implementation.md
│   └── test-scenarios.md
└── config/
    └── triggers.yml             # Trigger system config

.claude/logs/                     # Created during testing
└── trigger-events.jsonl         # Metrics log
```

---

## Test Execution Checklist

### Before Testing

- [ ] Read `full-workflow.md` completely
- [ ] Verify all agents configured
- [ ] Verify all hooks configured
- [ ] Verify triggers.yml valid
- [ ] Create test directories
- [ ] Install dependencies
- [ ] Review individual agent tests

### During Testing

- [ ] Execute scenarios in order (1 → 2 → 3)
- [ ] Document results in real-time
- [ ] Record all observations
- [ ] Measure performance metrics
- [ ] Check logs after each scenario
- [ ] Update TEST-EXECUTION-STATUS.md
- [ ] Log issues in ISSUES.md

### After Testing

- [ ] Compile final report in full-workflow.md
- [ ] Categorize all issues by severity
- [ ] Propose fixes for critical issues
- [ ] Calculate test coverage achieved
- [ ] Provide deployment recommendation
- [ ] Request sign-off

---

## Getting Help

### Documentation References

- **Agent Documentation**: `.claude/agents/*/instructions.md`
- **Hook Documentation**: `.claude/hooks/README.md`
- **Trigger System**: `.claude/config/triggers.yml`
- **Individual Tests**: `tests/*-agent-test.md`

### Common Questions

**Q: How long does testing take?**
A: Approximately 2.5-3.5 hours for all three scenarios.

**Q: Can I run scenarios out of order?**
A: Yes, but running in order (1→2→3) is recommended as they build on each other.

**Q: What if I find a critical bug?**
A: Document it immediately in ISSUES.md with severity P0, and note if it blocks further testing.

**Q: Do I need to test all bypass mechanisms?**
A: Yes, bypass testing is important to ensure the system doesn't block users.

**Q: What if metrics aren't being logged?**
A: Check that `.claude/logs/` directory exists and monitoring is enabled in triggers.yml.

---

## Version History

**Version 1.0.0** - 2025-11-19
- Initial integration test suite
- Three main test scenarios
- Comprehensive test plan
- Issue tracking framework
- Execution status tracking

---

## Quick Start

**For the impatient**:

1. Read the test plan:
   ```bash
   cat tests/integration/full-workflow.md
   ```

2. Set up environment:
   ```bash
   mkdir -p test-project/{src,tests}
   pip install pytest
   ```

3. Run Scenario 1:
   - Create `calculator.py` with bug (see test plan)
   - Create `test_calculator.py` (see test plan)
   - Run `pytest tests/` and watch agents activate
   - Document results

4. Repeat for Scenarios 2 and 3

5. Compile final report

**Total time**: 2.5-3.5 hours

---

**Document Version**: 1.0.0
**Last Updated**: 2025-11-19
**Status**: Ready for test execution
**Next Action**: Begin Scenario 1 execution
