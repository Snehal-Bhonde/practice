

import 'package:flutter/material.dart';

import '../Future&Streams/PostApi.dart';
import '../model/album_model.dart';
import 'home_bloc.dart';

class PostApi extends StatefulWidget {
  const PostApi({Key? key}) : super(key: key);

  @override
  _PostApiState createState() {
    return _PostApiState();
  }
}

class _PostApiState extends State<PostApi> {
  final TextEditingController _controller = TextEditingController();
  //Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creating Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Post API'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          // ignore: unnecessary_null_comparison
          child:

          //(homeBloc.postStream == null) ?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration:
                const InputDecoration(hintText: 'Enter Title'),
              ),
              ElevatedButton(
                child: const Text('Create Data'),
                onPressed: () {
                   // homeBloc.setFutureText(_controller.text);
                    homeBloc.setAlbum(_controller.text);
                },
              ),
            StreamBuilder(
                stream: homeBloc.postStream,
                builder: (context, snapshot) {
                  print("snapshot");
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ],
          )
          //     : StreamBuilder(
          //   stream: homeBloc.postStream,
          //   builder: (context, snapshot) {
          //     print("snapshot");
          //     if (snapshot.hasData) {
          //       return Text(snapshot.data!);
          //     } else if (snapshot.hasError) {
          //       return Text("${snapshot.error}");
          //     }
          //
          //     return const CircularProgressIndicator();
          //   },
          // ),
        ),
      ),
    );
  }
}