
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PeriodicRequester extends StatefulWidget {
  @override
  _PeriodicRequester createState() => _PeriodicRequester();
}

class _PeriodicRequester extends State<PeriodicRequester> {
  Stream<http.Response> getRandomNumberFact() async* {
    yield* Stream.periodic(Duration(seconds: 5), (_) {
      return http.get(Uri.parse("http://numbersapi.com/random/"));
    }).asyncMap((event) async => await event);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body: StreamBuilder<http.Response>(
          stream: getRandomNumberFact(),
          builder: (context, snapshot) => snapshot.hasData
              ? Center(child: Text(snapshot.data!.body))
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}