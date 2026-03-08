# FeedOracle Documentation

Evidence-grade financial, regulatory, and macro data infrastructure for AI agents and regulated institutions.

**Live platform:** [feedoracle.io](https://feedoracle.io)  
**Status:** [uptime.feedoracle.io](https://uptime.feedoracle.io)  
**OpenAPI:** [feedoracle.io/.well-known/openapi.json](https://feedoracle.io/.well-known/openapi.json)

---

## What FeedOracle Is

FeedOracle provides cryptographically signed, audit-ready data artifacts — not raw feeds. Every response carries an ES256K signature verifiable against a public JWKS endpoint, with optional Polygon blockchain anchoring.

**Built for:** MiCA/DORA compliance officers, RWA protocols, DeFi risk systems, AI agents needing audit-ready data.

---

## Three MCP Servers

| Server | Endpoint | Tools | Purpose |
|--------|----------|-------|---------|
| Compliance Oracle | `https://feedoracle.io/mcp/` | 22 | MiCA Art. 16–66, DORA, RWA risk |
| Macro Oracle | `https://feedoracle.io/mcp/macro/` | 13 | 86 FRED series, macro regime engine |
| Stablecoin Risk | `https://feedoracle.io/mcp/risk/` | 13 | Operational risk: SAFE/CAUTION/AVOID |

---

## Agent Self-Service — Full Autonomous Journey

AI agents can complete the full lifecycle without human intervention:

```
1. Discovery  →  /.well-known/oauth-authorization-server
2. Register   →  POST /mcp/register  (RFC 7591, client_credentials)
3. Authenticate → POST /mcp/token
4. Use tools  →  GET /mcp/sse + POST /mcp/messages
5. Hit limit  →  machine-readable upgrade signal in response headers
6. Pay        →  POST /usdc/intent → send USDC on Polygon → POST /usdc/verify
7. Upgrade    →  API key issued automatically, no human required
8. Verify     →  ES256K signatures + public JWKS, independent of FeedOracle
```

**Production proof:** [TX 0x2be6dd...f95905](https://polygonscan.com/tx/0x2be6dd56aed6e45f5bacb0af53b95e7cded8b36885aabba12cb7bac282f95905) — Polygon mainnet, 67 confirmations.

---

## Independent Verification

```bash
# Download and run the public 38-check verification suite
curl -O https://feedoracle.io/feedoracle_agent_verify.py
python3 feedoracle_agent_verify.py
# → 38/38 checks passed
```

No account, no API key, no FeedOracle trust required.

---

## Key Endpoints

| Endpoint | Purpose |
|----------|---------|
| `/.well-known/oauth-authorization-server` | OAuth 2.0 server metadata (RFC 8414) |
| `/.well-known/oauth-protected-resource` | Upgrade paths, evidence metadata |
| `/.well-known/jwks.json` | Public ES256K signing key |
| `/.well-known/mcp/server-card.json` | Machine-readable service description |
| `/mcp/register` | Dynamic client registration |
| `/mcp/token` | Bearer token issuance |
| `/usdc/pricing` | Plans, wallet, chain_id |
| `/usdc/intent` | Create USDC payment intent |
| `/usdc/recover/{tx_hash}` | Agent crash recovery |
| `/verify` | Signature verification guide |
| `/feedoracle_agent_verify.py` | Public 38-check test suite |

---

## Regulatory Frameworks

| Framework | Coverage |
|-----------|----------|
| MiCA | 19 articles, 105+ stablecoins, ESMA/EBA register cross-validation |
| DORA | ICT risk, incident reporting, resilience testing, third-party oversight |
| RWA | 61 protocols, legal state, liquidity, on-chain/off-chain reconciliation |

MiCA full enforcement: **July 2026**

---

## Repository Contents

```
contracts/    Smart contracts (DAPAnchor, on-chain anchoring)
docs/         Architecture, API reference
examples/     Agent integration examples  
schemas/      JSON schemas for evidence artifacts
specs/        OpenAPI fragments
```

---

## Data Sources

FRED (86 series) · ECB (20 series) · ESMA Register · EBA Register · CoinGecko · DeFiLlama · CCRI · EMBER · ENTSO-E · EU-ETS · Polygon (anchoring) · Gnosis Chain (Olas Mech)

---

🌐 [feedoracle.io](https://feedoracle.io) · 📋 [OpenAPI](https://feedoracle.io/.well-known/openapi.json) · ✅ [Verify](https://feedoracle.io/feedoracle_agent_verify.py)

**License:** Proprietary — © 2026 FeedOracle.
