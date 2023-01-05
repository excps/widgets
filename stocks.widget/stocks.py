import requests
import json

rCad = requests.get('https://v6.exchangerate-api.com/v6/e8c619ed6982805067945c14/latest/CAD')
rUsd = requests.get('https://v6.exchangerate-api.com/v6/e8c619ed6982805067945c14/latest/USD')
cad = rCad.json()
usd = rUsd.json()
data = {
    "CAD/USD": cad['conversion_rates']['USD'],
    "CAD/EUR": cad['conversion_rates']['EUR'],
    "CAD/AUD": cad['conversion_rates']['AUD'],
    "CAD/ARS": cad['conversion_rates']['ARS'],
    "USD/ARS": usd['conversion_rates']['ARS'],
    "USD/EUR": usd['conversion_rates']['EUR'],
    "USD/CAD": usd['conversion_rates']['CAD'],
    "EUR/CAD": round(1 / float(cad['conversion_rates']['EUR']), 4),
}
print(json.dumps(data))
