# GitHub, Markdownify, and Dev-Tools MCP Setup Guide

Complete guide to setting up GitHub MCP, Markdownify MCP, and dev-tools MCP across different repositories.

**Last Updated:** 2025-11-23
**Setup Time:** 45-60 minutes
**Complexity:** Medium (OAuth setup required for GitHub)

---

## Table of Contents

1. [GitHub MCP Setup](#github-mcp-setup)
2. [Markdownify MCP Setup](#markdownify-mcp-setup)
3. [Dev-Tools MCP Setup](#dev-tools-mcp-setup)
4. [Per-Repository Configuration](#per-repository-configuration)
5. [Troubleshooting](#troubleshooting)

---

## GitHub MCP Setup

### What GitHub MCP Does

GitHub MCP provides enhanced GitHub integration beyond the `gh` CLI, enabling Claude to:
- Create, read, and update issues and PRs
- Search repositories and code
- Manage projects and milestones
- Work with GitHub Actions workflows
- Access repository metadata and statistics

**Official Package:** `@anthropic-ai/mcp-server-github`

### Prerequisites

Before setting up GitHub MCP:

```bash
# Check Node.js version
node --version  # Should be 18.0.0 or higher
npm --version   # Should be 9.0.0 or higher

# Verify gh CLI is installed (optional but helpful)
gh --version
```

### Step 1: Create GitHub OAuth App

**IMPORTANT:** You need a GitHub OAuth App for authentication.

1. **Go to GitHub Settings:**
   - Navigate to: https://github.com/settings/developers
   - Click "OAuth Apps" → "New OAuth App"

2. **Configure OAuth App:**
   ```
   Application name: Claude Code MCP - [Your Project Name]
   Homepage URL: http://localhost:3000
   Authorization callback URL: http://localhost:3000/callback
   ```

3. **Save Credentials:**
   - After creation, note down:
     - **Client ID**: `Iv1.xxxxxxxxxxxx`
     - **Client Secret**: Click "Generate a new client secret"
   - Store these securely (you'll need them for configuration)

### Step 2: Global Configuration

Add to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-github"],
      "oauth": {
        "clientId": "${GITHUB_CLIENT_ID}",
        "clientSecret": "${GITHUB_CLIENT_SECRET}",
        "scopes": ["repo", "issues"]
      },
      "timeout": 60000,
      "disabled": true
    }
  }
}
```

### Step 3: Environment Variables

**Global Environment** (`~/.bashrc`, `~/.zshrc`, or `~/.env`):

```bash
# GitHub OAuth Credentials
export GITHUB_CLIENT_ID="Iv1.xxxxxxxxxxxx"
export GITHUB_CLIENT_SECRET="your-client-secret-here"
```

**Per-Project `.env`** (optional, for project-specific credentials):

```bash
# GitHub OAuth for this project
GITHUB_CLIENT_ID=Iv1.xxxxxxxxxxxx
GITHUB_CLIENT_SECRET=your-client-secret-here
```

### Step 4: OAuth Scopes Explained

The `scopes` field determines what permissions Claude has:

| Scope | Access | Use Case |
|-------|--------|----------|
| `repo` | Full repository access | Create/edit issues, PRs, code |
| `issues` | Issue management only | Read/write issues (safer) |
| `read:org` | Read organization data | Access private repos in orgs |
| `workflow` | GitHub Actions | Trigger/manage workflows |
| `project` | GitHub Projects | Manage project boards |

**Recommended Scopes:**
- **Development:** `["repo", "issues"]` (full access)
- **Read-Only:** `["issues"]` (safest, no code changes)
- **CI/CD:** `["repo", "issues", "workflow"]` (automation)

### GitHub MCP Configuration Variables

#### ⚠️ **Change Per Repository:**

- **OAuth Scopes**: Adjust based on project needs (read-only vs full access)
- **Enable/Disable**: Set `"disabled": false` in project-specific settings

#### ✅ **Same Across Repositories:**

- `command`: Always `"npx"`
- `args`: Always `["-y", "@anthropic-ai/mcp-server-github"]`
- `clientId`/`clientSecret`: Can reuse same OAuth app across projects

#### 🔐 **Security Considerations:**

- Never commit OAuth credentials to git
- Use environment variables (`${GITHUB_CLIENT_ID}`)
- Revoke OAuth app if credentials compromised
- Use minimal scopes required for your workflow

### Available Tools (GitHub MCP)

When enabled, provides these tools:
- `mcp__github__create-issue`
- `mcp__github__update-issue`
- `mcp__github__list-issues`
- `mcp__github__create-pr`
- `mcp__github__search-code`
- `mcp__github__get-repo-info`

---

## Markdownify MCP Setup

### What Markdownify MCP Does

Markdownify MCP converts various file formats and web content to markdown:
- PDFs, DOCX, PPTX, XLSX to markdown
- Webpages to clean markdown (no ads/clutter)
- YouTube videos to transcripts
- Audio files to transcribed markdown
- Images to OCR markdown
- Bing search results to markdown

**Repository:** Custom Node.js server (requires local installation)

### Prerequisites

```bash
# Check Node.js
node --version  # 18.0.0+

# Check if uv (Python package manager) is installed
uv --version    # Used for some conversion tools
```

### Step 1: Install Markdownify MCP

**Option A: Clone and Build**

```bash
# Clone repository
cd ~/projects/
git clone https://github.com/your-org/markdownify-mcp.git
cd markdownify-mcp

# Install dependencies
npm install

# Build
npm run build

# Note the installation path
pwd  # Example: /Users/yourname/projects/markdownify-mcp
```

**Option B: Use Pre-built Binary** (if available)

```bash
# Download pre-built version
npm install -g markdownify-mcp

# Find installation path
which markdownify-mcp
```

### Step 2: Global Configuration

Add to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "markdownify": {
      "command": "node",
      "args": [
        "/PATH/TO/markdownify-mcp/dist/index.js"
      ],
      "env": {
        "UV_PATH": "/PATH/TO/bin/uv"
      },
      "autoApprove": [
        "get-markdown-file",
        "image-to-markdown",
        "pdf-to-markdown",
        "pptx-to-markdown",
        "webpage-to-markdown",
        "xlsx-to-markdown",
        "youtube-to-markdown",
        "audio-to-markdown",
        "bing-search-to-markdown",
        "docx-to-markdown"
      ],
      "timeout": 300000,
      "disabled": true
    }
  }
}
```

### Step 3: Find Required Paths

**Find Markdownify Path:**

```bash
# If built from source
cd ~/projects/markdownify-mcp
ls dist/index.js  # Should exist

# Full path
echo "$(pwd)/dist/index.js"
# Example output: /Users/yourname/projects/markdownify-mcp/dist/index.js
```

**Find UV Path:**

```bash
# If using uv
which uv
# Example output: /opt/homebrew/bin/uv

# Or if using Python venv
which python3
# Then find uv in that environment
```

### Step 4: Update Configuration with Actual Paths

**Edit `~/.claude/settings.json`:**

```json
{
  "mcpServers": {
    "markdownify": {
      "command": "node",
      "args": [
        "/Users/yourname/projects/markdownify-mcp/dist/index.js"
      ],
      "env": {
        "UV_PATH": "/opt/homebrew/bin/uv"
      },
      "autoApprove": [
        "get-markdown-file",
        "image-to-markdown",
        "pdf-to-markdown",
        "pptx-to-markdown",
        "webpage-to-markdown",
        "xlsx-to-markdown",
        "youtube-to-markdown",
        "audio-to-markdown",
        "bing-search-to-markdown",
        "docx-to-markdown"
      ],
      "timeout": 300000,
      "disabled": true
    }
  }
}
```

### Markdownify MCP Configuration Variables

#### ⚠️ **Change Per Repository:**

- **autoApprove List**: Remove tools you don't want auto-approved
- **timeout**: Increase for large files (default: 300000ms = 5 minutes)
- **Enable/Disable**: Set `"disabled": false` in project settings

#### ✅ **Same Across Repositories:**

- `command`: Always `"node"`
- `args[0]`: Path to markdownify-mcp installation (system-wide)
- `env.UV_PATH`: System-wide uv installation

#### 🔐 **Security Note:**

`autoApprove` allows these tools to run without asking permission. Remove sensitive operations if concerned:

```json
"autoApprove": [
  "pdf-to-markdown",
  "docx-to-markdown",
  "webpage-to-markdown"
]
```

### Available Tools (Markdownify MCP)

When enabled, provides:
- `mcp__markdownify__get-markdown-file` - Read markdown files
- `mcp__markdownify__pdf-to-markdown` - Convert PDF
- `mcp__markdownify__docx-to-markdown` - Convert Word docs
- `mcp__markdownify__webpage-to-markdown` - Extract webpage content
- `mcp__markdownify__youtube-to-markdown` - Get video transcripts
- `mcp__markdownify__xlsx-to-markdown` - Convert spreadsheets
- `mcp__markdownify__image-to-markdown` - OCR images
- `mcp__markdownify__audio-to-markdown` - Transcribe audio
- `mcp__markdownify__bing-search-to-markdown` - Search results

---

## Dev-Tools MCP Setup

### What Dev-Tools MCP Does

Dev-Tools MCP provides developer utilities and enhanced functions:
- Code analysis and linting
- Security vulnerability scanning
- Web search integration (Brave Search)
- File system operations
- Development environment utilities

**Binary:** Custom Go binary (`mcp-devtools`)

### Prerequisites

```bash
# Check if Go binary exists
ls /Users/samm/go/bin/mcp-devtools
# Or check your Go bin directory
echo $GOPATH/bin

# Brave Search API key (optional, for search features)
# Get from: https://brave.com/search/api/
```

### Step 1: Install or Build Dev-Tools

**Option A: Pre-built Binary**

If you received a pre-built binary:

```bash
# Copy to your Go bin directory
cp mcp-devtools ~/go/bin/
chmod +x ~/go/bin/mcp-devtools

# Verify
~/go/bin/mcp-devtools --version
```

**Option B: Build from Source**

```bash
# Clone repository
git clone https://github.com/your-org/mcp-devtools.git
cd mcp-devtools

# Build
go build -o mcp-devtools .

# Install to Go bin
go install

# Verify installation
mcp-devtools --version
```

### Step 2: Get Brave Search API Key (Optional)

If you want web search functionality:

1. Go to: https://brave.com/search/api/
2. Sign up for API access
3. Copy your API key: `BSA...`

### Step 3: Global Configuration

Add to `~/.claude/settings.json`:

```json
{
  "mcpServers": {
    "dev-tools": {
      "command": "/Users/YOURUSERNAME/go/bin/mcp-devtools",
      "type": "stdio",
      "env": {
        "DISABLED_FUNCTIONS": "",
        "ENABLE_EXTRA_FUNCTIONS": "security",
        "BRAVE_API_KEY": "${BRAVE_API_KEY}"
      },
      "timeout": 600000,
      "disabled": true
    }
  }
}
```

### Step 4: Environment Variables

**Global Environment** (`~/.bashrc`, `~/.zshrc`, or `~/.env`):

```bash
# Brave Search API Key (optional)
export BRAVE_API_KEY="BSA_your_api_key_here"
```

### Dev-Tools MCP Configuration Variables

#### ⚠️ **Change Per Repository:**

- **command**: Update with YOUR username/path
  ```json
  "command": "/Users/YOURUSERNAME/go/bin/mcp-devtools"
  ```
- **DISABLED_FUNCTIONS**: Comma-separated list of functions to disable
  ```json
  "DISABLED_FUNCTIONS": "web-search,file-operations"
  ```
- **ENABLE_EXTRA_FUNCTIONS**: Enable additional features
  - `"security"` - Security scanning
  - `"security,analysis"` - Security + code analysis
  - `""` - No extra functions
- **BRAVE_API_KEY**: Required only if using web search
- **timeout**: Adjust based on task complexity (default: 600000ms = 10 minutes)

#### ✅ **Same Across Repositories:**

- `type`: Always `"stdio"`
- Binary location: System-wide installation

#### 🔧 **Function Control:**

**Disable specific functions per project:**

```json
"env": {
  "DISABLED_FUNCTIONS": "web-search,file-write",
  "ENABLE_EXTRA_FUNCTIONS": "security"
}
```

**Available function categories:**
- `web-search` - Brave Search integration
- `file-operations` - File system access
- `network` - Network utilities
- `analysis` - Code analysis
- `security` - Security scanning

### Dev-Tools Binary Path by OS

| OS | Typical Path | How to Find |
|----|--------------|-------------|
| **macOS** | `/Users/USERNAME/go/bin/mcp-devtools` | `echo ~/go/bin/mcp-devtools` |
| **Linux** | `/home/USERNAME/go/bin/mcp-devtools` | `which mcp-devtools` |
| **Windows** | `C:\Users\USERNAME\go\bin\mcp-devtools.exe` | `where mcp-devtools` |

**Find your path:**

```bash
# macOS/Linux
which mcp-devtools
# or
echo $GOPATH/bin/mcp-devtools

# Windows (PowerShell)
where.exe mcp-devtools
```

---

## Per-Repository Configuration

### Quick Setup Checklist

When setting up MCPs in a new repository:

**1. Create `.claude/settings.json` in repository root:**

```bash
mkdir -p .claude
touch .claude/settings.json
```

**2. Enable only the MCPs you need:**

```json
{
  "mcpServers": {
    "github": { "disabled": false },
    "markdownify": { "disabled": false },
    "dev-tools": { "disabled": false }
  }
}
```

**3. Add repository-specific overrides:**

```json
{
  "mcpServers": {
    "github": {
      "disabled": false,
      "oauth": {
        "scopes": ["issues"]  // Read-only for this project
      }
    },
    "dev-tools": {
      "disabled": false,
      "env": {
        "DISABLED_FUNCTIONS": "file-write",  // No file writes in production repo
        "ENABLE_EXTRA_FUNCTIONS": "security"
      }
    }
  }
}
```

### Configuration by Project Type

#### Open Source Project

```json
{
  "mcpServers": {
    "github": {
      "disabled": false,
      "oauth": {
        "scopes": ["repo", "issues"]
      }
    },
    "markdownify": {
      "disabled": false,
      "autoApprove": ["webpage-to-markdown", "pdf-to-markdown"]
    },
    "dev-tools": {
      "disabled": false,
      "env": {
        "ENABLE_EXTRA_FUNCTIONS": "security,analysis"
      }
    }
  }
}
```

#### Production/Sensitive Repository

```json
{
  "mcpServers": {
    "github": {
      "disabled": false,
      "oauth": {
        "scopes": ["issues"]  // Read-only
      }
    },
    "markdownify": {
      "disabled": true  // Don't process external content
    },
    "dev-tools": {
      "disabled": false,
      "env": {
        "DISABLED_FUNCTIONS": "web-search,file-write",
        "ENABLE_EXTRA_FUNCTIONS": "security"  // Security only
      }
    }
  }
}
```

#### Documentation/Content Project

```json
{
  "mcpServers": {
    "github": {
      "disabled": false,
      "oauth": {
        "scopes": ["repo", "issues"]
      }
    },
    "markdownify": {
      "disabled": false,
      "autoApprove": [
        "webpage-to-markdown",
        "pdf-to-markdown",
        "docx-to-markdown",
        "youtube-to-markdown"
      ]
    },
    "dev-tools": {
      "disabled": true  // Not needed for docs
    }
  }
}
```

---

## Validation & Testing

### Step 1: Restart Claude Code

After configuration changes:

```bash
# Close Claude Code completely
# Reopen Claude Code in your project directory
cd /path/to/your/project
claude
```

### Step 2: Verify MCP Servers Loaded

```bash
# Check MCP status
/mcp list

# Should show:
# - github (enabled/disabled)
# - markdownify (enabled/disabled)
# - dev-tools (enabled/disabled)
```

### Step 3: Test Each MCP

**Test GitHub MCP:**

```bash
# In Claude conversation:
"List recent issues in this repository"
"Create a test issue titled 'MCP Setup Verification'"
```

**Test Markdownify MCP:**

```bash
# Test webpage conversion:
"Convert https://example.com to markdown"

# Test PDF conversion:
"Convert ~/Downloads/document.pdf to markdown"
```

**Test Dev-Tools MCP:**

```bash
# Test security scanning (if enabled):
"Scan this repository for security vulnerabilities"

# Test Brave search (if API key configured):
"Search for latest Python best practices"
```

---

## Troubleshooting

### GitHub MCP Issues

**Issue: OAuth authentication failed**

```bash
Error: OAuth authentication failed for GitHub
```

**Solutions:**

1. **Check OAuth credentials:**
   ```bash
   echo $GITHUB_CLIENT_ID
   echo $GITHUB_CLIENT_SECRET
   ```

2. **Verify OAuth app configuration:**
   - Go to: https://github.com/settings/developers
   - Check callback URL is `http://localhost:3000/callback`
   - Ensure OAuth app is not suspended

3. **Regenerate client secret:**
   - In GitHub OAuth app settings
   - Generate new client secret
   - Update environment variable

4. **Check scopes:**
   ```json
   "scopes": ["repo", "issues"]  // Ensure valid scopes
   ```

**Issue: Rate limit exceeded**

```bash
Error: GitHub API rate limit exceeded
```

**Solutions:**

- Wait 1 hour (rate limits reset hourly)
- Use authenticated requests (ensure OAuth is working)
- Check current rate limit: `gh api rate_limit`

---

### Markdownify MCP Issues

**Issue: Cannot find markdownify-mcp binary**

```bash
Error: Command not found: /PATH/TO/markdownify-mcp/dist/index.js
```

**Solutions:**

1. **Verify installation path:**
   ```bash
   ls /PATH/TO/markdownify-mcp/dist/index.js
   ```

2. **Find actual path:**
   ```bash
   cd ~/projects/markdownify-mcp
   pwd
   ls dist/index.js
   ```

3. **Update settings.json with correct path:**
   ```json
   "args": ["/ACTUAL/PATH/TO/markdownify-mcp/dist/index.js"]
   ```

**Issue: UV_PATH not found**

```bash
Error: UV executable not found
```

**Solutions:**

1. **Install uv:**
   ```bash
   # macOS/Linux
   curl -LsSf https://astral.sh/uv/install.sh | sh

   # Or via Homebrew
   brew install uv
   ```

2. **Find uv path:**
   ```bash
   which uv
   # Example: /opt/homebrew/bin/uv
   ```

3. **Update settings.json:**
   ```json
   "env": {
     "UV_PATH": "/opt/homebrew/bin/uv"
   }
   ```

**Issue: Timeout on large files**

```bash
Error: Timeout converting large PDF
```

**Solutions:**

- Increase timeout:
  ```json
  "timeout": 600000  // 10 minutes instead of 5
  ```

- Split large files into smaller chunks
- Use lower-quality conversion settings

---

### Dev-Tools MCP Issues

**Issue: Binary not found**

```bash
Error: Cannot execute /Users/samm/go/bin/mcp-devtools
```

**Solutions:**

1. **Find your username:**
   ```bash
   whoami
   # Example: johnsmith
   ```

2. **Update path in settings.json:**
   ```json
   "command": "/Users/johnsmith/go/bin/mcp-devtools"
   ```

3. **Verify binary exists:**
   ```bash
   ls ~/go/bin/mcp-devtools
   chmod +x ~/go/bin/mcp-devtools
   ```

**Issue: Brave Search not working**

```bash
Error: Brave API key invalid
```

**Solutions:**

1. **Verify API key:**
   ```bash
   echo $BRAVE_API_KEY
   ```

2. **Test API key:**
   ```bash
   curl -H "X-Subscription-Token: $BRAVE_API_KEY" \
     "https://api.search.brave.com/res/v1/web/search?q=test"
   ```

3. **Get new API key:**
   - Go to: https://brave.com/search/api/
   - Generate new key
   - Update environment variable

**Issue: Security scanning not enabled**

```bash
Error: Security scanning not available
```

**Solutions:**

- Enable in configuration:
  ```json
  "env": {
    "ENABLE_EXTRA_FUNCTIONS": "security"
  }
  ```

- Restart Claude Code after config change

---

## Security Best Practices

### 1. Never Commit Credentials

**Add to `.gitignore`:**

```
.env
.env.local
.env.*.local
.claude/settings.local.json
```

### 2. Use Environment Variables

**Always use `${VARIABLE}` syntax:**

```json
"oauth": {
  "clientId": "${GITHUB_CLIENT_ID}",  // ✅ Good
  "clientSecret": "${GITHUB_CLIENT_SECRET}"
}

// ❌ BAD - Never hardcode:
// "clientSecret": "ghp_abc123..."
```

### 3. Minimal Scopes

**GitHub OAuth - use minimal required scopes:**

```json
// ✅ Production/Read-only
"scopes": ["issues"]

// ⚠️ Development only
"scopes": ["repo", "issues"]

// ❌ Avoid unless absolutely necessary
"scopes": ["repo", "admin:org", "delete_repo"]
```

### 4. Disable Unused MCPs

**Per-project, only enable what you need:**

```json
{
  "mcpServers": {
    "github": { "disabled": false },      // ✅ Using
    "markdownify": { "disabled": true },  // ✅ Not needed
    "dev-tools": { "disabled": true }     // ✅ Not needed
  }
}
```

### 5. Review autoApprove Lists

**Markdownify - only auto-approve safe operations:**

```json
// ✅ Safe operations
"autoApprove": [
  "webpage-to-markdown",
  "pdf-to-markdown"
]

// ⚠️ Review each file operation
"autoApprove": []  // Require confirmation for everything
```

---

## Migration Checklist

When moving to a new repository:

- [ ] Copy `.claude/settings.json` template
- [ ] Update GitHub OAuth scopes for project needs
- [ ] Verify Markdownify path is absolute (system-wide)
- [ ] Update dev-tools binary path with your username
- [ ] Add project-specific `.env` if needed
- [ ] Disable unused MCPs
- [ ] Test each enabled MCP
- [ ] Update `.gitignore` to exclude credentials
- [ ] Document any project-specific MCP configurations

---

## Quick Reference

### GitHub MCP

```json
{
  "github": {
    "command": "npx",
    "args": ["-y", "@anthropic-ai/mcp-server-github"],
    "oauth": {
      "clientId": "${GITHUB_CLIENT_ID}",
      "clientSecret": "${GITHUB_CLIENT_SECRET}",
      "scopes": ["repo", "issues"]
    },
    "disabled": true
  }
}
```

**Change per repo:** OAuth scopes, enable/disable

### Markdownify MCP

```json
{
  "markdownify": {
    "command": "node",
    "args": ["/PATH/TO/markdownify-mcp/dist/index.js"],
    "env": {"UV_PATH": "/PATH/TO/bin/uv"},
    "autoApprove": ["pdf-to-markdown", "webpage-to-markdown"],
    "timeout": 300000,
    "disabled": true
  }
}
```

**Change per repo:** autoApprove list, timeout, enable/disable
**Change per system:** Binary path, UV path

### Dev-Tools MCP

```json
{
  "dev-tools": {
    "command": "/Users/USERNAME/go/bin/mcp-devtools",
    "type": "stdio",
    "env": {
      "DISABLED_FUNCTIONS": "",
      "ENABLE_EXTRA_FUNCTIONS": "security",
      "BRAVE_API_KEY": "${BRAVE_API_KEY}"
    },
    "timeout": 600000,
    "disabled": true
  }
}
```

**Change per repo:** DISABLED_FUNCTIONS, ENABLE_EXTRA_FUNCTIONS, enable/disable
**Change per system:** Binary path (username)

---

## Additional Resources

- **GitHub MCP:** https://github.com/anthropics/mcp-server-github
- **OAuth Setup Guide:** https://docs.github.com/en/developers/apps/building-oauth-apps
- **Brave Search API:** https://brave.com/search/api/
- **UV Package Manager:** https://github.com/astral-sh/uv
- **MCP Protocol:** https://modelcontextprotocol.io/

---

**Last Updated:** 2025-11-23
**Tested With:** Claude Code v4.0+
**Status:** Production-ready configurations
