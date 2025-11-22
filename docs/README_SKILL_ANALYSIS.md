# Claude Code Skills: Pattern Analysis Documentation

**Comprehensive analysis of successful skill patterns, anti-patterns, and best practices**

---

## Overview

This analysis examines 20+ Claude Code skills from multiple sources (.claude/skills, skills/, and framework-specific directories) to extract recurring patterns that make skills effective, identify common pitfalls, and establish actionable best practice guidelines.

**Key Finding**: The most successful skills follow a **progressive disclosure architecture** with clear activation patterns, strict tool constraints, and modular documentation.

---

## Documentation Set

### 📚 [SKILL_PATTERNS_ANALYSIS.md](SKILL_PATTERNS_ANALYSIS.md)
**Comprehensive deep-dive analysis** (~20,000 words)

**Contents**:
1. Common Patterns (What Works) - 10 major patterns
2. Anti-Patterns (What to Avoid) - 8 critical mistakes
3. Best Practice Principles - 10 core guidelines
4. Context Management Best Practices
5. Advanced Patterns
6. Quality Assurance Patterns
7. Special Patterns by Skill Type
8. Actionable Guidelines Summary
9. Patterns by Numbers
10. Common Questions

**Use when**: Creating a new skill, reviewing existing skills, understanding the rationale behind patterns

---

### ⚡ [SKILL_PATTERNS_QUICK_REFERENCE.md](SKILL_PATTERNS_QUICK_REFERENCE.md)
**One-page quick reference** (~2,000 words)

**Contents**:
- ✅ DO: Common Patterns That Work
- ❌ DON'T: Anti-Patterns to Avoid
- 📐 Size Guidelines
- 🎯 When to Split Skills
- 📋 Quality Checklist
- 🎨 Style Guide
- 🔧 Common Patterns by Skill Type
- 💡 Quick Decisions
- 🚀 Skill Creation Workflow
- 🎓 Top 10 Skill Success Factors

**Use when**: Quick lookup during skill development, refreshing on standards, rapid decision-making

---

### 🗺️ [SKILL_CREATION_DECISION_TREE.md](SKILL_CREATION_DECISION_TREE.md)
**Interactive flowchart guide** (~5,000 words)

**Contents**:
1. Start Here: Do You Need a New Skill?
2. Step 1: Activation Design
3. Step 2: Scope Definition
4. Step 3: Tool Selection
5. Step 4: Structure Planning
6. Step 5: Documentation Planning
7. Step 6: Writing Style Check
8. Step 7: Quality Validation
9. Step 8: Testing
10. Step 9: Deployment Decision
11. Step 10: Iteration
12. Common Decision Points Quick Reference
13. Emergency Troubleshooting
14. Final Checklist

**Use when**: Creating a new skill from scratch, making decisions at each stage, troubleshooting issues

---

## Quick Navigation

### By Use Case

**Creating a new skill?**
→ Start with [Decision Tree](SKILL_CREATION_DECISION_TREE.md)
→ Reference [Quick Reference](SKILL_PATTERNS_QUICK_REFERENCE.md) during writing
→ Consult [Full Analysis](SKILL_PATTERNS_ANALYSIS.md) for detailed patterns

**Reviewing an existing skill?**
→ Use [Quality Checklist](SKILL_PATTERNS_QUICK_REFERENCE.md#quality-checklist)
→ Check against [Anti-Patterns](SKILL_PATTERNS_ANALYSIS.md#2-anti-patterns-what-to-avoid)
→ Validate with [Quality Gates](SKILL_PATTERNS_ANALYSIS.md#61-validation-framework)

**Looking for a specific pattern?**
→ Check [Quick Reference](SKILL_PATTERNS_QUICK_REFERENCE.md#common-patterns-by-skill-type)
→ Find detailed example in [Full Analysis](SKILL_PATTERNS_ANALYSIS.md)

**Deciding to split a skill?**
→ See [When to Split Skills](SKILL_PATTERNS_QUICK_REFERENCE.md#when-to-split-skills)
→ Review [Scope Definition](SKILL_CREATION_DECISION_TREE.md#step-2-scope-definition)

**Need quick answers?**
→ See [Quick Decisions](SKILL_PATTERNS_QUICK_REFERENCE.md#quick-decisions)
→ See [Common Questions](SKILL_PATTERNS_ANALYSIS.md#10-common-questions)

---

### By Topic

| Topic | Quick Ref | Full Analysis | Decision Tree |
|-------|-----------|---------------|---------------|
| **Activation Patterns** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#activation) | [Section 1.1](SKILL_PATTERNS_ANALYSIS.md#11-skill-activation-patterns) | [Step 1](SKILL_CREATION_DECISION_TREE.md#step-1-activation-design) |
| **Progressive Disclosure** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#structure) | [Section 1.2](SKILL_PATTERNS_ANALYSIS.md#12-progressive-disclosure-architecture) | [Step 4](SKILL_CREATION_DECISION_TREE.md#step-4-structure-planning) |
| **Tool Constraints** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#frontmatter) | [Section 1.3](SKILL_PATTERNS_ANALYSIS.md#13-tool-usage-constraints) | [Step 3](SKILL_CREATION_DECISION_TREE.md#step-3-tool-selection) |
| **Writing Style** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#style-guide) | [Section 1.4](SKILL_PATTERNS_ANALYSIS.md#14-imperative-instruction-style) | [Step 6](SKILL_CREATION_DECISION_TREE.md#step-6-writing-style-check) |
| **File Organization** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#structure) | [Section 3.5](SKILL_PATTERNS_ANALYSIS.md#35-file-organization-patterns) | [Step 4](SKILL_CREATION_DECISION_TREE.md#step-4-structure-planning) |
| **Size Guidelines** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#size-guidelines) | [Section 3.1](SKILL_PATTERNS_ANALYSIS.md#31-skill-size-and-scope-guidelines) | [Step 2](SKILL_CREATION_DECISION_TREE.md#step-2-scope-definition) |
| **Quality Validation** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#quality-checklist) | [Section 6.1](SKILL_PATTERNS_ANALYSIS.md#61-validation-framework) | [Step 7](SKILL_CREATION_DECISION_TREE.md#step-7-quality-validation) |
| **Anti-Patterns** | [Link](SKILL_PATTERNS_QUICK_REFERENCE.md#dont-anti-patterns-to-avoid) | [Section 2](SKILL_PATTERNS_ANALYSIS.md#2-anti-patterns-what-to-avoid) | [Troubleshooting](SKILL_CREATION_DECISION_TREE.md#emergency-troubleshooting) |

---

## Key Findings Summary

### Top 10 Success Patterns

1. **Clear Activation** - Explicit triggers with 3-5 concrete phrases
2. **Progressive Disclosure** - Lean SKILL.md (<5k words), detailed references loaded as needed
3. **Tool Constraints** - Minimum necessary tools explicitly listed
4. **Imperative Instructions** - Direct commands ("Use X"), not suggestions ("You should...")
5. **Concrete Examples** - Real code with good/bad comparisons
6. **Quality Gates** - Verification steps and validation frameworks
7. **Error Handling** - Top 4-5 common issues with solutions
8. **Modular Structure** - Single responsibility, composable with other skills
9. **Token Awareness** - Efficient context usage, subagent delegation
10. **User-Centric** - Solves real problems with clear workflows

### Top 8 Anti-Patterns to Avoid

1. **Scope Creep** - Multiple unrelated capabilities in one skill
2. **Unclear Triggers** - Vague descriptions like "help with coding"
3. **Missing Tool Constraints** - No `allowed-tools` specification
4. **Documentation Duplication** - Same info in SKILL.md and references/
5. **Overly Complex Logic** - Deep nested conditions without structure
6. **Missing Examples** - Abstract instructions without demonstrations
7. **Weak Verification** - No evidence requirements before claims
8. **Second-Person Voice** - "You should..." instead of "Use..."

### Size Guidelines

| Tier | SKILL.md | Complexity | Time |
|------|----------|------------|------|
| Simple | <200 lines | 1-3 | <5 min |
| Standard | 200-500 lines | 4-6 | <15 min |
| Complex | 500+ lines | 7-10 | 20-30 min |

---

## Skills Analyzed

### Document Skills
- **docx** - Word document creation, editing, analysis
- **pdf** - PDF manipulation and form filling
- **xlsx** - Spreadsheet creation, editing, formulas
- **pptx** - Presentation creation and editing

### Development Skills
- **systematic-debugging** - Four-phase debugging framework
- **test-driven-development** - Red-green-refactor discipline
- **verification-before-completion** - Evidence-based completion claims
- **playwright-skill** - Browser automation and testing
- **python-performance-optimization** - Profiling and optimization

### Content Skills
- **collaborative-writing** - Socratic dialogue writing process
- **writing-clearly-and-concisely** - Strunk's Elements of Style
- **article-extractor** - Clean web content extraction
- **tapestry** - Unified content extraction and planning

### Utility Skills
- **brand-guidelines** - Anthropic brand application
- **skill-creator** - Skill development guidance
- **sql-optimization-patterns** - Database query optimization

### Framework Skills
- **moai-alfred-agent-factory** - Intelligent agent generation
- **moai-alfred-*** - Various framework-specific skills

---

## Usage Examples

### Example 1: Creating a Simple Skill

```yaml
# Workflow using Decision Tree

1. Start → Single clear purpose → Yes
2. Activation → Can list 3 triggers → Yes
3. Scope → Single domain, complexity 2 → Simple tier
4. Tools → Need: Bash, Read → List in allowed-tools
5. Structure → <1000 words → SKILL.md only
6. Documentation → Write overview, workflow, 1 example
7. Validation → Run through 4 gates → All pass
8. Testing → 3 test cases → All pass
9. Deploy → Project-specific → .claude/skills/
10. Iterate → Gather feedback → Version 1.0.0
```

### Example 2: Refactoring a Complex Skill

```yaml
# Problem: Skill has 10k words in SKILL.md, users confused

1. Check Anti-Patterns
   → Found: Documentation duplication
   → Found: Overly complex logic
   → Found: Missing decision trees

2. Apply Progressive Disclosure
   → Keep workflow in SKILL.md (1.5k words)
   → Extract API docs to references/ (5k words)
   → Extract examples to examples/ (3k words)

3. Simplify Logic
   → Replace nested conditions with decision table
   → Add flowchart for complex routing
   → Break into sub-phases

4. Enhance Examples
   → Add 2 complete workflows
   → Add good/bad comparisons
   → Show edge case handling

5. Test and Deploy
   → Version 2.0.0 (breaking changes)
   → Update changelog
   → Notify users
```

### Example 3: Deciding Whether to Split

```yaml
# Situation: "web-and-database" skill

Questions from Decision Tree:
Q: Multiple distinct domains?
A: Yes (web scraping + database ops)

Q: Are they tightly related?
A: No (independent concerns)

Q: Different tool requirements?
A: Yes (web needs WebFetch, DB needs different tools)

Q: Do users need both together?
A: Rarely

Decision: SPLIT into two skills
→ web-scraping (Bash, WebFetch, Write)
→ database-optimization (Bash, Read, Write)

Result: Clearer activation, better tool constraints, easier maintenance
```

---

## Statistics

**Skills Analyzed**: 20+
**Total Lines Analyzed**: ~50,000
**Directories Scanned**:
- .claude/skills
- skills/
- agentic-coding-main/Claude/skills
- claude-code-stuff-main/skills
- moai-adk-main/.claude/skills

**Patterns Identified**:
- Success Patterns: 10 major categories
- Anti-Patterns: 8 critical mistakes
- Best Practices: 10 core principles
- Quality Gates: 4 validation levels
- Skill Types: 5 distinct categories

---

## Maintenance

**Last Updated**: 2025-11-18
**Version**: 1.0
**Status**: Initial release

**Future Updates**:
- Additional skill types (as ecosystem grows)
- Framework-specific patterns
- Performance metrics
- User feedback integration

---

## Contributing

Found a pattern not covered? Have feedback on the analysis?

**How to contribute**:
1. Review existing patterns in [Full Analysis](SKILL_PATTERNS_ANALYSIS.md)
2. Check if pattern fits existing categories
3. Document with concrete examples
4. Show why pattern works (or fails)
5. Suggest addition to appropriate section

---

## Related Resources

**Official Documentation**:
- Claude Code Skills Guide
- Claude Code Tool Reference
- TRUST 5 Framework

**Community Resources**:
- Skill Repository Collection
- Skill Templates
- Example Skills

---

## License

This analysis is based on skills from multiple sources with varying licenses:
- Some skills: MIT License
- Some skills: Proprietary (see LICENSE.txt)
- This analysis: Documentation purposes

Always check individual skill licenses before reuse.

---

## Questions?

**Common questions answered in**:
- [Quick Decisions](SKILL_PATTERNS_QUICK_REFERENCE.md#quick-decisions)
- [Common Questions](SKILL_PATTERNS_ANALYSIS.md#10-common-questions)
- [Emergency Troubleshooting](SKILL_CREATION_DECISION_TREE.md#emergency-troubleshooting)

**For detailed patterns**:
- See [Full Analysis](SKILL_PATTERNS_ANALYSIS.md)

**For step-by-step guidance**:
- Follow [Decision Tree](SKILL_CREATION_DECISION_TREE.md)

---

**Happy Skill Building!** 🚀
