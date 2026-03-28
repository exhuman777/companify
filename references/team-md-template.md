# TEAM.md Template

Only generated when company has 6+ agents. One per team, in teams/{slug}/TEAM.md.

```yaml
---
slug: {team-slug}
name: {Team Name}
description: {What this team handles}
manager: ../../agents/{lead-slug}/AGENTS.md
includes:
  - ../../agents/{member-1}/AGENTS.md
  - ../../agents/{member-2}/AGENTS.md
  - ../../skills/{skill-slug}/SKILL.md
tags:
  - {domain-tag}
---
```

Body: brief description of purpose, work flow, connections to other teams.

## Rules

- Manager and includes use relative paths from team directory
- Include both agents AND skills relevant to the team
- Tags match the domain/function
