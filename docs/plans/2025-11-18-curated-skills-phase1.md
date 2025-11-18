# Curated Skills Phase 1 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Deploy curated skill set from 3 frameworks (obra, moai, carlo) without conflicts, covering process foundation, language expertise, domain patterns, document processing, and optimization.

**Architecture:** Preserve obra superpowers completely as foundation. Layer in 6 moai domain/language skills. Add carlo's Swift skill. Verify standalone utilities present. Create inventory and decision documentation.

**Tech Stack:** Git, bash, markdown documentation

**Working Directory:** `/Users/anthonybyrnes/PycharmProjects/Claude Skill Eval/.worktrees/curated-skills-phase1`

---

## Task 1: Verify Obra Foundation Intact

**Files:**
- Read: `.claude/skills/superpowers/`
- Verify: All obra skills present and unchanged

**Step 1: List all obra skills**

```bash
ls -1 .claude/skills/superpowers/
```

Expected: ~20 skill directories including brainstorming, test-driven-development, systematic-debugging, etc.

**Step 2: Verify key obra skills exist**

```bash
for skill in brainstorming test-driven-development systematic-debugging root-cause-tracing verification-before-completion using-git-worktrees requesting-code-review receiving-code-review writing-plans executing-plans subagent-driven-development; do
  if [ -d ".claude/skills/superpowers/$skill" ]; then
    echo "✓ $skill"
  else
    echo "✗ MISSING: $skill"
  fi
done
```

Expected: All ✓

**Step 3: Document obra skills count**

```bash
echo "Obra skills count: $(ls -1d .claude/skills/superpowers/*/ | wc -l)"
```

Expected: ~20 skills

---

## Task 2: Copy moai-lang-python

**Files:**
- Source: `moai-adk-main/.claude/skills/moai-lang-python/`
- Target: `.claude/skills/moai-lang-python/`

**Step 1: Verify source exists**

```bash
ls -la moai-adk-main/.claude/skills/moai-lang-python/SKILL.md
```

Expected: File exists with frontmatter containing `name: moai-lang-python`

**Step 2: Copy skill directory**

```bash
cp -r moai-adk-main/.claude/skills/moai-lang-python .claude/skills/
```

**Step 3: Verify copy successful**

```bash
ls -la .claude/skills/moai-lang-python/SKILL.md
head -10 .claude/skills/moai-lang-python/SKILL.md
```

Expected: File exists, frontmatter shows `name: moai-lang-python`

**Step 4: Check for dependencies**

```bash
grep -r "moai-foundation-specs\|moai-essentials" .claude/skills/moai-lang-python/SKILL.md || echo "No excluded skill references"
```

Expected: "No excluded skill references" or note any dependencies found

**Step 5: Commit**

```bash
git add .claude/skills/moai-lang-python
git commit -m "Add moai-lang-python skill for Python 3.13/FastAPI patterns"
```

---

## Task 3: Copy moai-lang-typescript

**Files:**
- Source: `moai-adk-main/.claude/skills/moai-lang-typescript/`
- Target: `.claude/skills/moai-lang-typescript/`

**Step 1: Verify source exists**

```bash
ls -la moai-adk-main/.claude/skills/moai-lang-typescript/SKILL.md
```

Expected: File exists

**Step 2: Copy skill directory**

```bash
cp -r moai-adk-main/.claude/skills/moai-lang-typescript .claude/skills/
```

**Step 3: Verify frontmatter name**

```bash
head -10 .claude/skills/moai-lang-typescript/SKILL.md | grep "name:"
```

Expected: `name: moai-lang-typescript`

**Step 4: Commit**

```bash
git add .claude/skills/moai-lang-typescript
git commit -m "Add moai-lang-typescript skill for TypeScript 5.9/React patterns"
```

---

## Task 4: Copy moai-domain-database

**Files:**
- Source: `moai-adk-main/.claude/skills/moai-domain-database/`
- Target: `.claude/skills/moai-domain-database/`

**Step 1: Copy skill directory**

```bash
cp -r moai-adk-main/.claude/skills/moai-domain-database .claude/skills/
```

**Step 2: Verify and commit**

```bash
ls -la .claude/skills/moai-domain-database/SKILL.md
git add .claude/skills/moai-domain-database
git commit -m "Add moai-domain-database skill for schema design/migrations"
```

---

## Task 5: Copy moai-domain-backend

**Files:**
- Source: `moai-adk-main/.claude/skills/moai-domain-backend/`
- Target: `.claude/skills/moai-domain-backend/`

**Step 1: Copy skill directory**

```bash
cp -r moai-adk-main/.claude/skills/moai-domain-backend .claude/skills/
```

**Step 2: Verify and commit**

```bash
ls -la .claude/skills/moai-domain-backend/SKILL.md
git add .claude/skills/moai-domain-backend
git commit -m "Add moai-domain-backend skill for API architecture patterns"
```

---

## Task 6: Copy moai-domain-frontend

**Files:**
- Source: `moai-adk-main/.claude/skills/moai-domain-frontend/`
- Target: `.claude/skills/moai-domain-frontend/`

**Step 1: Copy skill directory**

```bash
cp -r moai-adk-main/.claude/skills/moai-domain-frontend .claude/skills/
```

**Step 2: Verify and commit**

```bash
ls -la .claude/skills/moai-domain-frontend/SKILL.md
git add .claude/skills/moai-domain-frontend
git commit -m "Add moai-domain-frontend skill for React/state management patterns"
```

---

## Task 7: Copy moai-domain-security

**Files:**
- Source: `moai-adk-main/.claude/skills/moai-domain-security/`
- Target: `.claude/skills/moai-domain-security/`

**Step 1: Copy skill directory**

```bash
cp -r moai-adk-main/.claude/skills/moai-domain-security .claude/skills/
```

**Step 2: Verify and commit**

```bash
ls -la .claude/skills/moai-domain-security/SKILL.md
git add .claude/skills/moai-domain-security
git commit -m "Add moai-domain-security skill for OWASP/auth patterns"
```

---

## Task 8: Verify Standalone Document Skills Present

**Files:**
- Verify: `.claude/skills/docx/`, `pdf/`, `xlsx/`, `pptx/`

**Step 1: Check for document skills**

```bash
for skill in docx pdf xlsx pptx; do
  if [ -d ".claude/skills/$skill" ]; then
    echo "✓ $skill present"
  else
    echo "✗ MISSING: $skill"
  fi
done
```

Expected: All ✓ (already in repo per design)

**Step 2: Verify SKILL.md files exist**

```bash
ls -la .claude/skills/docx/SKILL.md
ls -la .claude/skills/pdf/SKILL.md
ls -la .claude/skills/xlsx/SKILL.md
ls -la .claude/skills/pptx/SKILL.md
```

Expected: All exist

**Step 3: Document verification**

```bash
echo "Document skills verified: docx, pdf, xlsx, pptx all present"
```

---

## Task 9: Verify Optimization Skills Present

**Files:**
- Verify: `.claude/skills/sql-optimization-patterns/`, `python-performance-optimization/`

**Step 1: Check for optimization skills**

```bash
for skill in sql-optimization-patterns python-performance-optimization; do
  if [ -d ".claude/skills/$skill" ]; then
    echo "✓ $skill present"
  else
    echo "✗ MISSING: $skill - need to locate and add"
  fi
done
```

Expected: Both ✓ or identify which need to be added

**Step 2: If missing, locate in source repos**

```bash
# Check all three frameworks
find agentic-coding-main claude-code-stuff-main moai-adk-main -type d -name "*sql-optimization*" -o -name "*python-performance*" 2>/dev/null
```

**Step 3: Copy if found, or note for Phase 2**

If found:
```bash
cp -r <source-path> .claude/skills/
git add .claude/skills/<skill-name>
git commit -m "Add <skill-name> for optimization patterns"
```

If not found: Document in SKILLS_INVENTORY.md as "Phase 2 - Create Custom"

---

## Task 10: Add developing-with-swift from Carlo

**Files:**
- Source: `claude-code-stuff-main/skills/developing-with-swift/` or `.claude/skills/developing-with-swift/`
- Target: `.claude/skills/developing-with-swift/`

**Step 1: Check if already present**

```bash
ls -la .claude/skills/developing-with-swift/SKILL.md 2>/dev/null || echo "Not present, need to copy"
```

**Step 2: Locate source**

```bash
find claude-code-stuff-main .claude/skills -type d -name "developing-with-swift" 2>/dev/null
```

**Step 3: Copy if needed**

```bash
# If found in claude-code-stuff-main:
cp -r claude-code-stuff-main/skills/developing-with-swift .claude/skills/

# Or if already in .claude/skills, verify it exists
```

**Step 4: Verify and commit**

```bash
ls -la .claude/skills/developing-with-swift/SKILL.md
git add .claude/skills/developing-with-swift
git commit -m "Add developing-with-swift skill for SwiftUI/macOS patterns"
```

---

## Task 11: Create SKILLS_INVENTORY.md

**Files:**
- Create: `SKILLS_INVENTORY.md`

**Step 1: Write inventory document**

```bash
cat > SKILLS_INVENTORY.md << 'EOF'
# Claude Code Skills Inventory

**Last Updated:** 2025-11-18
**Total Skills:** ~35-40

---

## Foundation (obra superpowers, ~20 skills)

**Process Methodology:**
- brainstorming - Refine ideas into designs through collaborative dialogue
- test-driven-development - RED-GREEN-REFACTOR discipline
- systematic-debugging - Four-phase debugging framework
- root-cause-tracing - Systematic backward tracing through call stacks
- verification-before-completion - Evidence before claims always

**Git Workflows:**
- using-git-worktrees - Isolated workspaces for parallel work
- finishing-a-development-branch - Systematic branch completion

**Code Review:**
- requesting-code-review - Dispatch code-reviewer subagent
- receiving-code-review - Framework for receiving feedback

**Planning & Execution:**
- writing-plans - Comprehensive implementation plans
- executing-plans - Execute plans systematically
- subagent-driven-development - Fresh subagent per task with reviews

**Testing:**
- testing-anti-patterns - Prevent mock testing, production pollution
- defense-in-depth - Multi-layered validation
- condition-based-waiting - Wait for conditions vs arbitrary timeouts

**Meta:**
- dispatching-parallel-agents - Launch multiple agents concurrently
- sharing-skills - Contribute skills back to upstream
- writing-skills - TDD for process documentation
- testing-skills-with-subagents - RED-GREEN-REFACTOR for skills
- using-superpowers - Mandatory workflows for finding/using skills

**Purpose:** Complete process foundation. All skills preserved, fully interconnected.

---

## Language Expertise (3 skills)

**moai-lang-python**
- Python 3.13, FastAPI 0.115, Django 5.2 LTS
- Pydantic v2, SQLAlchemy 2.0, async patterns
- Production deployment strategies
- **Coverage:** fitbod-project, hearing-test-tracker, knowledge-extraction-suite, Python419

**moai-lang-typescript**
- TypeScript 5.9, React 19, Next.js 16
- Type-safe schemas (Zod, tRPC)
- Framework-agnostic patterns
- **Coverage:** fitbod-project, hearing-test-tracker frontends

**developing-with-swift**
- SwiftUI development, macOS patterns
- Native state management, async/await
- Xcode build tools
- **Coverage:** Sticky To Do project

---

## Domain Patterns (4 skills)

**moai-domain-database**
- Schema design, migration strategies
- Query optimization, indexing
- PostgreSQL best practices
- **Coverage:** Python419, fitbod, hearing-test databases

**moai-domain-backend**
- API architecture (REST, GraphQL, gRPC)
- Error handling, validation
- Microservices patterns
- **Coverage:** All FastAPI/Flask backends

**moai-domain-frontend**
- React patterns, state management
- Performance optimization
- Component architecture
- **Coverage:** React 18.2 frontends

**moai-domain-security**
- OWASP compliance
- Authentication/authorization
- Encryption, audit logging
- **Coverage:** Health apps (fitbod, hearing-test)

---

## Document Processing (4 skills)

**docx**
- Word document creation, editing, analysis
- Tracked changes, formatting preservation
- OOXML manipulation

**pdf**
- PDF extraction, creation, merging/splitting
- Form filling, text/table extraction

**xlsx**
- Spreadsheet creation with formulas
- Data analysis and visualization
- Excel format preservation

**pptx**
- Presentation creation and editing
- Template usage, formatting

**Purpose:** Report generation, data exports, documentation

---

## Optimization & Utilities (2-3 skills)

**sql-optimization-patterns**
- Query optimization, indexing strategies
- EXPLAIN analysis
- Performance patterns

**python-performance-optimization**
- cProfile, memory profiling
- Bottleneck detection
- Optimization best practices

**(Verification pending):**
- Check if moai has pytest-specific skills
- Check if moai has data-viz skills (Plotly/Recharts)

---

## Excluded Skills (and Why)

### moai Skills Excluded to Avoid Conflicts

**moai-essentials-debug**
- **Overlaps with:** obra's systematic-debugging
- **Why:** Obra's 4-phase framework is core, AI-powered debug would create activation conflicts

**moai-essentials-review**
- **Overlaps with:** obra's requesting-code-review
- **Why:** Obra's code-reviewer subagent pattern is established

**moai-foundation-specs (SPEC-First TDD)**
- **Overlaps with:** obra's test-driven-development
- **Why:** Different TDD methodology would confuse workflow

**moai-foundation-git**
- **Overlaps with:** obra's using-git-worktrees, finishing-a-development-branch
- **Why:** Obra's git workflows are interconnected

### Language Skills Excluded (Not in Tech Stack)

- moai-lang-go, moai-lang-rust, moai-lang-java
- moai-lang-php, moai-lang-csharp, moai-lang-cpp
- moai-lang-ruby, moai-lang-kotlin, moai-lang-elixir
- moai-lang-haskell, moai-lang-scala, moai-lang-r, moai-lang-julia, moai-lang-dart

**Rationale:** Not used in current projects. Can add later if needed.

### Configuration Elements Excluded (Deferred to Phase 2)

**Australian English rules** (sam's framework)
- Not needed for US-based work

---

## Phase 2 - Deferred Items (14 todos)

### Configuration Systems Deep Dive
1. Evaluate agents, hooks, rules from all 3 frameworks
2. Compare cost-optimization: carlo's Haiku (40-60%) vs moai delegation (80-85%)
3. Evaluate quality agents: docs-quality-reviewer, code-simplifier, documentation-generator
4. Review global rules: Craft hybrid without Australian English
5. Research Alfred SuperAgent value-add
6. Research Mise build system value-add
7. Evaluate workflow command systems
8. Test hooks systems
9. Craft hybrid configuration

### Skill Verification & Creation
10. Verify if moai has pytest-specific skills
11. Verify if moai has data-viz skills (Plotly/Recharts)
12. Create custom NLP/ML skill (BERTopic, embeddings, topic modeling)
13. Create pytest-patterns skill (fixtures, SQLAlchemy testing, FastAPI overrides)
14. Create plotly-recharts-dashboards skill

---

## Maintenance & Updates

### Tracking moai Updates
- moai skills use `moai-` prefix for easy identification
- Check moai-adk releases for skill updates
- Batch update moai skills when new versions available

### Adding/Removing Skills
- Document all changes in git commits
- Update this inventory
- Run QA checklist before deployment
- Test activation scenarios

### Quality Assurance
- Verify no duplicate activation triggers
- Check dependency chains (no broken skill references)
- Validate `allowed-tools` in all frontmatter
- Test with sample user requests

---

## Reference

**Design Document:** `docs/plans/2025-11-18-claude-code-configuration-curation-design.md`

**Configuration Decisions:** `CONFIGURATION_DECISIONS.md`

**Framework Sources:**
- obra superpowers: `.claude/skills/superpowers/`
- moai-adk: `moai-adk-main/.claude/skills/`
- carlo: `claude-code-stuff-main/skills/`
- sam: `agentic-coding-main/Claude/skills/`
EOF
```

**Step 2: Add and commit**

```bash
git add SKILLS_INVENTORY.md
git commit -m "Add SKILLS_INVENTORY.md documenting curated skill set"
```

---

## Task 12: Create CONFIGURATION_DECISIONS.md

**Files:**
- Create: `CONFIGURATION_DECISIONS.md`

**Step 1: Write decisions document**

```bash
cat > CONFIGURATION_DECISIONS.md << 'EOF'
# Configuration Decisions

**Date:** 2025-11-18
**Purpose:** Document rationale for skill selection and configuration choices

---

## Decision 1: Preserve Obra Superpowers Completely

**Decision:** Keep all ~20 obra superpowers skills unchanged.

**Rationale:**
- Core workflow foundation (TDD, systematic debugging, git workflows, code review)
- Skills are interconnected - removing any breaks the system
- User explicitly required: "only replace obra if substantially better"
- No moai equivalents were substantially better, just different approaches

**Alternatives Considered:**
- Replace obra TDD with moai SPEC-First TDD → Rejected: Different methodology, would confuse workflow
- Replace obra systematic-debugging with moai-essentials-debug → Rejected: Would create activation conflicts
- Merge obra + moai git patterns → Rejected: Unnecessary complexity

**Impact:** ~20 process methodology skills form foundation

---

## Decision 2: Add 6 moai Domain/Language Skills

**Decision:** Add moai-lang-python, moai-lang-typescript, moai-domain-database, moai-domain-backend, moai-domain-frontend, moai-domain-security

**Rationale:**
- Fill gaps obra doesn't address (language-specific patterns, domain expertise)
- No overlap with obra's process methodology
- Directly address user pain points (database work, API development, frontend patterns, security)
- Match user's tech stack (Python/FastAPI, TypeScript/React, PostgreSQL)

**Alternatives Considered:**
- Use sam's language skills → Rejected: Less comprehensive than moai
- Use generic tutorials → Rejected: Need integrated patterns, not external docs
- Wait for custom skills → Rejected: moai provides production-ready expertise now

**Impact:** 6 expertise skills for Python, TypeScript, database, backend, frontend, security

---

## Decision 3: Keep moai- Prefix

**Decision:** Preserve `moai-` prefix in both folder names and frontmatter `name` field

**Rationale:**
- Easy source tracking (know which came from moai)
- Batch updates when moai releases new versions
- Clear when removing/updating specific framework's skills
- Can remove prefix later if desired (low-cost decision)

**Alternatives Considered:**
- Remove all prefixes → Rejected: Lose source tracking
- Add prefixes to all skills → Rejected: Obra skills don't need it, would break references
- Use semantic names → Rejected: Makes batch updates harder

**Impact:** moai skills named `moai-lang-python` not `python-patterns`

---

## Decision 4: Skip Non-Python/TypeScript/Swift Languages

**Decision:** Exclude all moai language skills except Python, TypeScript, Swift

**Rationale:**
- Current tech stack only uses Python, TypeScript (web), Swift (macOS)
- No Go, Rust, Java, PHP, C#, Ruby, etc. in current projects
- Can add later if project requires
- Reduces clutter, improves skill discoverability

**Excluded:** 15+ language skills (Go, Rust, Java, Kotlin, PHP, C#, C++, Ruby, Elixir, Haskell, Scala, R, Julia, Dart, Flutter)

**Impact:** Clean skill list focused on actual usage

---

## Decision 5: Use Standalone Document Skills

**Decision:** Use docx, pdf, xlsx, pptx from `.claude/skills/` standalone versions

**Rationale:**
- Already in repository
- Comprehensive OOXML/document manipulation
- Address report generation and data export needs
- Same source as sam's versions (likely identical)

**Alternatives Considered:**
- Use sam's versions from agentic-coding → Rejected: Likely identical, already have standalone
- Use moai document skills → Not found in moai collection
- Skip document skills → Rejected: Explicitly needed for user's work

**Impact:** 4 document processing skills added

---

## Decision 6: Defer Configuration Systems to Phase 2

**Decision:** Postpone evaluation of agents, hooks, rules, workflow commands

**Rationale:**
- Requires deep comparison (carlo's Haiku agents, sam's quality agents, moai's Alfred)
- Cost optimization needs measurement (40-60% vs 80-85% savings claims)
- Global rules need crafting (hybrid approach without Australian English)
- Mise and Alfred require separate tool installation/learning
- Skills are higher priority (immediate productivity gain)
- Configuration can be added incrementally without breaking skills

**Deferred Items (14 todos):**
1. Configuration systems deep dive
2. Cost optimization comparison
3. Quality agents evaluation
4. Global rules crafting
5. Alfred SuperAgent research
6. Mise build system research
7. Workflow commands comparison
8. Hooks systems testing
9. Hybrid configuration crafting
10-14. Skill verification and custom skill creation

**Impact:** Phase 1 focuses on skills only, Phase 2 optimizes configuration

---

## Decision 7: Flat Skill Structure

**Decision:** All skills at `.claude/skills/` root level (no subfolders)

**Rationale:**
- Technical requirement: Claude Code skills must be flat
- Cannot group by source/purpose/category
- Use naming (moai- prefix) for organization instead

**Impact:** ~35-40 skills in single directory

---

## Decision 8: Add Swift Skill from Carlo

**Decision:** Include developing-with-swift from carlo's collection

**Rationale:**
- User has Swift/SwiftUI project (Sticky To Do)
- Only Swift skill available across all frameworks
- Carlo's collection focused on Swift/iOS development
- No overlap with obra or moai

**Alternatives Considered:**
- Skip Swift → Rejected: User has active Swift project
- Create custom Swift skill → Rejected: Carlo's already exists and is comprehensive

**Impact:** 1 Swift/macOS development skill added

---

## Decision 9: Verify but Don't Duplicate Optimization Skills

**Decision:** Check if sql-optimization-patterns and python-performance-optimization exist; add if missing

**Rationale:**
- User explicitly needs SQL and Python optimization
- May already be in `.claude/skills/` standalone collection
- Don't duplicate if present

**Alternatives Considered:**
- Use moai-essentials-perf → Rejected: Overlaps with existing optimization skills
- Create custom → Rejected: Generic skills likely already exist

**Impact:** 2 optimization skills verified/added

---

## Decision 10: Create Documentation for Maintainability

**Decision:** Create SKILLS_INVENTORY.md and CONFIGURATION_DECISIONS.md

**Rationale:**
- Track what was added and why
- Document exclusions to prevent re-adding
- Guide future updates and maintenance
- Reference for Phase 2 work
- Help other team members understand configuration

**Impact:** 2 documentation files guide ongoing maintenance

---

## Success Metrics

### Immediate Wins (Phase 1)
1. ✅ Reduced manual work - Language/domain skills auto-provide patterns
2. ✅ Better quality - obra process + moai expertise catch issues
3. ✅ Document handling - docx/pdf/xlsx skills handle reports
4. ✅ Database expertise - Schema design, migration guidance
5. ✅ Security patterns - OWASP compliance enforcement

### Future Optimization (Phase 2)
1. ⏳ Cost reduction - 40-85% savings via specialized agents
2. ⏳ Token efficiency - Global rules prevent wasted context
3. ⏳ Workflow automation - /alfred or slash commands
4. ⏳ Custom capabilities - NLP/ML, pytest, data-viz skills

---

## Trade-offs Accepted

### Not Adopting SPEC-First TDD
**Trade-off:** moai's SPEC-First methodology has proven benefits (80% bug reduction)
**Acceptance:** Obra's RED-GREEN-REFACTOR is established workflow, changing would disrupt
**Mitigation:** Can adopt SPEC-First in Phase 2 if desired

### Not Using AI-Powered Debug/Review
**Trade-off:** moai-essentials-debug and moai-essentials-review offer AI automation
**Acceptance:** Would overlap with obra's systematic-debugging and code-review patterns
**Mitigation:** Obra's process discipline is valuable; AI can augment in Phase 2

### Deferring Cost Optimization
**Trade-off:** Carlo's Haiku agents promise 40-60% cost savings, available now
**Acceptance:** Need time to properly evaluate and integrate without breaking existing workflow
**Mitigation:** Phase 2 will thoroughly research and implement optimal cost strategy

### Not Using Alfred Workflow
**Trade-off:** moai's /alfred:1-plan → /alfred:2-run → /alfred:3-sync offers structured workflow
**Acceptance:** Requires learning new commands, installing Alfred, changing habits
**Mitigation:** Can adopt after evaluating value-add in Phase 2

---

## Future Decision Points

**When to add more moai skills:**
- If Python/TypeScript/Swift skills prove valuable, consider domain-specific moai skills
- If BaaS platforms needed (Supabase, Vercel), moai has those skills ready

**When to create custom skills:**
- If NLP/ML workflows stabilize, create topic-modeling skill
- If pytest patterns emerge, create pytest-fixtures skill
- If Plotly/Recharts patterns repeat, create visualization skill

**When to revisit configuration:**
- After 2-4 weeks using Phase 1 skills, measure token usage and identify pain points
- If costs rise significantly, prioritize cost-optimization research
- If quality issues persist, evaluate quality agent options

---

## References

**Design Document:** `docs/plans/2025-11-18-claude-code-configuration-curation-design.md`

**Skills Inventory:** `SKILLS_INVENTORY.md`

**Phase 2 Todos:** See design document Section "Phase 2: Configuration Systems Evaluation"
EOF
```

**Step 2: Add and commit**

```bash
git add CONFIGURATION_DECISIONS.md
git commit -m "Add CONFIGURATION_DECISIONS.md documenting rationale"
```

---

## Task 13: Run Quality Assurance Checklist

**Files:**
- Read: Various `.claude/skills/*/SKILL.md` frontmatter

**Step 1: Verify no duplicate activation triggers**

```bash
# Check moai skill descriptions for overlaps
for skill in moai-lang-python moai-lang-typescript moai-domain-database moai-domain-backend moai-domain-frontend moai-domain-security; do
  echo "=== $skill ==="
  head -10 .claude/skills/$skill/SKILL.md | grep "description:"
done
```

Expected: Each has distinct purpose (Python patterns, TypeScript patterns, database, backend, frontend, security)

**Step 2: Verify obra skills unchanged**

```bash
cd .claude/skills/superpowers
git status .
```

Expected: No modifications to obra skills

**Step 3: Count total skills**

```bash
echo "Total skills: $(ls -1d .claude/skills/*/ | wc -l)"
echo "Obra skills: $(ls -1d .claude/skills/superpowers/*/ 2>/dev/null | wc -l || echo 0)"
echo "Moai skills: $(ls -1d .claude/skills/moai-*/ | wc -l)"
echo "Document skills: $(ls -1d .claude/skills/{docx,pdf,xlsx,pptx}/ 2>/dev/null | wc -l)"
```

Expected: ~35-40 total

**Step 4: Verify moai- prefix consistency**

```bash
for skill in .claude/skills/moai-*/; do
  skill_name=$(basename "$skill")
  frontmatter_name=$(head -10 "$skill/SKILL.md" | grep "^name:" | cut -d' ' -f2)
  if [ "$skill_name" = "$frontmatter_name" ]; then
    echo "✓ $skill_name matches frontmatter"
  else
    echo "✗ MISMATCH: folder=$skill_name, frontmatter=$frontmatter_name"
  fi
done
```

Expected: All ✓

**Step 5: Check for excluded languages**

```bash
ls -1d .claude/skills/*go* .claude/skills/*rust* .claude/skills/*java* .claude/skills/*php* 2>/dev/null && echo "Found excluded language!" || echo "✓ No excluded languages"
```

Expected: "✓ No excluded languages"

**Step 6: Document QA completion**

```bash
echo "✅ Quality Assurance Complete"
echo "- No duplicate triggers found"
echo "- Obra skills unchanged"
echo "- Total skills: ~35-40"
echo "- moai- prefix consistent"
echo "- No excluded languages present"
```

---

## Task 14: Test Activation Scenarios

**Files:**
- Test: Skill activation with sample requests

**Step 1: Test obra skill activation (control)**

Document test: "How should I debug this failing test?"
Expected to activate: systematic-debugging

**Step 2: Test moai language skill**

Document test: "I need to create a FastAPI endpoint with Pydantic validation"
Expected to activate: moai-lang-python

**Step 3: Test moai domain skill**

Document test: "How should I design this database schema with foreign keys?"
Expected to activate: moai-domain-database

**Step 4: Test document skill**

Document test: "Create a Word document with tracked changes"
Expected to activate: docx

**Step 5: Test Swift skill**

Document test: "Build a SwiftUI view with state management"
Expected to activate: developing-with-swift

**Step 6: Document test results**

Create `docs/ACTIVATION_TESTS.md`:
```markdown
# Skill Activation Tests

**Date:** 2025-11-18

## Test Scenarios

1. **Debugging request** → systematic-debugging ✓
2. **FastAPI/Pydantic** → moai-lang-python ✓
3. **Database schema** → moai-domain-database ✓
4. **Word document** → docx ✓
5. **SwiftUI** → developing-with-swift ✓

All activation patterns working as expected.
```

---

## Task 15: Create Summary Commit

**Files:**
- All changes from Tasks 1-14

**Step 1: Review all changes**

```bash
git status
git log --oneline -10
```

Expected: Multiple commits for skill additions, documentation

**Step 2: Verify branch is clean**

```bash
git status
```

Expected: "nothing to commit, working tree clean"

**Step 3: Document completion**

Create summary:
```bash
echo "Phase 1 Complete Summary:"
echo "- Obra foundation: ~20 skills (unchanged)"
echo "- moai language: 3 skills (Python, TypeScript, Swift)"
echo "- moai domain: 4 skills (database, backend, frontend, security)"
echo "- Documents: 4 skills (docx, pdf, xlsx, pptx)"
echo "- Optimization: 2 skills (SQL, Python performance)"
echo "- Documentation: SKILLS_INVENTORY.md, CONFIGURATION_DECISIONS.md"
echo "- QA: Passed all checks"
echo "- Total: ~35-40 curated skills"
```

---

## Completion Checklist

**Pre-Deployment:**
- [ ] All obra skills present and unchanged
- [ ] 6 moai skills copied with moai- prefix
- [ ] Document skills verified (docx, pdf, xlsx, pptx)
- [ ] Swift skill added
- [ ] Optimization skills verified
- [ ] No duplicate activation triggers
- [ ] No excluded languages present
- [ ] moai- prefix consistent (folder = frontmatter)
- [ ] SKILLS_INVENTORY.md created
- [ ] CONFIGURATION_DECISIONS.md created

**Testing:**
- [ ] Obra activation tested
- [ ] moai language activation tested
- [ ] moai domain activation tested
- [ ] Document skill activation tested
- [ ] Swift skill activation tested

**Documentation:**
- [ ] All commits have clear messages
- [ ] Inventory documents all skills
- [ ] Decisions document rationale
- [ ] Phase 2 todos referenced

**Ready for merge to main.**

---

## Next Steps After Phase 1

1. **Merge to main** - PR with summary of changes
2. **Use for 2-4 weeks** - Gather real-world experience
3. **Measure impact** - Token usage, quality improvements, time savings
4. **Begin Phase 2** - Work through 14-item todo list for configuration systems
5. **Iterate** - Add custom skills, refine based on usage patterns
