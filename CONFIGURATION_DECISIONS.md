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
