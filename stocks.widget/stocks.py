import requests
import json

c = requests.get('https://v6.exchangerate-api.com/v6/e8c619ed6982805067945c14/latest/CAD')
data = c.json()
USD = round(1 / float(data['conversion_rates']['USD']), 4)
AUD = round(1 / float(data['conversion_rates']['AUD']), 4)
EUR = round(1 / float(data['conversion_rates']['EUR']), 4)
ARS = data['conversion_rates']['ARS']

data = {
    "USD/CAD": USD,
    "EUR/CAD": EUR,
    "AUD/CAD": AUD,
    "ARS/CAD": ARS,
}
print(json.dumps(data))
# print(f"EUR/CAD,{EUR}")
# print(f"AUD/CAD,{AUD}")
# print(f"ARS/CAD,{ARS}")
