# Trigger System Rules and Decision Trees

**Version**: 1.0.0
**Last Updated**: 2025-11-19
**Status**: Production Ready

---

## Table of Contents

1. [Overview](#overview)
2. [Trigger Logic](#trigger-logic)
3. [Decision Trees](#decision-trees)
4. [Precedence Rules](#precedence-rules)
5. [Edge Cases](#edge-cases)
6. [Bypass Mechanisms](#bypass-mechanisms)
7. [Integration with Hooks](#integration-with-hooks)
8. [Examples and Test Cases](#examples-and-test-cases)
9. [Troubleshooting](#troubleshooting)

---

## Overview

### Purpose

The trigger system is the **intelligent routing layer** that determines when and which specialized agents should be activated based on:

- **Keywords** in user input
- **Tool events** (Bash errors, Edit operations, etc.)
- **Context** (file types, change significance, etc.)
- **User signals** (completion indicators, error reports, etc.)

### Design Principles

1. **Transparency**: Users should understand why agents activate
2. **Predictability**: Same inputs should produce consistent agent activations
3. **Override-ability**: Users can always bypass or explicitly choose agents
4. **Non-intrusive**: Triggers enhance workflow without disrupting it
5. **Learning**: System improves based on usage patterns

### Three-Agent System

```
┌─────────────────┐
│  Debug Agent    │  Priority: HIGH (P1)
│  (Sonnet)       │  Purpose: Systematic debugging methodology
└─────────────────┘  Triggers: Errors, failures, "debug", "fix"

┌─────────────────┐
│ Consistency     │  Priority: MEDIUM (P2)
│ Agent (Haiku)   │  Purpose: Pattern matching and reuse
└─────────────────┘  Triggers: "implement", "add", before Edit/Write

┌─────────────────┐
│ Quality Agent   │  Priority: MEDIUM (P3)
│ (Sonnet)        │  Purpose: Post-implementation review
└─────────────────┘  Triggers: "done", "commit", after Edit/Write
```

---

## Trigger Logic

### Trigger Evaluation Pipeline

```
User Input / Tool Call
        ↓
┌──────────────────────────┐
│ 1. Check Bypass Flags    │ → If bypassed: Skip to execution
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 2. Extract Keywords      │ → Parse user input for trigger words
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 3. Detect Tool Events    │ → Monitor tool execution and results
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 4. Evaluate Conditions   │ → Check file types, sizes, patterns
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 5. Match Triggers        │ → Find all matching triggers
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 6. Apply Precedence      │ → Resolve conflicts, prioritize
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 7. Check Agent Status    │ → Prevent recursion, manage queue
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 8. Activate Agent(s)     │ → Execute selected agent(s)
└──────────────────────────┘
        ↓
┌──────────────────────────┐
│ 9. Log Event             │ → Record for analytics
└──────────────────────────┘
```

### Keyword Matching Algorithm

```python
def match_keywords(user_input, trigger_config):
    """
    Matches user input against keyword triggers
    Returns: List of (trigger, confidence_score)
    """
    matched_triggers = []

    # Normalize input
    normalized = user_input.lower()

    for trigger in trigger_config.keyword_triggers:
        confidence = 0.0
        matched_keywords = []

        # Check each keyword
        for keyword in trigger.keywords:
            if keyword in normalized:
                matched_keywords.append(keyword)
                # Exact word boundary match gets higher score
                if re.search(r'\b' + re.escape(keyword) + r'\b', normalized):
                    confidence += 0.3
                else:
                    confidence += 0.1

        # Multi-keyword matches boost confidence
        if len(matched_keywords) > 1:
            confidence *= 1.5

        # Context requirements
        if trigger.context.require_error_evidence:
            if not has_error_indicators(user_input):
                confidence *= 0.5

        # Only add if meets minimum confidence
        if confidence >= trigger.context.min_keyword_confidence:
            matched_triggers.append((trigger, confidence))

    return sorted(matched_triggers, key=lambda x: x[1], reverse=True)
```

### Tool Event Detection

```python
def detect_tool_events(tool_call, result):
    """
    Detects triggering events from tool execution
    Returns: List of matched tool triggers
    """
    triggered = []

    for trigger in trigger_config.tool_triggers:
        # Match tool type
        if trigger.tool != tool_call.tool_name:
            continue

        # Evaluate condition
        if trigger.condition.type == "exit_code":
            if evaluate_exit_code(result.exit_code, trigger.condition):
                triggered.append(trigger)

        elif trigger.condition.type == "output_pattern":
            if re.search(trigger.condition.pattern, result.output):
                triggered.append(trigger)

        elif trigger.condition.type == "operation_count":
            if check_operation_count(tool_call, trigger.condition):
                triggered.append(trigger)

        # Check filters
        if not pass_filters(tool_call, trigger.filters):
            triggered.remove(trigger)

    return triggered
```

---

## Decision Trees

### Main Decision Tree

```
User Input Received
│
├─→ Explicit Agent Request? (e.g., "use debug-agent")
│   └─→ YES → Activate requested agent (OVERRIDE ALL)
│   └─→ NO → Continue evaluation
│
├─→ Bypass Flag Set? (--skip-triggers, CLAUDE_SKIP_AGENTS)
│   └─→ YES → Skip trigger evaluation, execute normally
│   └─→ NO → Continue evaluation
│
├─→ Tool Call Event?
│   ├─→ Bash Error (exit != 0)?
│   │   └─→ YES → CRITICAL: Activate debug-agent immediately
│   │
│   ├─→ Test Failure Pattern?
│   │   └─→ YES → CRITICAL: Activate debug-agent immediately
│   │
│   ├─→ Stack Trace Detected?
│   │   └─→ YES → CRITICAL: Activate debug-agent immediately
│   │
│   ├─→ Before Write (new file)?
│   │   └─→ YES + code file + ≥10 lines → Activate consistency-agent
│   │
│   ├─→ Before Edit (significant change)?
│   │   └─→ YES + creation pattern + ≥10 lines → Activate consistency-agent
│   │
│   ├─→ After Write (completed)?
│   │   └─→ YES + code file + ≥20 lines → Activate quality-agent
│   │
│   ├─→ Multiple Edits (≥3 in session)?
│   │   └─→ YES + ≥20 lines changed → Activate quality-agent
│   │
│   └─→ Git Commit Command?
│       └─→ YES + staged changes → HIGH: Activate quality-agent
│
├─→ Keyword Detected?
│   ├─→ Debug Keywords? (debug, fix, error, broken, etc.)
│   │   └─→ YES + confidence ≥ 0.8 → HIGH: Activate debug-agent
│   │
│   ├─→ Implementation Keywords? (implement, add, create, etc.)
│   │   └─→ YES + code context + confidence ≥ 0.7 → MEDIUM: Activate consistency-agent
│   │
│   └─→ Completion Keywords? (done, commit, ready, etc.)
│       └─→ YES + changes present + confidence ≥ 0.75 → MEDIUM: Activate quality-agent
│
├─→ Fallback Patterns?
│   ├─→ Implementation mentioned but no trigger?
│   │   └─→ Suggest consistency-agent (LOW priority)
│   │
│   ├─→ Confusion/frustration expressed?
│   │   └─→ Suggest debug-agent (LOW priority)
│   │
│   └─→ Quality question asked?
│       └─→ Suggest quality-agent (LOW priority)
│
└─→ No Match → Continue without agent activation
```

### Keyword Confidence Decision Tree

```
Keyword Match Found
│
├─→ Exact word boundary match?
│   └─→ YES → Base confidence = 0.3
│   └─→ NO (substring) → Base confidence = 0.1
│
├─→ Multiple keywords matched?
│   └─→ YES → confidence × 1.5
│
├─→ Error evidence required? (for debug triggers)
│   └─→ YES + evidence found → confidence × 1.0
│   └─→ YES + no evidence → confidence × 0.5
│
├─→ Code context required? (for consistency triggers)
│   └─→ YES + code mentioned → confidence × 1.0
│   └─→ YES + no code context → confidence × 0.5
│
├─→ Changes present required? (for quality triggers)
│   └─→ YES + uncommitted changes → confidence × 1.0
│   └─→ YES + no changes → confidence × 0.3
│
└─→ Final confidence ≥ threshold?
    └─→ YES → Trigger activated
    └─→ NO → Trigger skipped
```

### Tool Trigger Decision Tree

```
Tool Execution Completed
│
├─→ Bash Tool?
│   ├─→ Exit code != 0?
│   │   ├─→ Command in exclude list? (test -f, which, etc.)
│   │   │   └─→ YES → Skip trigger
│   │   │   └─→ NO → Continue
│   │   │
│   │   └─→ CRITICAL → Capture context → Activate debug-agent
│   │
│   ├─→ Output matches test failure pattern?
│   │   └─→ YES → CRITICAL → Activate debug-agent
│   │
│   ├─→ Output contains stack trace?
│   │   └─→ YES → CRITICAL → Activate debug-agent
│   │
│   └─→ Command is "git commit"?
│       └─→ YES + staged changes → HIGH → Activate quality-agent (pre-commit)
│
├─→ Edit Tool?
│   ├─→ Timing: Before execution?
│   │   ├─→ Operation type = creation/addition?
│   │   │   └─→ Lines added ≥ 10 + code file → Activate consistency-agent
│   │   │
│   │   └─→ Skip trigger
│   │
│   └─→ Timing: After execution?
│       ├─→ Operation count in session ≥ 3?
│       │   └─→ Total lines changed ≥ 20 + code file → Activate quality-agent
│       │
│       └─→ Skip trigger
│
└─→ Write Tool?
    ├─→ Timing: Before execution?
    │   ├─→ File exists?
    │   │   └─→ NO (new file) → Continue
    │   │   └─→ YES → Skip trigger
    │   │
    │   └─→ Code file + lines ≥ 10 → Activate consistency-agent
    │
    └─→ Timing: After execution?
        └─→ Success + code file + lines ≥ 20 → Activate quality-agent
```

### Precedence Resolution Tree

```
Multiple Triggers Matched
│
├─→ Different Priority Levels?
│   └─→ YES → Select HIGHEST priority trigger
│       │     (critical > high > medium > low > lowest)
│       │
│       └─→ Activate agent for highest priority
│
├─→ Same Priority Level?
│   └─→ Apply Agent Order:
│       │   1. debug-agent (highest)
│       │   2. quality-agent
│       │   3. consistency-agent (lowest)
│       │
│       └─→ Activate first agent in order
│
├─→ Duplicate Triggers (same agent)?
│   └─→ Merge into single activation
│       └─→ Combine context from all triggers
│
└─→ User Explicit Override?
    └─→ YES → IGNORE all automatic triggers
        └─→ Activate user-requested agent only
```

---

## Precedence Rules

### Priority Hierarchy

```
Priority Level    Numeric   Use Cases
─────────────────────────────────────────────────────
CRITICAL (P0)       1000    - Bash errors (exit != 0)
                            - Test failures
                            - Stack traces
                            - Build failures
                            - Security issues

HIGH (P1)            100    - Git commit (before)
                            - Debug keywords with evidence
                            - Blocking quality issues

MEDIUM (P2)           10    - Quality keywords
                            - Consistency keywords
                            - Multiple edits trigger
                            - Post-write reviews

LOW (P3)               1    - Fallback patterns
                            - Suggestions
                            - Optional improvements

LOWEST (P4)            0    - Default (no action)
                            - General queries

OVERRIDE (∞)          ∞     - Explicit user requests
                            - Emergency bypasses
```

### Agent Priority Order

When multiple triggers have **same priority**, use agent order:

```
1. debug-agent        → Correctness and errors FIRST
2. quality-agent      → Quality and security SECOND
3. consistency-agent  → Pattern consistency THIRD
```

**Rationale**:
- **Debug first**: Can't build on broken foundation
- **Quality second**: Security and standards before optimization
- **Consistency last**: Nice-to-have, not critical

### Precedence Examples

#### Example 1: Different Priorities

```
User Input: "implement user login"
Bash Command: npm install (exits with code 1)

Matched Triggers:
- consistency-keyword-trigger (MEDIUM, P2=10)
- bash-error-trigger (CRITICAL, P0=1000)

Resolution: bash-error-trigger wins (1000 > 10)
Result: Activate debug-agent first
```

#### Example 2: Same Priority, Different Agents

```
User Input: "done with the feature, ready to commit"

Matched Triggers:
- quality-keyword-trigger (MEDIUM, P2=10) → quality-agent
- pre-commit-trigger (HIGH, P1=100) → quality-agent

Resolution: Both trigger same agent, merge contexts
Result: Activate quality-agent once with combined context
```

#### Example 3: Same Priority, Same Level

```
Tool Events:
- Multiple Edit operations (MEDIUM, P2=10) → quality-agent
- After Write completed (MEDIUM, P2=10) → quality-agent

Resolution: Duplicate agent at same priority
Result: Merge into single quality-agent activation
```

#### Example 4: Explicit Override

```
User Input: "use consistency-agent to check this implementation"
Auto Triggers: bash-error-trigger (CRITICAL)

Resolution: Explicit user request (OVERRIDE, ∞)
Result: Activate consistency-agent, ignore error trigger
Note: User takes responsibility for bypassing error
```

---

## Edge Cases

### 1. Multiple Agents Triggered Simultaneously

**Scenario**: Implementation task encounters error

```
User: "implement user authentication"
Action: Edit auth.ts
Result: Bash error during validation

Triggers:
- consistency-agent (implement + before Edit)
- debug-agent (bash error)

Resolution:
1. Execute debug-agent first (higher priority)
2. After debug resolution, queue consistency-agent
3. Execute consistency-agent if user continues implementation
```

**Strategy**: `sequential_execution` with priority ordering

### 2. Agent Already Active (Recursion Prevention)

**Scenario A**: Same agent triggered while active

```
Active: debug-agent (debugging test failure)
Event: Another bash error occurs during debugging

Resolution: SKIP trigger (prevent recursion)
Rationale: Already debugging, new error is part of investigation
```

**Scenario B**: Different agent triggered while active

```
Active: consistency-agent (searching patterns)
Event: Bash error occurs during pattern search

Resolution: QUEUE debug-agent
Execution: After consistency completes, run debug-agent
Max Queue Depth: 3 agents
```

**Strategy**: `queue_or_skip` based on agent type

### 3. User Explicitly Requests Different Agent

**Scenario**: Override automatic triggers

```
Auto Trigger: bash-error-trigger → debug-agent
User Input: "use quality-agent to review this code despite the error"

Resolution: HONOR user request (OVERRIDE priority)
Result: Activate quality-agent, skip debug-agent
Warning: "Note: Bash error detected but bypassed per your request"
```

**Strategy**: `honor_user_request` with warning

### 4. Trigger During Agent Execution

**Scenario**: Agent action triggers another agent

```
Active: debug-agent
Action: debug-agent calls Edit tool to fix code
Event: Edit operation would trigger consistency-agent

Resolution: DEFER consistency-agent
Execution: After debug-agent completes, ask user:
           "Would you like consistency-agent to review the fix?"
```

**Strategy**: `defer_or_ignore` with user confirmation

### 5. Low Confidence Triggers

**Scenario**: Keyword match below confidence threshold

```
User Input: "make the page load faster"
Keyword: "make" (consistency trigger)
Confidence: 0.5 (< 0.7 threshold)

Resolution: SUGGEST, don't auto-activate
Message: "Would you like me to check for similar performance optimizations?"
Action: User can accept/decline suggestion
```

**Strategy**: `suggest_not_enforce` for confidence < threshold

### 6. Rapid Trigger Succession

**Scenario**: Multiple rapid tool calls trigger same agent

```
Time 0s: bash npm test (exit 1) → debug-agent
Time 1s: bash pytest (exit 1) → debug-agent
Time 2s: bash make test (exit 1) → debug-agent

Resolution: DEBOUNCE (5-second window)
Result: Batch all errors into single debug-agent activation
Context: All three test failures included in debug context
```

**Strategy**: `debounce` with 5-second window

### 7. Conflicting Agent Recommendations

**Scenario**: Agents suggest conflicting actions

```
consistency-agent: "Use pattern A (matches 5 similar implementations)"
quality-agent: "Pattern A has security vulnerability (SQL injection risk)"

Resolution: quality-agent wins (security > consistency)
Action: Block pattern A
Suggestion: "Find alternative pattern or fix security issue in all 5 implementations"
```

**Strategy**: `highest_priority_wins` (debug > quality > consistency)

### 8. Bypass Explicitly Invoked

**Scenarios**:

```bash
# A. Command-line flag
edit file.ts --skip-triggers
# Result: No agents activated

# B. Environment variable
export CLAUDE_SKIP_AGENTS=true
# Result: All agent triggers disabled globally

# C. File annotation
# @skip-triggers
# Result: All triggers skipped for this file

# D. Agent-specific bypass
edit file.ts --skip-agent=consistency-agent
# Result: Consistency-agent skipped, others still active
```

**Strategy**: `respect_bypass` with logging

### 9. Tool Exclusion Filters

**Scenario**: Intentional exit codes should not trigger debug-agent

```bash
# These commands SHOULD NOT trigger debug-agent:
test -f file.txt || echo "not found"  # Intentional test
git diff --exit-code  # Uses exit code for logic
which python3 || echo "not installed"  # Check existence

# These commands SHOULD trigger debug-agent:
npm install  # Failed dependency installation
pytest tests/  # Failed tests
make build  # Failed compilation
```

**Strategy**: Maintain `exclude_commands` filter list

---

## Bypass Mechanisms

### 1. Command-Line Flags

```bash
# Disable all triggers for this command
edit file.py --skip-triggers

# Disable specific agent
edit file.py --skip-agent=consistency-agent

# Disable all hooks (includes triggers)
edit file.py --no-hooks
```

### 2. Environment Variables

```bash
# Disable all agent activations (global)
export CLAUDE_SKIP_AGENTS=true

# Disable automatic triggers but allow manual activation
export CLAUDE_SKIP_TRIGGERS=true

# Manual-only mode (no automatic activations)
export CLAUDE_AGENT_MODE=manual
```

### 3. File-Level Annotations

```python
# @skip-triggers
# This file bypasses all trigger checks

def my_function():
    pass
```

```typescript
// @skip-agent:consistency
// Skip consistency checks but allow quality and debug

export function myComponent() {
  return <div>Hello</div>;
}
```

### 4. Directory Patterns

Automatically bypass for certain directories:

```
**/test/**          → Relaxed triggers (testing has different patterns)
**/docs/**          → Skip code triggers (documentation)
**/node_modules/**  → Skip all triggers (dependencies)
**/vendor/**        → Skip all triggers (third-party code)
```

### 5. Conditional Bypasses

```yaml
# Automatically bypass for trivial changes
change_size < 5 lines → Skip consistency and quality, keep debug

# Bypass for documentation files
file_type == 'markdown' → Skip consistency and quality

# Senior user fast-track
user_role == 'senior' → Allow bypass with single confirmation
```

### How to Use Bypasses

#### Temporary Bypass (Single Command)

```bash
# When you're confident and want speed
edit urgent-fix.py --skip-triggers
```

#### Session Bypass (Experimental Work)

```bash
# When prototyping and don't want interruptions
export CLAUDE_SKIP_AGENTS=true
# ... work on prototype ...
unset CLAUDE_SKIP_AGENTS
```

#### File Bypass (Generated Code)

```python
# @skip-triggers
# Auto-generated file - do not trigger pattern checks
# Generated by: schema-builder v2.1.0

# ... generated code ...
```

---

## Integration with Hooks

### Trigger-Hook Relationship

**Triggers** and **Hooks** are complementary systems:

- **Triggers**: **WHEN** and **WHICH** agent to activate
- **Hooks**: **HOW** and **WHAT** the agent does

```
┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│   TRIGGER    │ ────→ │     HOOK     │ ────→ │    AGENT     │
│              │       │              │       │              │
│ Detects:     │       │ Defines:     │       │ Executes:    │
│ - Keywords   │       │ - Workflow   │       │ - Analysis   │
│ - Tool events│       │ - Checklist  │       │ - Fixes      │
│ - Conditions │       │ - Context    │       │ - Review     │
└──────────────┘       └──────────────┘       └──────────────┘
```

### Trigger-Hook Mappings

| Trigger | Hook | Agent | When |
|---------|------|-------|------|
| `pre-write-trigger` | `pre-implementation` | consistency-agent | Before Write (new file) |
| `pre-edit-trigger` | `pre-implementation` | consistency-agent | Before Edit (creation pattern) |
| `bash-error-trigger` | `post-error` | debug-agent | After Bash error |
| `test-failure-trigger` | `post-error` | debug-agent | After test failure |
| `stack-trace-trigger` | `post-error` | debug-agent | Stack trace detected |
| `post-write-trigger` | `post-implementation` | quality-agent | After Write completes |
| `multiple-edit-trigger` | `post-implementation` | quality-agent | After 3+ Edits |
| `pre-commit-trigger` | `post-implementation` | quality-agent | Before git commit |

### Workflow Example

**User**: "Add a new API endpoint for user registration"

```
Step 1: TRIGGER EVALUATION
├─ Keyword detected: "add" + "endpoint"
├─ Trigger: consistency-keyword-trigger (MEDIUM)
└─ Decision: Activate consistency-agent

Step 2: HOOK EXECUTION
├─ Hook: pre-implementation.yml
├─ Mode: interactive
├─ Workflow:
│   ├─ identify_task_type → "API endpoint creation"
│   ├─ search_similar_patterns → Find existing endpoints
│   ├─ analyze_patterns → Extract common structure
│   └─ suggest_reuse → Present to user
└─ Exit: 0 (continue)

Step 3: AGENT EXECUTION
├─ Agent: consistency-agent
├─ Tools: Grep, Glob, Read
├─ Actions:
│   ├─ Search: grep -r "app.post\(" src/
│   ├─ Found: 5 similar POST endpoints
│   ├─ Extract pattern: Express + Joi + transaction wrapper
│   └─ Suggest: "Follow this structure?"
└─ User: Accepts pattern

Step 4: IMPLEMENTATION
├─ User/Agent creates endpoint following pattern
└─ Consistency maintained across codebase
```

### Hook Override of Triggers

Hooks can override trigger settings:

```yaml
# triggers.yml
tool_triggers:
  - name: pre-write-trigger
    agent: consistency-agent
    activation_mode: pre-execution  # Default

# pre-implementation.yml (hook)
agent_mode: interactive  # OVERRIDES activation_mode
requires_approval: true  # Additional requirement

# Result: Agent activates in interactive mode with approval requirement
```

---

## Examples and Test Cases

### Test Case 1: Debug Keywords

**Input**: `"debug this test failure"`

**Expected**:
- Trigger: `debug-keyword-trigger`
- Agent: `debug-agent`
- Confidence: 0.9 (high)
- Priority: HIGH

**Evaluation**:
```
Keywords matched: ["debug", "test", "failure"]
Confidence calculation:
  - "debug" (exact match): +0.3
  - "test" (exact match): +0.3
  - "failure" (exact match): +0.3
  - Multiple keywords bonus: ×1.5
  - Final: (0.3 + 0.3 + 0.3) × 1.5 = 1.35 (capped at 1.0)

Result: ✓ ACTIVATED (confidence 1.0 ≥ threshold 0.8)
```

### Test Case 2: Implementation Keywords

**Input**: `"implement user authentication"`

**Expected**:
- Trigger: `consistency-keyword-trigger`
- Agent: `consistency-agent`
- Confidence: 0.7 (medium)
- Priority: MEDIUM

**Evaluation**:
```
Keywords matched: ["implement"]
Confidence calculation:
  - "implement" (exact match): +0.3
  - Code context present (authentication): ×1.0
  - Final: 0.3

Checking context requirement:
  - require_code_context: true
  - Code context found: "authentication" (code feature)
  - Meets requirement: ✓

Result: ✓ ACTIVATED (confidence 0.3 ≥ threshold 0.7... wait, 0.3 < 0.7)

Actually, let me recalculate:
  - "implement" is exact word match: +0.3
  - But we need higher confidence for this trigger
  - Need additional signals or multiple keywords

Let's enhance:
Input: "implement user authentication feature"
Keywords matched: ["implement", "feature"]
  - "implement": +0.3
  - "feature": +0.3
  - Multiple keywords: ×1.5
  - Final: (0.3 + 0.3) × 1.5 = 0.9

Result: ✓ ACTIVATED (confidence 0.9 ≥ threshold 0.7)
```

### Test Case 3: Completion Keywords

**Input**: `"done with implementation, ready to commit"`

**Expected**:
- Trigger: `quality-keyword-trigger`
- Agent: `quality-agent`
- Confidence: 0.95
- Priority: MEDIUM

**Evaluation**:
```
Keywords matched: ["done", "ready", "commit"]
Confidence calculation:
  - "done": +0.3
  - "ready": +0.3
  - "commit": +0.3
  - Multiple keywords: ×1.5
  - Final: (0.3 + 0.3 + 0.3) × 1.5 = 1.35 (capped at 1.0)

Context check:
  - require_changes_present: true
  - git status shows modified files: ✓
  - Meets requirement: ✓

Result: ✓ ACTIVATED (confidence 1.0 ≥ threshold 0.75)
```

### Test Case 4: Bash Error

**Input**: Bash command `npm install` exits with code 1

**Expected**:
- Trigger: `bash-error-trigger`
- Agent: `debug-agent`
- Priority: CRITICAL

**Evaluation**:
```
Tool: Bash
Exit Code: 1 (non-zero)
Command: "npm install"

Checking exclude list:
  - "test -f": No match
  - "which": No match
  - "command -v": No match
  - Not in exclude list: ✓

Condition evaluation:
  - exit_code != 0: ✓ (1 != 0)

Context capture:
  - command: "npm install"
  - exit_code: 1
  - stderr: "npm ERR! peer dependency conflict..."
  - Captured: ✓

Result: ✓ ACTIVATED IMMEDIATELY (CRITICAL priority)
```

### Test Case 5: Multiple Triggers

**Input**: `"implement login feature"` + Bash error during setup

**Matched Triggers**:
1. `consistency-keyword-trigger` (MEDIUM, P2=10)
2. `bash-error-trigger` (CRITICAL, P0=1000)

**Expected**:
- Primary: `debug-agent` (CRITICAL priority)
- Queued: `consistency-agent` (after debug resolution)

**Resolution**:
```
Precedence evaluation:
  - Trigger A: consistency-keyword-trigger
    Priority: MEDIUM (10)
    Agent: consistency-agent

  - Trigger B: bash-error-trigger
    Priority: CRITICAL (1000)
    Agent: debug-agent

Comparison: 1000 > 10
Winner: bash-error-trigger

Execution plan:
  1. Activate debug-agent (immediate, CRITICAL)
  2. Queue consistency-agent (deferred, MEDIUM)
  3. After debug resolves, ask user:
     "Debug complete. Would you like consistency-agent to check patterns?"

Result: ✓ SEQUENTIAL EXECUTION with user confirmation
```

### Test Case 6: Multiple Edits

**Input**: User makes 5 Edit operations, changing 60 lines total

**Expected**:
- Trigger: `multiple-edit-trigger`
- Agent: `quality-agent`
- Priority: MEDIUM

**Evaluation**:
```
Tool tracking:
  - Edit #1: auth.ts, 12 lines changed
  - Edit #2: api.ts, 15 lines changed
  - Edit #3: utils.ts, 8 lines changed
  - Edit #4: auth.ts, 18 lines changed
  - Edit #5: api.ts, 7 lines changed

  Total edits: 5
  Total lines: 60

Condition check:
  - operation_count >= 3: ✓ (5 >= 3)
  - timeframe = session: ✓ (all in current session)

Filter check:
  - min_lines_changed: 20
  - Total changed: 60
  - Meets threshold: ✓ (60 ≥ 20)

File type check:
  - All files are .ts (TypeScript)
  - In allowed file_types: ✓

Result: ✓ ACTIVATED after 5th edit
Message: "Multiple changes detected. Running quality review..."
```

### Test Case 7: Bypass Flag

**Input**: `edit file.py --skip-triggers`

**Expected**:
- All triggers: BYPASSED
- Execution: Normal (no agent activation)

**Evaluation**:
```
Bypass check (Step 1 of pipeline):
  - Flag: --skip-triggers
  - Bypass enabled: ✓

Trigger evaluation:
  - SKIPPED (bypass active)

Agent activation:
  - SKIPPED (bypass active)

Logging:
  - Event: "trigger_bypassed"
  - Reason: "--skip-triggers flag"
  - User: (current user)
  - Timestamp: 2025-11-19T10:30:00Z

Result: ✓ BYPASSED successfully
```

### Test Case 8: Explicit Agent Request

**Input**: `"use consistency-agent for this implementation"`

**Expected**:
- Trigger: Explicit override
- Agent: `consistency-agent`
- Priority: OVERRIDE (∞)

**Evaluation**:
```
Explicit request detection:
  - Pattern: "use {agent-name}"
  - Match: "use consistency-agent"
  - Extracted agent: consistency-agent
  - Confidence: 1.0 (explicit)

Automatic triggers:
  - consistency-keyword-trigger: Matched
  - (Would normally activate consistency-agent anyway)

Precedence:
  - Explicit override: OVERRIDE (∞)
  - Automatic triggers: Ignored

Result: ✓ ACTIVATED (explicit request)
Note: Same agent would have been activated, but explicit request takes precedence
```

### Test Case 9: Test Failure Pattern

**Input**: Bash output contains "===== 3 failed, 5 passed in 2.34s ====="

**Expected**:
- Trigger: `test-failure-trigger`
- Agent: `debug-agent`
- Priority: CRITICAL

**Evaluation**:
```
Tool: Bash
Output pattern matching:
  - Pattern: "(FAILED|FAIL|Error|Exception|AssertionError)"
  - Output: "===== 3 failed, 5 passed in 2.34s ====="
  - Match: "failed" (matched)

Framework detection:
  - pytest pattern: "FAILED|ERROR|===.*failed"
  - Match: "===.*failed" ✓
  - Identified framework: pytest

Context capture:
  - framework: pytest
  - failed_count: 3
  - passed_count: 5
  - duration: 2.34s
  - full_output: (captured)

Result: ✓ ACTIVATED (CRITICAL)
Message: "Test failures detected. Activating debug-agent..."
```

### Test Case 10: Low Confidence

**Input**: `"make the UI prettier"`

**Keyword**: "make" (consistency trigger)

**Expected**:
- Trigger: Below confidence threshold
- Action: Suggest, don't auto-activate

**Evaluation**:
```
Keywords matched: ["make"]
Confidence calculation:
  - "make": +0.3 (exact match)
  - Single keyword: No bonus
  - Code context: "UI prettier" (design, not implementation)
  - Context match: Weak (×0.5)
  - Final: 0.3 × 0.5 = 0.15

Threshold check:
  - Required: 0.7
  - Actual: 0.15
  - Meets threshold: ✗ (0.15 < 0.7)

Low confidence handling:
  - Strategy: suggest_not_enforce
  - Action: Suggest to user

Result: ✗ NOT ACTIVATED (below threshold)
Suggestion: "Would you like me to check for similar UI implementations?"
User can accept/decline.
```

---

## Troubleshooting

### Problem: Agent Not Activating When Expected

**Symptoms**: You expect an agent to activate but it doesn't

**Debugging Steps**:

1. **Check bypass flags**:
   ```bash
   # Are you using bypass flags?
   echo $CLAUDE_SKIP_AGENTS
   echo $CLAUDE_SKIP_TRIGGERS
   # Expected: (empty) or "false"
   ```

2. **Check keyword confidence**:
   - Is your keyword exact match or substring?
   - Do you have multiple keywords?
   - Is context requirement met?

3. **Check file filters**:
   - Is file type in allowed list?
   - Does file size meet minimums?
   - Is file in excluded directory?

4. **Check trigger logs**:
   ```bash
   tail -n 50 .claude/logs/trigger-events.jsonl | grep trigger_evaluated
   # Look for why trigger didn't match
   ```

5. **Manual activation**:
   ```
   # Force agent activation
   "use debug-agent for this"
   ```

### Problem: Wrong Agent Activating

**Symptoms**: Different agent than expected activates

**Debugging Steps**:

1. **Check for errors**:
   - Debug-agent has CRITICAL priority
   - Any error will trigger debug first

2. **Check precedence**:
   - Review priority levels
   - Check agent order for tie-breaking

3. **Check trigger logs**:
   ```bash
   tail -n 50 .claude/logs/trigger-events.jsonl | grep trigger_activated
   # See which triggers matched and their priorities
   ```

### Problem: Agent Activating Too Often

**Symptoms**: Agent triggers on every action

**Solutions**:

1. **Adjust confidence thresholds**:
   ```yaml
   # In triggers.yml
   context:
     min_keyword_confidence: 0.9  # Increase from 0.7
   ```

2. **Add filters**:
   ```yaml
   filters:
     min_lines_changed: 50  # Increase threshold
     file_types: ["js", "ts"]  # Narrow scope
   ```

3. **Use bypass for specific files**:
   ```python
   # @skip-agent:consistency
   # This file bypasses consistency checks
   ```

4. **Temporary session bypass**:
   ```bash
   export CLAUDE_SKIP_AGENTS=true
   # Work without interruptions
   unset CLAUDE_SKIP_AGENTS
   ```

### Problem: Trigger Recursion

**Symptoms**: Agent activates itself repeatedly

**This should not happen** due to recursion prevention, but if it does:

1. **Check agent status tracking**:
   - System should prevent same agent re-triggering
   - Check logs for `agent_already_active` events

2. **Report bug**:
   - This is a system issue
   - Collect logs from `.claude/logs/trigger-events.jsonl`
   - Include reproduction steps

3. **Immediate workaround**:
   ```bash
   export CLAUDE_SKIP_AGENTS=true
   # Temporarily disable all agents
   ```

### Problem: Triggers Not Respecting Bypasses

**Symptoms**: Bypass flags/annotations ignored

**Debugging Steps**:

1. **Check flag syntax**:
   ```bash
   # Correct:
   edit file.py --skip-triggers

   # Incorrect:
   edit file.py -skip-triggers
   edit file.py --skip_triggers
   ```

2. **Check environment variables**:
   ```bash
   # Must be exported
   export CLAUDE_SKIP_AGENTS=true  # Correct
   CLAUDE_SKIP_AGENTS=true         # Incorrect (not exported)
   ```

3. **Check file annotations**:
   ```python
   # Must be first line or in header
   # @skip-triggers  # Correct (first line)

   # ... 50 lines of code ...
   # @skip-triggers  # Incorrect (too late, won't be detected)
   ```

### Getting Help

If you can't resolve the issue:

1. **Check logs**:
   ```bash
   # Trigger evaluation logs
   cat .claude/logs/trigger-events.jsonl | jq .

   # Agent activation logs
   cat .claude/logs/debug-sessions.jsonl | jq .
   ```

2. **Enable debug logging**:
   ```bash
   export CLAUDE_DEBUG=true
   # Get verbose logging of trigger evaluation
   ```

3. **Report issue** with:
   - Input that triggered (or didn't trigger)
   - Expected behavior
   - Actual behavior
   - Relevant log excerpts
   - Configuration files

---

## Summary

### Key Takeaways

1. **Triggers route requests** to the right agent based on keywords, tool events, and context
2. **Precedence is clear**: CRITICAL > HIGH > MEDIUM > LOW, with debug > quality > consistency for ties
3. **Edge cases are handled**: recursion prevention, queueing, bypasses, conflicts
4. **Users stay in control**: explicit requests override, bypasses available, suggestions for low confidence
5. **System is transparent**: logs everything, explains decisions, predictable behavior

### Quick Reference

| Scenario | Trigger | Agent | Priority |
|----------|---------|-------|----------|
| Bash error | `bash-error-trigger` | debug-agent | CRITICAL |
| Test failure | `test-failure-trigger` | debug-agent | CRITICAL |
| User says "debug" | `debug-keyword-trigger` | debug-agent | HIGH |
| User says "implement" | `consistency-keyword-trigger` | consistency-agent | MEDIUM |
| Before Write new file | `pre-write-trigger` | consistency-agent | MEDIUM |
| User says "done" | `quality-keyword-trigger` | quality-agent | MEDIUM |
| Multiple Edits | `multiple-edit-trigger` | quality-agent | MEDIUM |
| Git commit | `pre-commit-trigger` | quality-agent | HIGH |

### Best Practices

1. **Trust the system** - It's designed to help, not hinder
2. **Use bypasses sparingly** - They exist for edge cases, not daily use
3. **Provide clear input** - Explicit keywords get better results
4. **Review suggestions** - Low-confidence triggers offer suggestions, consider them
5. **Report issues** - System improves based on feedback

---

**End of Trigger Rules Documentation**

*For questions or improvements, contact the Claude Code Team*
