# Stack-to-Role Mappings

Default mappings from detected tech stack to proposed agent roles. Used by Phase 4.

## Framework -> Agent Role

| Tech Detected | Agent Slug | Title | Default Skills |
|---|---|---|---|
| React / Next.js / Remix / Vue / Svelte | frontend-lead | Frontend Lead | framework best practices |
| Express / Fastify / Hono / NestJS | api-architect | API Architect | api-design |
| Supabase / PostgreSQL / MySQL / MongoDB | data-engineer | Data Engineer | database-management |
| Tailwind / CSS Modules / Styled Components | ui-engineer | UI Engineer | design-system |
| Jest / Vitest / Pytest / Go test | qa-engineer | QA Engineer | testing-strategy |
| GitHub Actions / Vercel / Docker / Railway | release-engineer | Release Engineer | ci-cd |
| Solidity / Foundry / Hardhat | smart-contract-auditor | Smart Contract Auditor | contract-security |
| Python / FastAPI / Django / Flask | backend-engineer | Backend Engineer | python-best-practices |
| Rust / Cargo | systems-engineer | Systems Engineer | rust-best-practices |
| Go / Gin / Echo | backend-engineer | Backend Engineer | go-best-practices |
| MDX / Markdown / Docusaurus | content-lead | Content Lead | technical-writing |
| Remotion / FFmpeg / Canvas | media-producer | Media Producer | video-production |
| Redis / BullMQ / Kafka | infrastructure-engineer | Infrastructure Engineer | queue-management |
| Stripe / Payment APIs | billing-engineer | Billing Engineer | payment-integration |
| Auth0 / Clerk / NextAuth | auth-engineer | Auth Engineer | authentication |

## Project Purpose -> Additional Agents

| Purpose | Additional Agent | Why |
|---|---|---|
| Web app with users | security-reviewer | OWASP review, auth hardening |
| Public API | api-docs-writer | OpenAPI spec, developer docs |
| Game | game-designer | Gameplay logic, balance |
| Data pipeline | data-analyst | Query optimization, ETL |
| Library/SDK | developer-advocate | Examples, docs, release notes |
| Marketing site | seo-specialist | Metadata, performance, analytics |

## Org Shape Heuristics

| Project Characteristic | Recommended Shape |
|---|---|
| 1-20 files, single framework | Flat (CEO + 2-3 specialists) |
| 20-50 files, 2 concerns | Flat (CEO + 4-5 specialists) |
| 50-100 files, 3+ concerns | Pipeline (CEO -> leads -> specialists) |
| 100+ files, multiple domains | Hierarchical (CEO -> division heads -> leads) |
| Monorepo with workspaces | One team per workspace, hierarchical |

## Mandatory Agents (always present)

| Slug | Title | Reports To | Skills |
|---|---|---|---|
| ceo | Chief Executive Officer | null | paperclip, para-memory-files, goal-tracker |
| db-manager | Chief Data Officer | ceo | paperclip, data-integrity, schema-migration |

## Budget Defaults by Role

| Role Type | Monthly Token Limit | Heartbeat Schedule |
|---|---|---|
| CEO | 10,000,000 | 0 8 * * * (daily 8am) |
| Division Lead | 5,000,000 | 0 9 * * 1-5 (weekdays 9am) |
| Specialist | 2,000,000 | 0 */4 * * * (every 4 hours) |
| DB Manager | 1,000,000 | 0 */6 * * * (every 6 hours) |
| Ledger Keeper | 1,000,000 | 0 */6 * * * (every 6 hours) |
