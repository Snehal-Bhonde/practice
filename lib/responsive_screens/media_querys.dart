
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';

class MediaQuerys extends StatefulWidget {
  const MediaQuerys({super.key});

  @override
  State<MediaQuerys> createState() => _MediaQuerysState();
}

class _MediaQuerysState extends State<MediaQuerys> {

 /* @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: mediaQuery.padding.top,
      ),
      child: Container(
        height: mediaQuery.size.height,
        color: Colors.blue,
      ),
    );
  }*/

  /*@override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 500;
    return Container(
      width: 30.h,      //It will take a 30% of screen height
      height: 30.h,     //It will take a 30% of screen height
    );
  }*/

  /*@override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sizer',
          theme: ThemeData.dark(),
          home:
          SizerUtil.deviceType == DeviceType.mobile
                ? Container(   // Widget for Portrait
              width: 100.w,
              height: 20.5.h,color: Colors.green,
            )
                : Container(   // Widget for Landscape
              width: 100.w,
              height: 12.5.h,color: Colors.green,
            )
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(
        vertical:MediaQuery.of(context).size.height > 820
            ? MediaQuery.of(context).size.height * 0.03
            : MediaQuery.of(context).size.height * 0.025,
      ),
      child: Text(
        "Strings.earlyAccess",
        textScaleFactor: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 24,
        ),
      ),
    );
  }

}


class CounterBloc {

  int initialCount = 0; //if the data is not passed by paramether it initializes with 0
  BehaviorSubject<int> _subjectCounter= BehaviorSubject();

  CounterBloc({required this.initialCount}){
    _subjectCounter = new BehaviorSubject<int>.seeded(this.initialCount); //initializes the subject with element already
  }

  Stream<int> get counterObservable => _subjectCounter.stream;

  void increment(){
    initialCount++;
    _subjectCounter.sink.add(initialCount);
  }

  void decrement(){
    initialCount--;
    _subjectCounter.sink.add(initialCount);
  }

  void dispose(){
    _subjectCounter.close();
  }

}

class CounterPage extends StatefulWidget {

  @override
  _CounterPageState createState() => new _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  CounterBloc _counterBloc = new CounterBloc(initialCount: 0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text('You have pushed the button this many times:'),
              new StreamBuilder(stream: _counterBloc.counterObservable, builder: (context, AsyncSnapshot<int> snapshot){
                return new Text('${snapshot.data}', style: Theme.of(context).textTheme.displayMedium);
              })
            ],
          ),
        ),
        floatingActionButton: new Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          new Padding(padding: EdgeInsets.only(bottom: 10), child:
          new FloatingActionButton(
            onPressed: _counterBloc.increment,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          )
          ),
          new FloatingActionButton(
            onPressed: _counterBloc.decrement,
            tooltip: 'Decrement',
            child: new Icon(Icons.remove),
          ),
        ])
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

}