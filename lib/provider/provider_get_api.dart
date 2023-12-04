import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class ProviderGetApiScreen extends StatefulWidget {
  const ProviderGetApiScreen({Key? key}) : super(key: key);

  @override
  _ProviderGetApiScreenState createState() => _ProviderGetApiScreenState();
}

class _ProviderGetApiScreenState extends State<ProviderGetApiScreen> {
  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: postModel.loading?Center(
          child: Container(
            child: SpinKitThreeBounce(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            ),
          ),
        ):Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                child: Text(
                  postModel.post?.title ?? "",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                child: Text(postModel.post?.body ?? ""),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DataClass extends ChangeNotifier {
  DataModel? post;
  bool loading = false;

  getPostData() async {
    loading = true;
    post = (await getSinglePostData())!;
    loading = false;

    notifyListeners();
  }
}

Future<DataModel?> getSinglePostData() async {
  DataModel? result;
  try {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/2"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },);
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DataModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
  return result;
}

class DataModel {

  final String title;
  final String body;

  DataModel({required this.title, required this.body});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'] ?? "",
      body: json['body'] ?? "",
    );
  }
}