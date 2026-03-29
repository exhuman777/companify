# Validation Checklist

Run after every file write (Loop 1) and after all files written (Loop 2).

## Loop 1: Per-File Validation

### COMPANY.md
- [ ] Has `name` (non-empty)
- [ ] Has `description` (1-1024 chars)
- [ ] Has `slug` (URL-safe)
- [ ] Frontmatter has ONLY `name`, `slug`, `description` (no schema, kind, version, license, authors, goals, requirements, tags, metadata)
- [ ] No placeholder text (TBD, TODO, FIXME)
- [ ] No machine-local paths or secret values
- [ ] Body has: overview, tech stack, org structure, workflows

### AGENTS.md (per agent)
- [ ] Has `name`, `title`, `reportsTo` (slug or null)
- [ ] Has `skills` list with at least `paperclip`
- [ ] CEO has `para-memory-files` in skills
- [ ] Frontmatter has ONLY `name`, `title`, `reportsTo`, `skills` (no slug, no metadata.paperclip)
- [ ] No `slug` field in frontmatter (auto-derived from directory name)
- [ ] No `metadata.paperclip` block in frontmatter (config lives in .paperclip.yaml)
- [ ] Body has: Capabilities, What triggers you, What you do, What you produce, Who you hand off to, Safety
- [ ] Capabilities has 2+ items
- [ ] No machine paths or secret values
- [ ] reportsTo references a real agent slug
- [ ] All skill shortnames resolvable
- [ ] Body grounded in actual project context

### SKILL.md (custom skills)
- [ ] `name`: 1-64 chars, lowercase + hyphens, matches dir
- [ ] `description`: 1-1024 chars, starts with "Use when"
- [ ] Body under 500 lines
- [ ] Has gotchas section
- [ ] Has validation/checklist
- [ ] No placeholder text

### TEAM.md
- [ ] Has `slug`, `name`, `description`
- [ ] `manager` is valid relative path
- [ ] All `includes` are valid relative paths

### .paperclip.yaml
- [ ] Has `schema: paperclip/v1`
- [ ] Agent slugs match agents/ directory
- [ ] **Every agent has `adapter.config.dangerouslySkipPermissions: true`** (without this, agents are sandbox-locked)
- [ ] Every agent has `adapter.config.model` set
- [ ] Every agent has `adapter.config.maxTurnsPerRun` set
- [ ] No agent entry is omitted (all need adapter.config even without secrets)
- [ ] Secrets as `{ kind: secret, requirement: ... }`
- [ ] No actual secret values or absolute paths
- [ ] Does not duplicate agent instructions

### TRUST.md (if Agent Ledger)
- [ ] Agent slug matches existing agent
- [ ] Has Requires, Gates, Denied sections
- [ ] Production/spending gates are human-approval

### WORKFLOW.md (if Agent Ledger)
- [ ] All agent/skill references resolve
- [ ] Final step has human-approval gate
- [ ] Step outputs reference correctly

### .companify/company.db
- [ ] Valid SQLite file
- [ ] All tables created
- [ ] Seeded with agent, skill, team data

## Loop 2: Package Validation

- [ ] Org tree connected (every agent reachable from CEO)
- [ ] No orphaned skills (every custom skill assigned to 1+ agent)
- [ ] No skill gaps (every agent has 1+ skill beyond paperclip)
- [ ] Handoff paths exist (every agent names downstream in "Who you hand off to")
- [ ] .paperclip.yaml agent count matches agents/ directory (every agent has an entry)
- [ ] Every agent in .paperclip.yaml has dangerouslySkipPermissions: true
- [ ] All reportsTo form valid tree (no cycles, no dangling)
- [ ] Company goals are actionable
- [ ] If Agent Ledger: every agent has trust/{slug}/TRUST.md
- [ ] If Agent Ledger: workflows reference valid agents/skills
- [ ] README org chart matches actual agents/ directory
