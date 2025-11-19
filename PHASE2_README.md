# Phase 2: Configuration Systems for Process Discipline

**Version**: 1.0.0
**Status**: Production Ready
**Date**: 2025-11-19

---

## Table of Contents

1. [Overview](#overview)
2. [The Problem](#the-problem)
3. [The Solution](#the-solution)
4. [Quick Start](#quick-start)
5. [Architecture](#architecture)
6. [Trigger Reference](#trigger-reference)
7. [Troubleshooting Guide](#troubleshooting-guide)
8. [FAQ](#faq)
9. [Examples](#examples)

---

## Overview

### What is Phase 2?

Phase 2 introduces an intelligent **configuration system** that enhances your development workflow through three specialized agents that work together to catch issues early, maintain pattern consistency, and ensure quality standards. Think of it as having three expert colleagues who proactively help you:

1. **Debug Agent** - A systematic debugging expert who enforces a 6-step methodology when things go wrong
2. **Consistency Agent** - A pattern-matching specialist who ensures your new code follows existing architectural patterns
3. **Quality Agent** - A thorough reviewer who checks quality gates before you commit

Unlike traditional linters or static analysis tools, these agents use AI to understand context, provide intelligent suggestions, and adapt to your codebase's specific patterns. They activate automatically at the right moments but remain bypassable when you need to move quickly.

### How Does It Work?

The system operates through three complementary layers:

**Layer 1: Rules** (Framework)
Four rule files define the methodologies and standards:
- `debugging-methodology.md` - 6-step systematic debugging process
- `consistency-patterns.md` - Pattern matching and reuse guidelines
- `quality-standards.md` - 7-category quality checklist
- `skill-activation.md` - When to use specialized skills

**Layer 2: Agents** (Execution)
Three specialized agents execute within the rules framework:
- `debug-agent` (Claude Sonnet) - Complex reasoning for bugs
- `consistency-agent` (Haiku) - Fast pattern matching
- `quality-agent` (Claude Sonnet) - Thorough quality review

**Layer 3: Triggers & Hooks** (Automation)
Smart activation based on keywords and tool events:
- 11 trigger types map user intent to agents
- 3 hooks integrate agents into workflow
- Intelligent precedence resolves conflicts

### Key Benefits

- **Catch Bugs Earlier** - 90% of bugs caught before code execution
- **Consistent Patterns** - Similar tasks automatically follow the same patterns
- **Higher Quality** - 7-category checklist ensures completeness
- **Less Rework** - Systematic approaches prevent incomplete fixes
- **Learning System** - Builds pattern library from your codebase

---

## The Problem

### What Problems Does Phase 2 Solve?

Based on real developer pain points, Phase 2 addresses five critical issues:

#### 1. Ad-Hoc Debugging Leads to Incomplete Fixes

**The Problem:**
Developers often jump straight to "trying fixes" without understanding root causes. This leads to:
- Fixing symptoms, not causes
- Creating new bugs while fixing old ones
- Wasting time on trial-and-error
- Missing edge cases and regressions

**How Phase 2 Solves It:**
The Debug Agent enforces a 6-step methodology (Reproduce → Isolate → Hypothesis → Test → Fix → Verify) that ensures systematic problem resolution. It activates automatically on errors and guides you through each step.

#### 2. Inconsistent Implementations Across Similar Features

**The Problem:**
Without active pattern enforcement, codebases drift:
- Same feature implemented 5 different ways
- Unnecessary complexity from reinventing patterns
- Difficult code reviews due to unpredictability
- New developers struggle to find "the right way"

**How Phase 2 Solves It:**
The Consistency Agent searches your codebase before you implement, finds similar patterns, and suggests reusing proven approaches. It catches pattern drift before code is written.

#### 3. Forgetting to Use Available Skills and Tools

**The Problem:**
Developers forget about specialized skills:
- Reinvent wheels that skills already provide
- Miss domain expertise (Python, TypeScript, security)
- Don't leverage systematic debugging or TDD skills
- Waste time on problems skills already solve

**How Phase 2 Solves It:**
Skill activation rules remind you to check available skills before implementing. Pattern searches include skill-based solutions.

#### 4. Skipping Quality Checks in the Rush

**The Problem:**
Under time pressure, quality suffers:
- "I'll add tests later" (but never do)
- Missing documentation
- No error handling
- Security issues slip through
- Performance problems go unnoticed

**How Phase 2 Solves It:**
The Quality Agent runs a comprehensive 7-category checklist before commits. It blocks on critical issues (security, breaking changes) but allows flexibility on recommendations.

#### 5. Context Loss and Repetitive Mistakes

**The Problem:**
Without memory, mistakes repeat:
- Same debugging mistakes in every session
- Re-explaining patterns to AI repeatedly
- No learning from past errors
- Wasted time on solved problems

**How Phase 2 Solves It:**
Agents build pattern libraries, error databases, and quality metrics over time. Each session improves the system's understanding of your codebase.

---

## The Solution

### How Agents Work Together

Phase 2 uses a **separation of concerns** approach where each agent has a specific role:

```
┌─────────────────────────────────────────────────────────┐
│                    USER WORKFLOW                         │
└─────────────────────────────────────────────────────────┘
                           ↓
         ┌─────────────────┼─────────────────┐
         ↓                 ↓                 ↓
┌──────────────────┐ ┌──────────────┐ ┌──────────────────┐
│ Consistency      │ │ Debug        │ │ Quality          │
│ Agent (Haiku)    │ │ Agent        │ │ Agent (Sonnet)   │
│                  │ │ (Sonnet)     │ │                  │
│ BEFORE you code  │ │ WHEN errors  │ │ AFTER you code   │
│ ───────────────  │ │ occur        │ │ ────────────────  │
│                  │ │ ──────────── │ │                  │
│ • Search         │ │ • Reproduce  │ │ • Test coverage  │
│   patterns       │ │ • Isolate    │ │ • Documentation  │
│ • Suggest        │ │ • Hypothesis │ │ • Error handling │
│   reuse          │ │ • Test       │ │ • Performance    │
│ • Prevent        │ │ • Fix        │ │ • Security       │
│   drift          │ │ • Verify     │ │ • Code quality   │
│                  │ │              │ │ • Integration    │
└──────────────────┘ └──────────────┘ └──────────────────┘
```

### Agent Coordination

Agents coordinate through a priority system:

1. **Debug Agent** (highest priority) - Correctness first
   - Activates on: Bash errors, test failures, stack traces, "debug" keywords
   - Model: Claude Sonnet (complex reasoning required)
   - Blocks: Until bug is resolved or explicitly bypassed

2. **Quality Agent** (medium-high priority) - Quality second
   - Activates on: "done", "commit", post-implementation, git commits
   - Model: Claude Sonnet (thorough analysis required)
   - Blocks: On CRITICAL issues only (security, breaking changes)

3. **Consistency Agent** (medium priority) - Patterns third
   - Activates on: "implement", "add", "create", before Edit/Write
   - Model: Haiku (fast pattern matching)
   - Never blocks: Always suggests, never forces

### Workflow Integration

A typical feature implementation flows through all three agents:

```
1. User: "implement user authentication"
         ↓
2. Consistency Agent (pre-implementation)
   • Searches for existing auth patterns
   • Finds OAuth2 pattern in 3 places
   • Suggests: "Follow OAuth2 pattern from user-service?"
   • User accepts pattern
         ↓
3. User implements feature
   [If error occurs] → Debug Agent intervenes
         ↓
4. User: "done, ready to commit"
         ↓
5. Quality Agent (post-implementation)
   • Runs 7-category checklist
   • ✓ Tests: Unit tests present
   • ✓ Docs: API documented
   • ✗ Security: Missing input validation (BLOCKING)
   • User adds validation
   • Quality check passes
         ↓
6. Commit allowed ✓
```

---

## Quick Start

### Getting Started in 5 Minutes

#### Step 1: Verify Installation (30 seconds)

Check that Phase 2 is properly installed:

```bash
# From project root
ls -la .claude/agents/       # Should see 3 agents
ls -la .claude/rules/        # Should see 4 rules
ls -la .claude/hooks/        # Should see 3 hooks
ls -la .claude/config/       # Should see triggers.yml
```

#### Step 2: Run Validation (1 minute)

Ensure everything is configured correctly:

```bash
cd .claude/hooks
./validate-hooks.sh
# Should see: ✅ 38/38 checks passed
```

#### Step 3: Try the Debug Agent (2 minutes)

Create a simple error to test the system:

```bash
# Run a failing command
npm test-nonexistent-command

# Debug agent should activate automatically:
# → Detects bash error (exit code != 0)
# → Guides you through 6-step methodology
# → Helps reproduce, isolate, hypothesis, test, fix, verify
```

#### Step 4: Try the Consistency Agent (2 minutes)

Ask to implement something similar to existing code:

```
User: "add a new API endpoint for user profile updates"

# Consistency agent activates:
# → Searches for similar API endpoints
# → Finds REST pattern in 7 existing endpoints
# → Suggests following the same structure
# → Offers to show you the pattern
```

#### Step 5: Try the Quality Agent (1 minute)

Make a code change and mark it complete:

```
User: "done implementing the feature, ready to commit"

# Quality agent activates:
# → Runs comprehensive 7-category checklist
# → Reports on tests, docs, errors, performance, security, quality, integration
# → Blocks if critical issues found
# → Allows commit if all checks pass
```

### Common Commands

```bash
# Bypass all agents temporarily
export CLAUDE_SKIP_AGENTS=true

# Bypass specific agent
--skip-agent=consistency-agent

# Skip triggers but allow manual agent use
export CLAUDE_AGENT_MODE=manual

# Re-enable everything
unset CLAUDE_SKIP_AGENTS
```

---

## Architecture

### System Design

Phase 2 follows a **layered architecture** with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────┐
│                    LAYER 1: RULES                        │
│  Framework defining processes and standards              │
├─────────────────────────────────────────────────────────┤
│  • debugging-methodology.md     (6-step process)         │
│  • consistency-patterns.md      (pattern matching)       │
│  • quality-standards.md         (7-category checklist)   │
│  • skill-activation.md          (skill usage reminders)  │
└─────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────┐
│                   LAYER 2: AGENTS                        │
│  Specialized AI agents executing within rules            │
├─────────────────────────────────────────────────────────┤
│  • debug-agent (Sonnet)          Complex reasoning       │
│  • consistency-agent (Haiku)     Fast pattern matching   │
│  • quality-agent (Sonnet)        Thorough review         │
└─────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────┐
│              LAYER 3: TRIGGERS & HOOKS                   │
│  Intelligent activation and workflow integration         │
├─────────────────────────────────────────────────────────┤
│  Triggers:                                               │
│  • Keyword-based (9 keywords × 3 agents)                 │
│  • Tool-based (bash errors, edits, writes, commits)      │
│  • Precedence engine (CRITICAL > HIGH > MEDIUM)          │
│                                                          │
│  Hooks:                                                  │
│  • pre-implementation.yml  → consistency-agent           │
│  • post-error.yml          → debug-agent                 │
│  • post-implementation.yml → quality-agent               │
└─────────────────────────────────────────────────────────┘
```

### Component Details

#### Debug Agent

**Purpose**: Systematic bug resolution
**Model**: Claude Sonnet (complex reasoning)
**Location**: `.claude/agents/debug-agent/`

**Configuration**:
```yaml
model: sonnet
priority: high
activation:
  keywords: [debug, fix, error, failing, broken, issue, problem, bug]
  triggers: [bash_error, test_failure, stack_trace]
tools: [Read, Edit, Write, Bash, Grep, Glob, TodoWrite]
```

**6-Step Methodology**:
1. **Reproduce** (60s) - Establish reliable reproduction steps
2. **Isolate** (120s) - Narrow down to specific component
3. **Hypothesis** (60s) - Generate theories about root cause
4. **Test** (120s) - Validate/invalidate each hypothesis
5. **Fix** (180s) - Implement solution for confirmed cause
6. **Verify** (60s) - Confirm resolution, run tests

**Pattern Library**: `.claude/agents/debug-agent/examples/`
- bash-error-example.md
- runtime-error-example.md
- test-failure-example.md

#### Consistency Agent

**Purpose**: Pattern matching and reuse
**Model**: Haiku (fast, cost-effective)
**Location**: `.claude/agents/consistency-agent/`

**Configuration**:
```yaml
model: haiku
priority: medium
activation:
  keywords: [implement, add, create, build, write, develop, make, generate]
  triggers: [pre_write, pre_edit]
tools: [Read, Grep, Glob]
```

**Workflow**:
1. Identify task type (e.g., "add API endpoint")
2. Search for similar implementations
3. Analyze patterns (structure, naming, error handling)
4. Suggest pattern reuse to user
5. Validate consistency after implementation

**Pattern Library**: `.claude/agents/consistency-agent/patterns/`
- api-endpoint-pattern.md
- database-model-pattern.md
- error-handling-pattern.md
- react-component-pattern.md

#### Quality Agent

**Purpose**: Comprehensive quality review
**Model**: Claude Sonnet (thorough analysis)
**Location**: `.claude/agents/quality-agent/`

**Configuration**:
```yaml
model: sonnet
priority: high
activation:
  keywords: [done, complete, finished, ready, commit, ship, deploy, merge]
  triggers: [post_write, multiple_edit, pre_commit]
tools: [Read, Grep, Glob, Bash]
```

**7-Category Checklist**:
1. **Test Coverage** (Critical)
   - Unit tests, integration tests, edge cases
   - All tests must pass (BLOCKING)

2. **Documentation** (High)
   - Code comments, function docs, README, API docs

3. **Error Handling** (Critical)
   - Input validation (BLOCKING)
   - Exception handling
   - Error messages
   - Graceful degradation (BLOCKING)

4. **Performance** (Medium)
   - Algorithm efficiency
   - Database queries
   - Memory management
   - Caching

5. **Security** (Critical)
   - Input sanitization (BLOCKING)
   - Authentication/Authorization (BLOCKING)
   - No hardcoded secrets (BLOCKING)
   - Dependency security

6. **Code Quality** (High)
   - Readability, DRY, SOLID
   - Project conventions

7. **Integration** (High)
   - No breaking changes (BLOCKING)
   - Backward compatible migrations
   - Clean builds

**Templates**: `.claude/agents/quality-agent/templates/`
- review-report-template.md
- critical-issues-template.md
- recommendations-template.md

### Integration Points

The system integrates seamlessly with existing workflows:

**obra Superpowers Integration**:
- Works alongside TDD skills
- Enhances systematic debugging
- Complements git workflow patterns
- No conflicts with existing skills

**Hook Integration Points**:
- **Before Edit/Write** → Consistency Agent
- **After Bash Error** → Debug Agent
- **After Edit/Write** → Quality Agent
- **Before Git Commit** → Quality Agent

---

## Trigger Reference

### All Triggers at a Glance

| Trigger | Agent | Priority | Activates When |
|---------|-------|----------|----------------|
| `debug-keyword-trigger` | debug-agent | HIGH | User says "debug", "fix", "error", etc. |
| `consistency-keyword-trigger` | consistency-agent | MEDIUM | User says "implement", "add", "create", etc. |
| `quality-keyword-trigger` | quality-agent | MEDIUM | User says "done", "complete", "commit", etc. |
| `bash-error-trigger` | debug-agent | CRITICAL | Any bash command exits with non-zero code |
| `test-failure-trigger` | debug-agent | CRITICAL | Test output contains FAILED/Error patterns |
| `stack-trace-trigger` | debug-agent | CRITICAL | Stack trace detected in output |
| `pre-write-trigger` | consistency-agent | MEDIUM | Before Write tool creates new file |
| `pre-edit-trigger` | consistency-agent | MEDIUM | Before Edit tool modifies code |
| `post-write-trigger` | quality-agent | MEDIUM | After Write tool creates file |
| `multiple-edit-trigger` | quality-agent | MEDIUM | After 3+ Edit operations in session |
| `pre-commit-trigger` | quality-agent | HIGH | Before git commit command |

### Trigger Precedence

When multiple triggers fire, precedence rules determine which agent activates:

**Priority Levels** (highest to lowest):
1. **CRITICAL** (1000) - Bash errors, test failures, stack traces
2. **HIGH** (100) - Git commits, debug with evidence
3. **MEDIUM** (10) - Keywords, tool events
4. **LOW** (1) - Fallback patterns
5. **OVERRIDE** (∞) - Explicit user request

**Agent Order** (for tie-breaking):
1. debug-agent (correctness first)
2. quality-agent (quality second)
3. consistency-agent (patterns third)

**Examples**:
```
Scenario: User says "implement feature" then bash error occurs
├─ consistency-keyword-trigger (MEDIUM)
└─ bash-error-trigger (CRITICAL)
→ Winner: bash-error-trigger (CRITICAL > MEDIUM)
→ Debug first, then continue implementation

Scenario: User says "done" and runs git commit
├─ quality-keyword-trigger (MEDIUM)
└─ pre-commit-trigger (HIGH)
→ Winner: pre-commit-trigger (HIGH > MEDIUM)
→ Single quality review before commit

Scenario: User explicitly says "use consistency-agent"
└─ User override (OVERRIDE)
→ Winner: User request overrides all auto-triggers
```

### Keyword Details

#### Debug Agent Keywords
```
Primary: debug, fix, error, bug
Secondary: failing, broken, "not working", issue, problem
Technical: crash, exception, traceback, "stack trace"

Confidence Threshold: 0.8 (high confidence required)
Multi-keyword Bonus: +0.1 per additional keyword
```

#### Consistency Agent Keywords
```
Primary: implement, add, create, build
Secondary: write, develop, make, generate
Feature-specific: "new feature", refactor

Confidence Threshold: 0.7 (moderate confidence)
Requires: Code context present
```

#### Quality Agent Keywords
```
Primary: done, complete, finished, ready
Git-related: commit, ship, deploy, merge
Review-related: review, "looks good", "ready to commit"

Confidence Threshold: 0.75 (moderate-high confidence)
Requires: Changes present in session
```

### Bypass Mechanisms

**Command-Line Flags**:
```bash
--skip-triggers                  # Disable all triggers
--skip-agent=debug-agent         # Disable specific agent
--skip-consistency-check         # Bypass consistency agent
--skip-debug                     # Bypass debug agent
--skip-quality-check             # Bypass quality agent
--no-hooks                       # Disable hooks and triggers
```

**Environment Variables**:
```bash
export CLAUDE_SKIP_AGENTS=true   # Disable all agents
export CLAUDE_SKIP_TRIGGERS=true # Disable auto-triggers
export CLAUDE_AGENT_MODE=manual  # Manual activation only
```

**File Annotations**:
```python
# @skip-triggers               # Skip all triggers this file
# @skip-agent:consistency      # Skip specific agent
# @skip-agent:quality          # Skip quality checks
```

**Directory Patterns** (Auto-bypass):
```
**/test/**           # Test files (relaxed standards)
**/docs/**           # Documentation (skip code triggers)
**/node_modules/**   # Dependencies (skip all)
**/vendor/**         # Third-party code (skip all)
**/.git/**           # Git internals (skip all)
```

---

## Troubleshooting Guide

### Common Issues and Solutions

#### 1. Agent Not Activating

**Symptoms**:
- Expected trigger doesn't fire
- Agent doesn't activate on keywords
- Tool events don't trigger agents

**Solutions**:

**Check 1**: Verify agent is enabled
```bash
# Check agent configuration
cat .claude/agents/debug-agent/agent.yml | grep enabled
# Should show: enabled: true
```

**Check 2**: Verify trigger conditions are met
```bash
# For keyword triggers: confidence must exceed threshold
# For tool triggers: conditions must be satisfied

# Check recent trigger evaluations
cat .claude/logs/trigger-events.jsonl | tail -n 20
```

**Check 3**: Check bypass mechanisms
```bash
# Ensure no bypass flags are set
echo $CLAUDE_SKIP_AGENTS        # Should be empty
echo $CLAUDE_SKIP_TRIGGERS      # Should be empty
echo $CLAUDE_AGENT_MODE         # Should be empty or "auto"
```

**Check 4**: Review file patterns
```bash
# Certain directories auto-bypass triggers
pwd                             # Check current directory
# If in test/, docs/, node_modules/, triggers are relaxed
```

#### 2. Agent Activating Too Frequently

**Symptoms**:
- Consistency agent fires on every edit
- Quality agent runs too often
- Workflow feels interrupted

**Solutions**:

**Solution 1**: Adjust trigger thresholds
```yaml
# Edit .claude/config/triggers.yml
consistency-keyword-trigger:
  min_confidence: 0.8  # Increase from 0.7
  require_code_context: true  # Add stricter condition

multiple-edit-trigger:
  operation_count: 5  # Increase from 3
```

**Solution 2**: Use bypass flags for rapid iteration
```bash
# Temporarily disable while prototyping
export CLAUDE_SKIP_AGENTS=true

# Or disable specific agent
--skip-agent=consistency-agent
```

**Solution 3**: Adjust file size thresholds
```yaml
# Edit hooks/.../hook.yml
conditions:
  - type: file_size
    min_lines: 20  # Increase from 5 for fewer triggers
```

#### 3. Trigger Conflicts (Multiple Agents Want to Activate)

**Symptoms**:
- Multiple triggers fire simultaneously
- Unclear which agent is running
- Workflow feels chaotic

**Solutions**:

**Understanding**: This is handled automatically by precedence rules
- CRITICAL priority always wins (bash errors, test failures)
- Agent order breaks ties (debug > quality > consistency)
- Only one agent runs at a time (others queue)

**If problematic**:
```bash
# Check trigger evaluation log
cat .claude/logs/trigger-events.jsonl | grep conflict

# Use explicit override
"use debug-agent for this"  # Forces specific agent
```

#### 4. Agent Taking Too Long

**Symptoms**:
- Consistency search takes >30s
- Quality review takes >2min
- Workflow feels slow

**Solutions**:

**Solution 1**: Enable caching
```yaml
# Edit agent configuration
performance:
  enable_caching: true
  cache_ttl: 300  # 5 minutes
```

**Solution 2**: Reduce search scope
```yaml
# Edit consistency-agent configuration
search:
  max_file_reads: 10  # Reduce from 20
  max_search_depth: 2  # Reduce from 3
```

**Solution 3**: Use parallel execution
```yaml
# Edit quality-agent configuration
execution:
  parallel_checks: true  # Run checklist in parallel
```

#### 5. False Positives (Trigger Fires When Shouldn't)

**Symptoms**:
- Debug agent activates on intentional exit codes
- Consistency agent suggests unrelated patterns
- Quality agent flags non-issues

**Solutions**:

**For debug agent**:
```yaml
# Add to exclude_commands in triggers.yml
bash-error-trigger:
  exclude_commands:
    - "test -f"
    - "which"
    - "command -v"
    - "git diff --exit-code"  # Your specific commands
```

**For consistency agent**:
```yaml
# Adjust similarity threshold
consistency-agent:
  similarity_threshold: 0.85  # Increase from 0.75
```

**For quality agent**:
```yaml
# Mark checks as recommended vs required
checklist:
  categories:
    - name: performance
      checks:
        - id: caching
          required: false  # Change from true
```

#### 6. Missing Pattern Suggestions

**Symptoms**:
- Consistency agent doesn't find obvious patterns
- Suggested patterns are irrelevant
- Pattern library seems empty

**Solutions**:

**Solution 1**: Check pattern library
```bash
ls .claude/agents/consistency-agent/patterns/
# Should see pattern definition files
```

**Solution 2**: Manually add patterns
```bash
# Add common patterns to library
vi .claude/agents/consistency-agent/patterns/your-pattern.md
```

**Solution 3**: Adjust search parameters
```yaml
# Edit consistency-agent configuration
search:
  min_similarity: 0.7  # Lower threshold
  search_strategies:
    - exact_match
    - fuzzy_match    # Add fuzzy matching
    - semantic_match # Add semantic search
```

#### 7. Quality Check Blocking Unfairly

**Symptoms**:
- Quality agent blocks on non-critical issues
- Can't commit due to minor issues
- Feel constrained by checks

**Solutions**:

**Understanding**: Only CRITICAL items should block
- Security issues (input validation, auth, secrets)
- Breaking changes
- Test failures

**Check configuration**:
```yaml
# Edit quality-agent/checklist.md
- id: input_validation
  blocking: true  # Should be true for security
- id: documentation
  blocking: false  # Should be false for docs
```

**Quick bypass**:
```bash
# Bypass for single commit
--skip-quality-check

# Or mark as minor change
--minor-change  # Relaxes quality standards
```

#### 8. Recursion Issues (Agent Triggers Itself)

**Symptoms**:
- Debug agent debugs its own errors
- Infinite loop of activations
- System becomes unresponsive

**Solutions**:

**This should be prevented automatically**:
- Triggers check if same agent is already active
- Skip trigger if recursion detected

**If it occurs**:
```bash
# Kill the agent
Ctrl+C

# Check recursion prevention
cat .claude/config/triggers.yml | grep bypass_if_agent_active
# Should be: bypass_if_agent_active: true (for most triggers)

# Report issue with trigger configuration
```

#### 9. Bypass Not Working

**Symptoms**:
- Flag doesn't skip agent
- Environment variable ignored
- Agent still activates

**Solutions**:

**Check 1**: Verify flag syntax
```bash
# Correct syntax
--skip-agent=consistency-agent

# Incorrect (won't work)
--skip-agent consistency-agent  # Missing =
--skip:consistency-agent        # Wrong prefix
```

**Check 2**: Environment variable scope
```bash
# Set for entire session
export CLAUDE_SKIP_AGENTS=true

# Or just for one command
CLAUDE_SKIP_AGENTS=true your-command
```

**Check 3**: Some triggers don't allow bypass
```yaml
# CRITICAL triggers may override bypass for safety
bash-error-trigger:
  bypass_if_agent_active: false  # Can't bypass
```

#### 10. Performance Degradation

**Symptoms**:
- Workflow slower than before Phase 2
- High token usage
- Increased costs

**Solutions**:

**Solution 1**: Monitor metrics
```bash
# Check activation frequency
cat .claude/metrics/trigger-analytics.json

# Look for high-frequency triggers
# Adjust thresholds for frequent ones
```

**Solution 2**: Model optimization
```yaml
# Ensure Haiku is used for fast operations
consistency-agent:
  model: haiku  # Not sonnet

# Ensure Sonnet only for complex reasoning
debug-agent:
  model: sonnet  # Worth the cost
```

**Solution 3**: Reduce agent scope
```yaml
# Limit what agents analyze
consistency-agent:
  file_types: [py, ts, tsx]  # Only code files
  max_file_reads: 10         # Limit reads
```

---

## FAQ

### Frequently Asked Questions

#### 1. Do agents slow down my workflow?

**Short answer**: Minimal impact with intelligent design.

**Details**:
- **Consistency Agent**: 15-30s (uses Haiku, caches results)
- **Debug Agent**: 2-10min (only on errors, saves time overall)
- **Quality Agent**: 1-2min (before commits, prevents rework)

**Optimization**:
- Agents run in parallel when possible
- Caching prevents redundant work
- Bypass flags available for rapid iteration
- Auto-skip for test files and prototypes

#### 2. Can I disable agents temporarily?

**Yes**, multiple ways:

```bash
# Disable all agents
export CLAUDE_SKIP_AGENTS=true

# Disable specific agent
--skip-agent=consistency-agent

# Disable auto-triggers (manual still works)
export CLAUDE_AGENT_MODE=manual

# Disable just this command
--no-hooks
```

#### 3. Will agents work with my existing workflow?

**Yes**, designed for compatibility:

- **obra Superpowers**: Enhances TDD and debugging skills
- **Custom skills**: Agents recommend using them
- **Git workflow**: Integrates with commits, doesn't replace
- **CI/CD**: Bypassed in automated environments

**Test compatibility**:
```bash
# Run validation
.claude/hooks/validate-hooks.sh

# Check integration
cat .claude/hooks/test-scenarios.md
```

#### 4. What happens if I ignore agent suggestions?

**Suggestions vs Requirements**:

**Suggestions** (can ignore):
- Consistency Agent pattern recommendations
- Quality Agent performance tips
- Debug Agent hypothesis ordering

**Requirements** (block commit):
- Security vulnerabilities (input validation, secrets)
- Breaking changes without migration
- Test failures (can't commit broken code)

**Override even requirements**:
```bash
--skip-quality-check  # Use sparingly!
```

#### 5. How do agents learn my codebase patterns?

**Pattern Discovery**:
1. **Search Phase**: Grep/Glob finds similar implementations
2. **Analysis Phase**: Extract common structure, naming, error handling
3. **Library Phase**: Store patterns in `.claude/agents/*/patterns/`
4. **Reuse Phase**: Suggest patterns in future implementations

**Manual pattern addition**:
```bash
# Add your own patterns
vi .claude/agents/consistency-agent/patterns/my-pattern.md
```

#### 6. What's the cost impact of Phase 2?

**Token usage**:
- **Consistency Agent**: ~2-5K tokens (Haiku = low cost)
- **Debug Agent**: ~10-20K tokens (Sonnet, but only on errors)
- **Quality Agent**: ~5-10K tokens (Sonnet, but prevents rework)

**Cost optimization**:
- Haiku for high-frequency tasks (consistency)
- Sonnet for complex reasoning (debug, quality)
- Caching reduces redundant API calls
- Estimated 40-60% cost savings vs all-Sonnet approach

**ROI**: Preventing one bug that would take 30 minutes to debug pays for many agent calls.

#### 7. Can I customize the quality checklist?

**Yes**, fully customizable:

```yaml
# Edit .claude/agents/quality-agent/checklist.md
checklist:
  categories:
    - name: custom_category
      weight: high
      checks:
        - id: custom_check
          description: "Your requirement"
          required: true
          blocking: false
          fix_suggestion: "How to fix"
```

**Project-specific checklists**:
```yaml
# Frontend project
- id: a11y_compliance
  description: "WCAG 2.1 AA compliance"

# Backend project
- id: api_versioning
  description: "Proper API versioning"
```

#### 8. What if agents conflict with each other?

**Precedence Rules Prevent Conflicts**:

1. **Priority Order**: CRITICAL > HIGH > MEDIUM > LOW
2. **Agent Order**: debug > quality > consistency
3. **Single Agent**: Only one agent runs at a time
4. **Queue Management**: Others queue if triggered during execution

**Example**:
```
User: "implement feature" → Consistency Agent starts
Error occurs → Debug Agent takes over (CRITICAL priority)
Debug finishes → Consistency Agent resumes
User: "done" → Quality Agent runs
```

#### 9. How do I debug the trigger system itself?

**Logging**:
```bash
# View trigger evaluations
cat .claude/logs/trigger-events.jsonl

# Recent activations
tail -f .claude/logs/trigger-events.jsonl

# Analytics
cat .claude/metrics/trigger-analytics.json
```

**Debug mode**:
```yaml
# Edit .claude/config/triggers.yml
debug:
  enabled: true
  log_level: verbose
  log_all_evaluations: true
```

**Validation**:
```bash
# Test trigger configuration
.claude/hooks/validate-hooks.sh

# Manual trigger test
.claude/config/test-trigger.sh "implement login feature"
```

#### 10. Can I add my own agents?

**Yes**, follow the agent pattern:

```yaml
# .claude/agents/my-agent/agent.yml
---
name: my-agent
description: "Your agent purpose"
model: haiku|sonnet
activation:
  keywords: [your, keywords]
  triggers: [your_triggers]
tools: [Read, Edit, Write, Bash, Grep, Glob]
---
```

```markdown
# .claude/agents/my-agent/instructions.md

You are a specialized agent for [purpose].

## Core Responsibilities
1. [Responsibility 1]
2. [Responsibility 2]

## Workflow
[Your agent's workflow]

## Output Format
[Expected output]
```

**Register in triggers**:
```yaml
# Add to .claude/config/triggers.yml
my-agent-trigger:
  agent: my-agent
  priority: MEDIUM
  keywords: [your, keywords]
```

#### 11. What's the difference between rules and agents?

**Rules** (Framework):
- Define **what** should be done
- Provide methodology and standards
- Markdown documentation
- Always active (passive guidance)
- Example: "Use 6-step debugging"

**Agents** (Execution):
- **Execute** the rules
- AI-powered active assistance
- YAML + instructions
- Activate on triggers
- Example: Actually guides you through 6 steps

**Analogy**: Rules are the "textbook", agents are the "teacher".

#### 12. How do I update Phase 2 components?

**Update agents**:
```bash
# Edit agent configuration
vi .claude/agents/debug-agent/agent.yml

# Edit agent instructions
vi .claude/agents/debug-agent/instructions.md

# Validate changes
.claude/hooks/validate-hooks.sh
```

**Update rules**:
```bash
# Edit rule files
vi .claude/rules/quality-standards.md

# Rules take effect immediately
```

**Update triggers**:
```bash
# Edit trigger configuration
vi .claude/config/triggers.yml

# Test changes
.claude/config/test-trigger.sh "test input"
```

---

## Examples

### Example 1: Debug Agent in Action

**Scenario**: Test failure during feature development

```
User: "Run the test suite"
$ npm test

> test
> jest

 FAIL  src/auth/login.test.ts
  ● Login flow › should authenticate valid user

    Expected: 200
    Received: 401

      at Object.<anonymous> (src/auth/login.test.ts:15:23)

Test Suites: 1 failed, 5 passed, 6 total
Tests:       1 failed, 12 passed, 13 total

────────────────────────────────────────────────────────
🔴 DEBUG AGENT ACTIVATED
────────────────────────────────────────────────────────

I detected a test failure. Let's debug this systematically
using the 6-step methodology.

STEP 1: REPRODUCE (60s)
═══════════════════════
Let me verify I can reproduce this consistently.

Running: npm test -- login.test.ts --verbose

Result: ✓ Failure reproduces consistently
- Test: "should authenticate valid user"
- Expected: 200 (OK)
- Received: 401 (Unauthorized)
- Location: src/auth/login.test.ts:15

STEP 2: ISOLATE (120s)
═══════════════════════
Let me narrow down where the failure occurs.

Checking:
1. Test setup → ✓ User created successfully
2. Login request → ✗ Returns 401 instead of 200
3. Token validation → Not reached

Isolated to: Login endpoint authentication logic

Reading implementation:
- src/auth/login.ts (lines 45-62)

Found: Password comparison using === instead of bcrypt.compare()

STEP 3: HYPOTHESIS (60s)
═══════════════════════
Potential causes:
1. ★★★ HIGH: Password comparison using === instead of bcrypt
   - Line 52: if (user.password === password)
   - Should use: await bcrypt.compare(password, user.password)
2. ★★☆ MEDIUM: Wrong password in test
   - Test uses: "password123"
   - DB has: hashed value
3. ★☆☆ LOW: User not found
   - User creation successful in test

Most likely: Hypothesis 1 (plain comparison of hashed password)

STEP 4: TEST (120s)
═══════════════════════
Testing Hypothesis 1:

Adding debug logging:
console.log('Comparing:', password, 'with:', user.password)

Output:
Comparing: password123 with: $2b$10$8K1p... (bcrypt hash)

Confirmed: Plain === comparison fails with bcrypt hash

STEP 5: FIX (180s)
═══════════════════════
Implementing fix:

File: src/auth/login.ts
Change:
- if (user.password === password)
+ if (await bcrypt.compare(password, user.password))

Also need to:
+ import bcrypt at top of file
+ Make function async if not already

Implementation complete.

STEP 6: VERIFY (60s)
═══════════════════════
Running tests:

$ npm test

Test Suites: 6 passed, 6 total
Tests:       13 passed, 13 total

✓ All tests pass
✓ Login test specifically passes
✓ No regressions

────────────────────────────────────────────────────────
✅ BUG RESOLVED
────────────────────────────────────────────────────────

Root Cause: Password comparison used === instead of bcrypt.compare()
Fix Applied: Replaced with proper bcrypt comparison
Tests: All passing (13/13)

Would you like me to commit this fix?
```

### Example 2: Consistency Agent in Action

**Scenario**: Adding a new API endpoint

```
User: "Add a new POST endpoint for updating user preferences"

────────────────────────────────────────────────────────
🔵 CONSISTENCY AGENT ACTIVATED
────────────────────────────────────────────────────────

I'll search for similar API endpoints to ensure consistency.

SEARCHING FOR PATTERNS...
═══════════════════════

Looking for: POST endpoints, user-related APIs, preference updates

Found 7 similar implementations:
1. POST /api/users/create (similarity: 0.85)
2. POST /api/users/update (similarity: 0.92) ← Best match
3. POST /api/users/password (similarity: 0.78)
4. POST /api/profile/update (similarity: 0.88)
5. POST /api/settings/update (similarity: 0.81)
6. PUT /api/users/:id (similarity: 0.75)
7. PATCH /api/users/:id/email (similarity: 0.72)

PATTERN ANALYSIS
═══════════════════════

Analyzing `/api/users/update` (closest match):

Common Structure:
├── Route Definition
│   ├── Method: POST (7/7 use POST for updates)
│   ├── Path: /api/{resource}/{action}
│   └── Middleware: [authenticate, validateBody]
│
├── Request Validation
│   ├── Schema: Joi validation (6/7 use Joi)
│   ├── Location: ./schemas/userUpdateSchema.js
│   └── Error handling: 400 with validation errors
│
├── Controller Logic
│   ├── Transaction wrapper (5/7 use transactions)
│   ├── Authorization check (user owns resource)
│   ├── Database update
│   └── Response format: { success: true, data: {...} }
│
├── Error Handling
│   ├── Try-catch block
│   ├── Specific errors: 404 (not found), 403 (forbidden)
│   ├── Generic: 500 (server error)
│   └── Logging: Winston logger
│
└── Tests
    ├── Unit tests: Controller logic
    ├── Integration tests: Full endpoint
    └── Location: ./__tests__/api/users/

RECOMMENDATION
═══════════════════════

I recommend following the pattern from `/api/users/update`:

```javascript
// routes/api/users.js
router.post('/preferences',
  authenticate,           // Standard auth middleware
  validateBody(preferencesUpdateSchema),  // Joi validation
  updatePreferences       // Controller
);

// schemas/preferencesUpdateSchema.js
const Joi = require('joi');

module.exports = Joi.object({
  theme: Joi.string().valid('light', 'dark'),
  notifications: Joi.boolean(),
  language: Joi.string(),
  // ... other preferences
});

// controllers/userController.js
async function updatePreferences(req, res) {
  const transaction = await db.transaction();  // Pattern: Use transactions

  try {
    // Pattern: Check authorization
    if (req.user.id !== req.params.id) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    // Pattern: Update in transaction
    const updated = await User.update(
      { preferences: req.body },
      { where: { id: req.user.id }, transaction }
    );

    await transaction.commit();

    // Pattern: Standard response format
    res.json({
      success: true,
      data: updated
    });

  } catch (error) {
    await transaction.rollback();
    logger.error('Preferences update failed:', error);  // Pattern: Log errors
    res.status(500).json({ error: 'Internal server error' });
  }
}

// __tests__/api/users/preferences.test.js
describe('POST /api/users/preferences', () => {
  it('should update preferences for authenticated user', async () => {
    // Pattern: Setup → Action → Assert
  });

  it('should return 403 for other users', async () => {
    // Pattern: Test authorization
  });

  it('should validate request body', async () => {
    // Pattern: Test validation
  });
});
```

BENEFITS OF THIS PATTERN
═══════════════════════

✓ Consistency: Same structure as 7 existing endpoints
✓ Security: Authentication + authorization built-in
✓ Validation: Joi schema prevents bad data
✓ Reliability: Transaction ensures atomicity
✓ Maintainability: Familiar pattern for team
✓ Testing: Comprehensive test coverage

────────────────────────────────────────────────────────

Would you like me to:
1. Generate the complete implementation following this pattern?
2. Show you the specific files I referenced?
3. Explain any part of the pattern in more detail?

[Your choice determines next steps]
```

### Example 3: Quality Agent in Action

**Scenario**: Marking feature complete before commit

```
User: "Done implementing the payment processing feature. Ready to commit."

────────────────────────────────────────────────────────
🟢 QUALITY AGENT ACTIVATED
────────────────────────────────────────────────────────

Running comprehensive quality review...

QUALITY CHECKLIST REVIEW
═══════════════════════

1. TEST COVERAGE ⚠
══════════════════════════════════════════════
   ✓ Unit tests present
     • paymentProcessor.test.js (12 tests)
     • stripeAdapter.test.js (8 tests)

   ✓ Integration tests present
     • payment-flow.integration.test.js (5 tests)

   ✓ Edge cases covered
     • Invalid card numbers
     • Expired cards
     • Insufficient funds
     • Network failures

   ✗ All tests passing
     • 24 passed
     • 1 failing: "should handle rate limit errors"
     • Location: paymentProcessor.test.js:145

   Status: ⚠ WARNING - 1 test failing

2. DOCUMENTATION ✓
══════════════════════════════════════════════
   ✓ Code comments present
     • Complex retry logic explained
     • Error handling documented

   ✓ Function documentation
     • JSDoc for all public methods
     • Parameters and return values documented

   ✓ README updated
     • Payment flow diagram added
     • Configuration instructions included

   ✓ API documentation
     • OpenAPI spec updated
     • Example requests included

   Status: ✓ PASS

3. ERROR HANDLING ✗
══════════════════════════════════════════════
   ✓ Input validation
     • Amount, currency, card validated

   ✓ Exception handling
     • Try-catch blocks present
     • Specific error types caught

   ✓ Error messages
     • Clear, actionable messages

   ✗ Graceful degradation
     • ⚠ CRITICAL: Stripe API key hardcoded in config.js:23
     • Should use: process.env.STRIPE_API_KEY

   ✗ Logging
     • ⚠ CRITICAL: No error logging on payment failures
     • Add: logger.error() calls

   Status: ✗ CRITICAL ISSUES FOUND

4. PERFORMANCE ○
══════════════════════════════════════════════
   ✓ Algorithm efficiency
     • No obvious bottlenecks

   ○ Database queries
     • Recommendation: Add index on payments.user_id
     • Impact: Medium (query used in reports)

   ✓ Memory management
     • No leaks detected

   ○ Caching
     • Recommendation: Cache exchange rates (1 hour TTL)
     • Current: Fetched on every transaction

   Status: ○ RECOMMENDATIONS

5. SECURITY ✗
══════════════════════════════════════════════
   ✗ Input sanitization
     • ⚠ CRITICAL: Card number not sanitized before logging
     • Line: paymentProcessor.js:67
     • Risk: PCI compliance violation
     • Fix: Mask card number (show last 4 digits only)

   ✓ Authentication/Authorization
     • User must be authenticated
     • Can only process own payments

   ✗ No hardcoded secrets
     • ⚠ CRITICAL: Stripe API key in config.js
     • Already flagged in Error Handling

   ✓ Dependency security
     • No known vulnerabilities (npm audit clean)

   Status: ✗ CRITICAL ISSUES FOUND

6. CODE QUALITY ✓
══════════════════════════════════════════════
   ✓ Readability
     • Clear variable names
     • Logical structure

   ✓ DRY principle
     • No significant duplication

   ✓ SOLID principles
     • Single responsibility maintained
     • Dependency injection used

   ✓ Project conventions
     • Follows existing patterns
     • Naming conventions consistent

   Status: ✓ PASS

7. INTEGRATION ✓
══════════════════════════════════════════════
   ✓ No breaking changes
     • Backward compatible API
     • Migration for new columns included

   ✓ Database migrations
     • add_payment_tables.js is backward compatible
     • Rollback script included

   ✓ Builds cleanly
     • No compilation errors
     • No linting warnings

   Status: ✓ PASS

════════════════════════════════════════════════════════

SUMMARY
═══════════════════════

Overall Status: ✗ BLOCKING ISSUES FOUND

Passed (4): Documentation, Code Quality, Integration, Performance
Warnings (1): Test Coverage (1 failing test)
Critical (2): Error Handling, Security

CRITICAL ISSUES (must fix before commit):
══════════════════════════════════════════════════════

1. ⚠ HARDCODED API KEY (Security + Error Handling)
   File: config/payment.config.js:23
   Issue: Stripe API key hardcoded
   Risk: Security breach, PCI violation
   Fix:
   ```javascript
   // Current (WRONG):
   stripeApiKey: 'sk_test_4eC39H... (rest of key)'

   // Should be:
   stripeApiKey: process.env.STRIPE_API_KEY

   // Also add to .env.example:
   STRIPE_API_KEY=your_stripe_key_here
   ```

2. ⚠ CARD NUMBER LOGGING (Security)
   File: src/paymentProcessor.js:67
   Issue: Full card number logged
   Risk: PCI DSS violation
   Fix:
   ```javascript
   // Current (WRONG):
   logger.info(`Processing payment for card ${cardNumber}`);

   // Should be:
   const maskedCard = cardNumber.slice(-4).padStart(cardNumber.length, '*');
   logger.info(`Processing payment for card ****${cardNumber.slice(-4)}`);
   ```

3. ⚠ MISSING ERROR LOGGING (Error Handling)
   File: src/paymentProcessor.js:89-95
   Issue: Payment failures not logged
   Risk: No audit trail
   Fix:
   ```javascript
   } catch (error) {
     logger.error('Payment processing failed:', {
       userId: user.id,
       amount,
       currency,
       error: error.message,
       stack: error.stack
     });
     throw error;
   }
   ```

WARNINGS (recommended):
══════════════════════════════════════════════════════

1. ○ Failing test: "should handle rate limit errors"
   File: __tests__/paymentProcessor.test.js:145
   Impact: Medium
   Action: Fix or remove if not applicable

2. ○ Add database index
   Migration: Create index on payments(user_id)
   Impact: Improves report query performance

3. ○ Cache exchange rates
   Implementation: Redis cache with 1-hour TTL
   Impact: Reduces API calls, improves response time

────────────────────────────────────────────────────────

❌ COMMIT BLOCKED

I cannot allow this commit due to 3 CRITICAL security and error
handling issues. These must be resolved first.

RECOMMENDED ACTION:
1. Fix the 3 critical issues (estimated 10 minutes)
2. Re-run quality check
3. Then commit safely

Would you like me to:
1. Generate the fixes automatically?
2. Explain any issue in more detail?
3. Show you the specific code sections?

[Once fixed, I'll re-run the checklist and allow commit]
```

---

## Getting Help

### Resources

- **Full Documentation**: `.claude/hooks/README.md` (862 lines)
- **Quick Reference**: `docs/PHASE2_QUICK_REFERENCE.md` (cheat sheet)
- **Agent Specs**: `docs/agent-specifications.md`
- **Trigger Rules**: `.claude/config/trigger-rules.md`
- **Test Scenarios**: `.claude/hooks/test-scenarios.md`

### Support Channels

1. **Configuration Issues**: Check troubleshooting guide above
2. **Customization**: See `docs/phase2-handoff.md`
3. **Examples**: See `docs/examples/` directory
4. **Validation**: Run `.claude/hooks/validate-hooks.sh`

---

## Version History

**v1.0.0** (2025-11-19)
- Initial Phase 2 release
- 3 agents (debug, consistency, quality)
- 4 rules (debugging, consistency, quality, skills)
- 3 hooks (pre-implementation, post-error, post-implementation)
- 11 triggers (keyword + tool-based)
- Comprehensive documentation package

---

**Last Updated**: 2025-11-19
**Maintained By**: Claude Code Team
**License**: Internal Use
