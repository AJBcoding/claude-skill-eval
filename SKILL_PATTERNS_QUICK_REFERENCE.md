# Claude Code Skills: Quick Reference Guide

**One-page reference for skill patterns and best practices**

---

## ✅ DO: Common Patterns That Work

### Activation
- **Explicit triggers**: List 3-5 concrete activation phrases
- **Keywords**: Include domain-specific terms
- **Use cases**: "Use when [specific scenario]"

### Structure
```
skill-name/
├── SKILL.md (<5k words)        # Workflow guidance
├── scripts/                     # Executable code
├── references/                  # Detailed docs (loaded as needed)
├── assets/                      # Templates, output resources
└── examples/                    # Complete demonstrations
```

### Documentation
- **Progressive disclosure**: Metadata (100w) → SKILL.md (<5kw) → References (unlimited)
- **Imperative voice**: "Use X", "Run Y" (not "You should...")
- **Code examples**: Good/Bad comparisons, realistic scenarios
- **Decision trees**: Clear branching logic for complex choices

### Frontmatter
```yaml
---
name: skill-name                              # Required
description: "What + When to use"            # Required
allowed-tools: [Bash, Read, Write]           # Strongly recommended
version: 1.0.0                               # Recommended
status: production                           # Optional
---
```

### Workflows
- **Phased**: Number phases, include transition cues
- **Verification**: Evidence before claims
- **Error handling**: Top 4-5 common issues with solutions
- **Examples**: 1-3 complete end-to-end workflows

---

## ❌ DON'T: Anti-Patterns to Avoid

### Activation
- ❌ Vague descriptions: "Help with coding tasks"
- ❌ Multiple domains: "web-scraping-and-database-operations"
- ❌ No examples: Abstract descriptions only

### Structure
- ❌ Everything in SKILL.md: 10k+ words in one file
- ❌ Duplication: Same info in SKILL.md and references/
- ❌ Deep nesting: More than 3 folder levels

### Documentation
- ❌ Second person: "You should use this when you..."
- ❌ No examples: Abstract instructions only
- ❌ Missing errors: No troubleshooting section

### Scope
- ❌ Too broad: Multiple unrelated capabilities
- ❌ No tool constraints: Missing allowed-tools
- ❌ Unclear boundaries: Overlaps with other skills

---

## 📐 Size Guidelines

| Tier     | SKILL.md   | Complexity | Time     |
|----------|------------|------------|----------|
| Simple   | <200 lines | 1-3        | <5 min   |
| Standard | 200-500    | 4-6        | <15 min  |
| Complex  | 500+       | 7-10       | 20-30min |

---

## 🎯 When to Split Skills

Split when you have:
- ✂️ Multiple distinct domains (web + database)
- ✂️ Different tool requirements ([Bash, Docker] vs [Read, Write])
- ✂️ Different complexity levels (basic vs advanced)
- ✂️ Independent evolution (separate update cycles)

Keep together when:
- 🔗 Tightly coupled features
- 🔗 Shared resources
- 🔗 Common activation pattern

---

## 📋 Quality Checklist

### Activation & Scope
- [ ] Single clear purpose
- [ ] 3-5 activation triggers listed
- [ ] Distinct from other skills
- [ ] allowed-tools specified (minimum necessary)

### Documentation
- [ ] SKILL.md <5k words
- [ ] Imperative voice (no "you should")
- [ ] 1-3 complete examples
- [ ] Error handling documented
- [ ] Progressive disclosure used

### Structure
- [ ] No documentation duplication
- [ ] References properly linked
- [ ] Clear workflow phases
- [ ] Verification steps included

### Examples & Testing
- [ ] Good/Bad code comparisons
- [ ] Realistic scenarios
- [ ] Edge cases covered
- [ ] Test cases defined

---

## 🎨 Style Guide

### Writing Style
```markdown
✅ "Use this skill when optimizing Python code"
❌ "You should use this skill when you want to optimize your Python code"

✅ "Run the test suite to verify"
❌ "You can run the test suite if you want to verify"

✅ "Follow the workflow in order"
❌ "It's recommended that you follow the workflow"
```

### Code Examples
```markdown
### ❌ WRONG - Description
```language
bad_example()
```
Problem: Why this is bad

### ✅ CORRECT - Description
```language
good_example()
```
Benefit: Why this is better
```

### Workflow Format
```markdown
## Workflow

1. **Step Name**: Action
   ```bash
   command here
   ```
   Verification: Check X

2. **Next Step**: Action
   Output: Expected result
```

---

## 🔧 Common Patterns by Skill Type

### Document Skills (docx, pdf, xlsx)
- Decision tree (read/create/edit)
- Tool selection guide
- Format preservation requirements
- Verification steps (zero errors)

### Process Skills (TDD, debugging)
- Iron Law (non-negotiable rule)
- Red flags (violation detection)
- Rationalization table
- Required sub-skills

### Content Skills (writing, extraction)
- Phased approach (discovery → drafting)
- Optional integrations
- Voice/style consistency
- Complete session examples

### Technical Reference (optimization, patterns)
- Pattern catalog (Problem → Solution)
- Before/after comparisons
- Best practices list
- Common pitfalls

### Orchestration Skills (tapestry, agent-factory)
- Master workflow
- Component delegation
- Integration points
- End-to-end examples

---

## 💡 Quick Decisions

**Q: SKILL.md or reference file?**
- Workflow guidance → SKILL.md
- Detailed docs → references/

**Q: How many examples?**
- Minimum 1 per major workflow
- Add 2-3 for common variations

**Q: How to handle large docs?**
- Warn about token cost
- Offer subagent delegation
- Use progressive loading

**Q: Tool permissions?**
- Always specify allowed-tools
- List minimum necessary
- Explain why each tool

**Q: When to version?**
- Breaking changes → major (2.0.0)
- New features → minor (1.1.0)
- Bug fixes → patch (1.0.1)

---

## 🚀 Skill Creation Workflow

1. **Define Purpose**
   - Single clear goal
   - 3-5 activation triggers
   - Distinct from existing skills

2. **Plan Structure**
   - Identify allowed-tools
   - Sketch workflow phases
   - Determine SKILL.md vs references/

3. **Write SKILL.md**
   - Frontmatter with metadata
   - Overview and "When to Use"
   - Core workflow (imperative voice)
   - 1-3 examples
   - Error handling

4. **Add Resources**
   - Scripts for repeated code
   - References for detailed docs
   - Assets for templates
   - Examples for demonstrations

5. **Validate**
   - Test activation triggers
   - Verify tool constraints
   - Check documentation clarity
   - Review against checklist

6. **Test & Iterate**
   - Run realistic scenarios
   - Gather feedback
   - Refine based on usage
   - Version appropriately

---

## 🎓 Top 10 Skill Success Factors

1. **Clear activation** - Explicit triggers, no ambiguity
2. **Progressive disclosure** - Lean SKILL.md, load details as needed
3. **Tool constraints** - Minimum necessary, explicitly listed
4. **Imperative instructions** - Direct commands, not suggestions
5. **Concrete examples** - Real code, not abstract descriptions
6. **Quality gates** - Verification steps, validation frameworks
7. **Error handling** - Common issues with solutions
8. **Modular structure** - Single responsibility, composable
9. **Token awareness** - Efficient context usage
10. **User-centric** - Solves real problems clearly

---

## 📚 Reference

**Full Analysis**: See `SKILL_PATTERNS_ANALYSIS.md` for detailed patterns, examples, and rationale

**Quick Lookup**:
- Activation patterns → Section 1.1
- File organization → Section 3.5
- Workflow structures → Section 3.8
- Code examples → Section 3.9
- Quality gates → Section 6.1

---

**Version**: 1.0
**Date**: 2025-11-18
**Purpose**: Quick reference for skill development best practices
