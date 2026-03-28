# Custom SKILL.md Template

For Tier 3 skill creation when no local or skills.sh skill matches.

```yaml
---
name: {skill-slug}
description: Use when {specific trigger from project context}. {What the skill does}.
license: MIT
metadata:
  author: companify
  version: "1.0"
---
```

## Body

```markdown
# {Skill Name}

## When to Use
- {Symptom/situation 1 from project analysis}
- {Symptom/situation 2}

**Don't use when:**
- {Counter-indication}

## Procedure
1. {Step 1 -- concrete, actionable}
2. {Step 2}
3. {Validate: check output before proceeding}

## Gotchas
- {Project-specific fact that defies assumptions}
- {Another gotcha from codebase analysis}

## Validation
After completing the procedure:
- [ ] {Check 1}
- [ ] {Check 2}
```

## Rules

- name: 1-64 chars, lowercase + hyphens only, matches directory
- description: 1-1024 chars, starts with "Use when"
- Body under 500 lines / 5000 tokens
- Gotchas section mandatory
- Procedures over declarations
- Include validation loops
- Defaults, not menus
- Ground in real project artifacts
