import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/list_visibility.dart';
import 'package:practice/permissions_handling_screen.dart';
import 'package:practice/provider/color_picker.dart';
import 'package:practice/provider/counter_provider.dart';
import 'package:practice/provider/provider_get_api.dart';
import 'package:practice/responsive_screens/listview.dart';
import 'package:practice/user_data/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'Future&Streams/FutureBuilderEx.dart';
import 'Future&Streams/PostApi.dart';
import 'Future&Streams/StreamBuilder1.dart';
import 'Future&Streams/StreamBuilder2.dart';
import 'aws_imag_upload/aws_imgup_screen.dart';
import 'currency_conversion/currency_conv_screen.dart';
import 'employee/employee_screen.dart';
import 'employee_get_sqflite/emp_sqf_screen.dart';
import 'expense_manager/expense_screen.dart';
import 'get_api/get_api_screen.dart';
import 'getx/counter/counter_screen.dart';
import 'home/home_screen.dart';
import 'responsive_screens/media_querys.dart';
import 'slider_with_bloc/slider_screen.dart';

Future<void> main() async {
  //HttpOverrides.global = MyHttpOverrides();
 // runApp(ChangeNotifierProvider<ThemeProvider>(create: (_)=>ThemeProvider(),child: MyApp()));
  await init();
  runApp(MyApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
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
    return  MaterialApp(
      //home: MyHomePage(),
      //home: ScrollControl(),
      //home: StreamBuilderExample(),
      //home: Futures(),
     // home: PeriodicRequester(),
     // home: PostApi(),
     // home: GetScreen(),
     // home: EmpListScreen(),
      //home: CurrencyConverter(),
      //home: ExpenseManager(),
      //home: EmpSqfScreen(),
      //home: MediaQueryEx(),
     // home: MediaQuerys(),
    //  home: CounterPage(),
     // home: SliderScreen(),
     // home: ListVisibility(),
     // home: ImagePage(),
      //home: UserScreen(),
      //home: MainScaffold(),
     // home: CounterProvider(),
     /* home: ChangeNotifierProvider(create: (context)=>DataClass(),
         child:ProviderGetApiScreen(),
      )*/
      //home: HomePage(title: 'Counter',),
      home: PermissionScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isVisible = false;
  String visItem="";
  double visiblePercentage=0;
  int list=1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 50,
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:4,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: list-1==index?Colors.blue:Colors.black),
                          borderRadius: BorderRadius.circular(15),
                          color: list-1==index?Colors.lightBlueAccent:Colors.white
                        ),
                        width: 70,
                        child: ListTile(
                          // key: Key("key"),
                          leading: Text("List ${index+1}",style: TextStyle(color: list-1==index?Colors.white:Colors.black)),
                        ),
                      );}),
              ),
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
                                  if(visiblePercentage >= 60){
                                    visItem="List 1";
                                  list=1;}
                                  print(visItem);print(list);
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
                                      leading: Text("${index+1}",style: TextStyle(color: Colors.black)),
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
                                  if(visiblePercentage >= 60) {
                                     visItem = "List 2";
                                     list = 2;
                                  }
                                 print(visItem);print(list);
                                });
                              },
                              key: Key('my-widget-key2'),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:10,
                                  itemBuilder: (BuildContext context, int index){
                                    return ListTile(
                                      key: Key("key"),
                                      leading: Text("${index+1}",style: TextStyle(color: Colors.black)),
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
                                  if(visiblePercentage >= 60){
                                    visItem="List 3";
                                  list=3;}
                                  print(visItem);print(list);
                                });
                              },
                              key: Key('my-widget-key3'),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:10,
                                  itemBuilder: (BuildContext context, int index){
                                    return ListTile(
                                      key: Key("key"),
                                      leading: Text("${index+1}",style: TextStyle(color:Colors.black)),
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
                                  if(visiblePercentage >= 60){
                                    visItem="List 4";
                                  list=4;}
                                  print(visItem);print(list);
                                });
                              },
                              key: Key('my-widget-key4'),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:10,
                                  itemBuilder: (BuildContext context, int index){
                                    return ListTile(
                                      key: Key("key"),
                                      leading: Text("${index+1}",style: TextStyle(color: Colors.black)),
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
  ScrollController _controller= ScrollController();
  ScrollController _controller2= ScrollController();

  @override
  void initState() {
    //_controller = ScrollController();
    //_controller2 = ScrollController();
    //_controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.addListener(_scrollListener);
    });

    _controller2.addListener(_scrollListener2);
    super.initState();
  }

  @override
  void dispose(){
    _controller.removeListener(_onScrollEvent);
  }
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the bottom of list 1";
        print(message);
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top of list 1";
        print(message);
      });
    }
  }
  _scrollListener2() {
    if (_controller2.offset >= _controller2.position.maxScrollExtent &&
        !_controller2.position.outOfRange) {
      setState(() {
        message = "reach the bottom of list 2";
        print(message);
      });
    }
    if (_controller2.offset <= _controller2.position.minScrollExtent &&
        !_controller2.position.outOfRange) {
      setState(() {
        message = "reach the top of list 2";
        print(message);
      });
    }
  }

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    print("Extent after: $extentAfter");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(message),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              //color: Colors.green,
              child: Text(message),
            ),

            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    ListView.builder(
                    shrinkWrap: true,
                    //physics: ScrollPhysics(),
                    controller: _controller,
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text("Index : $index"));
                    },
                  ),
                    ListView.builder(
                      shrinkWrap: true,
                     // physics: ScrollPhysics(),
                      controller: _controller2,
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text("Index : $index"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

