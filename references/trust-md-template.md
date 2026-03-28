# TRUST.md Template

Optional (Agent Ledger layer). One per agent, in trust/{agent-slug}/TRUST.md.

```markdown
# Trust Declaration: {Agent Name}

## Requires
- filesystem: {read|write} (scope: {paths relative to project root})
- network: {inbound|outbound} (hosts: [{allowed hosts}])
- secrets: read (keys: [{specific key names}])
- database: {read|write}
- spending: ${amount}
- code-execution: {sandboxed|arbitrary}
- duration: {max minutes per heartbeat}

## Gates
- {action}: {gate-type}
  - auto-pass: routine operations after {N} successful runs
  - human-approval: high-stakes actions (never auto-relax)
  - threshold({N}): require N successes before auto-pass

## Denied
- {capability}: {reason}
```

## Default Permission Matrix

| Role | Filesystem | Network | Secrets | Denied |
|---|---|---|---|---|
| CEO | read (all) | none | none | code-execution, direct secrets |
| Frontend Lead | rw (src/, public/) | outbound (CDN, API) | none | secrets, database |
| API Architect | rw (api/, lib/) | outbound (APIs) | read (API keys) | fs outside project |
| Release Engineer | read (all) | outbound (registry) | read (DEPLOY_TOKEN) | database, spending |
| DB Manager | rw (.companify/) | none | read (DB creds) | network outbound |

## Rules

- Production deploys: always human-approval (never auto-relax)
- Spending actions: always human-approval
- Deny rules override all grants
- Progressive trust: gates relax after N successes for non-critical ops
