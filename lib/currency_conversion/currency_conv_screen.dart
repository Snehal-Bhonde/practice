import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:practice/currency_conversion/currency_conv_bloc.dart';

void main() => runApp(new MaterialApp(
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
  String amount="";
  CurrConvBloc convBloc=CurrConvBloc();

  @override
  void initState() {
    super.initState();
    convBloc.fetchCurrencyList();
  }

  _doConversion() async {
    if(fromTextController.text!=""){
      convBloc.fetchCoversion(fromTextController.text, fromCurrency, toCurrency);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill from currency")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Currency Converter"),
        ),
        body:
       // currencies == null ? Center(child: CircularProgressIndicator()) :
        Container(
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
                      decoration: InputDecoration(
                       // border: InputBorder.,
                        hintText: 'Enter amount',
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.black,),
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                    ),
                   // trailing: _buildDropDownButton(fromCurrency),
                    trailing: SizedBox(
                      width: 100,
                      child: StreamBuilder(
                          stream: convBloc.currConvStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData){
                              return Container();}
                            else {
                              //fromCurrency=snapshot.data!.first;
                              return DropdownButton(
                               // hint: const Text("Currency"),
                                value: fromCurrency,
                                items: snapshot.data!
                                    .map((String value) =>
                                    DropdownMenuItem(
                                      value: value,
                                      child: Text(value,style: TextStyle(color: Colors.black),),
                                    ))
                                    .toList(),

                                // onChanged: bloc.inName,
                                onChanged: (value) {
                                  //fromCurrency=value!;print(value);
                                  setState(() {
                                    fromCurrency=value!;
                                    print(value);
                                  });
                                },
                              );
                            }
                          },
                  ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_downward),
                    onPressed: _doConversion,
                  ),
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

                        return Center(child:  Container());
                      },
                    ),
                   // trailing: _buildDropDownButton(toCurrency),
                    trailing: SizedBox(
                      width: 100,
                      child: StreamBuilder(
                        stream: convBloc.currConvStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData){
                            return Container();}
                          else {
                            //fromCurrency=snapshot.data!.first;
                            return DropdownButton(
                              // hint: const Text("Currency"),
                              value: toCurrency,
                              items: snapshot.data!
                                  .map((String value) =>
                                  DropdownMenuItem(
                                    value: value,
                                    child: Text(value,style: TextStyle(color: Colors.black),),
                                  ))
                                  .toList(),

                              // onChanged: bloc.inName,
                              onChanged: (value) {
                                //fromCurrency=value!;print(value);
                                setState(() {
                                  toCurrency=value!;
                                  print(value);
                                });
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
    );
  }


}