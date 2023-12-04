import 'package:rxdart/subjects.dart';

import 'currency_conv_repo.dart';

class CurrConvBloc {
  final CurrencyConvRepo _currencyConvRepo = CurrencyConvRepo();

  BehaviorSubject<List<String>> currencyBehavior = BehaviorSubject();

  Stream<List<String>> get currConvStream => currencyBehavior.stream;

  fetchCurrencyList() async {
    List<String> currencyList=await _currencyConvRepo.loadCurrencies();
    if(currencyList!=null){
      currencyBehavior.sink.add(currencyList!);
    }
    else{
      currencyBehavior.sink.add([]);
    }
  }

  BehaviorSubject<String> convertBehavior = BehaviorSubject();

  Stream<String> get convStream => convertBehavior.stream;

  fetchCoversion(String amount,String fromCurrency, String toCurrency) async {
    String conversion=await _currencyConvRepo.doConversion(amount, fromCurrency, toCurrency);
    if(conversion!=null){
      convertBehavior.sink.add(conversion!);
    }
    else{
      convertBehavior.sink.add("");
    }
  }
}