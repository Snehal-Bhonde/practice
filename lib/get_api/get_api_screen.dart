

import 'package:flutter/material.dart';
import 'package:practice/get_api/get_repo.dart';
import 'package:practice/home/home_bloc.dart';

import 'get_bloc.dart';

class GetScreen extends StatefulWidget {
  const GetScreen({Key? key}) : super(key: key);
  @override
  State<GetScreen> createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
   GetBloc _getBloc = GetBloc();

  @override
  void initState() {
    super.initState();
    _getBloc.setIPs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<String>(
                  stream: _getBloc.getStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return Center(
                          child: Text(snapshot.data!),
                        );
                      } else {
                        return const Center(
                          child: Text('No data found'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FutureBuilder(
            //       future: _getBloc.setIP("title"),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasError) {
            //           return Center(
            //             child: Text(snapshot.error.toString()),
            //           );
            //         } else if (snapshot.hasData) {
            //           if (snapshot.data != null) {
            //             return Center(
            //               child: Text(snapshot.data!),
            //             );
            //           } else {
            //             return const Center(
            //               child: Text('No data found'),
            //             );
            //           }
            //         } else {
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}