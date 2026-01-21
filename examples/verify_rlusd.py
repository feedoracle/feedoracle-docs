#!/usr/bin/env python3
import requests
API="https://feedoracle.io/api/v3"
d=requests.get(f"{API}/rlusd/latest").json()["snapshot"]
h=d["content_hash"]
print(f"RLUSD {d['report_month']}: {d['circulating_supply']:,}")
a=requests.get(f"{API}/rlusd/anchors/list").json()
m=next((x for x in a["anchors"] if x["content_hash"]==h),None)
if m: print(f"XRPL: https://xrpscan.com/tx/{m['tx_hash']}")
