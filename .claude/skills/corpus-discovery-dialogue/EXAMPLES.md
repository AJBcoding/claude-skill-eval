# Corpus Discovery Dialogue - Example Outputs

This document contains example outputs from the corpus-discovery-dialogue skill for different corpus types. These examples demonstrate what a complete Research Questions Framework looks like after the 5-phase Socratic dialogue process.

---

## Example 1: Theater Review Corpus

**Corpus Type:** Arts criticism
**Size:** 464 theater reviews, ~243K words
**Time Span:** 2010-2025 (15 years)
**Authorship:** Single critic
**User Goal:** Understand critical voice evolution

### Sample Research Questions Framework (Excerpt)

```markdown
---
title: Research Questions Framework
project: Theater Review Corpus Analysis
created: 2025-11-16
researcher: Theater Critic
corpus: 464 KCRW theater reviews, 2010-2025
created_with: corpus-discovery-dialogue skill v1.0
status: Initial Framework
version: 1.0
---

# Research Questions Framework: Theater Review Corpus Analysis

## I. Corpus Profile

**Domain:** Theater criticism (Los Angeles theater scene)
**Type:** Arts reviews (radio broadcast + web publication)
**Size:** Medium corpus: 464 documents, ~243K words (~524 words/review)
**Temporal Span:** 2010-05-11 to 2020-04-13 (10 years)
**Authorship:** Single author (sustained critical voice)
**Format:** JSON with structured metadata (dates, titles, some categories)
**Data Status:** Ready for analysis

**Analytical Implications:**
- **Size supports:** Topic modeling, sentiment analysis, entity extraction, network analysis, temporal tracking
- **Temporal span enables:** Evolution tracking, trend analysis, period comparison, change point detection
- **Single authorship enables:** Voice evolution, style development, personal pattern tracking, thematic shift analysis
- **Metadata supports:** Temporal aggregation (by year/month), categorical comparison if categories expanded

**Sample Texts Reviewed:** 5 representative reviews
**Representative Features:**
- Length range: 300-750 words per review
- Writing style: Evaluative, analytical, narrative-driven with vivid description
- Content focus: Performance quality, directorial vision, production design, emotional impact
- Domain terminology: "blocking," "proscenium," "ensemble," "intimacy," "visceral"

---

## II. Research Interests & Assumptions

### Primary Motivation

Personal connection - This is your own theater criticism over 15 years. You want to understand how your critical voice has evolved, what patterns define your work, and whether your self-perception of change matches computational evidence.

### Puzzles & Intrigues

1. **Voice evolution puzzle:** You sense your critical voice has changed—perhaps more enthusiastic, perhaps more focused on intimacy—but can't quantify how or when this shift occurred.

2. **Entity network puzzle:** You notice certain plays, venues, and artists appear repeatedly. What patterns exist in your critical attention? Is there a "core" LA theater ecosystem in your reviews?

3. **Language evolution puzzle:** Your language feels different now than in 2010—maybe more emotional, maybe more analytical—but you're not sure which direction or what drove changes.

### Explicit Assumptions (Worth Testing)

**Surprise Indicators (what would contradict your expectations):**
- Surprise if: No temporal evolution in sentiment (assumes change occurred)
- Surprise if: Sentiment trends opposite to memory (assumes you remember accurately)
- Surprise if: No distinctive entity clusters (assumes network structure exists)
- Current assumption: You've become more positive/enthusiastic over time; small theaters increasingly central

**Disappointment Indicators (what you hope to find):**
- Disappointed if: No distinctive voice markers (wants evidence of unique critical style)
- Disappointed if: No entity relationship patterns (suspects LA theater network exists in reviews)
- Disappointed if: Topics are incoherent (wants meaningful thematic structure)

### Stakes & Audience

**Primary Stakes:** Personal + Professional
- Understand your own critical evolution (personal insight)
- Potentially publish analysis (academic article on arts criticism evolution)
- Inform future critical practice (professional development)

**Intended Audience:**
- Theater practitioners (who you review)
- Other arts critics (peer community)
- Potentially academic audience (theater studies, media studies)

**Expected Contribution:**
- Documenting a decade of LA theater through one critic's lens
- Understanding how critical voices evolve over sustained practice
- Methodology for computational analysis of arts criticism

**Success Metric:**
- Evidence of voice evolution (confirms or revises self-perception)
- Meaningful patterns in critical attention (entity networks make sense)
- Publishable findings (novel contribution to arts criticism literature)

**Implicit Hypotheses Worth Testing:**

1. **Sentiment evolution hypothesis:** Critical tone has become more positive over 15 years (testable with sentiment analysis)

2. **Intimacy theme hypothesis:** Focus on intimate, small-scale theater has increased (testable with topic modeling + entity analysis)

3. **Entity centrality hypothesis:** Certain venues/artists are central to network, reflecting LA theater ecosystem structure (testable with entity extraction + network analysis)

4. **Stylistic shift hypothesis:** Language has evolved—vocabulary, phrase patterns, evaluative terms (testable with keyness analysis + collocation extraction)

---

## III. Research Questions

### Primary Questions

**RQ1: How has the emotional tenor of theater criticism evolved 2010-2025?**

- **Priority:** High (directly addresses voice evolution puzzle)
- **Rationale:** You sense your critical voice has changed in enthusiasm/positivity but lack empirical evidence. Sentiment analysis provides quantifiable, temporal evidence.
- **Addresses Interest:** Voice evolution puzzle, sentiment assumption
- **Expected Contribution:** Empirical evidence of critical tone evolution; comparison with self-perception
- **Analytical Approach:** Sentiment analysis with temporal tracking (VADER + Transformers)
- **Estimated Time:** 8-12 hours

**RQ2: What are the dominant critical frameworks across the corpus, and how have they evolved?**

- **Priority:** High (reveals thematic structure and temporal shifts)
- **Rationale:** Understanding what you emphasize (performance, direction, social context, etc.) and whether emphases have shifted over time reveals critical priorities.
- **Addresses Interest:** Voice evolution puzzle, intimacy hypothesis
- **Expected Contribution:** Thematic map of criticism; evidence for/against intimacy theme increase
- **Analytical Approach:** Topic modeling with temporal dynamics (BERTopic)
- **Estimated Time:** 10-15 hours

**RQ3: What plays, venues, and artists are central to the critical network, and what clusters exist?**

- **Priority:** High (addresses entity network puzzle)
- **Rationale:** Reveals the "ecosystem" of your critical attention—which entities dominate, which appear together, whether small/large venues cluster separately.
- **Addresses Interest:** Entity network puzzle, intimacy hypothesis (small theater centrality)
- **Expected Contribution:** Network visualization of LA theater through critic's lens; entity centrality rankings
- **Analytical Approach:** Named entity recognition + co-occurrence network analysis (spaCy + NetworkX)
- **Estimated Time:** 12-18 hours

**RQ4: What language distinguishes early (2010-2015) from recent (2020-2025) criticism?**

- **Priority:** Medium-High (addresses stylistic shift hypothesis)
- **Rationale:** Identifies specific vocabulary/phrase changes, providing linguistic evidence for voice evolution beyond sentiment.
- **Addresses Interest:** Language evolution puzzle, stylistic shift hypothesis
- **Expected Contribution:** Distinctive term lists showing vocabulary evolution; evidence of linguistic drift
- **Analytical Approach:** Comparative keyness analysis + collocation extraction (Scattertext)
- **Estimated Time:** 6-10 hours

### Deferred Questions (Future Exploration)

**Interesting but not prioritized for initial analysis:**

1. **Sentiment arcs within reviews:** Do reviews follow predictable emotional trajectories (critical→appreciative, skeptical→convinced)?
   - **Why deferred:** Requires sentence-level analysis; complex; not core interest
   - **When to revisit:** If RQ1 reveals interesting sentiment patterns worth investigating further

2. **Comparative analysis with other LA critics:** How does your criticism compare to other critics covering same theater scene?
   - **Why deferred:** Requires external corpus (other critics' work); scope expansion
   - **When to revisit:** If initial analysis reveals patterns worth comparing externally

3. **Production element focus:** What gets more critical attention: acting, directing, writing, design?
   - **Why deferred:** Overlaps with RQ2 (topics may reveal this); secondary interest
   - **When to revisit:** If RQ2 topic model doesn't clearly distinguish production elements

### Question Dependencies

**Independent Questions (any order):**
- RQ1 (Sentiment evolution)
- RQ2 (Topic modeling)
- RQ3 (Entity networks)
- RQ4 (Keyness analysis)

All four questions can be pursued in parallel—none requires another's outputs.

**Complementary Questions (stronger together):**
- RQ1 + RQ2: Sentiment evolution may correlate with thematic shifts (e.g., intimacy theme → positive sentiment)
- RQ2 + RQ3: Topics may align with entity clusters (e.g., "intimacy" topic → small venue entities)
- RQ1 + RQ4: Sentiment changes may be reflected in vocabulary shifts (e.g., positive sentiment → evaluative terms like "masterful")

---

## IV. Methodological Roadmap

### RQ1: How has the emotional tenor of theater criticism evolved 2010-2025?

**Analytical Approach:** Sentiment analysis with temporal tracking

#### Tools & Installation

**Primary:** VADER (Valence Aware Dictionary and sEntiment Reasoner)
- Purpose: Lexicon-based sentiment scoring optimized for social media/short texts (-1 to +1 compound score)
- Installation: `pip install vaderSentiment`
- Documentation: https://github.com/cjhutto/vaderSentiment

**Secondary:** Transformers (Hugging Face)
- Purpose: Neural sentiment classification using pre-trained models (distilbert-base-uncased-finetuned-sst-2)
- Installation: `pip install transformers torch`
- Documentation: https://huggingface.co/distilbert-base-uncased-finetuned-sst-2

**Validation:** Pandas + Matplotlib
- Purpose: Data manipulation and visualization for manual review
- Installation: `pip install pandas matplotlib`

#### Procedure

1. **Data Preparation** [Estimated time: 1-2 hours]
   - Load 464 reviews from JSON into pandas DataFrame
   - Extract text, dates, IDs
   - Parse dates into datetime objects
   - Create year/month fields for temporal aggregation
   - Validate: no missing texts, all dates parseable

2. **Sentiment Scoring** [Estimated time: 2-3 hours]
   - Initialize VADER SentimentIntensityAnalyzer
   - Score each review: `analyzer.polarity_scores(text)['compound']`
   - Initialize Transformer pipeline: `pipeline("sentiment-analysis")`
   - Score each review: extract positive probability
   - Store both scores in DataFrame (vader_score, transformer_score)

3. **Temporal Aggregation** [Estimated time: 1-2 hours]
   - Group reviews by year: `df.groupby('year')`
   - Calculate mean sentiment per year (both VADER and Transformer)
   - Calculate standard deviation and standard error (for error bars)
   - Identify outliers (reviews > 2 std dev from yearly mean)
   - Create temporal trend dataset (year, mean_vader, std_vader, mean_transformer, std_transformer, n_reviews)

4. **Trend Analysis** [Estimated time: 1-2 hours]
   - Visualize: Line graph with years on x-axis, mean sentiment on y-axis, error bars showing std error
   - Plot both VADER and Transformer trends (dual lines)
   - Calculate linear regression: `scipy.stats.linregress(years, sentiments)`
   - Test for significant trend (p-value < 0.05)
   - Calculate correlation between VADER and Transformer (should be r > 0.7)
   - Identify change points (years where trend shifts direction)

5. **Validation** [Estimated time: 2-3 hours]
   - Sort reviews by sentiment score (both tools)
   - Extract top 20 VADER scores: manually read, code as correct/incorrect/ambiguous
   - Extract bottom 20 VADER scores: manually read, code as correct/incorrect/ambiguous
   - Extract 10 reviews with largest VADER-Transformer divergence: investigate why
   - Calculate error rate: (incorrect / total reviewed) * 100
   - Acceptable threshold: < 20% error rate

6. **Interpretation** [Estimated time: 1-2 hours]
   - Write summary: direction of trend (increase/decrease/stable), magnitude (% change), significance (p-value)
   - Connect to research question: Does this confirm/contradict your self-perception?
   - Note limitations: Could be linguistic drift (language norms changing) vs. genuine sentiment change
   - Extract representative quotes from high/low periods

#### Expected Evidence

**Quantitative:**
- Sentiment score dataset (464 rows: review_id, date, year, vader_score, transformer_score)
- Temporal aggregation (11 rows for 2010-2020: year, mean_vader, std_vader, n_reviews)
- Trend statistics (slope=0.007, p=0.03, r²=0.42) [example values]
- Correlation (VADER-Transformer r=0.84, p<0.001)

**Visual:**
- Sentiment-over-time line graph (dual lines for VADER/Transformer, error bars)
- Distribution histograms per period (2010-2014 vs 2015-2020)
- Scatter plot: VADER vs Transformer (shows agreement)

**Qualitative:**
- High-sentiment examples (2020): "Triumphant, visceral, transformative..."
- Low-sentiment examples (2012): "Uneven, lacks coherence, disappointing..."
- Validation notes: "Of 40 manually reviewed, 34 correctly classified (85% accuracy)"

**What This Shows:**
- Whether sentiment increased/decreased/remained stable 2010-2020
- How reliable sentiment tools are for theater criticism (cross-tool agreement)
- Periods of particularly positive/negative criticism
- Example language associated with high/low sentiment

#### Validation Strategy

**Computational Validation:**
- Cross-tool agreement: VADER vs Transformer correlation > 0.7 (indicates both tools see similar patterns)
- Outlier investigation: Reviews with extreme scores reviewed manually (are they genuinely extreme or tool error?)
- Baseline check: Is sentiment range (-0.5 to +0.8) plausible for theater reviews? (Compare to external corpora if available)

**Manual Validation:**
- Review 40 documents total:
  - 20 highest VADER scores (check for false positives: sarcasm, irony)
  - 20 lowest VADER scores (check for false negatives: genuine negativity vs neutral)
- Code each as: ✓ Correctly classified / ✗ Misclassified / ~ Ambiguous
- Acceptable error rate: < 20% misclassified
- If error > 20%: Caveat findings or adjust method (e.g., retrain model on theater reviews)

**External Validation:**
- Compare sentiment trends with known LA theater events:
  - Economic recession 2008-2010 (might predict lower sentiment early)
  - COVID-19 2020 (might predict sentiment shift)
  - Your personal life events (if known and relevant)
- Cross-reference with self-reflection: Ask "Does this trend match your memory of becoming more/less positive?"
- Domain expertise check: Share findings with other theater critics—does trend align with field knowledge?

**Alternative Explanation Checks:**
- **Selection bias test:** Could sentiment change reflect what you chose to review (more positive shows → higher sentiment)? Investigate review coverage rate.
- **Linguistic drift test:** Could this be language norms changing (critics generally more positive) vs. your personal shift? Compare with external theater criticism corpus if available.
- **Method artifact test:** Could this be VADER/Transformer limitation (tools calibrated on different text) vs. real pattern? Cross-validation with third tool (TextBlob) as tiebreaker.

#### Confidence Assessment

**Level:** High

**Rationale:**
- Sentiment analysis is well-established for evaluative text (theater reviews are ideal: opinion-based, evaluative language)
- Corpus size (464 reviews) is sufficient for temporal trend analysis
- Dual-tool approach mitigates individual tool limitations
- Validation strategy is robust (computational + manual + external)
- Evidence type is clear and measurable (quantitative scores, visualizations, examples)

**Potential Challenges:**
- **Sarcasm/irony:** Theater criticism sometimes uses ironic praise ("a triumph of tedium"). Mitigated by: manual review, Transformer model better at context.
- **Domain-specific language:** Terms like "uneven" (common in theater reviews) might not align with general sentiment lexicons. Mitigated by: dual tools, manual validation.
- **Selection bias:** Can't fully separate "what you chose to review" from "how you reviewed it." Acknowledged as limitation, partially investigable.

**Confidence Justification:**
Despite challenges, we have high confidence RQ1 is answerable because:
1. Two validated tools with different approaches (lexicon vs neural)
2. Large enough corpus for statistical significance (464 reviews, 11 years)
3. Manual validation catches tool errors
4. Clear quantitative evidence (trend slope, p-value)

#### Estimated Effort

**Time:** 8-12 hours total
- Setup & data prep: 1-2 hours
- Sentiment scoring: 2-3 hours
- Temporal aggregation & trend analysis: 2-3 hours
- Validation (manual review): 2-3 hours
- Interpretation & write-up: 1-2 hours

**Expertise Required:**
- **Programming:** Basic Python (load data, run functions, create plots)
- **Statistics:** Understanding p-values, correlations, standard deviation
- **Domain knowledge:** You have this—essential for validation (recognizing sarcasm, judging correct classification)

**Computational Resources:**
- **Hardware:** Standard laptop sufficient (no GPU required for VADER; Transformer runs on CPU for 464 reviews)
- **Storage:** ~50 MB for tools, ~10 MB for outputs
- **Execution time:** ~10 minutes for scoring all 464 reviews

**Dependencies:**
- **Requires first:** Data Preparation (Phase A) completed
- **Blocks:** None—RQ1 is independent
- **Informs:** RQ2 (sentiment context for topic interpretation), RQ4 (sentiment may correlate with vocabulary change)

---

[Similar detailed mappings would follow for RQ2, RQ3, RQ4...]

---

## V. Execution Plan

### Phase A: Data Preparation

**Goal:** Load corpus, validate quality, create analysis-ready dataset

**Tasks:**
- [ ] Load 464 reviews from JSON into Python environment (pandas DataFrame)
- [ ] Validate data quality:
  - [ ] No missing values in 'text' field (all 464 reviews have content)
  - [ ] No missing values in 'date' field (all reviews have dates)
  - [ ] Text encoding correct (no garbled characters like â€™ instead of apostrophes)
  - [ ] Dates parseable (all dates convert to datetime successfully)
  - [ ] Review IDs unique (no duplicate reviews)
- [ ] Create temporal metadata:
  - [ ] Parse 'date' strings to datetime objects
  - [ ] Extract 'year' field (2010-2020)
  - [ ] Extract 'month' field (for fine-grained analysis if needed)
  - [ ] Validate temporal distribution (no suspicious gaps or spikes)
- [ ] Run basic descriptive statistics:
  - [ ] Total document count: 464 ✓
  - [ ] Word count per review (min, max, mean, median)
  - [ ] Character count per review
  - [ ] Reviews per year (histogram to check temporal distribution)
  - [ ] Missing metadata: Check for any incomplete fields

**Estimated Time:** 2-4 hours

**Completion Checkpoint:**
✓ Data loaded: 464 reviews in DataFrame
✓ Quality validation: 100% complete text, 100% parseable dates, no duplicates
✓ Temporal metadata: Year/month fields created and validated
✓ Descriptive statistics: Documented in `data-description.txt`

**Critical Decision Point:** Do NOT proceed to RQ analyses until:
- All 464 reviews load successfully
- No data quality issues (encoding, missing values)
- Temporal distribution makes sense (reviews spread across 2010-2020)

If issues found: Fix data before continuing. Document any exclusions (e.g., if malformed reviews excluded).

---

### Phase B: RQ1 Analysis - Sentiment Evolution

[Full checklist from RQ1 procedure, broken into checkboxes...]

---

## VIII. Next Steps

### Immediate (Before Starting Analysis)

1. **Review this framework** ✓
   - Does it capture your research goals? (Voice evolution, entity networks, thematic structure)
   - Are these still the questions you want to answer?
   - Is timeline realistic? (36-55 hours = 7-11 weeks at 5 hours/week, 4-6 weeks at 10 hours/week)

2. **Gather tools**
   - [ ] Install Python 3.8+ (if not already installed)
   - [ ] Install required packages:
     ```bash
     pip install pandas numpy matplotlib
     pip install vaderSentiment transformers torch
     pip install bertopic sentence-transformers
     pip install spacy networkx
     pip install scattertext
     python -m spacy download en_core_web_sm
     ```
   - [ ] Set up Jupyter notebook environment (recommended for interactive analysis)

3. **Prepare workspace**
   - [ ] Create project directory structure:
     ```
     ~/theater-review-analysis/
       ├── 00-research-questions-framework.md (this document)
       ├── data/
       │   └── all_episodes_with_content.json
       ├── analysis/
       │   ├── 01_data_preparation.ipynb
       │   ├── 02_sentiment_analysis.ipynb
       │   ├── 03_topic_modeling.ipynb
       │   ├── 04_entity_extraction.ipynb
       │   └── 05_keyness_analysis.ipynb
       ├── outputs/
       │   ├── sentiment/
       │   ├── topics/
       │   ├── entities/
       │   └── keyness/
       ├── interpretations/
       └── methodology/
     ```

### Phase A: Data Preparation (Start Here)

1. **Load and validate corpus** (Phase A checklist)
2. **Run descriptive statistics**
3. **Document data quality**
4. **Checkpoint:** Confirm 464 reviews loaded, dates valid, no missing data

### Recommended Analysis Order

**Week 1-2: Data Preparation + RQ1**
- Complete Phase A (data prep)
- Execute RQ1 (sentiment analysis)
- Use analysis-interpretation-dialogue to interpret sentiment results

**Week 3-4: RQ2**
- Execute RQ2 (topic modeling)
- Use analysis-interpretation-dialogue to interpret topics
- Use pattern-verification-dialogue if interesting patterns emerge

**Week 5-6: RQ3**
- Execute RQ3 (entity network analysis)
- Use analysis-interpretation-dialogue to interpret network

**Week 7-8: RQ4 + Synthesis**
- Execute RQ4 (keyness analysis)
- Use research-synthesis-dialogue to integrate all findings
- Use methodology-documentation-dialogue to document process

**Timeline:** 7-8 weeks at 5 hours/week

---

**Framework Status:** ✅ Complete - Ready for execution

**Created:** 2025-11-16
**Next Action:** Install tools, prepare workspace, begin Phase A

---

*Created with corpus-discovery-dialogue skill v1.0*
```

### Key Features of This Example

1. **Corpus profile grounded in actual data:** 464 reviews, 243K words, 2010-2020
2. **Interest map reveals testable assumptions:** Sentiment evolution hypothesis, intimacy theme hypothesis
3. **4 concrete, answerable questions:** Each with clear evidence type
4. **Detailed methodological roadmap:** Step-by-step procedures, tools, validation
5. **Realistic timeline:** 36-55 hours = 7-11 weeks at 5-10 hours/week
6. **Built-in validation:** Multiple strategies per finding
7. **Actionable next steps:** Install tools, create workspace, begin Phase A

---

## Example 2: Business Reports Corpus

**Corpus Type:** Corporate communications
**Size:** 200 quarterly earnings reports, ~400K words
**Time Span:** 2015-2023 (8 years)
**Authorship:** Institutional (Fortune 500 company)
**User Goal:** Understand strategic framing evolution

### Sample Research Questions Framework (Excerpt)

```markdown
# Research Questions Framework: Corporate Communications Analysis

## I. Corpus Profile

**Domain:** Corporate communications (Fortune 500 quarterly earnings reports)
**Type:** Financial/strategic reports (SEC filings + investor presentations)
**Size:** Medium corpus: 200 documents (50 reports/year × 4 quarters), ~400K words (~2000 words/report)
**Temporal Span:** 2015 Q1 to 2023 Q4 (8 years, 32 quarters)
**Authorship:** Institutional (corporate communications team, CEO, CFO)
**Format:** PDF documents (need text extraction) + structured metadata (quarter, year, stock price)
**Data Status:** Partially ready (PDFs collected, extraction needed)

**Analytical Implications:**
- **Size supports:** Topic modeling, sentiment analysis, keyness analysis, temporal tracking
- **Temporal span enables:** Quarterly trend analysis, annual comparison, strategic shift detection
- **Institutional authorship enables:** Organizational voice evolution, consensus analysis, policy framing
- **Metadata supports:** Correlation with stock performance, quarterly/annual aggregation

---

## II. Research Interests & Assumptions

### Primary Motivation

Professional interest - You're analyzing how a major corporation frames strategic messaging over 8 years. Interest in understanding:
- How strategic priorities shift (cost-cutting → growth → innovation)
- How language evolves (optimistic → cautious → optimistic?)
- Whether framing correlates with performance (stock price changes)

### Puzzles & Intrigues

1. **Strategic framing puzzle:** Reports seem to shift emphasis over time—early focus on restructuring, recent focus on innovation—but is this real or perception bias?

2. **Sentiment-performance puzzle:** Do reports become more positive when stock rises, more cautious when it falls? Or is messaging independent of performance?

3. **Jargon evolution puzzle:** Corporate language feels increasingly "innovative" and "disruptive"—is this measurable?

### Explicit Assumptions (Worth Testing)

**Surprise if:**
- Messaging is completely independent of stock performance (assumes some correlation)
- No linguistic evolution (assumes corporate language evolves with trends)
- Topics are stable across 8 years (assumes strategic priorities shift)

**Current assumptions:**
- Early reports (2015-2017) emphasize "cost-cutting" and "efficiency"
- Recent reports (2021-2023) emphasize "innovation" and "digital transformation"
- Sentiment correlates with stock price (positive when rising, cautious when falling)

---

## III. Research Questions

### Primary Questions

**RQ1: How has strategic framing evolved 2015-2023?**

- **Priority:** High
- **Rationale:** Central to understanding corporate messaging shifts
- **Analytical Approach:** Topic modeling with temporal dynamics (BERTopic or LDA)
- **Estimated Time:** 12-16 hours

**RQ2: What language distinguishes early (2015-2017) from recent (2021-2023) reports?**

- **Priority:** High
- **Rationale:** Identifies vocabulary shifts, tests "innovation language" hypothesis
- **Analytical Approach:** Keyness analysis (Scattertext, log-likelihood)
- **Estimated Time:** 8-12 hours

**RQ3: How does sentiment correlate with stock performance?**

- **Priority:** Medium-High
- **Rationale:** Tests whether messaging adapts to financial reality or maintains consistency
- **Analytical Approach:** Sentiment analysis + correlation with stock price metadata
- **Estimated Time:** 10-14 hours

### Deferred Questions

1. **CEO vs CFO language differences:** Requires identifying which sections each executive wrote (complex, metadata-intensive)
2. **Industry comparison:** Requires external corpus of competitor reports (scope expansion)

---

## IV. Methodological Roadmap

### RQ1: Strategic Framing Evolution

**Analytical Approach:** Topic modeling with temporal tracking

**Tools:**
- BERTopic (semantic topic modeling)
- PyMuPDF (PDF text extraction)

**Procedure:**
1. **PDF Extraction** [4-6 hours]
   - Extract text from 200 PDFs
   - Validate extraction quality (check for garbled tables, missing sections)
   - Clean extracted text (remove headers/footers, page numbers)

2. **Topic Modeling** [6-8 hours]
   - Generate document embeddings
   - Cluster by semantic similarity
   - Extract representative terms per topic
   - Track topic prevalence over time (quarterly)

3. **Validation** [2-3 hours]
   - Manual review of topic coherence
   - Check topic-document assignments
   - Verify temporal patterns align with known corporate events

**Expected Evidence:**
- 10-15 coherent topics (e.g., "Cost Reduction," "Digital Innovation," "Global Expansion")
- Topic evolution heatmap (quarters on x-axis, topics on y-axis, color = prevalence)
- Representative reports per topic

**Confidence:** Medium-High (topic modeling robust, but PDF extraction may introduce noise)

**Estimated Time:** 12-16 hours

---

[Similar mappings for RQ2, RQ3...]

---

## V. Execution Plan

### Phase A: Data Preparation & PDF Extraction

- [ ] Extract text from 200 PDF reports
- [ ] Validate extraction quality (manually review 10 random extracts)
- [ ] Clean text (remove artifacts)
- [ ] Structure metadata (quarter, year, stock_price_change)
- [ ] Create analysis-ready dataset (CSV: report_id, quarter, year, text, stock_change)

**Estimated Time:** 6-8 hours

**Critical Decision Point:** If extraction quality poor (>20% garbled), investigate alternative extraction tools (Camelot for tables, Tesseract OCR if scanned PDFs).

---

**Framework Status:** ✅ Complete - Ready for execution after PDF extraction

**Total Estimated Effort:** 30-42 hours = 6-8 weeks at 5 hours/week
```

### Key Features of This Example

1. **Addresses PDF extraction challenge:** Acknowledges format complexity, builds in validation
2. **Institutional authorship considerations:** Organizational voice, not personal
3. **External validation opportunity:** Stock price correlation provides external metric
4. **Realistic scope:** 3 focused questions, 30-42 hours total
5. **Deferred appropriate questions:** CEO/CFO comparison too complex for initial analysis

---

## Example 3: Personal Writing Corpus (Small Corpus)

**Corpus Type:** Creative nonfiction
**Size:** 50 personal essays, ~75K words
**Time Span:** 2010-2025 (15 years)
**Authorship:** Single author (personal essays)
**User Goal:** Understand thematic preoccupations and voice evolution

### Sample Research Questions Framework (Excerpt)

```markdown
# Research Questions Framework: Personal Essay Corpus Analysis

## I. Corpus Profile

**Domain:** Creative nonfiction (personal essays)
**Type:** Reflective, narrative essays on personal experience
**Size:** Small corpus: 50 documents, ~75K words (~1500 words/essay)
**Temporal Span:** 2010-2025 (15 years)
**Authorship:** Single author (personal writing)
**Format:** Plain text files (.md, .txt) organized chronologically
**Data Status:** Ready for analysis

**Analytical Implications:**
- **Size supports:** Manual thematic coding with computational validation, topic modeling (small corpus), keyphrase extraction, stylistic analysis
- **Size limitations:** Large-scale network analysis not appropriate, sentiment analysis may be noisy with small N
- **Temporal span enables:** Life period comparison, thematic evolution tracking
- **Single authorship enables:** Voice development, style maturation, thematic preoccupations

**Note on Small Corpus:** 50 documents is at the lower bound for computational methods. We'll emphasize close reading with computational validation rather than computational-first approaches.

---

## II. Research Interests & Assumptions

### Primary Motivation

Personal insight - Understanding what themes recur across 15 years of personal writing, how your voice has evolved, whether life stages are reflected in thematic content.

### Puzzles & Intrigues

1. **Thematic obsessions:** What do you write about repeatedly? Family, work, place, identity?

2. **Life period patterns:** Do early essays (20s) differ from recent essays (30s) in themes/tone?

3. **Voice maturation:** Has your writing style become more confident, more complex, more reflective?

---

## III. Research Questions

### Primary Questions

**RQ1: What themes recur across the 50 essays, and how do they cluster?**

- **Priority:** High
- **Rationale:** Central to understanding preoccupations
- **Analytical Approach:** Manual thematic coding + topic modeling validation (BERTopic on small corpus)
- **Estimated Time:** 8-12 hours (5 hours manual coding, 3 hours computational, 2-4 hours synthesis)

**RQ2: How do essays from early period (2010-2017) differ from recent period (2018-2025) in theme and tone?**

- **Priority:** High
- **Rationale:** Tests life period hypothesis
- **Analytical Approach:** Comparative keyness analysis + manual reading
- **Estimated Time:** 6-10 hours

---

## IV. Methodological Roadmap

### RQ1: Thematic Patterns

**Analytical Approach:** Manual coding with computational validation

**Tools:**
- Spreadsheet for manual coding (Excel, Google Sheets)
- BERTopic for computational validation
- Python for text analysis

**Procedure:**

1. **Manual Thematic Coding** [5-6 hours]
   - Read all 50 essays
   - Code each with 1-3 themes (e.g., "family," "work," "place," "identity")
   - Note dominant vs secondary themes
   - Track themes in spreadsheet (essay_id, date, theme1, theme2, theme3, notes)

2. **Theme Clustering** [1-2 hours]
   - Group essays by theme
   - Identify theme frequency (how many essays per theme?)
   - Check for theme co-occurrence (which themes appear together?)

3. **Computational Validation** [2-3 hours]
   - Run BERTopic on 50 essays (min_cluster_size=3 to avoid over-clustering)
   - Compare computational topics with manual themes
   - Check for themes missed in manual coding

4. **Synthesis** [2-3 hours]
   - Write thematic map integrating manual + computational findings
   - Extract representative essays per theme
   - Note surprising findings

**Expected Evidence:**
- Thematic coding spreadsheet (50 rows)
- Theme frequency chart (bar graph)
- Topic model (5-8 topics if BERTopic succeeds)
- Representative essay excerpts per theme

**Validation:**
- Manual coding is primary (you know content best)
- Computational topics validate/challenge manual coding (inter-coder reliability check)

**Confidence:** High for manual findings, Medium for computational (small corpus may not cluster well)

**Estimated Time:** 8-12 hours

---

**Framework Status:** ✅ Complete - Ready for execution

**Total Estimated Effort:** 14-22 hours = 3-4 weeks at 5 hours/week

**Note:** Small corpus emphasizes close reading. Computational tools provide validation, not replacement.
```

### Key Features of This Example

1. **Acknowledges small corpus limitations:** Realistic about what 50 documents can support
2. **Emphasizes close reading:** Manual thematic coding primary, computational validation secondary
3. **Appropriate methods for scale:** No large network analysis, no complex temporal modeling
4. **Personal stakes honored:** Self-understanding goal, not publication
5. **Realistic effort:** 14-22 hours for 2 focused questions

---

## Comparison Across Examples

| Feature | Theater (464 docs) | Business (200 docs) | Personal (50 docs) |
|---------|-------------------|---------------------|-------------------|
| **Primary Methods** | Sentiment, topics, entities, keyness | Topics, keyness, sentiment | Manual coding, keyness |
| **Computational Emphasis** | High (computational-first) | Medium-High (PDF extraction + computational) | Low (close reading + validation) |
| **RQs** | 4 questions | 3 questions | 2 questions |
| **Total Effort** | 36-55 hours | 30-42 hours | 14-22 hours |
| **Timeline (5hr/wk)** | 7-11 weeks | 6-8 weeks | 3-4 weeks |
| **Validation** | Multi-tool, manual, external | Manual, stock price correlation | Manual primary, computational check |
| **Complexity** | High (4 analysis types) | Medium (3 analysis + PDF extraction) | Low (2 analysis, manual-focused) |

---

## What Makes These Examples Good

### 1. Grounded in Actual Corpora
- Theater: Real 464 KCRW reviews
- Business: Realistic 200 quarterly reports scenario
- Personal: Common 50-essay personal corpus

### 2. Realistic Research Questions
- Answerable with proposed methods
- Appropriate for corpus size
- Aligned with user interests

### 3. Detailed Methodological Roadmaps
- Step-by-step procedures
- Tool specifications
- Time estimates
- Validation strategies

### 4. Honest About Limitations
- Theater: Selection bias acknowledged
- Business: PDF extraction complexity noted
- Personal: Small corpus limitations explicit

### 5. Actionable Next Steps
- Specific installation commands
- Directory structure templates
- Phased execution plans

---

## Using These Examples

**If your corpus is similar to:**

- **Theater example:** Medium corpus (100-1000 docs), temporal span, evaluative text → Use 4-question framework, computational-first
- **Business example:** Medium corpus, institutional authorship, needs extraction → Use 3-question framework, emphasize validation
- **Personal example:** Small corpus (<100 docs), personal writing → Use 2-question framework, close reading + computational check

**Adapt by:**
1. Adjust corpus profile to your data
2. Modify questions to your domain
3. Scale methods to your corpus size
4. Align timeline with your available hours

---

*End of Examples Document*
