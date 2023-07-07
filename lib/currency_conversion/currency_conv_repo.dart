

import 'dart:convert';

import 'package:dio/dio.dart';

class CurrencyConvRepo{
  final Dio _dio=Dio();

  Future<List<String>> loadCurrencies() async {
    String uri = "https://v6.exchangerate-api.com/v6/268cdee972de1862d528e18e/latest/USD";
    //var response = await http.get(Uri.parse(uri), headers: {"Accept": "application/json"});
    var response = await _dio.get(uri);
    print(response);
    Map curMap = response.data['conversion_rates'];
    List<String> currencies = curMap.keys.toList() as List<String>;
    return currencies;
  }

  Future<String> doConversion(String amount,String fromCurrency, String toCurrency) async {
    double amt=double.parse(amount);
    String url = "https://v6.exchangerate-api.com/v6/268cdee972de1862d528e18e/pair/$fromCurrency/$toCurrency/$amt";
    var response = await _dio.get(url);
    String result = response.data['conversion_result'].toString();
    print("result $result");
    return result;
  }

}