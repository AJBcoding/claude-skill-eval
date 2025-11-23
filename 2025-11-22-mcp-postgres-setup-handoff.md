---
type: handoff
status: active
created: 2025-11-22
resolved_date: null
archived_date: null
related_sessions: []
related_plans: []
verification:
  implementation_complete: false
  documentation_exists: false
  tests_passing: false
  commits_made: false
---

# MCP Postgres Setup & Configuration Handoff

**Created:** 2025-11-22
**Status:** 🔴 Active
**Target:** Setup MCP Postgres server in another directory
**Based on:** Claude Skill Eval moai-adk-main repository configuration

---

## Context

You are setting up an MCP (Model Context Protocol) PostgreSQL server integration in another repository. This handoff documents the current configuration pattern from the moai-adk-main directory and provides step-by-step instructions for replicating it in your target repository.

**Current Setup in This Directory:**
- `.claude/settings.json` - Claude Code configuration
- `.claude/settings.local.json` - Local overrides
- `src/moai_adk/templates/.mcp.json` - MCP server templates (context7, playwright, sequential-thinking)
- `.moai/config/config.json` - MoAI development kit configuration
- `.claude/agents/alfred/database-expert.md` - Database expertise agent

**Gap Identified:**
- PostgreSQL MCP server is NOT currently configured in this directory
- Only context7, playwright, and sequential-thinking MCP servers are active
- Database operations currently use standard PostgreSQL client connections

---

## Tasks

- [ ] Understand MCP PostgreSQL specifications
- [ ] Set up PostgreSQL MCP server configuration
- [ ] Configure Claude Code settings for MCP postgres
- [ ] Test MCP postgres connection
- [ ] Create documentation for MCP postgres usage
- [ ] Verify integration with database operations
- [ ] Document troubleshooting steps

---

## Complete MCP PostgreSQL Setup Guide

### Part 1: Understanding MCP PostgreSQL

**What is MCP PostgreSQL?**

The MCP (Model Context Protocol) PostgreSQL server is a Model Context Protocol implementation that provides Claude with direct access to PostgreSQL databases. It allows Claude to:
- Execute queries safely
- Inspect database schema
- Perform data analysis
- Manage database operations

**Official Resources:**
- GitHub: https://github.com/anthropics/mcp-server-postgres
- Protocol Spec: https://modelcontextprotocol.io/
- Installation: `npx @anthropic-ai/mcp-server-postgres`

### Part 2: Prerequisites

Before setting up MCP PostgreSQL, ensure you have:

```bash
# Check Node.js and npm
node --version     # Should be 18.0.0 or higher
npm --version      # Should be 9.0.0 or higher

# Check PostgreSQL client tools
psql --version     # PostgreSQL client
pg_dump --version  # Database dump utility

# Verify npm can access MCP packages
npm search @anthropic-ai/mcp-server-postgres --long
```

### Part 3: Configuration Files

#### Step 1: Update Claude Settings

**File:** `.claude/settings.json`

Add MCP postgres to permissions (if not already present):

```json
{
  "permissions": {
    "allow": [
      "mcp__postgres__execute-query",
      "mcp__postgres__get-schema",
      "mcp__postgres__read-table",
      "mcp__postgres__list-databases",
      "mcp__postgres__list-tables"
    ]
  }
}
```

#### Step 2: Create MCP Configuration File

**File:** `.claude/.mcp.json` (create if it doesn't exist)

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": [
        "-y",
        "@anthropic-ai/mcp-server-postgres"
      ],
      "env": {
        "DATABASE_URL": "postgresql://user:password@localhost:5432/database_name"
      },
      "timeout": 30000,
      "retries": 3
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"],
      "timeout": 30000,
      "retries": 3
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "timeout": 30000,
      "retries": 3
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking@latest"],
      "timeout": 30000,
      "retries": 3
    }
  }
}
```

#### Step 3: Environment Configuration

**Create/Update:** `.env` (or `.env.local`)

```bash
# PostgreSQL Connection
DATABASE_URL=postgresql://postgres:password@localhost:5432/myapp
POSTGRES_USER=postgres
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=myapp
POSTGRES_HOST=localhost
POSTGRES_PORT=5432

# MCP Server Configuration
MCP_POSTGRES_TIMEOUT=30000
MCP_POSTGRES_RETRIES=3
```

**Security Note:** Never commit `.env` to git. Add to `.gitignore`:

```
.env
.env.local
.env.*.local
```

### Part 4: Connection String Formats

**Standard Local Development:**
```
postgresql://postgres:password@localhost:5432/myapp
```

**Production (with SSL):**
```
postgresql://user:password@hostname:5432/myapp?sslmode=require
```

**Docker Container:**
```
postgresql://postgres:password@postgres:5432/myapp
```

**Environment Variable Substitution in `.mcp.json`:**
```json
"env": {
  "DATABASE_URL": "${DATABASE_URL}"
}
```

Then reference in `.env`:
```
DATABASE_URL=postgresql://...
```

### Part 5: Docker Setup (Optional but Recommended)

**File:** `docker-compose.yml`

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16-alpine
    container_name: myapp_postgres
    environment:
      POSTGRES_USER: ${POSTGRES_USER:-postgres}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-postgres}
      POSTGRES_DB: ${POSTGRES_DB:-myapp}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-postgres}"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
    driver: local
```

**Start PostgreSQL:**
```bash
docker-compose up -d postgres
docker-compose logs postgres
```

### Part 6: Claude Code Settings Configuration

**File:** `.claude/settings.json` (Complete Version)

```json
{
  "permissions": {
    "defaultMode": "default",
    "allow": [
      "Task",
      "Read",
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "TodoWrite",
      "WebFetch",
      "WebSearch",
      "Bash(git:*)",
      "Bash(npm:*)",
      "Bash(node:*)",
      "Bash(psql:*)",
      "mcp__postgres__execute-query",
      "mcp__postgres__get-schema",
      "mcp__postgres__read-table",
      "mcp__postgres__list-databases",
      "mcp__postgres__list-tables",
      "mcp__postgres__describe-table",
      "mcp__postgres__sample-data",
      "mcp__context7__resolve-library-id",
      "mcp__context7__get-library-docs"
    ],
    "ask": [
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "mcp__postgres__execute-query"
    ],
    "deny": [
      "mcp__postgres__drop-table",
      "mcp__postgres__drop-database"
    ]
  }
}
```

### Part 7: Initialize Database Schema

**File:** `init.sql`

Create initial schema that PostgreSQL will load:

```sql
-- Create tables
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  title VARCHAR(255) NOT NULL,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_users_email ON users(email);

-- Grant permissions
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO postgres;
```

### Part 8: Verification & Testing

**Test 1: Check MCP Server Connection**

```bash
# From your project root
npx @anthropic-ai/mcp-server-postgres --help

# If installed locally
./node_modules/.bin/mcp-server-postgres --help
```

**Test 2: Verify PostgreSQL Connection**

```bash
# Using psql
psql postgresql://postgres:password@localhost:5432/myapp -c "SELECT VERSION();"

# Using node
node -e "const pg = require('pg'); const c = new pg.Client('postgresql://...'); c.connect(); c.query('SELECT NOW()').then(r => console.log(r.rows)).finally(() => c.end());"
```

**Test 3: Verify Claude Code MCP Configuration**

In Claude Code, run:
```bash
claude mcp serve
# Should list postgres server as available
```

### Part 9: Common Configuration Issues

**Issue 1: Connection Refused**
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```

**Solutions:**
- Verify PostgreSQL is running: `docker-compose logs postgres`
- Check DATABASE_URL is correct
- Ensure firewall allows port 5432
- For Docker: Use service name `postgres` instead of `localhost`

**Issue 2: Authentication Failed**
```
Error: password authentication failed for user "postgres"
```

**Solutions:**
- Verify credentials in `.env`
- Check POSTGRES_PASSWORD in docker-compose.yml
- Reset PostgreSQL password if needed
- Ensure no special characters breaking connection string

**Issue 3: MCP Server Not Found**
```
Error: command "npx" not found
```

**Solutions:**
- Verify Node.js is installed: `node --version`
- Clear npm cache: `npm cache clean --force`
- Reinstall MCP server: `npm install @anthropic-ai/mcp-server-postgres`
- Check PATH environment variable

**Issue 4: Query Timeout**
```
Error: query timeout
```

**Solutions:**
- Increase timeout in `.mcp.json`: `"timeout": 60000`
- Check for long-running queries: `SELECT * FROM pg_stat_activity;`
- Optimize query performance
- Check database indexes

### Part 10: Usage Patterns

**In Claude Code Conversations:**

```bash
# Query the database
"Show me all users and their post count"
# Claude uses mcp__postgres__execute-query internally

# Inspect schema
"What tables exist in this database?"
# Claude uses mcp__postgres__get-schema

# Analyze data
"Are there any users with no posts?"
# Claude combines schema inspection and queries

# Database design
"Create a migration for adding a comments table"
# Claude generates SQL based on existing schema
```

**Programmatic Access (if building agents):**

```python
# Using MCP server directly
import subprocess
import json

result = subprocess.run([
    'npx',
    '@anthropic-ai/mcp-server-postgres',
    'execute-query',
    'SELECT COUNT(*) FROM users'
], capture_output=True, text=True)

print(json.loads(result.stdout))
```

### Part 11: Security Best Practices

1. **Never commit credentials:**
   ```bash
   # .gitignore
   .env
   .env.local
   .env.*.local
   .mcp.local.json
   ```

2. **Use environment variables:**
   ```json
   "env": {
     "DATABASE_URL": "${DATABASE_URL}"
   }
   ```

3. **Restrict MCP permissions:**
   ```json
   "deny": [
     "mcp__postgres__drop-table",
     "mcp__postgres__drop-database",
     "mcp__postgres__execute-query"  // Ask before executing
   ]
   ```

4. **Use connection pooling:**
   ```
   postgresql://user:pass@host/db?application_name=claude-mcp&statement_timeout=10000
   ```

5. **Implement row-level security:**
   ```sql
   ALTER TABLE users ENABLE ROW LEVEL SECURITY;
   CREATE POLICY user_isolation ON users USING (id = current_user_id());
   ```

### Part 12: Integration with MoAI-ADK

If using MoAI-ADK (like moai-adk-main), integrate into workflow:

**Update `.moai/config/config.json`:**

```json
{
  "database": {
    "type": "postgresql",
    "mcp_enabled": true,
    "mcp_server": "postgres",
    "connection_string_env": "DATABASE_URL"
  }
}
```

**Use with database-expert agent:**

```bash
/alfred:1-plan "Create new feature requiring database schema"
# Agent will use MCP postgres to inspect current schema
# Proposes migrations based on existing structure
```

### Part 13: Monitoring & Maintenance

**Monitor Active Connections:**

```sql
SELECT datname, usename, state FROM pg_stat_activity;
```

**Monitor Slow Queries:**

```sql
SELECT query, calls, mean_exec_time FROM pg_stat_statements
ORDER BY mean_exec_time DESC LIMIT 10;
```

**Backup Database:**

```bash
pg_dump postgresql://user:pass@localhost:5432/myapp > backup.sql
```

**Restore Database:**

```bash
psql postgresql://user:pass@localhost:5432/myapp < backup.sql
```

---

## Implementation Notes

**Completed:**
- [x] Researched MCP PostgreSQL server specifications
- [x] Documented configuration requirements
- [x] Provided complete `.mcp.json` template
- [x] Included Docker setup for local development
- [x] Created security best practices section
- [x] Added troubleshooting guide

**Pending in Target Directory:**
- [ ] Copy and customize configuration files
- [ ] Set up PostgreSQL instance (local or Docker)
- [ ] Test MCP server connection
- [ ] Verify Claude Code integration
- [ ] Create documentation for team
- [ ] Set up monitoring (optional)

---

## Completion Criteria

- [x] All tasks documented in comprehensive guide
- [ ] Code configured in target directory
- [ ] MCP postgres server running and verified
- [ ] Claude Code settings configured
- [ ] Test queries executed successfully
- [ ] Documentation updated for team
- [ ] Troubleshooting guide validated

---

## Key Files to Transfer

When moving to another repository, ensure you have:

1. **Configuration Files:**
   - `.claude/.mcp.json` - MCP server configuration
   - `.claude/settings.json` - Claude Code permissions
   - `.env.example` - Environment variable template

2. **Database Files:**
   - `init.sql` - Initial schema
   - `docker-compose.yml` - Docker setup
   - `migrations/` - Database migrations (if applicable)

3. **Documentation:**
   - `docs/DATABASE.md` - Database documentation
   - `docs/MCP_SETUP.md` - This handoff
   - `README.md` - Updated with setup instructions

---

## Next Steps for Target Directory

1. **Step 1:** Copy `.mcp.json` and customize database credentials
2. **Step 2:** Update `.claude/settings.json` with postgres permissions
3. **Step 3:** Create `.env` file with DATABASE_URL
4. **Step 4:** Start PostgreSQL (local or Docker)
5. **Step 5:** Run initialization script to create schema
6. **Step 6:** Test connection with Claude Code
7. **Step 7:** Document team-specific customizations
8. **Step 8:** Commit configuration (excluding credentials)

---

## Additional Resources

- **Official MCP Documentation:** https://modelcontextprotocol.io/
- **PostgreSQL MCP Server:** https://github.com/anthropics/mcp-server-postgres
- **PostgreSQL Docs:** https://www.postgresql.org/docs/
- **Claude Code Docs:** https://claude.com/claude-code

---

**Handoff Created:** 2025-11-22
**Source Repository:** Claude Skill Eval (moai-adk-main)
**Prepared for:** MCP PostgreSQL setup in another directory
