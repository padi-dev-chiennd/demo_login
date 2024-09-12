import 'package:demologin/API/currency.dart';
import 'package:demologin/util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BitCoin extends StatefulWidget {
  const BitCoin({super.key});

  @override
  _BitCoinState createState() => _BitCoinState();
}

class _BitCoinState extends State<BitCoin> {
  /// set the default currency
  String selectedCurrency = 'USD';
  bool isWaiting = false;
  String value = '';

  @override
  void initState() {
    super.initState();
    getCurrenciesData();
  }

  getCurrenciesData() async {
    isWaiting = true;
    try {
      double data = await Currency().getRate();
      isWaiting = false;
      setState(() {
        value = data.toStringAsFixed(0);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, appBar: _appBar(), body: _content());
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.cyan,
      centerTitle: true,
      title: const Text(
        'CRYPTO EXCHANGE RATES',
      ),
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }

  _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: _menuItem(),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.blue,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC =  $value  $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ],
    );
  }

  _menuItem() {
    return Container(
      height: 50.0,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 30.0),
      color: Colors.white,
      child: DropdownButton<dynamic>(
        dropdownColor: Colors.white,
        value: selectedCurrency,
        items: dropDown(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value.toString();
            getCurrenciesData();
          });
        },
      ),
    );
  }
}
