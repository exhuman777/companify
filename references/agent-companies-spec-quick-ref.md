# Agent Companies Spec Quick Reference

Condensed rules from agentcompanies/v1. Read during Phase 6 validation.

## COMPANY.md Frontmatter

```yaml
---
schema: agentcompanies/v1          # Only at package root
name: Company Name                 # Required
description: What this company does # Required, 1-1024 chars
slug: company-name                 # URL-safe, stable identity
version: 1.0.0
license: MIT
authors:
  - name: Author Name
goals:
  - Goal description
requirements:
  secrets:
    - SECRET_NAME
tags:
  - tag1
metadata:
  paperclip:
    budget:
      monthly_token_limit: 50000000
---
```

## AGENTS.md Frontmatter

```yaml
---
slug: agent-slug                   # Matches directory name
name: Agent Name
title: Job Title
reportsTo: manager-slug            # null for CEO
skills:                            # Shortnames only
  - paperclip
  - skill-two
metadata:
  paperclip:
    adapter: claude_local
    model: claude-opus-4-6
    budget:
      monthly_token_limit: 5000000
    heartbeat:
      schedule: "0 9 * * 1-5"
      timezone: Europe/Warsaw
---
```

## TEAM.md Frontmatter

```yaml
---
slug: team-slug
name: Team Name
description: What this team does
manager: ../../agents/lead-slug/AGENTS.md
includes:
  - ../../agents/member-slug/AGENTS.md
  - ../../skills/skill-slug/SKILL.md
tags:
  - tag1
---
```

## SKILL.md Frontmatter (Agent Skills spec)

```yaml
---
name: skill-name                   # 1-64 chars, lowercase + hyphens
description: Use when [trigger]    # 1-1024 chars
license: MIT
metadata:
  sources:
    - kind: github-dir
      repo: org/repo
      path: skills/name
      commit: abc123
      attribution: Author Name
      license: MIT
      usage: referenced
---
```

## .paperclip.yaml

```yaml
schema: paperclip/v1
agents:
  agent-slug:
    adapter:
      type: claude_local
    inputs:
      env:
        SECRET_NAME:
          kind: secret
          requirement: required
```

## Hard Rules

- Slugs and relative paths are identity. Never database IDs.
- No machine-local paths in markdown files.
- No secret values in any package file.
- Vendor config in .paperclip.yaml only.
- Skills referenced by shortname. Resolution: local skills/{name}/SKILL.md first.
- SKILL.md format owned by Agent Skills spec. Do not redefine.
- Omit empty or default-valued fields.
- schema field at package root only.
- kind field optional when filename implies it.
- Attribution and license must survive import/export.
