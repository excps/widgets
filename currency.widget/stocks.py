import json
# import os
import requests
from requests.exceptions import ConnectionError
# from unittest import TestCase

# class TestGetCurrencyRates(TestCase):
#     def test_currency_rates(self):
#         with open(os.path.join(os.path.dirname(__file__), "fixtures", "currency_rates.json"), "r") as f:
#             expected = json.load(f)
#         print(expected)
#         response = get_currency_rates()
#         self.assertEqual(expected, response)
#     def test_no_network(self):
#         with open(os.path.join(os.path.dirname(__file__), 'fixtures', 'no_network.json'), 'r') as f:
#             expected = json.load(f)

#         with mock.patch('requests.get') as mock_get:
#             mock_get.side_effect = ConnectionError()
#             response = get_currency_rates()

#         self.assertEqual(expected, response)

def get_currency_rates():
    data = {"No Network": {"in": "", "out": ""}}

    try:
        response = requests.get('https://v6.exchangerate-api.com/v6/e8c619ed6982805067945c14/latest/CAD')
        cad = response.json()
        data = {
            "EUR/AUD": {
                "in": round(float(cad['conversion_rates']['AUD'])/float(cad['conversion_rates']['EUR']), 3),
                "out": round(float(cad['conversion_rates']['EUR'])/float(cad['conversion_rates']['AUD']), 3),
            },
            "CAD/USD": {
                "in": round(cad['conversion_rates']['USD'], 3),
                "out": round(1 / float(cad['conversion_rates']['USD']), 3)
            },
            "CAD/EUR": {
                "in": round(cad['conversion_rates']['EUR'], 3),
                "out": round(1 / float(cad['conversion_rates']['EUR']), 3)
            },
            "CAD/GBP": {
                "in": round(cad['conversion_rates']['GBP'], 3),
                "out": round(1 / float(cad['conversion_rates']['GBP']), 3)
            },
            "CAD/AUD": {
                "in": round(cad['conversion_rates']['AUD'], 3),
                "out": round(1 / float(cad['conversion_rates']['AUD']), 3),
            },
            "CAD/ARS": {
                "in":round( cad['conversion_rates']['ARS'], 3),
                "out": round(1 / float(cad['conversion_rates']['ARS']), 3)},
        }
    except ConnectionError as e:  # This is the correct syntax
        pass

    return json.dumps(data)

def run():
    print(get_currency_rates())

if __name__ == '__main__':
    run()
