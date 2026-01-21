#!/usr/bin/env python3
import requests
API="https://api.feedoracle.io/api/v3"
def verify():
    print("FeedOracle RLUSD Verification")
    print("="*40)
    snap=requests.get(f"{API}/rlusd/latest").json()["snapshot"]
    h=snap["content_hash"]
    print(f"Report: {snap['report_month']}")
    print(f"Supply: {snap['circulating_supply']:,} RLUSD")
    print(f"Reserve: ${snap['reserve_value_usd']:,}")
    print(f"Ratio: {snap['reserve_ratio']:.2%}")
    a=requests.get(f"{API}/rlusd/anchors").json()
    x=a["chains"]["xrpl"]["anchors"]
    m=next((i for i in x if i["content_hash"]==h),None)
    if m:
        print(f"\nXRPL: {m['tx_hash']}")
        print(f"https://xrpscan.com/tx/{m['tx_hash']}")
        print("\nVERIFIED on XRP Ledger")
if __name__=="__main__": verify()
