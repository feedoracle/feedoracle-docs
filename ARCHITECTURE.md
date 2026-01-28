# FeedOracle Architecture

## System Overview

```
Internet → Nginx (Gateway) → API Services → Data Sources
                ↓
         Evidence Layer → Multi-Chain Anchoring
                ↓
         Regulatory Memory → Historical Proofs
```

## Components

### Gateway Server (Gehirn)
- Nginx reverse proxy
- SSL termination
- Rate limiting
- API routing

### Worker Server
- 30+ API microservices
- ClickHouse analytics
- Job queue processing
- Snapshot generation

### Data Flow
1. External data ingestion
2. Normalization & validation
3. Evidence envelope creation
4. Multi-chain anchoring
5. Memory layer storage

## Ports
- 5070-5105: Core APIs
- 5110-5180: Financial APIs
- 443: Public HTTPS
