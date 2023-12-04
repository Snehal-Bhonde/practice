import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:practice/currency_conversion/currency_conv_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(
      title: "Currency Converter",
      home: CurrencyConverter(),
    ));

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final fromTextController = TextEditingController();

  // List<String>? currencies;
  String fromCurrency = "USD";
  String toCurrency = "GBP";
  String amount = "";
  CurrConvBloc convBloc = CurrConvBloc();

  @override
  void initState() {
    super.initState();
    convBloc.fetchCurrencyList();
  }

  _doConversion(String currency, String currencyTo) async {
    if (fromTextController.text != "") {
      convBloc.fetchCoversion(fromTextController.text, currency, currencyTo);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please fill from currency")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CurrencyModel(),
        child:  SafeArea(
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text("Currency Converter"),
                    ),
                    body:
                    Consumer<CurrencyModel>(
                      builder: (context, model, child) => Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 3.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ListTile(
                                title: TextField(
                                  controller: fromTextController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter amount',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                  keyboardType: const TextInputType.numberWithOptions(
                                      decimal: true),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: StreamBuilder(
                                    stream: convBloc.currConvStream,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        return DropdownButton(
                                          value: model.currency,
                                          items: snapshot.data!
                                              .map((String value) =>
                                                  DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            model.setCurrency = value!;
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.arrow_downward),
                                  onPressed: () {
                                    _doConversion(
                                        model.currency, model.currencyTo);
                                  }),
                              ListTile(
                                title: StreamBuilder(
                                  stream: convBloc.convStream,
                                  builder: (context, snapshot) {
                                    print("snapshot");
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data!);
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }
                                    return Center(child: Container());
                                  },
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: StreamBuilder(
                                    stream: convBloc.currConvStream,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      } else {
                                        return DropdownButton(
                                          value: model.currencyTo,
                                          items: snapshot.data!
                                              .map((String value) =>
                                                  DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            model.setCurrencyTo = value!;
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
  }
}


class CurrencyModel extends ChangeNotifier {
  String _currency = "USD";
  String _currencyTo = "USD";

  String get currency => _currency;

  String get currencyTo => _currencyTo;

  set setCurrency(String value) {
    if (value != _currency) {
      _currency = value;
      notifyListeners();
    }
  }

  set setCurrencyTo(String value) {
    if (value != _currencyTo) {
      _currencyTo = value;
      notifyListeners();
    }
  }
}
