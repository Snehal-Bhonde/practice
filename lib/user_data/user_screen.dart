import 'package:flutter/material.dart';
import 'package:practice/user_data/user_bloc.dart';
import 'package:practice/user_data/data/models/user_list.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    super.initState();
    _userBloc.fetchUserList();
   // _userBloc.fetchRefUserList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        StreamBuilder<List<UserList>>(
       // StreamBuilder<List<Geo>>(
            stream: _userBloc.userStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return Container(
                    height: double.maxFinite,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Container(
                                      margin: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("ID: ${snapshot.data![index].id}"),
                                          Text("Name: ${snapshot.data![index].name}"),
                                          Text("Email: ${snapshot.data![index].email}"),
                                          Text("Phone: ${snapshot.data![index].phone}"),
                                          Text("UserName: ${snapshot.data![index].username}"),
                                          Text("Website: ${snapshot.data![index].website}"),
                                          Text("Company Name: ${snapshot.data![index].company!.name}"),
                                          Text("Company BS: ${snapshot.data![index].company!.bs}"),
                                          Text("City: ${snapshot.data![index].address!.city}"),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                      // child:
                    ),
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
    );
  }
}

