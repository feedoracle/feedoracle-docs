# FeedOracle API Reference

## Base URL
`https://api.feedoracle.io`

## Authentication
`Authorization: Bearer YOUR_API_KEY`

## Carbon APIs
- `GET /carbon/networks` - List all networks
- `GET /carbon/network/{name}` - Get carbon data
- `GET /carbon/compare` - Compare networks

## Macro APIs
- `GET /macro/ecb/rates` - ECB rates
- `GET /macro/fed/rates` - Fed rates
- `GET /macro/worldbank/{indicator}` - World Bank data

## Memory Layer
- `GET /memory/dates` - List snapshot dates
- `GET /memory/snapshot/{date}` - Get snapshot
- `GET /memory/verify/{hash}` - Verify hash
- `GET /memory/proof/{date}` - Get proof
