import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

Future<String> getIPAddress() async {
  final url = Uri.parse('https://httpbin.org/ip');
  final httpClient = HttpClient();
  final request = await httpClient.getUrl(url);
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  final String ip = jsonDecode(responseBody)['origin'];
  print(ip);
  return ip;
}
Stream<String> getIPAdds() async* {
  final url = Uri.parse('https://httpbin.org/ip');
  final httpClient = HttpClient();
  final request = await httpClient.getUrl(url);
  final response = await request.close();
  final responseBody = await response.transform(utf8.decoder).join();
  final String ip = jsonDecode(responseBody)['origin'];
  print(ip);
  yield ip;
}

class Futures extends StatefulWidget {
  @override
  _Futures createState() => _Futures();
}

class _Futures extends State<Futures>{

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              FutureBuilder<String>(
                  future: getIPAddress(),
                  builder: (context, AsyncSnapshot<String> ipAddress) {
                    return Text(ipAddress.data.toString(),style: TextStyle(color: Colors.black),);
                  }
              ),
              StreamBuilder(
                  stream: getIPAdds(),
                  builder: (context, AsyncSnapshot<String> ipAddress) {
                    return Text(ipAddress.toString(),style: TextStyle(color: Colors.black),);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getIPAddress(),
        builder: (context, AsyncSnapshot<String> ipAddress) {
          return MaterialApp(
            title: 'Flutter Future',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FutureBuildPage(title: 'Flutter Future Home Page', asyncSnapshotIpAddress: ipAddress),
          );
        }
    );
  }
}

class FutureBuildPage extends StatefulWidget {
  final String title;
  final AsyncSnapshot<String> asyncSnapshotIpAddress;

  const FutureBuildPage({
    Key? key,
    required this.title,
    required this.asyncSnapshotIpAddress,
  }) : super(key: key);

  @override
  State<FutureBuildPage> createState() => _FutureBuildPage();
}

class _FutureBuildPage extends State<FutureBuildPage> {
  String _ipAddress = "";

  @override
  Widget build(context) {

    if (widget.asyncSnapshotIpAddress.hasData && widget.asyncSnapshotIpAddress.data != null) {
      _ipAddress = widget.asyncSnapshotIpAddress.data!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your ip address is:',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              '$_ipAddress',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}

