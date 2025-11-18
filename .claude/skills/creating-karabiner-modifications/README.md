# Creating Karabiner-Elements Modifications

A Claude Code skill for creating macOS keyboard customizations using Karabiner-Elements.

## What This Skill Does

This skill provides a systematic workflow for creating Karabiner-Elements complex modifications (JSON configurations) correctly and efficiently. It helps Claude:

- Clarify ambiguous requirements before writing JSON
- Choose between manual JSON editing vs external generators
- Use correct JSON structure (prevents common field name errors)
- Apply proven templates for common patterns
- Test configurations properly using EventViewer

## When Claude Uses This Skill

Automatically activated when you ask for:
- Karabiner-Elements keyboard remapping
- Key combinations or modifier customizations
- App-specific keyboard shortcuts
- Tap vs hold (dual-function) key behaviors

## Why This Skill Exists

### Problems It Solves

**Structural errors under pressure**: Without templates, Claude makes JSON structure errors like using `"title"` instead of `"description"` or adding extra `"rules"` wrappers, especially when responding quickly.

**Ambiguous requirements**: Users often say "arrow keys" without specifying up/down vs left/right, or request modifications without clarifying global vs app-specific scope.

**Over-engineering**: Claude sometimes introduces unnecessary complexity (like lazy modifiers) when simpler approaches work fine.

**No testing workflow**: Configurations may appear correct but fail at runtime without proper EventViewer testing.

## How It Was Created

This skill was created following the **Test-Driven Development (TDD)** approach from the `writing-skills` skill:

### RED Phase (Baseline Testing)
- Ran 5 test scenarios WITHOUT the skill
- Found critical failures: wrong JSON structure under time pressure, no requirement clarification
- Documented exact rationalizations agents used to skip proper workflow

### GREEN Phase (Write Skill)
- Created skill with 4-step workflow: Clarify → Choose → Write → Test
- Added quick reference templates for common patterns
- Included guidance on external generators vs manual JSON

### REFACTOR Phase (Close Loopholes)
- Identified rationalization: "Skip skill under time pressure to save time"
- Added Red Flags section and Common Rationalizations table
- Verified fix: agents now use skill even under urgency

## Real-World Usage Example

**User request**: "Make my return key a soft return on short press and a long return on long press"

**What the skill did**:
1. **Clarified** ambiguous "soft return" (asked: Shift+Return or regular Return?)
2. **Chose** manual JSON (simple modification)
3. **Wrote** correct configuration using Tap vs Hold template
4. **Tested** with EventViewer guidance
5. **Fixed** timing issue (both actions were firing) by adjusting parameters

Result: Working configuration in minutes, no JSON errors, proper timing.

## Key Features

### Workflow Templates
- Simple key remap
- Modifier + key combinations
- Tap vs hold (dual function)
- App-specific modifications

### Common Mistakes Table
Prevents frequent errors like:
- Using `"title"` field instead of `"description"`
- Forgetting `"type": "basic"`
- Wrong bundle identifiers
- Skipping EventViewer testing

### External Generator Guidance
Decision flowchart for choosing between:
- Manual JSON (simple, one-off modifications)
- GokuRakuJoudo (concise edn format)
- karabiner.ts (TypeScript with type safety)
- Web configurators (GUI for non-programmers)

## Files in This Skill

```
creating-karabiner-modifications/
├── SKILL.md    # Main skill file (Claude reads this)
└── README.md   # This file (for humans)
```

## Related Skills

- **writing-skills**: The TDD framework used to create this skill
- **testing-skills-with-subagents**: How to test skills under pressure

## Contributing

If you improve this skill or find new common mistakes/patterns, consider:
1. Testing changes with subagents first (TDD approach)
2. Updating the Common Mistakes or Rationalizations tables
3. Adding new templates to Quick Reference section
4. Sharing improvements via PR (if connected to upstream)

## Credits

Created using the Superpowers skill framework's TDD methodology for process documentation.

---

**For Claude**: Load `SKILL.md` - this README is for human readers only.
