---
name: companify
description: Use when converting a project, folder, or GitHub repo into a Paperclip agent company package, or when a repo is missing COMPANY.md for companies.sh add. Handles codebase analysis, agent org design, three-tier skill sourcing from local installs and skills.sh, SQLite database setup, and optional Agent Ledger integration with WORKFLOW.md, LEDGER.md, TRUST.md.
---

# Companify

Convert any project into a Paperclip agent company package. One invocation. Auto-analysis. User confirmation. All files written.

## When to Use

- Converting a local project folder into a Paperclip company
- Converting a GitHub repo into a Paperclip company
- Repo is missing COMPANY.md and `npx companies.sh add` fails with 422
- Setting up an AI agent workforce for an existing codebase
- Adding agent company structure to any project

**Don't use when:**
- Company package already exists and just needs updates (edit files directly)
- You only need to install a single skill (use `npx skills add`)

## Prerequisites

- Project must exist (local path or GitHub URL)
- For Paperclip import: Paperclip instance running
- SQLite available (ships with Node.js via better-sqlite3, or Python sqlite3)

## The Pipeline

Seven phases, executed in order. No phase skipping.

### Phase 1: Resolve Source

1. Determine input type:
   - Local path (e.g., `~/projects/lilnote`): validate directory exists
   - GitHub URL (e.g., `https://github.com/owner/repo`): clone to temp dir
2. Validate project: must have at least one of: package.json, Cargo.toml, pyproject.toml, go.mod, README.md, src/, app/, lib/
3. If git repo: note current branch, recent commits, contributor count
4. Check for existing company package files (COMPANY.md, agents/, .paperclip.yaml). If found, warn and ask: merge or overwrite?

### Phase 2: Analyze Codebase

Fan out parallel Explore agents to simultaneously:

1. **Structure:** Glob file tree, count files by type, identify key directories
2. **Stack:** Read manifest files (package.json, etc.), detect frameworks/databases/APIs
3. **Purpose:** Read README, infer from directory shape and manifest description
4. **Workflows:** Read scripts (package.json scripts, Makefile, GitHub Actions, Dockerfile)
5. **AI Config:** Check for CLAUDE.md, .claude/, .agents/, existing skills, MCP config
6. **Git History:** Recent commits, contributors, branch strategy

Read `references/stack-to-role-mappings.md` for the default tech-to-role mapping table.

Synthesize into a **Project Profile** and present to user:
```
Project: [name]
Purpose: [one-line]
Stack: [languages, frameworks, databases, services]
Workflows: [build, test, deploy commands]
Existing AI: [what's configured]
Size: [file count, contributors, activity]
```

### Phase 3: Source Skills

Read `references/skill-sourcing-guide.md` for the full three-tier procedure.

**Tier 1 -- Local (reuse first):**
Glob `~/.claude/skills/`, `~/.agents/skills/`, project `.claude/skills/`, superpowers cache. Match skill descriptions against detected tech stack. Check `~/.companify/global.db` skill_matches table for cached matches from previous runs.

**Tier 2 -- skills.sh (fill gaps):**
WebSearch skills.sh for uncovered tech stack needs. Use skills.sh URL or key-style ref as source. Do NOT convert to GitHub URLs. Prefer high-install-count skills. Cache matches to global.db.

**Tier 3 -- Create custom (last resort):**
For project-specific workflows with no match. Read `references/skill-md-template.md` for the template. Write to `skills/{slug}/SKILL.md` inside the company package.

Every agent gets the `paperclip` skill (core heartbeat procedure). CEO additionally gets `para-memory-files`.

### Phase 4: Design Org Structure

**Default to hierarchical with comprehensive coverage.** Every company should have at minimum 8 agents covering both technical and business domains. Read `references/stack-to-role-mappings.md`.

**Always hierarchical.** Even small projects benefit from a CTO layer. The CEO should not directly manage specialists.

```
ceo
 |- cto (Engineering division)
 |   |- {tech specialists from stack detection}
 |   |- db-manager
 |   |- security-reviewer
 |- marketing-lead (Growth division)
 |   |- analytics-lead
 |   |- {monetization/content agents if applicable}
 |- research-lead (Intelligence division)
 |   |- {osint/quant agents if applicable}
```

Mandatory agents (every company, minimum 7):
- `ceo` (reportsTo: null) -- strategy, coordination
- `cto` (reportsTo: ceo) -- technical architecture, engineering management
- `db-manager` (reportsTo: cto) -- data integrity, schema management
- `security-reviewer` (reportsTo: cto) -- OWASP audits, vulnerability review
- `marketing-lead` (reportsTo: ceo) -- user acquisition, brand, content
- `analytics-lead` (reportsTo: marketing-lead) -- metrics, funnels, dashboards
- `research-lead` (reportsTo: ceo) -- competitive analysis, technology scouting

Then add ALL tech-specific agents from stack detection (frontend-lead, api-architect, etc.) and purpose-specific agents (quant-trader, osint-analyst, monetization-specialist, etc.).

**Full autonomy by default.** Companies are created with:
- `requireBoardApprovalForNewAgents: false` -- CEO can hire freely
- `dangerouslySkipPermissions: true` on every agent -- no sandbox restrictions
- No approval gates on day-to-day operations

Review proposed org for: skill gaps, missing handoff paths, domains without coverage.

### Phase 5: Present for Approval

Present section by section:
1. Org chart (text tree)
2. Agent table (slug, title, reportsTo, skills, source)
3. Skills by source (local/skills.sh/custom)
4. Optional: "Do you want Agent Ledger integration (verifiable execution, trust permissions, workflow gates)?"
5. User modifies (add/remove/rename/reassign) before confirming

### Phase 6: Write Package

Read templates from `references/` directory. Write files in this order:

1. **COMPANY.md** -- read `references/company-md-template.md`
2. **agents/{slug}/AGENTS.md** -- read `references/agents-md-template.md`. Every agent gets `paperclip` in skills list. CEO additionally gets `para-memory-files`.
3. **skills/{slug}/SKILL.md** (custom only) -- read `references/skill-md-template.md`
4. **teams/{slug}/TEAM.md** (if 6+ agents) -- read `references/team-md-template.md`
5. **.paperclip.yaml** -- read `references/paperclip-yaml-template.md`
6. **README.md** -- org chart table, roster, quick start
7. **.companify/company.db** -- run `scripts/init-db.sql`, seed with entity data
8. If Agent Ledger opted in: trust/, workflows/, ledger/ -- read `references/trust-md-template.md` and `references/workflow-md-template.md`

Run validation after each file. Read `references/validation-checklist.md` for all checks.
Run package-level validation after all files. Fix issues inline.

### Phase 7: Import and Learn

1. Verify package completeness using `references/validation-checklist.md`
2. Import into Paperclip. Try `companies.sh` first, fall back to direct API if it fails:
   ```
   cd {project} && npx companies.sh add .
   ```
   If `companies.sh` returns a 500 error, use the direct API fallback:
   - Build inline source payload from package files (COMPANY.md, agents/, skills/, .paperclip.yaml)
   - `POST http://127.0.0.1:3100/api/companies/import/preview` to verify
   - `POST http://127.0.0.1:3100/api/companies/import` to apply
3. After import, verify agents have `dangerouslySkipPermissions: true` by checking via API:
   ```
   GET http://127.0.0.1:3100/api/companies/{companyId}/agents
   ```
   If any agent is missing it, patch them: `PATCH http://127.0.0.1:3100/api/agents/{agentId}` with `{"adapterConfig": {"dangerouslySkipPermissions": true}}`
4. Stage new files, commit with descriptive message
5. Hand user the push command with summary (never push directly)
6. Write learnings to `~/.companify/global.db`:
   - Stack-to-role mappings that worked
   - Skill-to-role mappings confirmed
   - Org pattern used and project characteristics
   - Any user corrections from Phase 5
   - Skill discovery cache from Phase 3

## Quick Reference

| Phase | Action | Key Reference |
|-------|--------|---------------|
| 1 | Resolve source | -- |
| 2 | Analyze codebase | stack-to-role-mappings.md |
| 3 | Source skills | skill-sourcing-guide.md |
| 4 | Design org | stack-to-role-mappings.md |
| 5 | Get approval | -- |
| 6 | Write package | all templates + validation-checklist.md |
| 7 | Import + learn | -- |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| **Extra fields in COMPANY.md frontmatter** | **Paperclip only parses `name`, `slug`, `description`. Remove `schema`, `kind`, `version`, `license`, `authors`, `goals`, `requirements`, `tags`, `metadata`. These cause 500 errors or are silently dropped.** |
| **`slug` in AGENTS.md frontmatter** | **Remove it. Slug is auto-derived from directory name (agents/{slug}/AGENTS.md). Having it in frontmatter can confuse the parser.** |
| **`metadata.paperclip` in AGENTS.md frontmatter** | **Remove it. Adapter config (model, permissions, budget, heartbeat) lives in .paperclip.yaml only. Duplicating it causes import failures.** |
| **Missing `dangerouslySkipPermissions: true`** | **Every agent MUST have this in .paperclip.yaml `adapter.config`. Without it, agents are sandbox-locked and all Bash commands require manual approval. Heartbeats will fail.** |
| **Using `adapter.type: process`** | **Must be `claude_local`. The `process` type requires a command field and will fail with "Process adapter missing command".** |
| Missing `model` in adapter.config | Always include model ID (e.g., claude-sonnet-4-6) in .paperclip.yaml adapter.config |
| Missing `maxTurnsPerRun` in adapter.config | Always set this to prevent runaway agents (300 for CEO, 200 for specialists) |
| Omitting agents from .paperclip.yaml | Every agent needs an entry, even without secrets, because adapter.config is required |
| Too few agents | Minimum 8 agents per company. Every domain needs coverage. Add business agents (marketing, analytics, research) even for small projects. |
| Board approval left on | Set `requireBoardApprovalForNewAgents: false` so CEO can operate autonomously |
| Jumping to org design without analyzing | Phase 2 before Phase 4. Always. |
| Creating skills that already exist locally | Tier 1 scan first. Check ~/.claude/skills/ |
| Generic agent descriptions | Ground in actual project needs from Phase 2 |
| Forgetting paperclip skill on agents | Every agent gets it. Non-negotiable. |
| Machine paths in AGENTS.md frontmatter | Vendor config in .paperclip.yaml only |
| Duplicating instructions in .paperclip.yaml | Agent instructions live in AGENTS.md body |
| skills.sh URL converted to GitHub | Keep skills.sh refs as-is |
| Skipping validation | Run validation-checklist.md per-file AND per-package |
| Forgetting to seed company.db | Phase 6 step 7. Initialize AND seed. |
| Not writing learnings | Phase 7 step 6. Every successful run writes to global.db |
| Using `companies.sh add .` when it 500s | Fallback to direct API: `POST http://127.0.0.1:3100/api/companies/import` with inline source. The CLI has an uncaught DB constraint bug. |
