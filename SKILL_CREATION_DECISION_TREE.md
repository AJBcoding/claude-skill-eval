# Skill Creation Decision Tree

**Interactive decision guide for creating effective Claude Code skills**

---

## Start Here: Do You Need a New Skill?

```
┌─────────────────────────────────────┐
│ What are you trying to accomplish?  │
└─────────────────────────────────────┘
                  │
     ─────────────┴─────────────
     │                         │
     ▼                         ▼
┌──────────────┐      ┌──────────────────┐
│ Single clear │      │ Multiple         │
│ purpose      │      │ unrelated tasks  │
└──────────────┘      └──────────────────┘
     │                         │
     │                         ▼
     │              ❌ Split into multiple skills
     │              (Each with single purpose)
     │
     ▼
┌────────────────────────────────┐
│ Does similar skill exist?      │
└────────────────────────────────┘
     │
     ├─── Yes ──► Consider:
     │            - Enhancing existing skill
     │            - Creating sub-skill
     │            - Creating complementary skill
     │
     └─── No ──► Continue to Activation Design
```

---

## Step 1: Activation Design

```
┌───────────────────────────────────┐
│ Can you list 3+ specific triggers?│
│ "Use when..."                     │
└───────────────────────────────────┘
     │
     ├─── No ──► Refine purpose
     │           Too vague or too broad
     │
     └─── Yes ──► Continue
                  │
                  ▼
┌───────────────────────────────────┐
│ Are triggers distinct from        │
│ existing skills?                  │
└───────────────────────────────────┘
     │
     ├─── No ──► Risk of overlap
     │           Redefine or merge
     │
     └─── Yes ──► Continue to Scope
```

---

## Step 2: Scope Definition

```
┌────────────────────────────────────┐
│ What domain(s) does this cover?   │
└────────────────────────────────────┘
     │
     ├─── Single domain ──────┐
     │                        │
     └─── Multiple domains ───┼──► Are they tightly related?
                              │
                              ├─── No ──► Split skills
                              │
                              └─── Yes ──► Continue
                                           │
                                           ▼
                              ┌──────────────────────────────┐
                              │ Estimate complexity (1-10)   │
                              └──────────────────────────────┘
                                           │
     ┌─────────────────────────────────────┼──────────────────────────────┐
     │                                     │                              │
     ▼                                     ▼                              ▼
┌─────────┐                        ┌──────────┐                   ┌──────────┐
│ 1-3     │                        │ 4-6      │                   │ 7-10     │
│ Simple  │                        │ Standard │                   │ Complex  │
│ <200L   │                        │ 200-500L │                   │ 500+L    │
│ <5 min  │                        │ <15 min  │                   │ 20-30min │
└─────────┘                        └──────────┘                   └──────────┘
     │                                     │                              │
     └─────────────────────────────────────┴──────────────────────────────┘
                                           │
                                           ▼
                                  Continue to Tools
```

---

## Step 3: Tool Selection

```
┌──────────────────────────────────────┐
│ What tools does this skill need?    │
└──────────────────────────────────────┘
     │
     ▼
Check each potential tool:

┌─── Read ────┐
│ Need to:    │
│ - Read files│
│ - View code │
└─────────────┘
     │
     ├─── Yes ──► Include
     └─── No ──► Exclude

┌─── Write ───┐
│ Need to:    │
│ - Create    │
│ - Modify    │
└─────────────┘
     │
     ├─── Yes ──► Include
     └─── No ──► Exclude

┌─── Bash ────┐
│ Need to:    │
│ - Execute   │
│ - Install   │
│ - Run tests │
└─────────────┘
     │
     ├─── Yes ──► Include
     └─── No ──► Exclude

┌─ WebFetch ──┐
│ Need to:    │
│ - Fetch URLs│
│ - Get docs  │
└─────────────┘
     │
     ├─── Yes ──► Use sparingly
     │            (Heavy, unreliable)
     └─── No ──► Exclude

         ▼
┌──────────────────────────────┐
│ List = allowed-tools         │
│ Include ONLY minimum needed  │
└──────────────────────────────┘
         │
         ▼
    Continue to Structure
```

---

## Step 4: Structure Planning

```
┌─────────────────────────────────────┐
│ How much documentation do you need? │
└─────────────────────────────────────┘
     │
     ├─── <1000 words ──► Simple structure
     │                     └─ SKILL.md only
     │
     ├─── 1k-5k words ──► Standard structure
     │                     ├─ SKILL.md (workflows)
     │                     └─ examples/ (optional)
     │
     └─── >5k words ───► Progressive disclosure
                          ├─ SKILL.md (lean, <5k)
                          ├─ references/ (detailed)
                          ├─ scripts/ (automation)
                          ├─ assets/ (templates)
                          └─ examples/ (demonstrations)

         ▼
┌─────────────────────────────────────┐
│ Do you have reusable code?          │
└─────────────────────────────────────┘
     │
     ├─── Yes ──► Add scripts/
     │            (Repeatedly written code)
     │
     └─── No ──► Skip scripts/

         ▼
┌─────────────────────────────────────┐
│ Do you need templates for output?   │
└─────────────────────────────────────┘
     │
     ├─── Yes ──► Add assets/
     │            (Output templates)
     │
     └─── No ──► Skip assets/

         ▼
    Continue to Documentation
```

---

## Step 5: Documentation Planning

```
┌──────────────────────────────┐
│ What goes in SKILL.md?       │
└──────────────────────────────┘
     │
     ▼

MUST HAVE:
├─ Frontmatter (name, description, allowed-tools)
├─ Overview (what, when to use)
├─ Core workflow (numbered steps)
└─ Examples (1-3 complete)

SHOULD HAVE:
├─ Error handling (common issues)
├─ Decision trees (complex choices)
├─ Verification steps (quality gates)
└─ Quick reference (common patterns)

MAY HAVE:
├─ Advanced usage (link to references/)
├─ Integration points (related skills)
├─ Troubleshooting (edge cases)
└─ Best practices (dos and don'ts)

         ▼
┌──────────────────────────────┐
│ Token budget check           │
└──────────────────────────────┘
     │
     ├─── <5k words ──► ✅ Good
     │
     ├─── 5-10k words ─► ⚠️ Consider splitting
     │                    Move details to references/
     │
     └─── >10k words ──► ❌ Too large
                         MUST split or extract

         ▼
    Continue to Writing
```

---

## Step 6: Writing Style Check

```
For each instruction, check:

┌─────────────────────────────┐
│ Is it imperative voice?    │
│ "Use X" not "You should X" │
└─────────────────────────────┘
     │
     ├─── Yes ──► ✅ Good
     └─── No ──► Rewrite

┌─────────────────────────────┐
│ Does it have examples?      │
│ Real code, not abstract     │
└─────────────────────────────┘
     │
     ├─── Yes ──► ✅ Good
     └─── No ──► Add examples

┌─────────────────────────────┐
│ Are steps numbered/clear?   │
│ Obvious what to do next     │
└─────────────────────────────┘
     │
     ├─── Yes ──► ✅ Good
     └─── No ──► Add structure

┌─────────────────────────────┐
│ Good/Bad comparisons?       │
│ Show anti-patterns          │
└─────────────────────────────┘
     │
     ├─── Yes ──► ✅ Good
     └─── No ──► Add comparisons

         ▼
    Continue to Validation
```

---

## Step 7: Quality Validation

```
Run through validation gates:

┌─────────────────────────────────┐
│ Gate 1: YAML Frontmatter        │
├─────────────────────────────────┤
│ ☐ name field present            │
│ ☐ description clear             │
│ ☐ allowed-tools specified       │
│ ☐ Valid YAML syntax             │
└─────────────────────────────────┘
     │
     ├─── All checked ──► Continue
     └─── Missing ──────► Fix before proceeding

┌─────────────────────────────────┐
│ Gate 2: Required Sections       │
├─────────────────────────────────┤
│ ☐ Overview exists               │
│ ☐ When to Use exists            │
│ ☐ Workflow documented           │
│ ☐ Examples provided             │
└─────────────────────────────────┘
     │
     ├─── All checked ──► Continue
     └─── Missing ──────► Add sections

┌─────────────────────────────────┐
│ Gate 3: Content Quality         │
├─────────────────────────────────┤
│ ☐ Error handling documented     │
│ ☐ No broken links               │
│ ☐ Code examples work            │
│ ☐ Verification steps present    │
└─────────────────────────────────┘
     │
     ├─── All checked ──► Continue
     └─── Issues found ─► Fix

┌─────────────────────────────────┐
│ Gate 4: Standards Compliance    │
├─────────────────────────────────┤
│ ☐ Naming conventions followed   │
│ ☐ Imperative voice used         │
│ ☐ Progressive disclosure        │
│ ☐ No documentation duplication  │
└─────────────────────────────────┘
     │
     ├─── All checked ──► ✅ Ready
     └─── Issues found ─► Fix

         ▼
    Continue to Testing
```

---

## Step 8: Testing

```
┌─────────────────────────────────┐
│ Test Case Planning              │
└─────────────────────────────────┘
     │
     ▼

Core Test Cases (Minimum 3):
┌────────────────────────────────┐
│ 1. Simple/common scenario      │
│ 2. Standard workflow           │
│ 3. Complex/edge case           │
└────────────────────────────────┘
     │
     ├─► Run each test
     │   ├─ Does skill activate correctly?
     │   ├─ Do tools work as expected?
     │   ├─ Are outputs correct?
     │   └─ Any errors or confusion?
     │
     ▼
┌────────────────────────────────┐
│ Edge Cases (Add 2-3):          │
│ - Error conditions             │
│ - Boundary cases               │
│ - Integration scenarios        │
└────────────────────────────────┘
     │
     ▼

All tests pass?
     │
     ├─── Yes ──► Continue to Deployment
     │
     └─── No ──► Identify issues
                 ├─ Activation problems → Fix triggers
                 ├─ Tool errors → Review constraints
                 ├─ Documentation gaps → Add clarification
                 └─ Logic errors → Fix workflow
                        │
                        └─► Retest
```

---

## Step 9: Deployment Decision

```
┌─────────────────────────────────┐
│ Where should this skill live?   │
└─────────────────────────────────┘
     │
     ├─── Project-specific ──► .claude/skills/
     │                          └─ Only for this repo
     │
     ├─── User-specific ────► ~/.claude/skills/
     │                          └─ Available globally
     │
     └─── Shareable ────────► Package for distribution
                               ├─ Create README.md
                               ├─ Add LICENSE
                               ├─ Version (1.0.0)
                               └─ Zip for sharing

         ▼
┌─────────────────────────────────┐
│ Initial version                 │
│ Status: alpha/beta/production   │
└─────────────────────────────────┘
     │
     ▼
    Deploy and Monitor
```

---

## Step 10: Iteration

```
After deployment:

┌─────────────────────────────────┐
│ Gather Feedback                 │
├─────────────────────────────────┤
│ - Activation accuracy           │
│ - Workflow clarity              │
│ - Error handling gaps           │
│ - Documentation issues          │
│ - Performance problems          │
└─────────────────────────────────┘
     │
     ▼
┌─────────────────────────────────┐
│ Categorize Changes              │
└─────────────────────────────────┘
     │
     ├─── Bug fixes ──────────────► Patch version (1.0.1)
     │                               - Fix errors
     │                               - Clarify docs
     │
     ├─── Enhancements ───────────► Minor version (1.1.0)
     │                               - Add features
     │                               - Improve workflows
     │
     └─── Breaking changes ───────► Major version (2.0.0)
                                     - New structure
                                     - Different API
                                     - Tool changes

         ▼
    Update → Test → Deploy → Repeat
```

---

## Common Decision Points Quick Reference

### Should I split this skill?

```
┌───────────────────┐
│ Ask yourself:     │
└───────────────────┘
├─ Does it serve multiple unrelated domains? ───► Split
├─ Are tool requirements vastly different? ─────► Split
├─ Is SKILL.md >10k words? ────────────────────► Split or extract
├─ Do users only need parts of it? ────────────► Split
└─ Is it growing out of control? ──────────────► Split

But keep together if:
├─ Features are tightly coupled
├─ They share common workflows
└─ Splitting would cause confusion
```

### Progressive disclosure or all-in-one?

```
┌───────────────────┐
│ Total content:    │
└───────────────────┘
├─ <1k words ──────► All in SKILL.md
├─ 1-5k words ─────► SKILL.md + examples/
├─ >5k words ──────► SKILL.md + references/
└─ >10k words ─────► Mandatory progressive disclosure
```

### Imperative or descriptive?

```
Always imperative:
✅ "Run the test suite"
✅ "Use pandas for data analysis"
✅ "Follow the workflow in order"

Never descriptive:
❌ "You should run the test suite"
❌ "It's recommended to use pandas"
❌ "You can follow the workflow"
```

### Examples: How many?

```
Minimum:
├─ 1 complete workflow example
└─ 1 good/bad code comparison

Recommended:
├─ 2-3 complete workflows (common scenarios)
├─ 2-3 good/bad comparisons
└─ 1-2 edge cases

Maximum:
└─ No limit, but extract to examples/ if >10
```

---

## Emergency Troubleshooting

### Skill not activating?

```
1. Check description clarity
   ├─ Are triggers specific?
   ├─ Are use cases concrete?
   └─ Test with exact user phrasing

2. Check for overlaps
   ├─ Does another skill match better?
   ├─ Are triggers too similar?
   └─ Refine activation criteria

3. Verify frontmatter
   └─ Valid YAML syntax?
```

### Too complex to document?

```
1. Simplify the skill
   ├─ Is scope too broad?
   ├─ Can you split it?
   └─ Remove non-essential features

2. Use progressive disclosure
   ├─ Lean SKILL.md
   ├─ Extract to references/
   └─ Load details as needed

3. Consider sub-skills
   └─ Break into composable pieces
```

### Users confused?

```
1. Add more examples
   ├─ Show complete workflows
   ├─ Include common scenarios
   └─ Add good/bad comparisons

2. Improve decision trees
   ├─ Make choices explicit
   ├─ Reduce branching
   └─ Provide clear criteria

3. Enhance error handling
   ├─ Document common issues
   ├─ Provide solutions
   └─ Add troubleshooting section
```

---

## Final Checklist

Before declaring skill complete:

### Completeness
- [ ] Frontmatter complete (name, description, allowed-tools)
- [ ] Overview explains what and when
- [ ] Workflow documented with clear steps
- [ ] 1+ complete examples provided
- [ ] Error handling documented
- [ ] Verification steps included

### Quality
- [ ] Imperative voice throughout
- [ ] No second-person instructions
- [ ] Good/bad code comparisons
- [ ] Decision trees for complex choices
- [ ] Progressive disclosure used
- [ ] No documentation duplication

### Testing
- [ ] 3+ core test cases passed
- [ ] 2+ edge cases tested
- [ ] Activation triggers verified
- [ ] Tool constraints validated
- [ ] Documentation clarity confirmed

### Standards
- [ ] Naming follows kebab-case
- [ ] SKILL.md <5k words
- [ ] Single clear purpose
- [ ] Distinct from existing skills
- [ ] Version and status set

---

**Version**: 1.0
**Created**: 2025-11-18
**Purpose**: Decision guide for skill creation process
