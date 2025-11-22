# Claude Code Skills: Patterns, Anti-Patterns, and Best Practices

**Analysis Date**: 2025-11-18
**Analyzed Skills**: 20+ skills across .claude/skills, skills/, and framework-specific directories
**Purpose**: Extract recurring successful patterns and problematic patterns to inform skill development

---

## Executive Summary

This analysis identifies what makes Claude Code skills effective by examining successful patterns, common anti-patterns, and extracting actionable best practice principles. The findings come from analyzing skills ranging from simple utilities (article-extractor) to complex frameworks (moai-alfred-agent-factory).

**Key Insight**: The most successful skills follow a **progressive disclosure architecture** with clear activation patterns, strict tool constraints, and modular documentation.

---

## 1. Common Patterns (What Works)

### 1.1 Skill Activation Patterns

**Pattern**: Explicit, multi-variant trigger specifications

**Examples**:
```yaml
# tapestry/SKILL.md
description: "Use when user says 'tapestry <URL>', 'weave <URL>',
'help me plan <URL>', or similar phrases..."

# systematic-debugging/SKILL.md
description: "Use when encountering any bug, test failure, or
unexpected behavior, before proposing fixes"
```

**Why it works**:
- Claude can pattern-match user intent accurately
- Multiple phrasings increase activation reliability
- Clear boundaries prevent skill overlap

**Implementation guidance**:
- List 3-5 concrete activation phrases
- Include variations (synonyms, related terms)
- Specify exclusions if needed (when NOT to use)

---

### 1.2 Progressive Disclosure Architecture

**Pattern**: Three-tier loading system

**Structure**:
```
1. Metadata (always in context): name + description (~100 words)
2. SKILL.md body (when triggered): <5k words
3. Bundled resources (as needed): Unlimited
   ├── scripts/     - Executable code
   ├── references/  - Detailed documentation
   ├── assets/      - Output templates
   └── examples/    - Practical demonstrations
```

**Examples**:
- **docx**: SKILL.md (200 lines) → references/ooxml.md (600 lines)
- **playwright-skill**: SKILL.md (400 lines) → node_modules/ (~50MB)
- **moai-alfred-agent-factory**: SKILL.md (300 lines) → 5 reference files (1300 lines)

**Why it works**:
- Minimizes token usage
- Claude loads detail only when needed
- Clear information hierarchy

**Anti-pattern to avoid**:
```markdown
# BAD: Everything in SKILL.md
---
name: complex-skill
---

[10,000 lines of detailed documentation, examples, reference material...]
```

**Implementation guidance**:
- Keep SKILL.md to essential workflow guidance
- Extract detailed documentation to references/
- Use clear signposting: "See references/detail.md for X"
- Include grep patterns for large reference files

---

### 1.3 Tool Usage Constraints

**Pattern**: Explicit `allowed-tools` frontmatter with selection guidance

**Examples**:
```yaml
# tapestry/SKILL.md
allowed-tools: [Bash, Read, Write]

# article-extractor/SKILL.md
allowed-tools: [Bash, Write]
```

**Why it works**:
- Prevents tool misuse
- Forces skill author to think through tool needs
- Provides security boundary

**Decision tree pattern** (xlsx):
```markdown
## Library Selection
- **pandas**: Best for data analysis, bulk operations
- **openpyxl**: Best for complex formatting, formulas

When to use:
- Reading data → pandas
- Writing formulas → openpyxl
- Simple export → pandas
- Complex formatting → openpyxl
```

**Implementation guidance**:
- List minimum necessary tools in frontmatter
- Provide clear decision criteria for tool selection
- Explain WHY certain tools (not just WHICH)

---

### 1.4 Imperative Instruction Style

**Pattern**: Verb-first, objective instructions

**Good examples**:
```markdown
# skill-creator/SKILL.md
"To accomplish X, do Y"
"Follow the Skill Creation Process in order"
"Skip this step only when..."

# systematic-debugging/SKILL.md
"BEFORE attempting ANY fix:"
"Read Error Messages Carefully"
"Reproduce Consistently"
```

**Bad examples** (to avoid):
```markdown
"You should use this when..."
"If you need to do X, you can try Y"
"It's recommended that you..."
```

**Why it works**:
- Clearer for AI consumption
- More authoritative
- Avoids ambiguity

**Implementation guidance**:
- Use infinitive form: "Use X", "Run Y", "Create Z"
- Avoid second person: "you should/can/might"
- Be direct and declarative

---

### 1.5 Phased Workflow Structures

**Pattern**: Multi-phase processes with clear transitions

**Example**: collaborative-writing (5 phases)
```
Phase 0: Lexicon Loading (Conditional)
  ↓ "Shall we move from discovery into message shaping?"
Phase 1: Discovery Dialogue
  ↓ "Would you like me to suggest how these points could be expressed?"
Phase 2: Message Architecture
  ↓ "Ready for me to propose a short passage?"
Phase 3: Framing and Voice Calibration
  ↓ "Let's draft in small segments..."
Phase 4: Collaborative Drafting
  ↓ "Ready for final alignment review?"
Phase 5: Alignment and Adaptation
```

**Why it works**:
- Clear checkpoints
- User can provide feedback at each stage
- Natural breakpoints for complex tasks
- Prevents premature solutions

**Implementation guidance**:
- Number phases explicitly (Phase 1, Phase 2...)
- Include transition cues between phases
- Allow returning to earlier phases
- Mark optional vs required phases

---

### 1.6 Quality Gates and Iron Laws

**Pattern**: Non-negotiable rules with explicit violation detection

**Examples**:
```markdown
# systematic-debugging/SKILL.md
## The Iron Law
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST

## Red Flags - STOP and Follow Process
- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "I don't fully understand but this might work"

# test-driven-development/SKILL.md
## The Iron Law
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST

## Red Flags - STOP and Start Over
- Code before test
- Test passes immediately
- "I'll test after"
```

**Why it works**:
- Prevents common failure modes
- Makes violations explicit
- Builds discipline into process

**Implementation guidance**:
- State the iron law prominently
- List specific red flags
- Address common rationalizations
- Make consequences clear

---

### 1.7 Good/Bad Code Examples

**Pattern**: Side-by-side comparisons with explanations

**Example** (test-driven-development):
```markdown
<Good>
```typescript
test('retries failed operations 3 times', async () => {
  let attempts = 0;
  const operation = () => {
    attempts++;
    if (attempts < 3) throw new Error('fail');
    return 'success';
  };
  expect(result).toBe('success');
  expect(attempts).toBe(3);
});
```
Clear name, tests real behavior, one thing
</Good>

<Bad>
```typescript
test('retry works', async () => {
  const mock = jest.fn()
    .mockRejectedValueOnce(new Error())
    .mockResolvedValueOnce('success');
  await retryOperation(mock);
});
```
Vague name, tests mock not code
</Bad>
```

**Why it works**:
- Shows don't tell
- Prevents misinterpretation
- Makes standards concrete

**Implementation guidance**:
- Use `<Good>` and `<Bad>` tags or ✅/❌
- Explain WHY it's good/bad
- Show realistic examples
- Cover common mistakes

---

### 1.8 Workflow Decision Trees

**Pattern**: Clear branching logic with condition-based routing

**Example** (docx):
```markdown
## Workflow Decision Tree

### Reading/Analyzing Content
Use "Text extraction" or "Raw XML access"

### Creating New Document
Use "Creating a new Word document" workflow

### Editing Existing Document
- Your own document + simple changes
  → Use "Basic OOXML editing"
- Someone else's document
  → Use "Redlining workflow" (recommended)
- Legal/academic/business docs
  → Use "Redlining workflow" (required)
```

**Why it works**:
- Reduces decision fatigue
- Prevents wrong workflow selection
- Handles complexity gracefully

**Implementation guidance**:
- Start with high-level decision points
- Use indentation to show hierarchy
- Mark recommendations vs requirements
- Provide escape hatches

---

### 1.9 Error Handling and Troubleshooting

**Pattern**: Dedicated sections for common issues

**Example** (article-extractor):
```markdown
## Error Handling

### Common Issues

1. Tool not installed
   - Try alternate tool (reader → trafilatura → fallback)
   - Offer to install: "Install reader with: npm install -g reader-cli"

2. Paywall or login required
   - Extraction tools may fail
   - Inform user: "This article requires authentication."

3. Invalid URL
   - Check URL format
   - Try with and without redirects

4. No content extracted
   - Site may use heavy JavaScript
   - Try fallback method
   - Inform user if extraction fails
```

**Why it works**:
- Reduces frustration
- Provides recovery paths
- Builds robustness

**Implementation guidance**:
- List common failure modes
- Provide diagnostic steps
- Include fallback strategies
- Give clear error messages

---

### 1.10 Context Budget Awareness

**Pattern**: Explicit warnings about token-heavy operations

**Example** (writing-clearly-and-concisely):
```markdown
**WARNING**: `elements-of-style.md` consumes ~12,000 tokens.
Read it only when writing or editing prose.

## Limited Context Strategy
When context is tight:
1. Write your draft using judgment
2. Dispatch a subagent with your draft and `elements-of-style.md`
3. Have the subagent copyedit and return the revision
```

**Why it works**:
- Prevents context window exhaustion
- Offers alternatives
- Makes resource costs visible

**Implementation guidance**:
- Note token counts for large files
- Suggest subagent delegation for heavy work
- Use progressive loading
- Provide abbreviated alternatives

---

## 2. Anti-Patterns (What to Avoid)

### 2.1 Scope Creep

**Anti-pattern**: Skills trying to do too many unrelated things

**Example** (hypothetical bad skill):
```yaml
name: web-operations
description: |
  Handles web scraping, API testing, browser automation,
  web server setup, SEO analysis, and website deployment
```

**Why it's bad**:
- Unclear activation trigger
- Too broad to be useful
- Difficult to maintain
- Confusing tool requirements

**Better approach**: Split into focused skills
- `article-extractor` (web content)
- `playwright-skill` (browser automation)
- `api-testing` (API validation)

**Detection**:
- Description has "and" 3+ times
- Multiple unrelated domains
- Tool list >8 items
- No clear single purpose

---

### 2.2 Unclear Activation Triggers

**Anti-pattern**: Vague or overlapping descriptions

**Bad example**:
```yaml
name: code-helper
description: "Help with coding tasks and development work"
```

**Why it's bad**:
- Too generic - when should this activate?
- Overlaps with many other skills
- No concrete use cases

**Good example**:
```yaml
name: python-performance-optimization
description: |
  Profile and optimize Python code using cProfile,
  memory profilers, and performance best practices.
  Use when debugging slow Python code, optimizing
  bottlenecks, or improving application performance.
```

**Fix checklist**:
- [ ] Specific domain mentioned
- [ ] Concrete activation scenarios listed
- [ ] Clear differentiation from similar skills
- [ ] Explicit trigger phrases

---

### 2.3 Missing Tool Constraints

**Anti-pattern**: No `allowed-tools` or unrestricted tool access

**Bad example**:
```yaml
name: data-processor
# No allowed-tools specified
```

**Why it's bad**:
- Security risk
- Claude may use inappropriate tools
- Hard to audit skill behavior

**Good example**:
```yaml
name: article-extractor
allowed-tools: [Bash, Write]
```

**Implementation rule**: ALWAYS specify `allowed-tools`

---

### 2.4 Documentation Duplication

**Anti-pattern**: Same information in SKILL.md and reference files

**Bad structure**:
```
skill/
├── SKILL.md (contains full API documentation)
└── references/
    └── api-docs.md (contains same API documentation)
```

**Why it's bad**:
- Wastes tokens loading duplicate info
- Creates maintenance burden
- Confusing information hierarchy

**Good structure**:
```
skill/
├── SKILL.md (workflow guidance, when to load references)
└── references/
    └── api-docs.md (detailed API documentation)
```

**Rule**: Information lives in ONE place
- Workflow → SKILL.md
- Detailed reference → references/
- Examples → examples/
- Templates → assets/

---

### 2.5 Overly Complex Conditional Logic

**Anti-pattern**: Deeply nested conditions without clear structure

**Bad example**:
```markdown
If X and (Y or Z) then:
  If A and not B:
    If C then D else E
  Else if A and B:
    If F then G
    Else if H then I
    ...
```

**Why it's bad**:
- Cognitive overload
- Hard to debug
- Easy to miss cases

**Good alternative**: Decision table or flowchart
```markdown
| Condition A | Condition B | Action |
|-------------|-------------|--------|
| True        | True        | X      |
| True        | False       | Y      |
| False       | True        | Z      |
| False       | False       | W      |
```

---

### 2.6 Missing Examples

**Anti-pattern**: Abstract instructions without concrete demonstrations

**Bad**:
```markdown
Use the appropriate extraction method based on content type.
Configure the settings according to your requirements.
Process the data using best practices.
```

**Good**:
```markdown
## Example 1: YouTube Video
User: tapestry https://youtube.com/watch?v=...
Claude:
🧵 Tapestry Workflow Starting...
📍 Detected: youtube
📺 Extracting transcript...
✓ Saved: Video Title.txt

## Example 2: Article
User: Extract https://example.com/article
Claude:
Using reader (Mozilla Readability)
✓ Saved: Article Title.txt
```

**Rule**: Every major workflow needs at least one complete example

---

### 2.7 Weak or Missing Verification Steps

**Anti-pattern**: Instructions without verification requirements

**Bad**:
```markdown
1. Create the configuration file
2. Run the build
3. Deploy to production
```

**Good** (verification-before-completion):
```markdown
BEFORE claiming any status:
1. IDENTIFY: What command proves this claim?
2. RUN: Execute the FULL command (fresh, complete)
3. READ: Full output, check exit code
4. VERIFY: Does output confirm the claim?
5. ONLY THEN: Make the claim
```

**Rule**: Every significant step needs verification criteria

---

### 2.8 Second-Person Instructions

**Anti-pattern**: Using "you should/can/might" phrasing

**Bad**:
```markdown
You should use this skill when you need to optimize your code.
If you want to profile memory, you can use the memory profiler.
You might want to consider using the debugging workflow.
```

**Good**:
```markdown
Use this skill when optimizing code.
To profile memory, use the memory profiler.
For debugging, follow the systematic debugging workflow.
```

**Rule**: Write in imperative/infinitive form, not second person

---

## 3. Best Practice Principles

### 3.1 Skill Size and Scope Guidelines

**Size tiers** (from moai-alfred-agent-factory):

| Tier     | SKILL.md Size | Complexity | Generation Time |
|----------|---------------|------------|-----------------|
| Simple   | <200 lines    | 1-3        | <5 min          |
| Standard | 200-500 lines | 4-6        | <15 min         |
| Complex  | 500+ lines    | 7-10       | 20-30 min       |

**Scope principle**: Single Responsibility
- ✅ One clear purpose
- ✅ One primary domain
- ✅ Cohesive tool set
- ❌ Multiple unrelated capabilities

**Size guidelines**:
- SKILL.md: <5,000 words (ideally <2,000)
- Reference files: Unlimited (loaded as needed)
- Total skill package: No limit

**When skill feels too large**:
- Split by domain (web scraping vs API testing)
- Split by complexity (simple vs advanced)
- Extract sub-skills (debugging → root-cause-tracing)

---

### 3.2 When to Split Skills

**Split when**:

1. **Multiple Distinct Domains**
   - Bad: `web-and-database-operations`
   - Good: `web-scraping` + `database-optimization`

2. **Different Tool Requirements**
   - Bad: One skill needs [Bash, Docker] for some features, [Read, Write] for others
   - Good: Split into infrastructure skill + document skill

3. **Different Complexity Levels**
   - Bad: Beginner + advanced features in one skill
   - Good: `basic-sql` + `sql-optimization-patterns`

4. **Different Activation Patterns**
   - Bad: Skill activates for "debug X" AND "create Y" AND "analyze Z"
   - Good: Three separate skills with clear triggers

5. **Independent Evolution**
   - Bad: Two features that will be updated separately
   - Good: Separate skills that can version independently

**Don't split when**:
- Features are tightly coupled
- Both use same resources
- Common activation pattern
- Would create confusion

---

### 3.3 How to Compose Skills

**Pattern 1: Sub-skill Dependencies**

```markdown
# systematic-debugging/SKILL.md

## Integration with Other Skills

**This skill requires using:**
- **root-cause-tracing** - REQUIRED when error is deep in call stack
- **test-driven-development** - REQUIRED for creating failing test case

**Complementary skills:**
- **defense-in-depth** - Add validation after finding root cause
- **verification-before-completion** - Verify fix worked
```

**Pattern 2: Skill Chains**

```
User request → tapestry (master)
              ├→ article-extractor (content)
              ├→ youtube-transcript (content)
              └→ ship-learn-next (planning)
```

**Pattern 3: Conditional Skill Loading**

```markdown
## Optional Inputs

Lexicon Dependencies (enhance quality when available):
- ~/lexicons/narrative-patterns.md
- ~/lexicons/language-bank.md

If available: Use for voice calibration
If not available: Proceed with Socratic discovery alone
```

**Implementation**:
- Declare dependencies explicitly
- Make optional vs required clear
- Provide fallback paths
- Document integration points

---

### 3.4 Naming Conventions

**Format**: `kebab-case`
- ✅ `skill-creator`
- ✅ `test-driven-development`
- ✅ `python-performance-optimization`
- ❌ `SkillCreator`
- ❌ `skill_creator`
- ❌ `SKILL-CREATOR`

**Length**: 2-4 words ideal
- ✅ `article-extractor` (2 words)
- ✅ `collaborative-writing` (2 words)
- ✅ `python-performance-optimization` (3 words)
- ⚠️ `comprehensive-web-scraping-and-data-extraction-toolkit` (too long)

**Descriptiveness**: What it does, not how
- ✅ `sql-optimization-patterns` (what)
- ✅ `systematic-debugging` (what)
- ❌ `uses-playwright-for-testing` (how)
- ❌ `python-script-executor` (how)

**Specificity**: Precise domain
- ✅ `python-performance-optimization` (specific)
- ❌ `code-helper` (vague)
- ✅ `xlsx` (specific format)
- ❌ `file-processor` (vague)

---

### 3.5 File Organization Patterns

**Standard structure**:
```
skill-name/
├── SKILL.md                 # Entry point (required)
├── LICENSE.txt              # If proprietary
├── README.md                # User-facing documentation (optional)
├── scripts/                 # Executable code (optional)
│   ├── setup.sh
│   ├── process.py
│   └── validate.js
├── references/              # Detailed documentation (optional)
│   ├── api-docs.md
│   ├── patterns.md
│   └── troubleshooting.md
├── assets/                  # Output resources (optional)
│   ├── templates/
│   │   ├── simple.template
│   │   └── complex.template
│   └── fonts/
└── examples/                # Practical demonstrations (optional)
    ├── EXAMPLES.md
    └── test-cases/
```

**When to use each**:

**scripts/**:
- Code that's repeatedly rewritten
- Deterministic operations
- Complex setup procedures
- Validation/verification tools

**references/**:
- API documentation (>500 lines)
- Detailed patterns and examples
- Troubleshooting guides
- Domain-specific knowledge

**assets/**:
- Templates (for output generation)
- Images, fonts, icons
- Boilerplate code
- Sample data files

**examples/**:
- Complete workflow demonstrations
- Test cases
- Before/after comparisons
- Common usage scenarios

**Organization rules**:
1. SKILL.md always at root
2. Use standard folder names
3. No deeply nested structures (max 2-3 levels)
4. Clear README.md in each subfolder
5. Alphabetize when order doesn't matter

---

### 3.6 Frontmatter Standards

**Required fields**:
```yaml
---
name: skill-name
description: "One-sentence description. Use when [specific scenarios]"
---
```

**Optional but recommended**:
```yaml
---
name: skill-name
description: "Description here"
allowed-tools: [Bash, Read, Write]  # Security boundary
version: 1.0.0                       # Semantic versioning
status: production                   # production|beta|alpha
license: "Proprietary. LICENSE.txt"  # If not MIT/open
tags: [domain, category, type]       # For discovery
---
```

**Description format**:
```yaml
# Pattern 1: Simple
description: "Extract clean article content from URLs"

# Pattern 2: With trigger
description: "Use when user wants to download, extract, or save an article from a URL"

# Pattern 3: Comprehensive
description: |
  Profile and optimize Python code using cProfile, memory profilers,
  and performance best practices. Use when debugging slow Python code,
  optimizing bottlenecks, or improving application performance.
```

**Allowed-tools guidelines**:
- List minimum necessary tools
- Order by usage frequency
- Common tools: Bash, Read, Write, Edit, Glob, Grep
- Avoid: WebFetch, WebSearch (unless essential)

---

### 3.7 Progressive Disclosure Strategy

**Principle**: Load information just-in-time

**Tier 1: Always in context** (~100 words)
- Skill name
- Description
- Activation triggers

**Tier 2: Loaded when skill activates** (<5k words)
- SKILL.md body
- Core workflow
- Common patterns
- Quick reference

**Tier 3: Loaded as needed** (unlimited)
- Detailed references
- Complete API documentation
- Advanced patterns
- Scripts and templates

**Implementation**:
```markdown
# SKILL.md (Tier 2)

## Quick Start
[Essential workflow here]

## Common Patterns
[Frequent use cases]

## Advanced Usage
For comprehensive API documentation, see:
- [API_REFERENCE.md](API_REFERENCE.md) - Complete API (~2000 lines)
- [PATTERNS.md](references/patterns.md) - Advanced patterns

Load these only when working with advanced features.
```

**Anti-pattern**:
```markdown
# SKILL.md - DON'T DO THIS

## Complete API Documentation
[10,000 lines of detailed documentation]

## All Patterns
[5,000 lines of examples]

## Troubleshooting
[3,000 lines of edge cases]
```

---

### 3.8 Workflow Documentation Patterns

**Pattern 1: Linear Workflow**
```markdown
## Workflow

1. **Step 1**: Action
   ```bash
   command here
   ```

2. **Step 2**: Next action
   ```python
   code here
   ```

3. **Step 3**: Final action
   Output: Result description
```

**Pattern 2: Branching Workflow**
```markdown
## Workflow Decision Tree

1. **Identify content type**
   - If YouTube → Use Pattern A
   - If Article → Use Pattern B
   - If PDF → Use Pattern C

2. **Extract content**
   [Type-specific instructions]

3. **Verify and save**
   [Common ending]
```

**Pattern 3: Iterative Workflow**
```markdown
## Red-Green-Refactor Cycle

Repeat until feature complete:
1. RED: Write failing test
2. Verify RED: Watch it fail
3. GREEN: Minimal code to pass
4. Verify GREEN: Watch it pass
5. REFACTOR: Clean up (stay green)
6. Next feature → return to step 1
```

**Pattern 4: Phased Workflow** (collaborative-writing)
```markdown
## The Process

### Phase 1: Discovery
[Steps for phase 1]
Transition: "Shall we move to architecture?"

### Phase 2: Architecture
[Steps for phase 2]
Transition: "Ready for voice calibration?"

### Phase 3: Voice Calibration
[Steps for phase 3]
[etc.]
```

---

### 3.9 Code Example Standards

**Format**:
```markdown
## Pattern Name

**Description**: What this pattern does

**Example**:
```language
code here
```

**Why it works**:
- Reason 1
- Reason 2

**When to use**:
- Scenario A
- Scenario B
```

**Good/Bad comparisons**:
```markdown
### ❌ WRONG - Description
```python
# Bad code with explanation
bad_example()
```
Problem: Why this is bad

### ✅ CORRECT - Description
```python
# Good code with explanation
good_example()
```
Benefit: Why this is better
```

**Complete examples**:
```markdown
## Complete Workflow Example

User: "Extract https://example.com/article"

Claude:
🔍 Checking for extraction tools...
✓ Using reader (Mozilla Readability)

📄 Extracting article content...
✓ Saved to: How to Build Great Skills.txt

Preview (first 10 lines):
[content preview]

Would you like me to create a Ship-Learn-Next plan from this?
```

---

### 3.10 Error Handling Standards

**Structure**:
```markdown
## Error Handling

### Common Issues

**Issue 1: Description**
- Symptom: What user sees
- Cause: Why it happens
- Solution: How to fix
- Prevention: Avoid in future

**Issue 2: Description**
[Same structure]

### Troubleshooting Checklist
- [ ] Check X
- [ ] Verify Y
- [ ] Test Z

### When All Else Fails
[Escalation path or alternative approach]
```

**Example** (playwright-skill):
```markdown
## Troubleshooting

**Playwright not installed:**
```bash
cd $SKILL_DIR && npm run setup
```

**Module not found:**
Ensure running from skill directory via `run.js` wrapper

**Browser doesn't open:**
- Check `headless: false` is set
- Ensure display available
- Try `DISPLAY=:0 node script.js`

**Element not found:**
Add explicit wait:
```javascript
await page.waitForSelector('.element', { timeout: 10000 });
```
```

---

## 4. Context Management Best Practices

### 4.1 Token Budget Awareness

**Document token costs**:
```markdown
**WARNING**: `api-reference.md` consumes ~15,000 tokens.
Load only when working with advanced API features.

For common operations, use the Quick Reference below.
```

**Provide alternatives**:
```markdown
## Two Approaches

### Full Documentation (15k tokens)
Read [api-reference.md](references/api-reference.md) for complete coverage

### Quick Reference (2k tokens)
See [quick-ref.md](references/quick-ref.md) for common patterns
```

---

### 4.2 Subagent Delegation

**Pattern**: Offload heavy work to subagents

**Example** (writing-clearly-and-concisely):
```markdown
## Limited Context Strategy

When context is tight:
1. Write your draft using judgment
2. Dispatch a subagent with your draft and `elements-of-style.md`
3. Have the subagent copyedit and return the revision

This keeps the main context clean while getting expert editing.
```

---

### 4.3 Conditional Loading

**Pattern**: Load resources based on conditions

**Example** (collaborative-writing):
```markdown
## Phase 0: Lexicon Loading (Conditional)

**If job-related writing:**
1. Ask: "What is the job slug?"
2. Try to load:
   - ~/lexicons/narrative-patterns.md
   - ~/lexicons/language-bank.md
   - ~/career-applications/[slug]/job-analysis.md

3. Report status:
   ✓ Lexicons loaded: [description]
   OR
   ℹ Lexicons not found (this is fine!)

**If lexicons not available**: Proceed with Socratic dialogue alone
```

---

## 5. Advanced Patterns

### 5.1 Skill Versioning

**Semantic versioning** (moai-alfred-agent-factory):
```yaml
---
name: moai-alfred-agent-factory
version: 1.0.0
status: production
---
```

**Change tracking**:
```markdown
## Changelog

### v1.1.0 (2025-11-20)
- Added: New template tier for micro-skills
- Changed: Improved domain detection algorithm
- Fixed: Edge case in model selection

### v1.0.0 (2025-11-15)
- Initial production release
```

---

### 5.2 Multi-Domain Skills

**Pattern**: Primary + secondary domains

**Example** (moai-alfred-agent-factory):
```markdown
Domain Detection:
- Primary: web-development (confidence: 0.85)
- Secondary: database-operations (confidence: 0.45)

Template selection based on primary domain
Skill recommendations include both domains
```

---

### 5.3 Template Systems

**Pattern**: Reusable templates with variable substitution

**Structure**:
```
skill/
├── SKILL.md
└── templates/
    ├── simple.template.md
    ├── standard.template.md
    ├── complex.template.md
    └── VARIABLE_REFERENCE.md
```

**Variable substitution** (moai-alfred-agent-factory):
```markdown
# templates/VARIABLE_REFERENCE.md

## Available Variables

### Agent Metadata
- {AGENT_NAME}: Agent identifier
- {AGENT_DESCRIPTION}: One-sentence purpose
- {DOMAIN}: Primary domain

### Configuration
- {MODEL}: sonnet|haiku|inherit
- {ALLOWED_TOOLS}: Tool list
- {REQUIRED_SKILLS}: Skill dependencies
```

---

## 6. Quality Assurance Patterns

### 6.1 Validation Framework

**Four quality gates** (moai-alfred-agent-factory):
```markdown
1. Gate 1: YAML syntax validation
   - Valid frontmatter structure
   - Required fields present
   - Correct data types

2. Gate 2: Required sections verification
   - Overview section exists
   - When to Use section exists
   - Core workflow documented

3. Gate 3: Content quality checks
   - Examples provided
   - Error handling documented
   - No broken references

4. Gate 4: Standards compliance
   - Follows naming conventions
   - Tool constraints defined
   - Progressive disclosure used
```

---

### 6.2 Test Cases

**Pattern**: Core + edge case test scenarios

**Example** (moai-alfred-agent-factory):
```markdown
## Test Cases

### Core Tests
1. Simple agent: To-do list manager
2. Standard agent: API client wrapper
3. Complex agent: Multi-step data pipeline

### Edge Cases
1. Multi-domain agent: Web + database
2. Minimal agent: Single function
3. No research: Offline generation
```

---

### 6.3 Self-Review Checklist

**Pattern**: Skill author verification

```markdown
## Skill Quality Checklist

### Activation
- [ ] Clear description with activation triggers
- [ ] Distinct from other skills
- [ ] Concrete use case examples

### Documentation
- [ ] SKILL.md <5k words
- [ ] Clear workflow structure
- [ ] Good/bad examples provided
- [ ] Error handling documented

### Tool Usage
- [ ] allowed-tools specified
- [ ] Minimum necessary tools
- [ ] Tool selection guidance

### Organization
- [ ] Progressive disclosure used
- [ ] No documentation duplication
- [ ] References properly linked
- [ ] Examples demonstrate key features

### Style
- [ ] Imperative voice used
- [ ] No second-person instructions
- [ ] Consistent formatting
- [ ] Clear section headers
```

---

## 7. Special Patterns by Skill Type

### 7.1 Document Manipulation Skills (docx, xlsx, pdf, pptx)

**Common patterns**:
```markdown
## Workflow Decision Tree
[Reading vs Creating vs Editing branches]

## Tool Selection Guide
[When to use which library]

## CRITICAL Requirements
[Zero errors, format preservation]

## Dependencies
[Auto-install vs pre-requisites]

## Code Style Guidelines
[Concise, minimal comments]
```

**Key features**:
- Explicit tool selection (pandas vs openpyxl)
- Format preservation requirements
- Verification steps (formula recalc)
- Error detection and fixing

---

### 7.2 Development Process Skills (TDD, debugging, verification)

**Common patterns**:
```markdown
## The Iron Law
[Non-negotiable core principle]

## Red Flags - STOP
[Violation detection triggers]

## Common Rationalizations
[Excuses and reality table]

## Integration with Other Skills
[Required and complementary skills]
```

**Key features**:
- Strong prescriptive language
- Violation prevention
- Process enforcement
- Clear checkpoints

---

### 7.3 Writing/Content Skills (collaborative-writing, article-extractor)

**Common patterns**:
```markdown
## Phased Approach
[Discovery → Architecture → Drafting → Review]

## Lexicon Integration (Optional)
[How to use when available, how to work without]

## Voice Calibration
[Maintaining consistency and authenticity]

## Examples of Complete Sessions
[Full workflows from start to finish]
```

**Key features**:
- Socratic dialogue
- Iterative refinement
- Voice consistency
- User collaboration

---

### 7.4 Technical Reference Skills (sql-optimization, python-performance)

**Common patterns**:
```markdown
## Pattern 1: [Name]
**Problem**: Description
**Solution**: Code example
**Why it works**: Explanation
**When to use**: Scenarios

## Pattern 2: [Name]
[Same structure]

## Best Practices
[Numbered list of principles]

## Common Pitfalls
[What to avoid]

## Monitoring and Debugging
[How to measure and troubleshoot]
```

**Key features**:
- Pattern catalog structure
- Before/after comparisons
- Performance metrics
- Tool-specific examples

---

### 7.5 Orchestration Skills (tapestry, moai-alfred-agent-factory)

**Common patterns**:
```markdown
## Master Workflow
[High-level orchestration flow]

## Component Skills
[What gets delegated to sub-skills]

## Integration Points
[How components communicate]

## Complete Examples
[End-to-end demonstrations]
```

**Key features**:
- Delegation strategy
- Component coordination
- Clear handoffs
- Unified interface

---

## 8. Actionable Guidelines Summary

### For Skill Creators

**Starting a new skill**:
1. Define single clear purpose
2. List 3-5 activation triggers
3. Determine allowed-tools (minimum necessary)
4. Sketch workflow phases
5. Identify what goes in SKILL.md vs references/

**Structuring documentation**:
1. Write SKILL.md first (<5k words)
2. Extract details to references/ when >500 lines
3. Provide 1-3 complete examples
4. Document common errors and solutions
5. Include verification steps

**Writing instructions**:
1. Use imperative voice ("Use X", not "You should use X")
2. Show code examples (good vs bad)
3. Number steps clearly
4. Provide decision trees for complex choices
5. Mark optional vs required steps

**Ensuring quality**:
1. Test with realistic scenarios
2. Verify all tool constraints work
3. Check for documentation duplication
4. Ensure progressive disclosure
5. Add self-review checklist

---

### For Skill Users

**Choosing the right skill**:
1. Read description for activation triggers
2. Check examples match your use case
3. Verify tool requirements align
4. Review complexity tier

**Using skills effectively**:
1. Follow workflows in order
2. Don't skip verification steps
3. Check red flags sections
4. Use examples as templates
5. Report issues and edge cases

---

### For Skill Maintainers

**Keeping skills healthy**:
1. Version updates semantically
2. Maintain changelog
3. Test with latest Claude versions
4. Monitor token usage
5. Collect user feedback

**Identifying problems**:
1. Skills with >10k word SKILL.md → extract references
2. Vague activation patterns → add concrete triggers
3. No examples → add 1-3 complete workflows
4. User confusion → add decision trees
5. Tool violations → add constraints

---

## 9. Patterns by Numbers

### Token Budgets
- SKILL.md: <5,000 words (ideally <2,000)
- Warning threshold: >10,000 tokens for reference files
- Progressive disclosure: 100 (metadata) → 5k (SKILL.md) → unlimited (references)

### Skill Size Tiers
- Simple: <200 lines SKILL.md, complexity 1-3, <5 min
- Standard: 200-500 lines, complexity 4-6, <15 min
- Complex: 500+ lines, complexity 7-10, 20-30 min

### Documentation Structure
- Activation triggers: 3-5 variants
- Code examples: Minimum 1-3 per workflow
- Error scenarios: Cover top 4-5 issues
- Workflow phases: 3-6 phases optimal

### Quality Gates
- 4 validation levels (YAML, structure, content, standards)
- 5 core test cases minimum
- 3 edge cases recommended

---

## 10. Common Questions

**Q: How do I know if my skill is too complex?**
A: If SKILL.md >5k words or you have 3+ distinct domains, split it.

**Q: Should I always specify allowed-tools?**
A: Yes, always. It's a security boundary and forces clarity.

**Q: When should I use references/ vs putting it in SKILL.md?**
A: SKILL.md = workflow guidance (<5k words). References = detailed docs loaded as needed.

**Q: How many examples should I include?**
A: Minimum 1 complete example per major workflow. Add 2-3 more for common variations.

**Q: What if my skill needs to load a lot of context?**
A: Use progressive disclosure: lean SKILL.md, delegate heavy work to subagents, or load references conditionally.

**Q: How do I prevent my skill from overlapping with others?**
A: Write specific activation triggers with concrete scenarios. Test against similar skills.

**Q: Should I use tables or prose for documentation?**
A: Tables for comparisons/reference, prose for workflows. Mix both.

**Q: How formal should the language be?**
A: Direct and imperative. Avoid: "you should", "you can", "it's recommended". Use: "Use X", "Run Y", "Follow Z".

**Q: What about backward compatibility when updating skills?**
A: Use semantic versioning. Major changes = breaking, minor = additions, patch = fixes.

**Q: How do I test if my skill will activate correctly?**
A: Write your description with concrete triggers, then test variations with example user requests.

---

## Conclusion

Effective Claude Code skills share these core attributes:

1. **Clear activation patterns** - Explicit triggers with multiple variants
2. **Progressive disclosure** - Lean SKILL.md, detailed references loaded as needed
3. **Tool constraints** - Minimum necessary tools specified
4. **Imperative instructions** - Direct, verb-first commands
5. **Concrete examples** - Real demonstrations, not abstract descriptions
6. **Quality gates** - Verification steps and validation frameworks
7. **Error handling** - Common issues documented with solutions
8. **Modular structure** - Single responsibility, composable with other skills

The most successful skills follow these patterns consistently, creating a reliable and predictable experience for users while maintaining efficient token usage and clear boundaries.

Use this analysis as a checklist when creating, reviewing, or maintaining skills to ensure they follow proven patterns and avoid common pitfalls.

---

**Document Version**: 1.0
**Analysis Date**: 2025-11-18
**Skills Analyzed**: 20+
**Maintainer**: Extracted from Claude Code skills ecosystem
