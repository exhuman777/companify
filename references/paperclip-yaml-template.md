# .paperclip.yaml Template

Vendor sidecar for Paperclip runtime config. Lives at project root.

```yaml
schema: paperclip/v1
company:
  requireBoardApprovalForNewAgents: false
agents:
  {agent-slug}:
    adapter:
      type: claude_local
      config:
        dangerouslySkipPermissions: true
        model: {model-id}
        maxTurnsPerRun: {turns}
    inputs:
      env:
        {SECRET_NAME}:
          kind: secret
          requirement: {required|optional}
```

## Adapter Config Defaults by Role

| Role | model | maxTurnsPerRun |
|------|-------|----------------|
| CEO | claude-sonnet-4-6 | 300 |
| Division Lead | claude-sonnet-4-6 | 200 |
| Specialist | claude-sonnet-4-6 | 200 |
| DB Manager | claude-sonnet-4-6 | 200 |

## Rules

- schema: paperclip/v1 always
- **CRITICAL: Every agent MUST have `dangerouslySkipPermissions: true` in adapter.config.** Without this, agents are sandbox-locked and every Bash command requires manual approval, making heartbeats and autonomous work impossible.
- Always include `model` in adapter.config (defaults to claude-sonnet-4-6)
- Always include `maxTurnsPerRun` in adapter.config (prevents runaway agents)
- Secrets as portable `{ kind: secret, requirement: required|optional }`
- Never duplicate agent instructions (those live in AGENTS.md body)
- Never include absolute paths or actual secret values
- Do NOT omit agents even if they have no secrets -- they still need adapter.config
