# Typinator Repository CD Shortcut

## Overview

This document describes a Typinator shortcut that allows you to quickly navigate to one of your three main project repositories and immediately launch either Claude or Codex with optional permissions flags.

**Shortcut Trigger:** `;cda`

## Quick Start

### Setup

1. Open Typinator
2. Create a new expansion with:
   - **Abbreviation:** `;cda`
   - **Expansion:** See [Expansion Code](#expansion-code) below
3. Save the expansion

### Usage

1. Type `;cda` anywhere
2. First menu appears: Select your repository
   - `419` → Python419
   - `Claude Skill Eval` → Claude Skill Eval
   - `Claude Skills` → Claude Skills
3. Press Tab to move to second menu
4. Second menu appears: Select your AI tool variant
   - `claude --dangerously-skip-permissions` → Claude with permissions flag
   - `claude` → Claude without flags
   - `codex` → Codex
5. Press Return to execute

## Expansion Code

### Trigger
```
;cda
```

### Expansion
```
cd {{?Repositories(419:/Users/anthonybyrnes/PycharmProjects/Python419|Claude Skill Eval:/Users/anthonybyrnes/PycharmProjects/Claude Skill Eval|Claude Skills:/Users/anthonybyrnes/PycharmProjects/Claude Skills)<419>}} && {{?AI(claude --dangerously-skip-permissions|claude|codex)<claude>}}{return}
```

## Syntax Breakdown

### Field Structure: `{{?FieldName(...)<default>}}`

- **`{{?`** - Start of Typinator input field
- **`FieldName`** - Label shown above the dropdown
- **`(options)`** - Comma-separated alternatives
- **`display:value`** - Display text in menu, but insert different value
- **`<default>`** - Default option highlighted when menu appears
- **`}}`** - End of field

### First Field: Repositories
```
{{?Repositories(419:/Users/anthonybyrnes/PycharmProjects/Python419|Claude Skill Eval:/Users/anthonybyrnes/PycharmProjects/Claude Skill Eval|Claude Skills:/Users/anthonybyrnes/PycharmProjects/Claude Skills)<419>}}
```

- **Display names:** `419`, `Claude Skill Eval`, `Claude Skills`
- **Actual paths:** Full filesystem paths
- **Default:** `419` (Python419)
- **Separator:** `|` (pipe character)

### Second Field: AI Variant
```
{{?AI(claude --dangerously-skip-permissions|claude|codex)<claude>}}
```

- **Options:** Three command variants
- **Default:** `claude` (without flags)
- **No display:value mapping** - Display and insert text are the same

### Command Execution
```
{return}
```

- Executes the full command: `cd [repo] && [ai_tool]`

## Features

✅ **Two sequential menus** - Tab between repository and AI tool selection
✅ **Default values** - Python419 and Claude pre-selected
✅ **Extended text results** - Show friendly names, insert full paths
✅ **Permissions flexibility** - Choose with or without `--dangerously-skip-permissions`
✅ **Keyboard navigation** - Tab to move between menus, Return to execute

## Adding More Repositories

To add additional repositories, edit the first menu:

```
{{?Repositories(
  419:/Users/anthonybyrnes/PycharmProjects/Python419|
  Claude Skill Eval:/Users/anthonybyrnes/PycharmProjects/Claude Skill Eval|
  Claude Skills:/Users/anthonybyrnes/PycharmProjects/Claude Skills|
  NewRepo:/Users/anthonybyrnes/PycharmProjects/NewRepo
)<419>}}
```

Format: `DisplayName:/full/path/to/repo`

## Adding More AI Tool Variants

To add additional command variants to the second menu:

```
{{?AI(
  claude --dangerously-skip-permissions|
  claude|
  codex|
  custom-command --with-flags
)<claude>}}
```

## Troubleshooting

### Menus showing as text input fields instead of dropdowns

**Issue:** You see text boxes instead of dropdown menus
**Solution:** Ensure you're using the correct syntax with parentheses `()` and pipes `|`, not curly braces `{}`

### Only returning `cd` without the path

**Issue:** The expansion only outputs `cd` without the selected repository path
**Solution:** Verify the `display:value` format is correct (colon `:` separates display from actual value)

### Default value not working

**Issue:** Menu doesn't show a default selection
**Solution:** Check that the default value (e.g., `<419>`) matches one of your display names exactly

### Tab not moving between menus

**Issue:** Can't tab to the second menu
**Solution:** Both fields must be properly formatted with `{{?...}}` syntax. Verify no syntax errors in the expansion.

## References

- [Typinator Forms Documentation](https://ergonis.com/typinator/learn/the-power-of-forms)
- [Typinator Input Fields with Default Values](https://ergonis.com/typinator/learn/input-fields-with-default-values)
