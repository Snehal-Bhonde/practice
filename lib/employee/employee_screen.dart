

import 'package:flutter/material.dart';
import 'package:practice/employee/employee_bloc.dart';
import 'package:practice/get_api/get_repo.dart';
import 'package:practice/home/home_bloc.dart';
import 'package:practice/model/emp_list_model.dart';

class EmpListScreen extends StatefulWidget {
  const EmpListScreen({Key? key}) : super(key: key);
  @override
  State<EmpListScreen> createState() => _EmpListScreenState();
}

class _EmpListScreenState extends State<EmpListScreen> {
  EmpBloc _empBloc = EmpBloc();

  @override
  void initState() {
    super.initState();
    _empBloc.fetchEmpList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<Data>>(
            stream: _empBloc.empStream,
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