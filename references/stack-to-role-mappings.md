# Stack-to-Role Mappings

Default mappings from detected tech stack to proposed agent roles. Used by Phase 4.

**PHILOSOPHY: More agents is better.** Every distinct concern in the project should have a dedicated agent. A company with 8-15 agents that covers all domains will outperform a skeleton crew of 3-4. When in doubt, add the agent. The CEO can always reassign or pause agents that aren't pulling weight.

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
| Polymarket / prediction markets | quant-trader | Quant Trader | polymarket-quant |
| AI / LLM / OpenRouter / Anthropic | ai-engineer | AI Engineer | ai-integration |
| WebSocket / Socket.io / SSE | realtime-engineer | Realtime Engineer | websocket-management |
| Cron / Scheduled tasks / Workers | automation-engineer | Automation Engineer | task-scheduling |

## Always-Add Business Agents

These agents are added to EVERY company regardless of tech stack. They cover business operations that every product needs:

| Agent Slug | Title | Why |
|---|---|---|
| cto | Chief Technology Officer | Technical architecture, code quality, engineering team management |
| marketing-lead | Marketing Lead | User acquisition, brand awareness, content creation |
| analytics-lead | Analytics Lead | Usage metrics, conversion funnels, data-driven decisions |
| research-lead | Research Lead | Competitive analysis, market research, technology scouting |
| security-reviewer | Security Reviewer | OWASP audits, vulnerability scanning, auth hardening |

## Project Purpose -> Additional Agents

| Purpose | Additional Agent | Why |
|---|---|---|
| Web app with users | auth-engineer | Authentication, session management |
| Public API | api-docs-writer | OpenAPI spec, developer docs |
| Game | game-designer | Gameplay logic, balance |
| Data pipeline | data-analyst | Query optimization, ETL |
| Library/SDK | developer-advocate | Examples, docs, release notes |
| Marketing site | seo-specialist | Metadata, performance, analytics |
| Trading / finance | quant-trader | Market analysis, trade execution |
| OSINT / intelligence | osint-analyst | Signal collection, source monitoring |
| Monetization / SaaS | monetization-specialist | Pricing, API access, revenue optimization |
| Content platform | content-moderator | Review, approval, quality gates |

## Org Shape Heuristics

**Default to hierarchical.** Flat orgs don't scale and limit the CEO's ability to delegate effectively. Even small projects benefit from a CTO layer between CEO and specialists.

| Project Characteristic | Recommended Shape |
|---|---|
| 1-20 files, single framework | Hierarchical (CEO -> CTO -> 3-5 specialists + business agents) |
| 20-50 files, 2 concerns | Hierarchical (CEO -> CTO + division leads -> specialists) |
| 50-100 files, 3+ concerns | Hierarchical (CEO -> 3-4 division leads -> specialists) |
| 100+ files, multiple domains | Hierarchical (CEO -> division heads -> team leads -> specialists) |
| Monorepo with workspaces | One team per workspace, hierarchical |

**Minimum agent count: 8.** Every company should have at least: CEO, CTO, db-manager, frontend-lead or backend-lead, security-reviewer, marketing-lead, analytics-lead, research-lead. More is better.

## Mandatory Agents (always present)

| Slug | Title | Reports To | Skills |
|---|---|---|---|
| ceo | Chief Executive Officer | null | paperclip, para-memory-files |
| cto | Chief Technology Officer | ceo | paperclip, framework best practices |
| db-manager | Chief Data Officer | cto | paperclip, data-integrity |
| security-reviewer | Security Reviewer | cto | paperclip, security-review |
| marketing-lead | Marketing Lead | ceo | paperclip, marketing-engine |
| analytics-lead | Analytics Lead | marketing-lead | paperclip, analytics-insights |
| research-lead | Research Lead | ceo | paperclip, research |

## Budget Defaults by Role

| Role Type | Monthly Token Limit | Heartbeat Schedule |
|---|---|---|
| CEO | 10,000,000 | 0 8 * * * (daily 8am) |
| CTO | 5,000,000 | 0 9 * * 1-5 (weekdays 9am) |
| Division Lead | 5,000,000 | 0 9 * * 1-5 (weekdays 9am) |
| Specialist | 2,000,000 | 0 */4 * * * (every 4 hours) |
| DB Manager | 1,000,000 | 0 */6 * * * (every 6 hours) |
| Ledger Keeper | 1,000,000 | 0 */6 * * * (every 6 hours) |
