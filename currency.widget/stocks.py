import requests
from requests.exceptions import ConnectionError
import json

try:
    response = requests.get('https://v6.exchangerate-api.com/v6/e8c619ed6982805067945c14/latest/CAD')
    cad = response.json()
    data = {
        "CAD/USD": {"in": cad['conversion_rates']['USD'], "out": round(1 / float(cad['conversion_rates']['USD']), 4)},
        "CAD/EUR": {"in": cad['conversion_rates']['EUR'], "out": round(1 / float(cad['conversion_rates']['EUR']), 4)},
        "CAD/GBP": {"in": cad['conversion_rates']['GBP'], "out": round(1 / float(cad['conversion_rates']['GBP']), 4)},
        "CAD/AUD": {"in": cad['conversion_rates']['AUD'], "out": round(1 / float(cad['conversion_rates']['AUD']), 4)},
        "CAD/ARS": {"in": cad['conversion_rates']['ARS'], "out": round(1 / float(cad['conversion_rates']['ARS']), 4)},
    }
except ConnectionError as e:  # This is the correct syntax
    data = {"No Network": {"in": "", "out": ""}}

print(json.dumps(data))
