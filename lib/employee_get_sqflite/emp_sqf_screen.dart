

import 'package:flutter/material.dart';
import 'package:practice/model/emp_list_model.dart';

import 'emp_sqf_bloc.dart';
import 'emp_sqf_repo.dart';

class EmpSqfScreen extends StatefulWidget {
  const EmpSqfScreen({Key? key}) : super(key: key);
  @override
  State<EmpSqfScreen> createState() => _EmpSqfScreenState();
}

class _EmpSqfScreenState extends State<EmpSqfScreen> {
  EmpSqfBloc _empBloc = EmpSqfBloc();

  @override
  void initState() {
    super.initState();
    initDb();
    //_empBloc.fetchEmpList();
    _empBloc.getRecords();
  }

  void initDb() async {
    await DatabaseRepo.instance.database;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<Data>>(
            stream: _empBloc.recordStream,
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
                                  margin: EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Container(
                                      margin: EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("ID: ${snapshot.data![index].id}"),
                                          Text("Employee Name: ${snapshot.data![index].employeeName}"),
                                          Text("Employee salary: ${snapshot.data![index].employeeSalary}",
                                            textAlign: TextAlign.start,
                                          ),
                                          Text("Age : ${snapshot.data![index].employeeAge}"),
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