import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List cryptoRate = List(3);

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList.elementAt(selectedIndex);
          getData();
        });
      },
      children: pickerItems,
    );
  }

  void getData() async {
    for (int i = 0; i < cryptoList.length; i++) {
      try {
        double cryptoData = await CoinData(
                moneyCurrency: selectedCurrency, coinCurrency: cryptoList[i])
            .getCoinData();
        print(cryptoData);
        setState(() {
          cryptoRate[i] = cryptoData.toStringAsFixed(2);
        });
      } catch (e) {
        print(e);
      }
    }
  }

//  void updateUI(dynamic coinData) {
//    setState(() {
////
//    });
//  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
//    for (int i = 0; i < cryptoList.length; i++) {
//      Padding(
//        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//        child: Card(
//          color: Colors.lightBlueAccent,
//          elevation: 5.0,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(10.0),
//          ),
//          child: Padding(
//            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//            child: Text(
//              //TODO: Update the Text Widget with the live bitcoin data here.
//              '1 ${cryptoList.elementAt(i)} = ${cryptoRate.elementAt(i)} $selectedCurrency',
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                fontSize: 20.0,
//                color: Colors.white,
//              ),
//            ),
//          ),
//        ),
//      );
//    }
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(
            cryptoRate: cryptoRate[0],
            selectedCurrency: selectedCurrency,
            cryptoCurrency: cryptoList[0],
          ),
          CryptoCard(
            cryptoRate: cryptoRate[1],
            selectedCurrency: selectedCurrency,
            cryptoCurrency: cryptoList[1],
          ),
          CryptoCard(
            cryptoRate: cryptoRate[2],
            selectedCurrency: selectedCurrency,
            cryptoCurrency: cryptoList[2],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    @required this.cryptoCurrency,
    @required this.cryptoRate,
    @required this.selectedCurrency,
  });

  final String cryptoCurrency;
  final String cryptoRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 $cryptoCurrency = $cryptoRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
