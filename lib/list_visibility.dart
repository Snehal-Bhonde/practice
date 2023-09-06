

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ListVisibility extends StatefulWidget {
  @override
  _ListVisibilityState createState() => _ListVisibilityState();
}

class _ListVisibilityState extends State<ListVisibility> {

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
