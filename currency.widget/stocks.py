import requests
from requests.exceptions import ConnectionError
import json

try:
    response = requests.get('https://v6.exchangerate-api.com/v6/e8c619ed6982805067945c14/latest/CAD')
    cad = response.json()
    data = {
        "CAD/USD": {"in": round(cad['conversion_rates']['USD'], 3), "out": round(1 / float(cad['conversion_rates']['USD']), 3)},
        "CAD/EUR": {"in": round(cad['conversion_rates']['EUR'], 3), "out": round(1 / float(cad['conversion_rates']['EUR']), 3)},
        "CAD/GBP": {"in": round(cad['conversion_rates']['GBP'], 3), "out": round(1 / float(cad['conversion_rates']['GBP']), 3)},
        "CAD/AUD": {"in": round(cad['conversion_rates']['AUD'], 3), "out": round(1 / float(cad['conversion_rates']['AUD']), 3)},
        "CAD/ARS": {"in":round( cad['conversion_rates']['ARS'], 3), "out": round(1 / float(cad['conversion_rates']['ARS']), 3)},
    }
except ConnectionError as e:  # This is the correct syntax
    data = {"No Network": {"in": "", "out": ""}}

print(json.dumps(data))
