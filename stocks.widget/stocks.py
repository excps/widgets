import requests
import json

c = requests.get('https://v6.exchangerate-api.com/v6/e8c619ed6982805067945c14/latest/CAD')
data = c.json()
data = {
    "USD/CAD": round(1 / float(data['conversion_rates']['USD']), 4),
    "EUR/CAD": round(1 / float(data['conversion_rates']['EUR']), 4),
    "CAD/AUD": data['conversion_rates']['AUD'],
    "CAD/ARS": data['conversion_rates']['ARS'],
}
print(json.dumps(data))
