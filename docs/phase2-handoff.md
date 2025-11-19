# Phase 2 Handoff: Modification and Extension Guide

**Date**: 2025-11-19
**Version**: 1.0.0
**For**: Developers who need to customize or extend Phase 2

---

## Table of Contents

1. [Current State](#current-state)
2. [What Was Implemented](#what-was-implemented)
3. [How to Modify/Extend](#how-to-modifyextend)
4. [Common Tasks](#common-tasks)
5. [Maintenance](#maintenance)

---

## Current State

### System Status

**Status**: ✅ Production Ready
**Version**: 1.0.0
**Date Deployed**: 2025-11-19

**Components**:
- **3 Agents**: debug-agent, consistency-agent, quality-agent (100% operational)
- **4 Rules**: debugging, consistency, quality, skills (active)
- **3 Hooks**: pre-implementation, post-error, post-implementation (validated)
- **11 Triggers**: keyword + tool-based (100% test pass rate)
- **Metrics**: Event logging and analytics (configured)

**Test Results**:
- Trigger tests: 62/62 passed (100%)
- Hook validation: 38/38 checks passed (100%)
- Integration verification: 11/11 verified (100%)

### Current Configuration

**Model Usage**:
- debug-agent: Claude Sonnet (complex reasoning)
- consistency-agent: Haiku (fast pattern matching)
- quality-agent: Claude Sonnet (thorough review)

**Performance**:
- Consistency Agent: 15-30s average
- Debug Agent: 2-10min (depending on complexity)
- Quality Agent: 1-2min average

**Integration**:
- Works alongside obra superpowers (no conflicts)
- Compatible with existing git workflow
- Integrates with test suite (pytest, jest, etc.)

---

## What Was Implemented

### Directory Structure

```
.claude/
├── agents/                      # Specialized AI agents
│   ├── consistency-agent/
│   │   ├── agent.yml           # Configuration
│   │   ├── instructions.md     # Behavior definition
│   │   └── patterns/           # Pattern library
│   │       ├── README.md
│   │       ├── api-endpoint-pattern.md
│   │       ├── database-model-pattern.md
│   │       ├── error-handling-pattern.md
│   │       └── react-component-pattern.md
│   ├── debug-agent/
│   │   ├── agent.yml
│   │   ├── instructions.md
│   │   └── examples/           # Debug examples
│   │       ├── bash-error-example.md
│   │       ├── runtime-error-example.md
│   │       └── test-failure-example.md
│   └── quality-agent/
│       ├── agent.yml
│       ├── instructions.md
│       ├── checklist.md        # 7-category checklist
│       └── templates/          # Report templates
│           ├── review-report-template.md
│           ├── critical-issues-template.md
│           └── recommendations-template.md
│
├── rules/                      # Process methodologies
│   ├── debugging-methodology.md     # 6-step debugging
│   ├── consistency-patterns.md      # Pattern matching
│   ├── quality-standards.md         # 7-category quality
│   └── skill-activation.md          # Skill usage reminders
│
├── hooks/                      # Workflow integration
│   ├── pre-implementation.yml       # Before Edit/Write
│   ├── post-error.yml              # After errors
│   ├── post-implementation.yml     # After changes
│   ├── README.md                   # Full documentation
│   ├── QUICKREF.md                 # Quick reference
│   ├── test-scenarios.md           # Test documentation
│   ├── validate-hooks.sh           # Validation script
│   └── IMPLEMENTATION-SUMMARY.md   # Implementation notes
│
├── config/                     # Trigger configuration
│   ├── triggers.yml                # Main trigger config
│   ├── trigger-rules.md            # Documentation
│   ├── trigger-test-results.md     # Test results
│   ├── trigger-integration-verification.md
│   └── TRIGGER_SYSTEM_SUMMARY.md
│
├── metrics/                    # Analytics and tracking
│   └── (runtime files will appear here)
│
└── data/                       # Runtime data
    └── (runtime files will appear here)
```

### Component Details

#### Agents (3 total)

**debug-agent**:
- **Purpose**: Systematic 6-step debugging
- **Model**: Claude Sonnet
- **Location**: `/home/user/claude-skill-eval/.claude/agents/debug-agent/`
- **Files**: agent.yml (49 lines), instructions.md, 3 examples
- **Activation**: Error keywords, bash errors, test failures, stack traces

**consistency-agent**:
- **Purpose**: Pattern matching and reuse
- **Model**: Haiku
- **Location**: `/home/user/claude-skill-eval/.claude/agents/consistency-agent/`
- **Files**: agent.yml, instructions.md, 4 pattern templates
- **Activation**: Implementation keywords, before Edit/Write operations

**quality-agent**:
- **Purpose**: 7-category quality review
- **Model**: Claude Sonnet
- **Location**: `/home/user/claude-skill-eval/.claude/agents/quality-agent/`
- **Files**: agent.yml, instructions.md, checklist.md, 3 templates
- **Activation**: Completion keywords, after changes, before commits

#### Rules (4 files)

**debugging-methodology.md** (5.8KB):
- 6-step process: Reproduce → Isolate → Hypothesis → Test → Fix → Verify
- Examples for each step
- Failure modes to avoid

**consistency-patterns.md** (9.6KB):
- Pattern matching workflow
- When to search for patterns
- How to apply patterns
- Pattern library usage

**quality-standards.md** (13.4KB):
- 7-category checklist definition
- Blocking vs recommended checks
- Fix suggestions
- Quality metrics

**skill-activation.md** (12.7KB):
- When to check for skills
- Skill invocation patterns
- Integration with agents

#### Hooks (3 files + 5 documentation files)

**pre-implementation.yml** (121 lines):
- Triggers consistency-agent before Edit/Write
- Searches for similar patterns
- Suggests pattern reuse
- Performance: 15-30s

**post-error.yml** (192 lines):
- Triggers debug-agent on errors
- Captures error context
- Enforces 6-step methodology
- Performance: 2-10min

**post-implementation.yml** (313 lines):
- Triggers quality-agent after changes
- Runs 7-category checklist
- Blocks on critical issues
- Performance: 1-2min

#### Triggers (11 types)

**Keyword Triggers** (3):
- debug-keyword-trigger (9 keywords)
- consistency-keyword-trigger (9 keywords)
- quality-keyword-trigger (9 keywords)

**Tool Triggers** (8):
- bash-error-trigger (CRITICAL priority)
- test-failure-trigger (CRITICAL)
- stack-trace-trigger (CRITICAL)
- pre-write-trigger (MEDIUM)
- pre-edit-trigger (MEDIUM)
- post-write-trigger (MEDIUM)
- multiple-edit-trigger (MEDIUM)
- pre-commit-trigger (HIGH)

---

## How to Modify/Extend

### Adding a New Agent

**When to add**: When you have a distinct workflow need not covered by existing agents

**Steps**:

1. **Create agent directory**:
```bash
mkdir -p .claude/agents/my-agent
cd .claude/agents/my-agent
```

2. **Create agent.yml**:
```yaml
---
name: my-agent
description: "Clear one-line purpose"

# Model Configuration
model: haiku  # or sonnet, based on complexity

# Activation Configuration
activation:
  keywords:
    - keyword1
    - keyword2
    - keyword3
  triggers:
    - trigger_type

# Tool Permissions
tools:
  - Read
  - Edit
  - Write
  - Bash
  - Grep
  - Glob

# Execution Configuration
execution:
  mode: interactive  # or guided, review
  timeout: 300       # seconds
  max_iterations: 5

# Metadata
color: blue  # blue, green, orange, red
priority: medium  # low, medium, high, critical
version: "1.0.0"
---
```

3. **Create instructions.md**:
```markdown
# My Agent Instructions

You are a specialized agent for [purpose].

## Core Responsibilities

1. [Primary responsibility]
2. [Secondary responsibility]
3. [Validation responsibility]

## Workflow

### Step 1: [Name]
[Description]

### Step 2: [Name]
[Description]

### Step 3: [Name]
[Description]

## Output Format

[Define expected output format]

## Performance Guidelines

- Time budget: [X seconds]
- Token budget: [X tokens]
- File read limit: [X files]

## Examples

### Example 1: [Scenario]
[Example walkthrough]
```

4. **Add to trigger system**:
```yaml
# Edit .claude/config/triggers.yml
my-agent-trigger:
  name: "my-agent-keyword-trigger"
  agent: my-agent
  priority: MEDIUM
  activation:
    type: keyword
    keywords: [keyword1, keyword2, keyword3]
    min_confidence: 0.7
  conditions:
    - type: context_requirement
      requires: code_context
```

5. **Create hook (if needed)**:
```yaml
# .claude/hooks/my-hook.yml
---
name: my-hook
version: "1.0.0"
enabled: true
priority: medium

description: "When to activate my-agent"

trigger:
  events:
    - event_type
  conditions:
    - condition

agent: my-agent
agent_mode: interactive

workflow:
  steps:
    - name: step1
      description: "What to do"

exit_codes:
  0: "Success"
  1: "Warning"

bypass:
  conditions:
    - bypass_scenario
---
```

6. **Test the agent**:
```bash
# Test keywords
echo "keyword1 keyword2" | test-trigger

# Test tool events
[trigger the tool event]

# Validate configuration
.claude/hooks/validate-hooks.sh
```

### Modifying Existing Agents

**Common modifications**:

#### Change Agent Model

**When**: Switch between Haiku and Sonnet for cost/quality trade-off

```yaml
# Edit .claude/agents/{agent-name}/agent.yml
model: haiku  # Change to: sonnet
```

**Consider**:
- Haiku: Faster, cheaper, good for simple tasks
- Sonnet: Slower, more expensive, better for complex reasoning

#### Adjust Activation Keywords

**When**: Agent triggers too often or not often enough

```yaml
# Edit .claude/agents/{agent-name}/agent.yml
activation:
  keywords:
    - existing_keyword
    - new_keyword  # Add more
```

#### Modify Agent Instructions

**When**: Agent behavior needs refinement

```markdown
# Edit .claude/agents/{agent-name}/instructions.md

# Add new responsibilities
## Core Responsibilities
4. [New responsibility]

# Modify workflow
### Step 2.5: [New intermediate step]
[Instructions]

# Add examples
## Examples
### Example N: [New scenario]
[Walkthrough]
```

### Adding New Patterns (Consistency Agent)

**When**: You want agent to recognize new code patterns

1. **Create pattern file**:
```bash
vi .claude/agents/consistency-agent/patterns/my-pattern.md
```

2. **Define pattern structure**:
```markdown
# My Pattern

## Pattern Name
[Descriptive name]

## When to Use
- [Scenario 1]
- [Scenario 2]

## Pattern Structure

```language
// Template code showing pattern
[Code structure]
```

## Common Variations

### Variation 1: [Name]
[Description and code]

### Variation 2: [Name]
[Description and code]

## Examples in Codebase

- File: `path/to/example1.ext` (lines X-Y)
- File: `path/to/example2.ext` (lines X-Y)

## Benefits

- [Benefit 1]
- [Benefit 2]

## Anti-patterns to Avoid

- [Anti-pattern 1]
- [Anti-pattern 2]
```

3. **Test pattern recognition**:
```bash
# Trigger consistency agent on relevant code
# Verify it finds and suggests your pattern
```

### Customizing Quality Checklist

**When**: You want project-specific quality checks

```yaml
# Edit .claude/agents/quality-agent/checklist.md

## Add custom category
### 8. Custom Category
**Weight**: high|medium|low
**Checks**:

#### [custom-check-id]
- **Description**: What to check
- **Required**: true|false
- **Blocking**: true|false (blocks commit if failed)
- **Check Method**: How to verify
- **Fix Suggestion**: How to resolve if failed

## Add check to existing category
### 1. Test Coverage

#### test-naming-convention
- **Description**: Test files follow naming convention
- **Required**: true
- **Blocking**: false
- **Check Method**: Verify `*.test.{js,ts,py}` naming
- **Fix Suggestion**: Rename test files to match convention
```

### Adding New Triggers

**When**: New workflow scenario needs agent activation

```yaml
# Edit .claude/config/triggers.yml

my-new-trigger:
  name: "descriptive-trigger-name"
  agent: agent-name
  priority: CRITICAL|HIGH|MEDIUM|LOW

  activation:
    type: keyword|tool|pattern
    # For keyword triggers:
    keywords: [word1, word2]
    min_confidence: 0.7

    # For tool triggers:
    tool: ToolName
    condition: "condition_expression"

  conditions:
    - type: context_requirement
      requires: code_context

    - type: file_filter
      file_types: [py, js, ts]

    - type: change_threshold
      min_lines_changed: 10

  context_capture:
    - field1
    - field2

  bypass:
    conditions:
      - bypass_scenario
```

### Modifying Hooks

**When**: Change when/how agents activate

```yaml
# Edit .claude/hooks/{hook-name}.yml

# Change trigger events
trigger:
  events:
    - new_event
    - existing_event  # Keep or remove

# Add conditions
  conditions:
    - type: file_size
      min_lines: 20  # Increase threshold

# Change agent mode
agent_mode: guided  # Change from interactive

# Adjust performance settings
performance:
  max_execution_time: 45  # Increase from 30
  enable_caching: true
  cache_ttl: 600  # 10 minutes instead of 5
```

---

## Common Tasks

### Task 1: Disable an Agent Temporarily

**Scenario**: Agent is interfering with rapid prototyping

**Solution 1**: Environment variable (session-wide)
```bash
export CLAUDE_SKIP_AGENTS=true  # All agents
# or
export CLAUDE_SKIP_TRIGGERS=true  # Auto-triggers only
```

**Solution 2**: Command flag (single command)
```bash
--skip-agent=consistency-agent
# or
--skip-quality-check
```

**Solution 3**: Disable in config (persistent)
```yaml
# Edit .claude/agents/consistency-agent/agent.yml
enabled: false  # Change from true
```

**Re-enable**:
```bash
unset CLAUDE_SKIP_AGENTS  # Remove env var
# or edit agent.yml back to: enabled: true
```

### Task 2: Change When Quality Agent Blocks

**Scenario**: Want stricter or looser blocking criteria

**Make stricter** (block on more issues):
```yaml
# Edit .claude/agents/quality-agent/checklist.md

# Change non-blocking to blocking
#### documentation
blocking: true  # Change from false
```

**Make looser** (block on fewer issues):
```yaml
# Change blocking to non-blocking
#### performance-caching
blocking: false  # Change from true
required: false  # Also make optional
```

### Task 3: Add Project-Specific Pattern

**Scenario**: Your team uses a specific API pattern

```markdown
# Create .claude/agents/consistency-agent/patterns/our-api-pattern.md

# Our API Endpoint Pattern

## Pattern Name
RESTful CRUD with JWT Authentication

## When to Use
Creating new API endpoints for resource management

## Pattern Structure

```typescript
// routes/api/resources.ts
router.post('/:id',
  authenticateJWT,
  validateBody(resourceSchema),
  authorize('resource:write'),
  async (req, res) => {
    const transaction = await db.transaction();
    try {
      const result = await ResourceService.update(
        req.params.id,
        req.body,
        { transaction, userId: req.user.id }
      );
      await transaction.commit();
      res.json({ success: true, data: result });
    } catch (error) {
      await transaction.rollback();
      logger.error('Resource update failed', error);
      res.status(500).json({ error: 'Update failed' });
    }
  }
);
```

## Examples in Codebase
- `routes/api/users.ts` (lines 45-75)
- `routes/api/posts.ts` (lines 30-60)
- `routes/api/comments.ts` (lines 20-50)
```

### Task 4: Adjust Trigger Sensitivity

**Scenario**: Consistency agent triggers too often

```yaml
# Edit .claude/config/triggers.yml

consistency-keyword-trigger:
  min_confidence: 0.85  # Increase from 0.7

  conditions:
    - type: change_threshold
      min_lines_changed: 20  # Increase from 5
```

### Task 5: Add Custom Quality Check

**Scenario**: Need to check for API versioning

```yaml
# Edit .claude/agents/quality-agent/checklist.md

### 7. Integration

#### api-versioning
- **Description**: API endpoints include version in path
- **Required**: true
- **Blocking**: true
- **Check Method**:
  - Search for router definitions
  - Verify paths include `/v1/` or `/v2/`
- **Fix Suggestion**: Add version to API path (e.g., `/api/v1/resource`)
- **Example**:
  ```typescript
  // Bad
  router.get('/users', ...)

  // Good
  router.get('/v1/users', ...)
  ```
```

### Task 6: Change Debug Methodology Steps

**Scenario**: Want to add team-specific debugging step

```markdown
# Edit .claude/rules/debugging-methodology.md

## 6-Step Debugging Methodology

[Keep existing steps 1-6]

## Optional: Step 7 - Document
**Purpose**: Share learnings with team
**Time Budget**: 30 seconds

**Actions**:
1. Add comment explaining root cause
2. Update team wiki if novel issue
3. Share in team chat if affects others

**Output**: Documentation created

**When to Skip**: Trivial bugs, time pressure
```

Update agent instructions:
```markdown
# Edit .claude/agents/debug-agent/instructions.md

## Workflow

### Step 7: Document (Optional)
If this bug could affect others:
- Add explanatory comment
- Consider updating team documentation
```

### Task 7: Create Hook for New Workflow Stage

**Scenario**: Want to run checks before pushing to remote

```yaml
# Create .claude/hooks/pre-push.yml
---
name: pre-push
version: "1.0.0"
enabled: true
priority: high

description: "Run comprehensive checks before git push"

trigger:
  events:
    - git_push
  conditions:
    - type: branch_check
      branches: [main, develop, staging]

agent: quality-agent
agent_mode: review

workflow:
  steps:
    - name: run_full_test_suite
      description: "All tests must pass"
      blocking: true

    - name: check_commit_messages
      description: "Verify conventional commits"
      blocking: false

    - name: security_scan
      description: "Check for secrets in commits"
      blocking: true

exit_codes:
  0: "All checks passed - push allowed"
  1: "Non-critical warnings - review and decide"
  2: "Critical issues found - push blocked"

bypass:
  flags: [--force-push]  # Danger: bypasses all checks
  conditions:
    - hotfix branches
---
```

Register trigger:
```yaml
# Edit .claude/config/triggers.yml

pre-push-trigger:
  name: "pre-push-quality-gate"
  agent: quality-agent
  priority: HIGH

  activation:
    type: tool
    tool: Bash
    condition: command_pattern = "git\\s+push"

  conditions:
    - type: branch_filter
      branches: [main, develop, staging]
```

---

## Maintenance

### Regular Maintenance Tasks

#### Weekly Tasks

**1. Review Metrics** (5 minutes)
```bash
# Check trigger activation rates
cat .claude/metrics/trigger-analytics.json | jq '.activation_rates'

# Look for:
# - High false positive rates (>20%)
# - Unused triggers (0 activations)
# - Slow agents (>2x expected time)
```

**2. Clean Pattern Library** (10 minutes)
```bash
# Review patterns for accuracy
ls .claude/agents/consistency-agent/patterns/

# Update patterns that have changed
# Remove patterns no longer used
# Add new patterns discovered this week
```

#### Monthly Tasks

**1. Review and Adjust Thresholds** (15 minutes)
```bash
# Based on metrics, adjust:
# - Trigger confidence thresholds
# - File size minimums
# - Quality check requirements

# Edit configuration files as needed
vi .claude/config/triggers.yml
vi .claude/agents/*/agent.yml
```

**2. Update Quality Checklist** (15 minutes)
```bash
# Review quality issues caught
# Add new checks for repeated issues
# Remove checks that never fail

vi .claude/agents/quality-agent/checklist.md
```

**3. Review Agent Performance** (10 minutes)
```bash
# Check average execution times
cat .claude/metrics/trigger-analytics.json | jq '.avg_execution_time'

# If agents are slow:
# - Enable caching
# - Reduce search scope
# - Consider model change
```

#### Quarterly Tasks

**1. Agent Effectiveness Review** (30 minutes)
- Review bugs caught vs bugs missed
- Analyze pattern reuse rates
- Survey team on agent helpfulness
- Identify areas for improvement

**2. Major Updates** (varies)
- Review new Claude model capabilities
- Update agent instructions for new features
- Refine methodologies based on learnings
- Add new agents if needed

### Troubleshooting

#### Agent Not Activating When Expected

**Diagnosis**:
```bash
# Check trigger logs
cat .claude/logs/trigger-events.jsonl | tail -20

# Look for:
# - Trigger evaluated but confidence too low
# - Conditions not met
# - Bypass mechanism active
```

**Fixes**:
- Lower confidence threshold
- Adjust conditions
- Check for bypass flags/env vars

#### Agent Running Too Slowly

**Diagnosis**:
```bash
# Check execution times
cat .claude/metrics/trigger-analytics.json | jq '.execution_times'
```

**Fixes**:
- Enable caching
- Reduce max_file_reads
- Switch to Haiku model (if appropriate)
- Add timeouts to prevent hanging

#### False Positives (Agent Activates When Shouldn't)

**Diagnosis**:
```bash
# Review recent activations
cat .claude/logs/trigger-events.jsonl | grep "false_positive"
```

**Fixes**:
- Increase confidence threshold
- Add more specific conditions
- Add exclude patterns
- Update keywords to be more specific

### Backup and Recovery

**Backup Configuration**:
```bash
# Create backup
tar -czf phase2-backup-$(date +%Y%m%d).tar.gz .claude/

# Store safely
mv phase2-backup-*.tar.gz ~/backups/
```

**Restore from Backup**:
```bash
# Extract backup
tar -xzf phase2-backup-YYYYMMDD.tar.gz

# Validate
.claude/hooks/validate-hooks.sh
```

**Version Control**:
```bash
# All configuration in git
git add .claude/
git commit -m "Phase 2: Update configuration"

# Restore previous version
git checkout HEAD~1 -- .claude/
```

### Upgrading

**When New Claude Models Release**:

1. **Test with new model**:
```yaml
# Create test agent config
# Edit .claude/agents/debug-agent/agent.yml
model: claude-sonnet-4-6-20260101  # New model
```

2. **Compare performance**:
- Run test scenarios
- Measure execution time
- Evaluate quality of outputs
- Check cost difference

3. **Roll out**:
- Update all agents to new model
- Monitor for issues
- Rollback if problems occur

**When Phase 2.1+ Released**:

1. Review changelog
2. Backup current configuration
3. Apply updates selectively
4. Test each updated component
5. Rollback if needed

---

## Getting Help

### Documentation Resources

- **PHASE2_README.md**: Comprehensive overview (10-minute read)
- **docs/PHASE2_QUICK_REFERENCE.md**: Cheat sheet
- **docs/agent-specifications.md**: Agent design details
- **.claude/hooks/README.md**: Hook system documentation
- **.claude/config/trigger-rules.md**: Trigger system details

### Validation Tools

```bash
# Validate all hooks
.claude/hooks/validate-hooks.sh

# Test specific trigger
.claude/config/test-trigger.sh "your input here"

# Check configuration syntax
yamllint .claude/agents/*/agent.yml
yamllint .claude/hooks/*.yml
yamllint .claude/config/triggers.yml
```

### Common Patterns

**Pattern 1: Agent Not Doing What You Want**
1. Read agent instructions.md
2. Check agent.yml configuration
3. Review relevant rule file
4. Check trigger configuration
5. Test with explicit keyword

**Pattern 2: System Too Intrusive**
1. Review metrics (which agents activate most)
2. Adjust thresholds for frequent ones
3. Add bypass for specific scenarios
4. Consider disabling least useful agent

**Pattern 3: Missing Functionality**
1. Check if existing agent can be extended
2. If yes: Update instructions.md and checklist
3. If no: Create new agent following guide above

---

## Change Log

### Version 1.0.0 (2025-11-19)
- Initial Phase 2 release
- 3 agents implemented
- 4 rules created
- 3 hooks configured
- 11 triggers defined
- Full test coverage

---

**Document Version**: 1.0.0
**Last Updated**: 2025-11-19
**Maintained By**: Claude Code Team
