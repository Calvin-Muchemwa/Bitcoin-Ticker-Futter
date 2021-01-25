import 'package:http/http.dart';
import 'networking.dart';

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

class CoinData {

  Future<Map> getCoinData(String selectedCurrency)async{
    NetworkHelper networkHelper;
    Map<String,String>coinRates={};
    for(String crypto in cryptoList) {
      networkHelper=await NetworkHelper(url:'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=8AC549DC-C887-489D-A2E4-9881F26B7C0C');
      var data= await networkHelper.getRequest();
      coinRates[crypto]=data['rate'].toString();
      print(data);
    }
    return coinRates;
  }

}
