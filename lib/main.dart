import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'Future&Streams/FutureBuilderEx.dart';
import 'Future&Streams/PostApi.dart';
import 'Future&Streams/StreamBuilder1.dart';
import 'Future&Streams/StreamBuilder2.dart';
import 'currency_conversion/currency_conv_screen.dart';
import 'employee/employee_screen.dart';
import 'employee_get_sqflite/emp_sqf_screen.dart';
import 'expense_manager/expense_screen.dart';
import 'get_api/get_api_screen.dart';
import 'home/home_screen.dart';

void main() {
  //HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MyApplication(),
    );
  }
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //home: MyHomePage(),
     // home: ScrollControl(),
      //home: StreamBuilderExample(),
      //home: Futures(),
     // home: PeriodicRequester(),
     // home: PostApi(),
     // home: GetScreen(),
     // home: EmpListScreen(),
      //home: CurrencyConverter(),
      //home: ExpenseManager(),
      home: EmpSqfScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // Flag that holds visibility status of Text()
  bool _isVisible = false;
  String visItem="";
  double visiblePercentage=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text("Visible List $visItem"),
              Expanded(
                child: ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                          children: [
                            Text("List 1"),
                            VisibilityDetector(
                              onVisibilityChanged: (visibilityInfo) {
                                setState(() {

                                  // Change the flag value of _isVisible
                                  // If it is greater than 0 means it is visible
                                  _isVisible = visibilityInfo.visibleFraction > 0;

                                  // It will show how much percentage the widget is visible
                                  visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  print('Widget is ${visiblePercentage}% visible');
                                  if(visiblePercentage >= 60)
                                  visItem="List 1";
                                  print(visItem);
                                });
                              },
                              key: Key('my-widget-key'),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:10,
                                  itemBuilder: (BuildContext context, int index){
                                    return ListTile(
                                      key: Key("key"),
                                      leading: Text(index.toString(),style: TextStyle(color: visiblePercentage>=20?Colors.blue:Colors.black)),
                                    );}),
                            ),
                            Text("List 2"),
                            VisibilityDetector(
                              onVisibilityChanged: (visibilityInfo) {
                                setState(() {

                                  // Change the flag value of _isVisible
                                  // If it is greater than 0 means it is visible
                                  _isVisible = visibilityInfo.visibleFraction > 0;

                                  // It will show how much percentage the widget is visible
                                  visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  print('Widget is ${visiblePercentage}% visible');
                                  if(visiblePercentage > 60)
                                  visItem="List 2";
                                  print(visItem);
                                });
                              },
                              key: Key('my-widget-key'),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:10,
                                  itemBuilder: (BuildContext context, int index){
                                    return ListTile(
                                      key: Key("key"),
                                      leading: Text(index.toString(),style: TextStyle(color: visiblePercentage>=20?Colors.blue:Colors.black)),
                                    );}),
                            ),
                            Text("List 3"),
                            VisibilityDetector(
                              onVisibilityChanged: (visibilityInfo) {
                                setState(() {

                                  // Change the flag value of _isVisible
                                  // If it is greater than 0 means it is visible
                                  _isVisible = visibilityInfo.visibleFraction > 0;

                                  // It will show how much percentage the widget is visible
                                  visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  print('Widget is ${visiblePercentage}% visible');
                                  if(visiblePercentage > 60)
                                    visItem="List 3";
                                  print(visItem);
                                });
                              },
                              key: Key('my-widget-key'),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:10,
                                  itemBuilder: (BuildContext context, int index){
                                    return ListTile(
                                      key: Key("key"),
                                      leading: Text(index.toString(),style: TextStyle(color: visiblePercentage>=20?Colors.blue:Colors.black)),
                                    );}),
                            ),
                            Text("List 4"),
                            VisibilityDetector(
                              onVisibilityChanged: (visibilityInfo) {
                                setState(() {

                                  // Change the flag value of _isVisible
                                  // If it is greater than 0 means it is visible
                                  _isVisible = visibilityInfo.visibleFraction > 0;

                                  // It will show how much percentage the widget is visible
                                  visiblePercentage = visibilityInfo.visibleFraction * 100;
                                  print('Widget is ${visiblePercentage}% visible');
                                  if(visiblePercentage > 60)
                                    visItem="List 4";
                                  print(visItem);
                                });
                              },
                              key: Key('my-widget-key'),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:10,
                                  itemBuilder: (BuildContext context, int index){
                                    return ListTile(
                                      key: Key("key"),
                                      leading: Text(index.toString(),style: TextStyle(color: visiblePercentage>=20?Colors.blue:Colors.black)),
                                    );}),
                            ),
                          ],
                  ),
              ),
            ],
          ),
        ),
        //),
      ),
    );
  }
}

class ScrollControl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return _ScrollControl();
  }
}

class _ScrollControl extends State<ScrollControl>{
  String message = "";
  late ScrollController _controller;
  late ScrollController _controller2;

  @override
  void initState() {
    _controller = ScrollController();
    _controller2 = ScrollController();
    _controller.addListener(_scrollListener);
    _controller2.addListener(_scrollListener2);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the bottom of list 1";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top of list 1";
      });
    }
  }
  _scrollListener2() {
    if (_controller2.offset >= _controller2.position.maxScrollExtent &&
        !_controller2.position.outOfRange) {
      setState(() {
        message = "reach the bottom of list 2";
      });
    }
    if (_controller2.offset <= _controller2.position.minScrollExtent &&
        !_controller2.position.outOfRange) {
      setState(() {
        message = "reach the top of list 2";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Scroll Limit reached"),
      // ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Text(message),
            ),
          ),

          Expanded(
            child: Column(
              children: [
                ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                controller: _controller,
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("Index : $index"));
                },
              ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  controller: _controller2,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text("Index : $index"));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

