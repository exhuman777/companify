# COMPANY.md Template

Replace all {PLACEHOLDER} values with actual project data from Phase 2 analysis.

**CRITICAL: Paperclip only parses `name`, `slug`, and `description` from frontmatter.** All other fields (schema, kind, version, license, authors, goals, requirements, tags, metadata) are ignored by the Paperclip import API and will cause 500 errors or be silently dropped. Keep frontmatter minimal.

```yaml
---
name: {Project Name}
slug: {project-slug}
description: {One-line description from README or Phase 2 analysis}
---
```

That's it. Three fields. Nothing else in frontmatter.

## Body Content

After the frontmatter, write markdown covering:

1. **Company Overview** -- 2-3 sentences (derived from README)
2. **Tech Stack** -- bullet list of languages, frameworks, services
3. **Org Structure** -- text tree of agent hierarchy
4. **Key Workflows** -- how work flows through the company
5. **Goals** -- put company goals here in the body, not in frontmatter

Do NOT include: machine-specific paths, secret values, database IDs, timestamps.

## What NOT to put in frontmatter

These fields are NOT parsed by Paperclip and must be omitted:
- `schema`, `kind`, `version`, `license` -- spec metadata, not runtime config
- `authors`, `goals`, `requirements` -- put in body markdown instead
- `tags`, `metadata` -- not used by import API
- `metadata.paperclip.budget`, `metadata.paperclip.governance` -- config lives in .paperclip.yaml
