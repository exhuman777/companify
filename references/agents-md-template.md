# AGENTS.md Template

One AGENTS.md per agent, in agents/{slug}/AGENTS.md.

## Frontmatter

**CRITICAL: Do NOT include `slug` or `metadata.paperclip` in frontmatter.** The slug is auto-derived from the directory name. Adapter config (model, permissions, maxTurns) lives in `.paperclip.yaml`, not here. Duplicating it causes import failures.

```yaml
---
name: {Agent Name}
title: {Job Title}
reportsTo: {manager-slug or null for CEO}
skills:
  - paperclip
  - {skill-shortname-1}
  - {skill-shortname-2}
---
```

That's it. Four fields: `name`, `title`, `reportsTo`, `skills`. Nothing else.

## What NOT to put in frontmatter

- `slug` -- auto-derived from directory name (agents/{slug}/AGENTS.md)
- `metadata.paperclip` -- adapter config lives in .paperclip.yaml
- `adapter`, `model`, `budget`, `heartbeat` -- all belong in .paperclip.yaml

## Body Structure

```markdown
You are the {Title} of {Company Name}.

## Capabilities
- {One-line discoverable capability 1}
- {One-line discoverable capability 2}

## What triggers you
{Heartbeat schedule, @-mention conditions, task assignment triggers}

## What you do
{Core responsibilities. Be specific to the project. Reference actual directories, frameworks, patterns from the codebase.}

## What you produce
{Concrete outputs: files, reports, PRs, reviews, deployments.}

## Who you hand off to
{Downstream agents and conditions. Use agent slugs.}

## Safety Considerations
- Never exfiltrate secrets or private data
- Do not perform destructive commands without board approval
```

## CEO Additions

```markdown
## Memory and Planning
You MUST use the `para-memory-files` skill for all memory operations.

## Autonomy
- You have full authority to hire agents, assign tasks, and manage the company
- The Board (Exhuman) can pause, override, or redirect any decision at any time
- Use your judgement for day-to-day operations without waiting for approval
```

## Rules

- Every agent MUST have `paperclip` in skills list
- CEO additionally gets `para-memory-files`
- Skills by shortname only (not paths)
- No machine paths in frontmatter
- No `slug` in frontmatter (auto-derived from directory)
- No `metadata.paperclip` in frontmatter (lives in .paperclip.yaml)
- Ground body in actual project context
- Capabilities section mandatory (enables agent discovery)
