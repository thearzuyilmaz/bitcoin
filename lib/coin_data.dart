import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'E7D7C1BB-8DC6-4196-9B20-AB1995DCD20B';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {}; // !!!!

    for (String crypto in cryptoList) {
      Uri myUrl =
          Uri.parse('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey');
      http.Response response = await http.get(myUrl);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}

// TEST
void main() async {
  CoinData coinData = CoinData();
  var data = await coinData.getCoinData('USD');
  print(data);
  print(data['BTC']);
}
