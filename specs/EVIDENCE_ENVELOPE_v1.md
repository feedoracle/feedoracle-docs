# Evidence Envelope Specification v1.0

**Publisher:** FeedOracle  
**First Published:** 2026-01-14  
**Genesis TX:** 0xcdfad8b21a5254c615f53c56fb073153135fe47950749bbaaae8baf2f797b713

## Core Fields

| Field | Type | Description |
|-------|------|-------------|
| `as_of` | ISO8601 | Data capture timestamp |
| `schema_version` | semver | Schema version |
| `feed_name` | string | Feed identifier |
| `content_hash` | SHA-256 | Payload hash |
| `sources` | array | Data sources |
| `anchor_ref` | object | On-chain reference |

## Hash Calculation

```python
import hashlib, json
content_hash = hashlib.sha256(
    json.dumps(payload, sort_keys=True, separators=(',',':')).encode()
).hexdigest()
```

## On-Chain Anchoring

Supported chains:
- **Polygon** (primary): Contract registry
- **XRPL**: Memo field anchoring

## Verification Steps

1. Download evidence artifact
2. Recalculate SHA-256 hash
3. Compare with `content_hash` field
4. Verify on-chain anchor (optional)

---
© 2026 FeedOracle - First published 2026-01-14
