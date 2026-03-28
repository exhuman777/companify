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

Present 2-3 org shapes with trade-offs. Read `references/stack-to-role-mappings.md`.

Shapes:
- **Flat:** CEO + specialists (small projects, <20 files)
- **Pipeline:** CEO -> sequential chain (linear workflows)
- **Hierarchical:** CEO -> leads -> specialists (large projects, 100+ files)

Mandatory agents (every company):
- `ceo` (reportsTo: null)
- `db-manager` (reportsTo: ceo)

Optional:
- `ledger-keeper` (offered in Phase 5)

Review proposed org for: redundant roles, skill gaps, missing handoff paths, purposeless agents.

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
2. Present import command:
   ```
   cd {project} && npx companies.sh add .
   ```
3. Stage new files, commit with descriptive message
4. Hand user the push command with summary (never push directly)
5. Write learnings to `~/.companify/global.db`:
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
| Jumping to org design without analyzing | Phase 2 before Phase 4. Always. |
| Creating skills that already exist locally | Tier 1 scan first. Check ~/.claude/skills/ |
| Generic agent descriptions | Ground in actual project needs from Phase 2 |
| Forgetting paperclip skill on agents | Every agent gets it. Non-negotiable. |
| Machine paths in AGENTS.md frontmatter | Vendor config in .paperclip.yaml only |
| Duplicating instructions in .paperclip.yaml | Agent instructions live in AGENTS.md body |
| skills.sh URL converted to GitHub | Keep skills.sh refs as-is |
| Skipping validation | Run validation-checklist.md per-file AND per-package |
| Forgetting to seed company.db | Phase 6 step 7. Initialize AND seed. |
| Not writing learnings | Phase 7 step 5. Every successful run writes to global.db |
