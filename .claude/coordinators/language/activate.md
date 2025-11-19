# Language Coordinator Activation

## Purpose
The Language Coordinator automatically routes language-specific tasks to appropriate specialist skills while enforcing obra superpowers patterns.

## How It Works

### 1. Detection Phase
The coordinator analyzes the task using multiple signals:
- **File Extensions**: .py → Python, .tsx → TypeScript, .swift → Swift
- **Keywords**: "FastAPI" → Python, "React" → TypeScript, "SwiftUI" → Swift
- **Tool Patterns**: Edit/Write operations on specific file types
- **Context**: Current project structure and open files

### 2. Routing Phase
Based on detection, the coordinator:
1. **Activates obra patterns first** (using-superpowers, TDD, verification)
2. **Routes to language skill** (moai-lang-python, moai-lang-typescript, developing-with-swift)
3. **Adds domain skills if needed** (moai-domain-backend, moai-domain-frontend, etc.)
4. **Enforces quality patterns** (requesting-code-review, defense-in-depth)

### 3. Execution Phase
The coordinator ensures:
- Obra patterns are used throughout
- Language-specific best practices are followed
- Multi-language tasks use parallel agents
- Results are verified before completion

## Activation Triggers

### Automatic Activation
The coordinator activates automatically when:
- Editing/writing code files (.py, .ts, .tsx, .swift)
- Keywords detected (FastAPI, React, SwiftUI, etc.)
- Full-stack tasks identified

### Manual Activation
You can explicitly activate: "Use the language coordinator for..."

### Bypass
To skip the coordinator: `--no-language-coordinator`

## Examples

### Example 1: Python FastAPI Task
```
User: "Create a FastAPI endpoint for user registration"

Coordinator Flow:
1. Detects: "FastAPI" keyword → Python route
2. Activates: using-superpowers (check for skills)
3. Routes to: moai-lang-python
4. Enforces: test-driven-development
5. Suggests: moai-domain-backend for API patterns
6. Completes: verification-before-completion
7. Triggers: requesting-code-review
```

### Example 2: React TypeScript Component
```
User: "Build a data table component in TypeScript"

Coordinator Flow:
1. Detects: "TypeScript" + "component" → TypeScript route
2. Activates: brainstorming (design decisions)
3. Routes to: moai-lang-typescript
4. Adds: moai-domain-frontend (component patterns)
5. Enforces: test-driven-development
6. Verifies: Type safety and component structure
```

### Example 3: Full-Stack Task
```
User: "Create an API with FastAPI and React frontend"

Coordinator Flow:
1. Detects: Multi-language task
2. Activates: dispatching-parallel-agents
3. Parallel routes:
   - Python path: moai-lang-python + moai-domain-backend
   - TypeScript path: moai-lang-typescript + moai-domain-frontend
4. Coordinates: API contract between frontend/backend
5. Verifies: Integration points
```

## Integration with Phase 2

### Works with Debug Agent
When errors occur in language-specific code:
- Debug agent activates
- Language coordinator provides language-specific debugging patterns
- Combined approach for faster resolution

### Works with Consistency Agent
Before routing:
- Consistency agent checks project patterns
- Language coordinator ensures language choices match project standards

### Works with Quality Agent
After implementation:
- Quality agent performs general checks
- Language coordinator adds language-specific quality validations

## Metrics Tracked

- **Detection Accuracy**: How often the correct language is identified
- **Routing Efficiency**: Time from detection to skill activation
- **Obra Pattern Usage**: Percentage of tasks using required patterns
- **Multi-Language Coordination**: Success rate of parallel language tasks

## Success Criteria

- ✅ 95%+ correct language detection
- ✅ 100% obra pattern usage
- ✅ <2 second routing time
- ✅ Improved developer experience

## Troubleshooting

### Wrong Language Detected
- Check file extension
- Add explicit language hint: "in Python" or "using TypeScript"
- Use bypass flag if needed

### Slow Routing
- Check for conflicting patterns
- Clear detection cache
- Report specific case for optimization

### Missing Language Support
- Currently supports: Python, TypeScript/JavaScript, Swift
- Other languages: Use general obra patterns
- Request addition if frequently needed

## Configuration Files

- **Main Config**: `.claude/coordinators/language/coordinator.yml`
- **Routing Rules**: `.claude/coordinators/language/routes.yml`
- **Examples**: `.claude/coordinators/language/examples/`

## Testing the Coordinator

Run these test cases to verify functionality:

1. **Python Detection Test**
   ```
   Task: "Write a Python function to calculate fibonacci"
   Expected: Routes to moai-lang-python with TDD
   ```

2. **TypeScript Detection Test**
   ```
   Task: "Create a TypeScript interface for user data"
   Expected: Routes to moai-lang-typescript
   ```

3. **Swift Detection Test**
   ```
   Task: "Build a SwiftUI button component"
   Expected: Routes to developing-with-swift
   ```

4. **Full-Stack Test**
   ```
   Task: "Build a REST API with FastAPI and React frontend"
   Expected: Parallel activation of Python and TypeScript paths
   ```

5. **No Match Test**
   ```
   Task: "Explain how to deploy to AWS"
   Expected: Falls back to brainstorming
   ```

## Maintenance

### Updating Routes
Edit `routes.yml` to add new patterns or adjust precedence.

### Adding Languages
1. Add language section to `coordinator.yml`
2. Add routing rules to `routes.yml`
3. Test with example tasks
4. Document in this file

### Performance Tuning
- Monitor metrics dashboard
- Adjust cache TTL if needed
- Optimize detection patterns

---

**Status**: Ready for testing
**Version**: 1.0.0
**Last Updated**: 2025-11-19