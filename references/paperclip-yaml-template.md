# .paperclip.yaml Template

Vendor sidecar for Paperclip runtime config. Lives at project root.

```yaml
schema: paperclip/v1
agents:
  {agent-slug}:
    adapter:
      type: claude_local
    inputs:
      env:
        {SECRET_NAME}:
          kind: secret
          requirement: {required|optional}
```

## Rules

- schema: paperclip/v1 always
- Only adapter type, env/secret declarations, and routine triggers
- Secrets as portable `{ kind: secret, requirement: required|optional }`
- Never duplicate agent instructions (those live in AGENTS.md body)
- Never include absolute paths or actual secret values
- Agents with default config (claude_local, no secrets) can be omitted
