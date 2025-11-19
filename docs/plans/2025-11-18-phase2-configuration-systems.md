# Phase 2 Implementation Plan: Configuration Systems for Process Discipline

**Created:** 2025-11-18
**Objective:** Implement configuration systems that enforce debugging methodology, ensure consistency, and maintain quality through agents and rules

## Success Metrics
- [ ] 90% of bugs caught before code execution
- [ ] Similar tasks follow identical patterns
- [ ] 50% reduction in Claude redirection needed
- [ ] Debugging follows 6-step methodology consistently
- [ ] Language/domain skills activated appropriately

## Implementation Tasks

### Task 1: Analyze Existing Configurations
**Size:** Small (30 mins)
**Dependencies:** None
**Parallel:** Can run with Tasks 2-3

**Steps:**
1. Read obra's `.claude/` configuration structure
2. Read carlo's configuration files and agent definitions
3. Read moai's configuration and agent patterns
4. Document configuration patterns in `analysis/config-patterns.md`
5. Identify reusable patterns for rules and agents

**Acceptance:** Document with configuration patterns from all three frameworks

---

### Task 2: Create System Rules Framework
**Size:** Medium (1 hour)
**Dependencies:** None
**Parallel:** Can run with Tasks 1, 3

**Steps:**
1. Create `.claude/rules/debugging-methodology.md`
   - Define 6-step process: reproduce → isolate → hypothesis → test → fix → verify
   - Add strong nudges for each step
2. Create `.claude/rules/consistency-patterns.md`
   - Define pattern matching requirements
   - Add nudges for checking previous similar tasks
3. Create `.claude/rules/quality-standards.md`
   - Define code quality checks
   - Documentation requirements
   - Test coverage expectations
4. Create `.claude/rules/skill-activation.md`
   - Remind to check for applicable skills
   - Enforce moai skill usage for Python/TypeScript

**Acceptance:** Four rule files that provide framework without blocking

---

### Task 3: Define Agent Specifications
**Size:** Small (30 mins)
**Dependencies:** None
**Parallel:** Can run with Tasks 1-2

**Steps:**
1. Create `docs/agent-specifications.md`
2. Document debug-agent requirements:
   - Enforce 6-step methodology
   - Use Claude model for reasoning
   - Keyword triggers: "debug", "fix", "error", "failing"
3. Document consistency-agent requirements:
   - Pattern matching against previous tasks
   - Use Haiku for efficiency
   - Keyword triggers: "implement", "add", "create feature"
4. Document quality-agent requirements:
   - Post-implementation review
   - Use Claude model for thoroughness
   - Trigger after Edit/Write operations

**Acceptance:** Clear specifications for all three agents

---

### Task 4: Implement Debug Agent
**Size:** Large (2 hours)
**Dependencies:** Tasks 1, 2, 3
**Parallel:** Can run with Tasks 5-6

**Steps:**
1. Create `.claude/agents/debug-agent/agent.yml`
   - Set model to Claude
   - Define activation keywords
   - Set execution mode
2. Create `.claude/agents/debug-agent/instructions.md`
   - Embed 6-step methodology
   - Add examples of each step
   - Include failure modes to avoid
3. Create test scenario in `tests/debug-agent-test.md`
4. Test with sample debugging task
5. Refine based on test results

**Acceptance:** Debug agent enforces methodology on test case

---

### Task 5: Implement Consistency Agent
**Size:** Large (2 hours)
**Dependencies:** Tasks 1, 2, 3
**Parallel:** Can run with Tasks 4, 6

**Steps:**
1. Create `.claude/agents/consistency-agent/agent.yml`
   - Set model to Haiku
   - Define activation keywords
   - Set pattern-matching mode
2. Create `.claude/agents/consistency-agent/instructions.md`
   - Define pattern recognition logic
   - Add memory/context checking
   - Include examples of pattern reuse
3. Create `.claude/agents/consistency-agent/patterns/` directory
   - Add common patterns as reference
4. Create test scenario in `tests/consistency-agent-test.md`
5. Test with duplicate task types
6. Refine pattern matching logic

**Acceptance:** Agent identifies and enforces pattern reuse

---

### Task 6: Implement Quality Agent
**Size:** Large (2 hours)
**Dependencies:** Tasks 1, 2, 3
**Parallel:** Can run with Tasks 4-5

**Steps:**
1. Create `.claude/agents/quality-agent/agent.yml`
   - Set model to Claude
   - Define post-implementation triggers
   - Set review mode
2. Create `.claude/agents/quality-agent/instructions.md`
   - Define review checklist
   - Add code quality standards
   - Include documentation requirements
3. Create `.claude/agents/quality-agent/checklist.md`
   - Tests written/passing?
   - Documentation updated?
   - Error handling present?
   - Performance considerations?
4. Create test scenario in `tests/quality-agent-test.md`
5. Test with completed implementation
6. Refine checklist based on results

**Acceptance:** Agent provides actionable quality feedback

---

### Task 7: Create Integration Hooks
**Size:** Medium (1 hour)
**Dependencies:** Tasks 4, 5, 6
**Parallel:** No

**Steps:**
1. Create `.claude/hooks/pre-implementation.yml`
   - Check for applicable skills
   - Trigger consistency agent if needed
2. Create `.claude/hooks/post-error.yml`
   - Trigger debug agent on errors
   - Enforce methodology before fixes
3. Create `.claude/hooks/post-implementation.yml`
   - Trigger quality agent after changes
   - Generate review report
4. Test hooks with obra workflow
5. Ensure no conflicts with existing skills

**Acceptance:** Hooks activate agents at appropriate times

---

### Task 8: Implement Trigger System
**Size:** Medium (1 hour)
**Dependencies:** Tasks 4, 5, 6, 7
**Parallel:** Can run with Task 9

**Steps:**
1. Create `.claude/config/triggers.yml`
   - Map keywords to agents
   - Define fallback patterns
   - Set priority ordering
2. Test keyword triggers:
   - "debug this test failure" → debug agent
   - "implement user auth" → consistency agent
   - "add login feature" → consistency + quality
3. Test tool-based triggers:
   - Bash error → debug agent
   - Multiple Edits → quality agent
4. Document trigger precedence
5. Handle edge cases (multiple triggers)

**Acceptance:** Correct agents activate on keywords/tools

---

### Task 9: Build Measurement Framework
**Size:** Medium (1 hour)
**Dependencies:** Tasks 4, 5, 6
**Parallel:** Can run with Task 8

**Steps:**
1. Create `.claude/metrics/tracking.yml`
   - Define metrics to track
   - Set collection points
2. Create `scripts/analyze-metrics.py`
   - Bug catch rate calculator
   - Pattern reuse analyzer
   - Redirection counter
3. Add metric collection to agents:
   - Debug agent logs bugs caught
   - Consistency agent logs pattern reuse
   - Quality agent logs issues found
4. Create `docs/metrics-dashboard.md` template
5. Run baseline measurement

**Acceptance:** Metrics collected and displayed

---

### Task 10: Integration Testing
**Size:** Large (2 hours)
**Dependencies:** Tasks 1-9
**Parallel:** No

**Steps:**
1. Create `tests/integration/full-workflow.md`
2. Test scenario 1: Bug fix workflow
   - Trigger debug agent
   - Follow methodology
   - Verify quality review
3. Test scenario 2: Feature implementation
   - Trigger consistency check
   - Reuse patterns
   - Quality review
4. Test scenario 3: Obra integration
   - Start with /superpowers:write-plan
   - Verify agents enhance workflow
   - Check no conflicts
5. Document any issues found
6. Refine agent interactions

**Acceptance:** All scenarios complete without conflicts

---

### Task 11: Create Rollback Plan
**Size:** Small (30 mins)
**Dependencies:** Task 10
**Parallel:** Can run with Task 12

**Steps:**
1. Create `docs/rollback-procedure.md`
2. Document how to disable each agent
3. Document how to remove hooks
4. Document how to revert rules
5. Create `scripts/disable-phase2.sh`
6. Test rollback procedure
7. Ensure Phase 1 config remains intact

**Acceptance:** Can disable Phase 2 in <2 minutes

---

### Task 12: Documentation Package
**Size:** Medium (1 hour)
**Dependencies:** Tasks 1-10
**Parallel:** Can run with Task 11

**Steps:**
1. Create `PHASE2_README.md`
   - Overview of configuration system
   - How agents work together
   - Trigger reference
   - Troubleshooting guide
2. Update `CONFIGURATION_DECISIONS.md`
   - Document Phase 2 choices
   - Rationale for each agent
   - Trade-offs accepted
3. Create `docs/phase2-handoff.md`
   - Current state
   - What was implemented
   - How to modify/extend
4. Create quick reference card
5. Add examples of each agent in action

**Acceptance:** New user can understand system in 10 mins

---

### Task 13: Performance Baseline
**Size:** Small (30 mins)
**Dependencies:** Tasks 1-12
**Parallel:** No

**Steps:**
1. Run typical workflow without Phase 2
2. Measure token usage, time, redirections
3. Run same workflow with Phase 2
4. Compare metrics
5. Document in `analysis/phase2-performance.md`
6. Calculate cost impact
7. Verify success metrics

**Acceptance:** Metrics show improvement or acceptable trade-off

---

### Task 14: Phase 2.5 Preparation
**Size:** Small (30 mins)
**Dependencies:** Task 13
**Parallel:** No

**Steps:**
1. Create `docs/plans/phase2.5-config-mcp-analysis.md`
2. List configuration files to analyze:
   - obra's rules, commands, settings
   - carlo's Haiku configs, MCP setup
   - moai's Alfred config, delegation setup
3. List MCPs to investigate:
   - Filesystem, memory, browser tools
   - Any unique integrations
4. Define evaluation criteria
5. Set timeline for Phase 2.5

**Acceptance:** Clear plan for configuration/MCP deep dive

---

## Execution Order

### Week 1: Foundation
**Monday-Tuesday:**
- Tasks 1, 2, 3 (in parallel) - 2 hours
- Tasks 4, 5, 6 (in parallel) - 2 hours

**Wednesday-Thursday:**
- Task 7 - 1 hour
- Tasks 8, 9 (in parallel) - 1 hour
- Task 10 - 2 hours

**Friday:**
- Tasks 11, 12 (in parallel) - 1.5 hours
- Task 13 - 30 mins
- Task 14 - 30 mins

**Total:** ~10 hours of focused work

## Risk Mitigation

### Risk 1: Agent Conflicts
- **Mitigation:** Test each agent independently first
- **Fallback:** Disable conflicting agent temporarily

### Risk 2: Performance Degradation
- **Mitigation:** Use Haiku for consistency agent
- **Fallback:** Reduce agent activation frequency

### Risk 3: Obra Workflow Disruption
- **Mitigation:** Hooks only enhance, never block
- **Fallback:** Quick disable via rollback script

### Risk 4: Over-Engineering
- **Mitigation:** Start with minimal viable agents
- **Fallback:** Simplify to rules-only approach

## Dependencies

- Existing Phase 1 configuration (complete ✓)
- Access to all three framework repositories
- Claude API access for agents
- Test environment for validation

## Notes

- Agents use "very strong nudges" not hard blocks
- Strategic mix: Haiku for efficiency, Claude for complex reasoning
- System rules provide framework, agents execute within it
- All changes complement obra superpowers workflow
- Phase 2.5 will analyze configuration files and MCPs separately

---

**Ready for execution:** Start with Tasks 1, 2, 3 in parallel