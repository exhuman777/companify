# COMPANY.md Template

Replace all {PLACEHOLDER} values with actual project data from Phase 2 analysis.

```yaml
---
schema: agentcompanies/v1
kind: company
slug: {project-slug}
name: {Project Name}
description: {One-line description from README or Phase 2 analysis}
version: 1.0.0
license: MIT
authors:
  - name: {Author from git config or package.json}
goals:
  - {Goal 1 derived from project purpose}
  - {Goal 2 derived from project workflows}
requirements:
  secrets:
    - {SECRET_1 from .env or environment}
tags:
  - {tag from tech stack}
  - {tag from domain}
metadata:
  paperclip:
    budget:
      monthly_token_limit: {total across all agents}
    governance:
      board_approval_required:
        - agent_hires
        - budget_changes
---
```

## Body Content

After the frontmatter, write markdown covering:

1. **Company Overview** -- 2-3 sentences (derived from README)
2. **Tech Stack** -- bullet list of languages, frameworks, services
3. **Org Structure** -- text tree of agent hierarchy
4. **Key Workflows** -- how work flows through the company

Do NOT include: machine-specific paths, secret values, database IDs, timestamps.
