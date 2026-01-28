# FeedOracle Provenance & Prior Art

**This document establishes FeedOracle's prior art and first-mover status.**

## Genesis Proof

| Chain | Transaction | Date |
|-------|-------------|------|
| Polygon | `0xcdfad8b21a5254c615f53c56fb073153135fe47950749bbaaae8baf2f797b713` | 2026-01-14 |

## Public Release Timeline

| Version | Date | What |
|---------|------|------|
| v1.0 | 2026-01-14 | Evidence Envelope Spec |
| v1.0 | 2026-01-14 | Genesis anchoring on Polygon |
| v2.0 | 2026-01-21 | OpenAPI 3.1 published |
| v3.0 | 2026-01-28 | Memory Layer (14+ days) |

## Smart Contracts (Polygon)

```
Registry:    0xa8F788e0E9e28F4A6aC73Be369CFA396a39a6ac4
Attestation: 0x8243AAC99d9004f6a972907bCF25148aF59Bf7C5
Compliance:  0x1C1850F43ae47A31cB084aC34945893F8E257f85
AccessPass:  0xA071Bc94774B03b26F72084ec5b63E804E7C2DC4
```

## Cryptographic Verification

### Release Bundle Hash
```
SHA-256: 231d185be869c8934a4109dc2636e5fcaa2979c3a56658c51205914a1b643452
Files included:
- specs/EVIDENCE_ENVELOPE_v1.md
- openapi.yaml
- llms.txt
```

### How to Verify

1. Clone repo at specific tag
2. Compute SHA-256 of release files
3. Compare with on-chain anchored hash
4. Verify Polygon TX contains matching hash

## Daily Memory Anchors

FeedOracle anchors daily data snapshots on-chain:
- Location: `/memory/anchors/`
- Format: `{date}.json`
- Contains: Merkle root of all endpoints

## Legal Notice

This prior art publication establishes FeedOracle's
first-mover status. Unauthorized reproduction of this
specification for competitive purposes is documented.

© 2026 FeedOracle
