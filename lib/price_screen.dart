import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'coin_data.dart';
import'networking.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'USD';
  String BTCrate='?';
  String LTCrate='?';
  String ETHrate='?';


 /*Future<String> getRate(String value,String coin)async{
   double rates;
   NetworkHelper networkHelper= await NetworkHelper(url:'https://rest.coinapi.io/v1/exchangerate/$coin/$value?apikey=8AC549DC-C887-489D-A2E4-9881F26B7C0C');
   var data= await networkHelper.getRequest();
   rates=data['rate'];
   return rates.toString();

 }*/


  CupertinoPicker IOSpicker() {
    List<Text> dd = [];
    for (int i = 0; i < currenciesList.length; i++) {
      dd.add(
        Text(currenciesList[i]),
      );
    }
    CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: dd,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dd = [];
    for (int i = 0; i < currenciesList.length; i++) {
      dd.add(DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      ));
    }

    return DropdownButton<String>(
        value: selectedCurrency /*currently selected value in our dropdownmenu*/

        ,
        items: dd,
        onChanged: (value) async{
          CoinData coinData=CoinData();
          Map<String,String>coindata= await coinData.getCoinData(selectedCurrency);
          setState(() {
            BTCrate=coindata['BTC'];
            LTCrate=coindata['LTC'];
            ETHrate=coindata['ETH'];
            selectedCurrency = value;

          });
        });
  }

//How would we use widgets that are device specific? i.e for android and IOS different Functionalities; We can with dart.io and 'Platform' Class see import lines
  Widget getPicker() {
    if (Platform.isIOS) {
      return IOSpicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }
@override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CoinCard(selectedCurrency: selectedCurrency,cardCoin:'BTC' ,coinRate: BTCrate,),
          CoinCard(selectedCurrency: selectedCurrency,cardCoin:'ETH' ,coinRate:ETHrate,),
          CoinCard(selectedCurrency: selectedCurrency,cardCoin:'LTC' ,coinRate: LTCrate,),
          Container(
            margin: EdgeInsets.only(top:270),
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS?IOSpicker():androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {

  final String cardCoin;
  final String selectedCurrency;
  final String coinRate;

  CoinCard({this.selectedCurrency,this.cardCoin,this.coinRate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cardCoin = $coinRate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
