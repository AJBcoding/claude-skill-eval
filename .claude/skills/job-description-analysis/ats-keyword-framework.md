# ATS Keyword Framework

## Overview

Applicant Tracking Systems (ATS) screen resumes by keyword matching before human review. Understanding how they work enables strategic keyword usage that passes screening without "stuffing."

## How ATS Systems Work

### Parsing & Extraction
1. ATS extracts text from resume (PDF, Word, plain text)
2. Identifies sections (experience, education, skills)
3. Extracts keywords and phrases
4. Scores against job description requirements

### Scoring Logic
**Keyword presence:** Does keyword appear? (binary yes/no)
**Keyword frequency:** How many times? (2-3x ideal, 1x weak, 5+ suspicious)
**Context matching:** Is keyword used in proper context?
**Section placement:** Where does it appear? (summary > experience > skills)

**Common scoring:**
- Exact match: 100% (e.g., "stakeholder management")
- Synonym match: 70-80% (e.g., "partner engagement" for "stakeholder management")
- Related term: 40-60% (e.g., "relationship building" for "stakeholder management")
- No match: 0%

## Keyword Density Best Practices

### The 2-3x Rule
**Optimal:** 2-3 mentions of critical keywords
- 1x = Weak signal (might be coincidence)
- 2-3x = Strong signal (demonstrates pattern)
- 4+x = Suspicious (possible keyword stuffing)

**Exception:** Common industry terms can appear more frequently naturally

### Strategic Placement Pattern

**Priority order (ATS weighting):**
1. **Professional Summary** (highest weight) - 1x critical keywords
2. **Recent Experience** (high weight) - 2x in different contexts
3. **Skills Section** (medium weight) - 1x for technical terms
4. **Earlier Experience** (lower weight) - contextual usage

**Example:**
```
✅ GOOD:
Summary: "Senior leader with expertise in stakeholder management..."
Experience (recent): "Managed stakeholder relationships across 5 campuses..."
Experience (recent): "Facilitated stakeholder alignment for $10M project..."
Skills: "Stakeholder Engagement, Partner Relations"

❌ STUFFING:
Summary: "Stakeholder management expert with stakeholder management experience in stakeholder management contexts..."
```

## Context Matching

### Keywords Need Context

**ATS scans for context clues around keywords:**

✅ **Strong context:**
"Stewarded $12M capital project from conception through delivery"
- Keyword: "capital project"
- Context: budget size, scope, role
- ATS score: HIGH

⚠️ **Weak context:**
"Familiar with capital projects"
- Keyword: "capital project"
- Context: vague, no specifics
- ATS score: LOW

❌ **No context:**
"Skills: Capital Projects, Budgeting, Management"
- Keyword: present but isolated
- Context: none (just list)
- ATS score: MINIMAL

### Context Enhancement Techniques

**Add quantification:**
- Not: "Managed projects"
- Yes: "Managed 5 projects totaling $20M"

**Add outcomes:**
- Not: "Led stakeholder engagement"
- Yes: "Led stakeholder engagement resulting in 95% approval"

**Add scope:**
- Not: "Budget oversight"
- Yes: "Budget oversight for $15M capital program across 3 facilities"

## Synonym Strategies

### Why Synonyms Matter

**Job descriptions use varied language:**
- "Stakeholder management" OR "partner engagement" OR "relationship building"
- ATS may score all as related but weight exact match higher

**Strategy:** Use exact match 2-3x, use synonyms for additional context

### Common Synonym Patterns

**Leadership:**
- Led = Stewarded, Directed, Oversaw, Guided, Managed
- Built = Developed, Created, Established, Launched, Founded

**Collaboration:**
- Stakeholder management = Partner engagement, Relationship building, Collaboration
- Cross-functional = Interdisciplinary, Multi-departmental, Integrated

**Financial:**
- Budget management = Fiscal oversight, Financial stewardship, Resource allocation
- Revenue growth = Income generation, Financial development, Earned revenue

### Synonym Usage Pattern

```
✅ STRATEGIC:
- "Stewarded $12M capital project..." (exact match: stewarded)
- "Led cross-functional team..." (synonym: led)
- "Directed budget planning..." (synonym: directed)

❌ MISSED OPPORTUNITY:
- "Managed project..." (generic)
- "Managed team..." (generic)
- "Managed budget..." (repetitive, no keyword variation)
```

## Industry-Specific Keyword Patterns

### Higher Education / Academic
**Common keywords:**
- Student success, enrollment, retention, recruitment
- Curriculum development, pedagogy, assessment
- Accreditation, program review, learning outcomes
- EDIAB, inclusive excellence, access, equity
- Faculty relations, shared governance

**ATS tip:** Use both academic ("pedagogy") and accessible ("teaching methods") versions

### Nonprofit / Arts
**Common keywords:**
- Mission-driven, community impact, stakeholder engagement
- Fundraising, development, donor relations, grant writing
- Board relations, governance, strategic planning
- Program evaluation, outcome measurement
- Community partnerships, public service

### Corporate / Business
**Common keywords:**
- P&L management, ROI, KPIs, metrics
- Strategic planning, business development, market analysis
- Change management, process improvement, operational excellence
- Cross-functional leadership, matrix management

## Common ATS Pitfalls to Avoid

### 1. Keyword Stuffing
**Problem:** Repetitive, unnatural keyword usage
**Detection:** ATS flags 5+ uses of same keyword, unusual keyword density
**Fix:** Use 2-3x rule, incorporate synonyms

### 2. Graphics & Tables
**Problem:** ATS can't read text in images or complex tables
**Detection:** ATS extracts empty strings or garbled text
**Fix:** Use plain text, simple formatting, avoid images with text

### 3. Uncommon Section Headers
**Problem:** ATS can't identify sections (e.g., "My Journey" instead of "Experience")
**Detection:** ATS misclassifies content, misses keywords in wrong section
**Fix:** Use standard headers (Experience, Education, Skills, Summary)

### 4. PDFs with Accessibility Issues
**Problem:** Some PDFs not machine-readable (scanned images, locked files)
**Detection:** ATS extracts no text
**Fix:** Ensure PDF is text-based (test by copying text from PDF)

### 5. Acronyms Without Spelled-Out Version
**Problem:** ATS might not match "PM" to "project management"
**Detection:** Missed keyword matches
**Fix:** First use: "Project Management (PM)", subsequent: "PM" alone

### 6. Skills Section Only
**Problem:** Keywords only in skills list, no context in experience
**Detection:** Low context score despite keyword presence
**Fix:** Use keywords in experience bullets, not just skills section

## Strategic Keyword Workflow

**From job description analysis:**

1. **Extract critical keywords** (required skills, repeated 3+x)
2. **Identify exact phrases** used in posting
3. **Map to resume experiences** (where can these naturally appear?)
4. **Calculate current frequency** (how many times already present?)
5. **Plan additions** (where to add 1-2 more mentions with context)
6. **Verify context** (each usage has quantification/scope/outcome)
7. **Check density** (2-3x for critical, 1-2x for important)
8. **Test readability** (does it still sound natural?)

## Example: Keyword Optimization

**Job description keyword:** "Stakeholder Management" (appears 5x in posting)

**Current resume:**
```
✗ No mentions of "stakeholder"
✗ Generic "managed relationships" (1x, vague)
```

**Optimized resume:**
```
Summary:
"Senior arts administrator with expertise in stakeholder management..."

Experience (Recent Position):
"Stewarded $12M capital project, managing stakeholder relationships across
city government, donor community, and campus leadership, achieving 100%
on-time regulatory approvals"

Experience (Earlier Position):
"Facilitated stakeholder alignment for strategic planning process, engaging
200+ faculty, staff, and students through listening sessions and data-driven
recommendations"

Skills:
"Stakeholder Engagement • Partner Relations • Community Building"
```

**Result:**
- Exact match "stakeholder management": 1x (summary)
- Keyword "stakeholder": 4x total (natural contexts)
- Synonyms: "partner relations" (skills), "engagement" (multiple)
- Context: budgets, scope, outcomes provided
- Density: Appropriate (not stuffing)

---

**Remember:** ATS optimization is about strategic clarity, not gaming. If you genuinely have the experience, keywords should fit naturally with proper context.