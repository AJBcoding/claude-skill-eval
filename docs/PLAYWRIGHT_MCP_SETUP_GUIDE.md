# Playwright MCP Setup Guide

Complete guide to setting up and troubleshooting the Playwright Model Context Protocol (MCP) in a new repository.

## Quick Start (10 minutes)

### 1. Add Global Configuration

Add this to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"],
      "timeout": 45000,
      "disabled": true
    }
  }
}
```

The `"disabled": true` prevents token pollution. You'll enable it per-project.

### 2. Enable in Your Project

Create or edit `.claude/settings.json` in your target repository:

```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false
    }
  }
}
```

### 3. Verify Installation

Restart Claude Code. You should see Playwright tools become available:
- `mcp__playwright__navigate`
- `mcp__playwright__click`
- `mcp__playwright__screenshot`
- And 10+ others

If tools don't appear, go to **Troubleshooting** below.

---

## What Playwright MCP Does

Playwright MCP gives you direct browser automation tools within Claude conversations. No special authentication required—it's a local client-side tool.

**Available Tools:**
- Navigate to URLs
- Take screenshots
- Click elements
- Fill forms
- Type text
- Press keys
- Get page content
- Wait for elements
- Execute JavaScript
- Check page state

Use it for:
- Quick web testing
- Screenshot capture
- Form automation
- Page inspection
- UI validation

---

## Configuration Options

### Basic Setup
```json
{
  "command": "npx",
  "args": ["-y", "@playwright/mcp"],
  "timeout": 45000
}
```

### With Retries (More Reliable)
```json
{
  "command": "npx",
  "args": ["-y", "@playwright/mcp@latest"],
  "timeout": 45000,
  "retries": 3
}
```

### Settings Reference

| Setting | Value | Notes |
|---------|-------|-------|
| `command` | `npx` | Always npx |
| `args[0]` | `-y` | Skip prompts |
| `args[1]` | `@playwright/mcp` | Package name |
| `args[2]` (optional) | `@latest` | Get latest version |
| `timeout` | 45000-60000 | Milliseconds |
| `disabled` | true/false | Enable per-project |
| `retries` | 1-3 | Retry failed connections |

---

## Repository-Specific Configuration

Each repository has different URLs and environments. Here's how to configure Playwright MCP for different projects.

### Setup Structure

```
Global Config:        ~/.claude/settings.json       (MCP installed, disabled)
Per-Repository:       YOUR-REPO/.claude/settings.json (Enable + set repo-specific options)
```

### Example 1: Local Development (localhost)

Repository: `my-web-app/`

`.claude/settings.json`:
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 45000
    }
  },
  "env": {
    "APP_URL": "http://localhost:3000",
    "API_URL": "http://localhost:3001"
  }
}
```

**Usage:**
```
Claude: "Navigate to http://localhost:3000 and take a screenshot"
Claude: "Go to the login page, fill in test credentials, and verify the dashboard loads"
```

### Example 2: Staging Environment

Repository: `e-commerce-platform/`

`.claude/settings.json`:
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 60000
    }
  },
  "env": {
    "APP_URL": "https://staging.myapp.com",
    "API_URL": "https://api-staging.myapp.com",
    "TEST_USERNAME": "qa-tester@example.com",
    "TEST_PASSWORD": "staging-test-password-here"
  }
}
```

**Usage:**
```
Claude: "Navigate to https://staging.myapp.com and check if the checkout flow works"
Claude: "Test the payment form on staging environment"
```

### Example 3: Docker Container

Repository: `containerized-app/`

`.claude/settings.json`:
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 60000
    }
  },
  "env": {
    "APP_URL": "http://localhost:8080",
    "COMPOSE_FILE": "docker-compose.yml",
    "SERVICE_NAME": "web"
  }
}
```

**Setup before using:**
```bash
docker-compose up -d
# Then in Claude Code:
# "Navigate to http://localhost:8080 and verify the app is running"
```

### Example 4: Production Testing (Read-Only)

Repository: `analytics-dashboard/`

`.claude/settings.json`:
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 45000
    }
  },
  "env": {
    "APP_URL": "https://dashboard.production.com",
    "READ_ONLY": "true",
    "SCREENSHOT_ONLY": "true"
  }
}
```

**Note:** Only take screenshots, don't fill forms or click buttons in production.

---

## What Changes Between Repositories

Here's a quick reference for what you need to update for each new repository:

### Must Change (Per Repository)
- ✅ **Enable/disable in `.claude/settings.json`** - Each repo has its own
  ```json
  "mcpServers": {
    "playwright": { "disabled": false }
  }
  ```

- ✅ **Base URL** - What domain/port is your app running on?
  - Local: `http://localhost:3000`
  - Docker: `http://localhost:8080`
  - Staging: `https://staging.example.com`
  - Production: `https://app.example.com`

- ✅ **Port (if different)** - Is it 3000, 5173, 8000, etc.?

### Should Consider (Optional)
- ✅ **Test credentials** - Store in `env` section if needed
- ✅ **Timeout** - Increase for slower apps
- ✅ **Retries** - More for unstable networks
- ✅ **Environment variables** - Login info, API endpoints, etc.

### Does NOT Change
- ❌ `command: "npx"`
- ❌ `args: ["-y", "@playwright/mcp"]`
- ❌ Global `~/.claude/settings.json` (stays the same)

---

## Configuration for Different Project Types

### React/Vue/Svelte App
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 45000
    }
  },
  "env": {
    "APP_URL": "http://localhost:5173",
    "API_BASE": "http://localhost:3001/api"
  }
}
```

### Next.js App
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 45000
    }
  },
  "env": {
    "APP_URL": "http://localhost:3000"
  }
}
```

### Django/Flask App
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 60000
    }
  },
  "env": {
    "APP_URL": "http://localhost:8000"
  }
}
```

### Ruby on Rails App
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 45000
    }
  },
  "env": {
    "APP_URL": "http://localhost:3000"
  }
}
```

### Static Site / Documentation
```json
{
  "mcpServers": {
    "playwright": {
      "disabled": false,
      "timeout": 30000
    }
  },
  "env": {
    "APP_URL": "http://localhost:8000"
  }
}
```

---

## Environment Variable Reference

Use the `env` section in `.claude/settings.json` to store repository-specific values:

```json
{
  "env": {
    "APP_URL": "http://localhost:3000",           // Where your app runs
    "API_URL": "http://localhost:3001",           // API endpoint
    "TEST_USERNAME": "testuser@example.com",      // Test credentials
    "TEST_PASSWORD": "password123",               // Test credentials
    "ADMIN_USERNAME": "admin@example.com",        // Admin credentials
    "ADMIN_PASSWORD": "admin123",                 // Admin credentials
    "DATABASE_URL": "postgresql://...",           // Database connection
    "STRIPE_TEST_KEY": "pk_test_...",            // API keys
    "READ_ONLY": "true"                          // Safety flags
  }
}
```

**Usage in conversations:**
```
Claude: "Navigate to the URL in your env, login with the test credentials, and verify the dashboard"

Claude: "Using the ADMIN_USERNAME and ADMIN_PASSWORD, log in and check admin settings"
```

---

## Common Configuration Mistakes

### Mistake 1: Wrong Port
```json
"APP_URL": "http://localhost:3000"   // ❌ Wrong - your app runs on 5173
"APP_URL": "http://localhost:5173"   // ✅ Correct
```

**Fix:** Check what port your app actually runs on
```bash
# Terminal: What port is your app on?
npm run dev    # Check the output
```

### Mistake 2: Protocol (http vs https)
```json
"APP_URL": "https://staging.example.com"  // ✅ Correct for HTTPS
"APP_URL": "http://staging.example.com"   // ❌ Wrong - will fail if site requires HTTPS
```

**Fix:** Check if site requires HTTPS
```bash
curl -I https://staging.example.com
```

### Mistake 3: Environment Not Running
```json
"APP_URL": "http://localhost:3000"
// But app not running!
```

**Fix:** Start your app first
```bash
npm run dev          # or
docker-compose up    # or
python manage.py runserver
```

### Mistake 4: Forgetting to Enable in `.claude/settings.json`
```json
// ~/.claude/settings.json - Playwright disabled globally ✓
// YOUR-REPO/.claude/settings.json - Forgot to enable! ❌

// Need this in YOUR-REPO/.claude/settings.json:
{
  "mcpServers": {
    "playwright": { "disabled": false }
  }
}
```

### Mistake 5: Invalid JSON Syntax
```json
{
  "mcpServers": {
    "playwright": { "disabled": false }  // ❌ Missing comma
    "other-mcp": { "disabled": true }
  }
}
```

**Fix:** Validate JSON
```bash
cat .claude/settings.json | jq
```

---

## Setup Checklist for New Repository

Use this checklist when setting up Playwright MCP in a new repository:

- [ ] **Create `.claude/settings.json`** in repository root
- [ ] **Add playwright config** with `"disabled": false`
- [ ] **Identify your app's URL** (localhost:port, staging domain, etc.)
- [ ] **Add `env` section** with `APP_URL` and other variables
- [ ] **Validate JSON** - Run `cat .claude/settings.json | jq`
- [ ] **Start your app** - Ensure it's actually running
- [ ] **Restart Claude Code** - Close completely and reopen
- [ ] **Test connectivity** - "Navigate to [your-url] and take a screenshot"
- [ ] **Verify tools appear** - Check tool list for playwright tools
- [ ] **Test form interaction** (if applicable) - Fill a form and submit
- [ ] **Document for team** - Add setup notes to project README

---

## Migrating from One Repository to Another

When you switch from `repo-a` to `repo-b`:

1. **Save current state** (optional)
   - Note working URL and configuration for repo-a

2. **Switch directories**
   ```bash
   cd ../repo-b
   ```

3. **Check if `.claude/settings.json` exists**
   ```bash
   ls -la .claude/settings.json
   ```

4. **If not, create it:**
   ```bash
   mkdir -p .claude
   cat > .claude/settings.json << 'EOF'
   {
     "mcpServers": {
       "playwright": { "disabled": false }
     },
     "env": {
       "APP_URL": "http://localhost:3000"
     }
   }
   EOF
   ```

5. **Verify your app is running on the configured port**

6. **Restart Claude Code**

7. **Test:** "Navigate to my app and take a screenshot"

That's it! Claude Code automatically loads the new repository's settings.

---

## Usage Examples

### Navigate and Screenshot
```
Claude: "Go to example.com and take a screenshot"
Claude will use mcp__playwright__navigate and mcp__playwright__screenshot
```

### Fill and Submit Form
```
Claude: "Navigate to the login page, fill in email 'test@example.com', password 'pass123', and click submit"
```

### Get Page Information
```
Claude: "What's the title and all links on example.com?"
Claude will use mcp__playwright__get_element_text and analyze the page
```

### Wait for Dynamic Content
```
Claude: "Go to example.com, wait for the loading spinner to disappear, then take a screenshot"
```

---

## Troubleshooting

### Tools Don't Appear After Restart

**Symptom:** Playwright tools not showing in tool list

**Solutions (in order):**

1. **Verify syntax** - Check `.claude/settings.json` JSON is valid
   ```bash
   cat .claude/settings.json | jq
   ```

2. **Kill existing processes** - Playwright may be stuck
   ```bash
   pkill -f "npx.*mcp"
   pkill -f "playwright"
   ```

3. **Restart Claude Code completely** - Close and reopen

4. **Check node/npm** - Ensure node is installed
   ```bash
   node --version  # Should be 18+
   npm --version   # Should be 8+
   ```

5. **Try manual npx call** - Test if playwright can be installed
   ```bash
   npx -y @playwright/mcp
   ```

### Timeout Errors

**Symptom:** "Timeout waiting for Playwright" or similar errors

**Solutions:**

1. **Increase timeout** - Edit `.claude/settings.json`
   ```json
   "timeout": 60000
   ```

2. **Close other browsers** - Chrome/Chromium may be running
   ```bash
   pkill -f "chrome\|chromium"
   ```

3. **Clear browser cache** (rare issue)
   ```bash
   rm -rf ~/.cache/ms-playwright
   ```

4. **Check system resources** - Ensure RAM/disk available
   ```bash
   df -h
   ```

### Element Not Found Errors

**Symptom:** "Could not find element matching selector..."

**Solutions:**

1. **Verify URL is correct** - Check page actually loaded
   ```
   Claude: "Navigate to [URL] and tell me what you see"
   ```

2. **Use wait for element** - Don't assume immediate availability
   ```
   Claude: "Navigate to [URL], wait for .login-button to appear, then click it"
   ```

3. **Check if element exists** - Get page content first
   ```
   Claude: "Get all text content from [URL]"
   ```

4. **Adjust selector** - Element might use different class/id
   ```
   Claude: "Take a screenshot of [URL] and tell me the exact text of buttons"
   ```

### Connection Refused

**Symptom:** "Error: connect ECONNREFUSED"

**Solutions:**

1. **Kill zombie processes**
   ```bash
   lsof -i :3000  # Check for process on port 3000
   pkill -f playwright
   ```

2. **Restart from clean state**
   ```bash
   pkill -f "claude|npx|playwright"
   # Close Claude Code completely
   # Reopen Claude Code
   ```

3. **Update npx cache** (rare)
   ```bash
   npm cache clean --force
   ```

### Playwright Works but Seems Slow

**Symptom:** Browser automation is working but very slow

**Solutions:**

1. **Headless mode is faster** - Let browser run headless
   - Don't request `{ headless: false }` unless needed

2. **Reduce retries** - Lower `retries` setting if only using occasionally

3. **Use Haiku model** for initial navigation, Sonnet for complex interaction

4. **Check network** - Slow internet = slow page loads
   ```
   Claude: "Navigate to [URL] and check network conditions"
   ```

---

## Token Impact

Enabling Playwright MCP costs:
- **Per-tool invocation:** 100-500 tokens (depending on screenshot size/complexity)
- **Tool definitions when loaded:** ~3,000 tokens
- **Combined with Context7 & Sequential Thinking:** <10,000 total tokens

**Cost Optimization:**
- Keep disabled globally (`"disabled": true` in `~/.claude/settings.json`)
- Enable only in projects that need browser automation (`.claude/settings.json`)
- Use Haiku model for simple web tests (40% cost savings)

---

## Advanced: Dedicated Integrator Agent

For complex multi-step automation, consider using a Playwright Integrator Agent (if available in your framework).

This agent:
- Tracks automation success/failure rates
- Implements intelligent retry strategies
- Coordinates with other MCPs (Context7, PostgreSQL)
- Monitors performance metrics

Ask Claude: "Set up a playwright integrator agent" if you need orchestration of complex browser workflows.

---

## Complementary Tool: Playwright Skill

**Note:** There's also a `playwright-skill` (different from this MCP) in your `.claude/skills` folder.

**Difference:**
- **Playwright MCP:** Direct tool access in conversations, works for quick tasks
- **Playwright Skill:** Writes custom test files, auto-detects dev servers, good for E2E test suites

**When to use each:**
- **MCP:** Quick screenshots, rapid testing, form filling, page inspection
- **Skill:** Complete E2E test suites, CI/CD integration, complex test workflows

You can use both together.

---

## Disabled-by-Default Strategy Explained

MCPs are disabled globally but enabled per-project to:

1. **Prevent token pollution** - Tools only loaded when needed
2. **Reduce initial context** - Faster response times
3. **Improve cost efficiency** - Enable only in projects that use them
4. **Maintain separation** - Different projects, different tools

**Example project structure:**

```
your-repo/
├── .claude/
│   └── settings.json        # "playwright": { "disabled": false }
├── src/
├── package.json
└── tests/
```

When you work in `your-repo/`, Playwright loads. When you work elsewhere, it doesn't.

---

## Validation Checklist

After setup, verify:

- [ ] `npx` is available in your shell
- [ ] `.claude/settings.json` is valid JSON
- [ ] Claude Code restarted after configuration changes
- [ ] Playwright tools visible in tool list
- [ ] Can navigate to a public website without errors
- [ ] Screenshots generate successfully
- [ ] No timeout errors on basic operations

If all boxes checked, you're good to go.

---

## Common Patterns

### Pattern 1: Quick Smoke Test
```
"Go to my-app.local:3000, take a screenshot, and tell me what you see"
```

### Pattern 2: Form Testing
```
"Navigate to login page, fill in username 'admin', password 'test123',
submit the form, and screenshot the result"
```

### Pattern 3: Content Verification
```
"Check if 'Sign Out' button exists on example.com after login"
```

### Pattern 4: Multi-Step Workflow
```
"Navigate to example.com,
click the 'Learn' button,
wait for the page to load,
get all headings,
take a final screenshot"
```

---

## Performance Metrics

**Typical performance:**
- Navigate to URL: 3-8 seconds
- Take screenshot: 1-3 seconds
- Click element: <1 second
- Fill form: <1 second per field
- Get page content: 2-4 seconds

**Timeout defaults:**
- Navigation: 30 seconds
- Element wait: 10 seconds
- Screenshot: 5 seconds
- Page evaluation: 10 seconds

**Optimization tips:**
- Use specific selectors (IDs > classes > text)
- Wait for elements explicitly if page is dynamic
- Take screenshots sparingly (they're large)
- Use headless mode (faster than headed)

---

## Getting Help

If you're stuck:

1. **Check syntax** - Valid JSON in settings file?
2. **Kill processes** - `pkill -f "playwright|npx|mcp"`
3. **Restart Claude Code** - Complete close and reopen
4. **Verify network** - Can you reach the target URL?
5. **Check logs** - Look for error messages in Claude Code output
6. **Try simpler command** - Does basic navigate/screenshot work?

If still stuck, create a minimal test case:
```
1. Fresh repo with just .claude/settings.json
2. Enable only playwright MCP
3. Try: "Navigate to example.com and take a screenshot"
4. Share the exact error message
```

---

## References

- [Playwright Documentation](https://playwright.dev)
- [Playwright MCP on npm](https://www.npmjs.com/package/@playwright/mcp)
- [Claude Code MCP Documentation](https://github.com/anthropics/claude-code)

---

**Last Updated:** 2025-11-23
**Status:** Tested and validated
**Recommended for:** All new repositories with browser automation needs
