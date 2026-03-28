# Skill Sourcing Guide

Three-tier procedure for Phase 3.

## Tier 1: Local Scan (always first)

Search in order:
1. `~/.claude/skills/` -- user-global Claude Code skills
2. `~/.agents/skills/` -- user-global cross-agent skills
3. `{project}/.claude/skills/` -- project-level
4. `{project}/.agents/skills/` -- project-level cross-agent
5. Superpowers plugin cache
6. Existing CLAUDE.md / AGENTS.md references

Read each SKILL.md description, match against tech stack keywords from Phase 2.

**Check global.db cache:**
```sql
SELECT skill_slug, source, hit_count
FROM skill_matches
WHERE tech_keyword IN ({detected_keywords})
ORDER BY hit_count DESC;
```

Cached match with hit_count >= 2: use without re-searching.

## Tier 2: skills.sh Search (fill gaps)

For uncovered tech stack keywords:
1. WebSearch: `site:skills.sh {framework-name}`
2. Prefer skills with >1000 installs (battle-tested)
3. Use skills.sh URL or key-style ref (e.g., `vercel-labs/skills/react-best-practices`)
4. Do NOT convert skills.sh URLs to GitHub URLs

**Record match:**
```sql
INSERT INTO skill_matches (tech_keyword, skill_slug, source, hit_count)
VALUES ('{keyword}', '{slug}', 'skills.sh', 1)
ON CONFLICT (tech_keyword, skill_slug)
DO UPDATE SET hit_count = hit_count + 1, last_matched = datetime('now');
```

## Tier 3: Create Custom (last resort)

1. Read `references/skill-md-template.md`
2. Ground in actual project artifacts
3. Include gotchas from Phase 2 analysis
4. Write to `{project}/skills/{slug}/SKILL.md`

**Record custom skill:**
```sql
INSERT INTO custom_skills (slug, created_for_project, content_hash)
VALUES ('{slug}', '{project}', '{sha256}');
```

## Mandatory Skills

| Skill | Assigned To | Source |
|---|---|---|
| paperclip | ALL agents | Built-in (Paperclip runtime) |
| para-memory-files | CEO | Should be installed locally |

## Assignment Rules

- Every agent gets `paperclip`
- CEO gets `para-memory-files`
- db-manager gets `data-integrity`, `schema-migration` (custom if not found)
- ledger-keeper gets `workflow-management`, `trust-audit`, `ledger-verification` (custom)
- Other agents: match via stack-to-role-mappings.md
- Every agent must have 1+ domain skill beyond paperclip
