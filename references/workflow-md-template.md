# WORKFLOW.md Template

Optional (Agent Ledger layer). In workflows/{slug}/WORKFLOW.md.

## Code Review Pipeline (code projects)

```markdown
# Code Review Pipeline

### Step 1: Write
- skill: code-implementation
- agent: {developer-slug}
- gate: auto-pass

### Step 2: Review
- skill: code-review
- agent: {reviewer-slug}
- input: ${step-1.output}
- gate: auto-pass

### Step 3: Test
- skill: testing
- agent: {qa-slug}
- input: ${step-2.output}
- gate: auto-pass

### Step 4: Merge
- skill: release
- agent: {release-slug}
- input: ${step-3.output}
- gate: human-approval
```

## Deploy Pipeline (full-stack projects)

```markdown
# Deploy Pipeline

### Step 1: Build
- skill: build
- agent: {engineer-slug}
- gate: auto-pass
- timeout: 10m

### Step 2: Test
- skill: testing
- agent: {qa-slug}
- input: ${step-1.output}
- gate: auto-pass

### Step 3: Stage
- skill: deploy-staging
- agent: {release-slug}
- input: ${step-2.output}
- gate: auto-pass

### Step 4: Production
- skill: deploy-production
- agent: {release-slug}
- input: ${step-3.output}
- gate: human-approval
- rollback: rollback-deploy
```

## Publish Pipeline (content projects)

```markdown
# Publish Pipeline

### Step 1: Draft
- skill: content-creation
- agent: {writer-slug}
- gate: auto-pass

### Step 2: Edit
- skill: content-review
- agent: {editor-slug}
- input: ${step-1.output}
- gate: auto-pass

### Step 3: Approve
- skill: content-approval
- agent: {lead-slug}
- input: ${step-2.output}
- gate: human-approval

### Step 4: Publish
- skill: content-publish
- agent: {ops-slug}
- input: ${step-3.output}
- gate: human-approval
```

## Rules

- Every pipeline ends with human-approval gate on final step
- Steps reference skills by shortname and agents by slug
- Rollback skills optional but recommended for deploy pipelines
- Timeout defaults: 30m workflow, 10m per step
