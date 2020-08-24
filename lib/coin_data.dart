import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'A5651B1A-096F-4A4B-904E-28F810A86740';

class CoinData {
  CoinData({this.moneyCurrency, this.coinCurrency});
  final String moneyCurrency;
  final String coinCurrency;
  Future getCoinData() async {
    http.Response response = await http
        .get('$coinAPIURL/$coinCurrency/$moneyCurrency?apikey=$apiKey');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['rate'];
    } else
      print(response.statusCode);
  }
}
