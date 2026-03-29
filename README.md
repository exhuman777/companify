```
  ____                                   _  __
 / ___|___  _ __ ___  _ __   __ _ _ __ (_)/ _|_   _
| |   / _ \| '_ ` _ \| '_ \ / _` | '_ \| | |_| | | |
| |__| (_) | | | | | | |_) | (_| | | | | |  _| |_| |
 \____\___/|_| |_| |_| .__/ \__,_|_| |_|_|_|  \__, |
                      |_|                       |___/
```

<p align="center">
<b>companify</b><br>
<i>Turn any project into a Paperclip agent company. One command.</i><br>
<a href="#install">Install</a> &middot; <a href="#how-it-works">How It Works</a> &middot; <a href="#file-map">File Map</a> &middot; <a href="https://agentcompanies.io">Agent Companies Spec</a>
</p>

<p align="center">
<img src="https://img.shields.io/badge/format-Agent_Skills-orange?style=flat-square" alt="Agent Skills">
<img src="https://img.shields.io/badge/spec-agentcompanies%2Fv1-black?style=flat-square" alt="agentcompanies/v1">
<img src="https://img.shields.io/badge/database-SQLite-amber?style=flat-square" alt="SQLite">
<img src="https://img.shields.io/badge/optional-Agent_Ledger-brightgreen?style=flat-square" alt="Agent Ledger">
<img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" alt="MIT">
</p>

---

## What This Is

An agent skill that analyzes any codebase and generates a fully autonomous Paperclip agent company package. Reads your project, builds a hierarchical org of 8+ AI agents with the right skills, writes all the files, sets up a SQLite database, and hands you the import command.

Works with any project. Local folders or GitHub repos. Any language, any framework. Every company ships with full autonomy: `dangerouslySkipPermissions: true`, no board approval gates, agents free to act.

```
your-project/                     companify generates:
  package.json          -->         COMPANY.md
  src/                  -->         agents/ceo/AGENTS.md
  README.md             -->         agents/cto/AGENTS.md
                                    agents/db-manager/AGENTS.md
                                    agents/frontend-lead/AGENTS.md
                                    agents/marketing-lead/AGENTS.md
                                    agents/analytics-lead/AGENTS.md
                                    agents/research-lead/AGENTS.md
                                    agents/security-reviewer/AGENTS.md
                                    skills/deploy/SKILL.md
                                    teams/engineering/TEAM.md
                                    .paperclip.yaml
                                    .companify/company.db
```

## How It Works

Seven-phase pipeline. No shortcuts.

```
+------------------+     +------------------+     +------------------+
|  1. RESOLVE      |---->|  2. ANALYZE      |---->|  3. SOURCE       |
|  Local or GitHub |     |  Stack, purpose, |     |  Local skills    |
|  Validate exists |     |  workflows, AI   |     |  skills.sh       |
+------------------+     +------------------+     |  Create custom   |
                                                  +------------------+
                                                          |
+------------------+     +------------------+     +------------------+
|  7. IMPORT       |<----|  6. WRITE        |<----|  4. DESIGN       |
|  companies.sh    |     |  All files +     |     |  Flat/pipeline/  |
|  Learn to DB     |     |  validate each   |     |  hierarchical    |
+------------------+     +------------------+     +------------------+
                                                          |
                                                  +------------------+
                                                  |  5. APPROVE      |
                                                  |  User confirms   |
                                                  |  org + skills    |
                                                  +------------------+
```

### Phase 2: Analyze

Parallel agents scan your codebase: directory structure, tech stack, project purpose, build/test/deploy workflows, existing AI config, git history. Produces a Project Profile.

### Phase 3: Three-Tier Skill Sourcing

| Priority | Source | Method |
|----------|--------|--------|
| 1st | Local skills | Scan ~/.claude/skills/, ~/.agents/skills/, project skills |
| 2nd | skills.sh | Search public registry, prefer high-install-count |
| 3rd | Create custom | Write new SKILL.md with gotchas from your codebase |

### Phase 4: Org Design

Always hierarchical. Minimum 8 agents. Every company gets business + tech agents.

| Layer | Agents |
|---|---|
| CEO | Strategic direction, cross-division coordination |
| Division Leads | CTO, marketing-lead, research-lead |
| Specialists | Tech-specific + analytics-lead, db-manager, security-reviewer |

### Mandatory in Every Company

| Component | Purpose |
|---|---|
| `ceo` agent | Orchestrator, owns company goals |
| `cto` agent | Technical architecture, engineering division |
| `db-manager` agent | SQLite database, data integrity, memory sync |
| `security-reviewer` agent | OWASP checks, dependency audit, secrets scan |
| `marketing-lead` agent | Growth, positioning, distribution |
| `analytics-lead` agent | Metrics, KPIs, data-driven decisions |
| `research-lead` agent | Competitive analysis, emerging patterns |
| `.companify/company.db` | Per-company SQLite database |
| `~/.companify/global.db` | Cross-company learning database |

### Full Autonomy

Every generated company ships with:
- `dangerouslySkipPermissions: true` on all agents
- `requireBoardApprovalForNewAgents: false`
- `adapter.type: claude_local` (not `process`)
- Model and turn limits configured per agent

### Optional: Agent Ledger

Add verifiable execution with [Agent Ledger](https://github.com/exhuman777/agentledger):

| File | Purpose |
|---|---|
| WORKFLOW.md | Declarative multi-step execution plans with gates |
| LEDGER.md | Append-only execution records with SHA-256 hashes |
| TRUST.md | Per-agent capability and permission declarations |

## Install

```bash
npx skills add exhuman777/companify
```

Or clone and install locally:

```bash
git clone https://github.com/exhuman777/companify.git
npx skills add ./companify
```

## Usage

After installing, tell your agent:

> "Use the companify skill to convert ~/projects/my-app into a Paperclip company"

Or:

> "Use companify on https://github.com/owner/repo"

Then import into Paperclip:

```bash
cd ~/projects/my-app && npx companies.sh add .
```

If `companies.sh` returns 500, use the direct API:

```bash
curl -X POST http://localhost:3100/api/companies/import \
  -H "Content-Type: application/json" \
  -d '{"path": "/absolute/path/to/my-app"}'
```

## File Map

```
companify/
  SKILL.md                              # Main skill (163 lines, 7-phase pipeline)
  references/
    agent-companies-spec-quick-ref.md   # Condensed spec rules for validation
    agents-md-template.md               # AGENTS.md template with body structure
    company-md-template.md              # COMPANY.md template with frontmatter
    paperclip-yaml-template.md          # .paperclip.yaml template
    skill-md-template.md                # Custom SKILL.md template (Tier 3)
    skill-sourcing-guide.md             # Three-tier sourcing procedure
    stack-to-role-mappings.md           # Tech stack -> agent role defaults
    team-md-template.md                 # TEAM.md template
    trust-md-template.md               # TRUST.md template (Agent Ledger)
    validation-checklist.md             # Per-file + package validation checks
    workflow-md-template.md             # WORKFLOW.md template (Agent Ledger)
  scripts/
    init-db.sql                         # SQLite schema for per-company DB
    init-global-db.sql                  # SQLite schema for cross-company learning
```

14 files. Zero dependencies.

## Generated Output

What companify writes inside your project:

```
your-project/
  COMPANY.md                    # agentcompanies/v1 package root
  .paperclip.yaml               # Adapter config, secrets, schedules
  README.md                     # Org chart, roster, quick start
  agents/
    ceo/AGENTS.md               # Always present
    db-manager/AGENTS.md        # Always present
    {role}/AGENTS.md             # Project-specific agents
  skills/
    {slug}/SKILL.md             # Custom skills only
  teams/
    {slug}/TEAM.md              # Only if 6+ agents
  .companify/
    company.db                  # SQLite database
  workflows/                    # Optional (Agent Ledger)
    {slug}/WORKFLOW.md
  trust/                        # Optional (Agent Ledger)
    {slug}/TRUST.md
  ledger/                       # Optional (Agent Ledger)
    LEDGER.md
```

## Learning Engine

Companify gets smarter with every run. Three validation loops:

| Loop | When | What |
|---|---|---|
| Per-file | After each file write | Schema, fields, cross-refs, no placeholders |
| Per-package | After all files | Org tree connectivity, skill gaps, handoff paths |
| Cross-session | After successful run | Stack-to-role patterns, user corrections, skill cache |

The global database (`~/.companify/global.db`) accumulates:
- Which tech stacks map to which agent roles (confirmed across projects)
- Which skills.sh skills match which frameworks (cached for fast lookup)
- User corrections (auto-applied after 3+ repetitions)
- Custom skills that can be reused across projects

## Spec Compliance

Follows all 289 documented best practices from:
- [Agent Companies Specification](https://agentcompanies.io/specification) (agentcompanies/v1)
- [Agent Skills Specification](https://agentskills.io/specification)
- [Paperclip Documentation](https://docs.paperclip.ing/)
- [Agent Ledger Specification](https://agentledger.sh/)

## Compatibility

Works with any agent that supports Agent Skills:

Claude Code, Cursor, GitHub Copilot, VS Code, Codex, Gemini CLI, Windsurf, Goose, Roo Code, OpenHands, Amp, JetBrains Junie, and 20+ more.

---

<p align="center">
<sub>Built by <a href="https://github.com/exhuman777">Exhuman</a> &middot; Built with Claude</sub>
</p>
