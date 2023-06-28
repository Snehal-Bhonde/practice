

import 'package:flutter/material.dart';

Stream<int> generateNumbers = (() async* {
  await Future<void>.delayed(Duration(seconds: 2));

  for (int i = 1; i <= 5; i++) {
    await Future<void>.delayed(Duration(seconds: 1));
    if(i%2==0){
      await Future<void>.delayed(Duration(seconds: 2));
    }
    yield i;
  }
})();

class StreamBuilderExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StreamBuilderExampleState ();
  }
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: StreamBuilder<int>(
            stream: generateNumbers,
            initialData: 0,
            builder: (
                BuildContext context,
                AsyncSnapshot<int> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data.toString(),
                        style: const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.active
                  || snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  // return ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: snapshot.data!.bitLength,
                  //     itemBuilder: (BuildContext context, int index){
                  //       return Text(
                  //           index.toString(),
                  //           style: const TextStyle(color: Colors.teal, fontSize: 36)
                  //       );
                  // });



                  return  Text(
                      snapshot.data.toString(),
                      style: const TextStyle(color: Colors.teal, fontSize: 36)
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}