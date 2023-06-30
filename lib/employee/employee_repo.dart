

import 'package:dio/dio.dart';
import 'package:practice/model/emp_list_model.dart';

class EmpRepo{
  final Dio _dio=Dio();

  final String url="https://dummy.restapiexample.com/api/v1/employees";

  Future<EmployeeList> fetchEmpList() async{
    Response? response;
    response= await _dio.get(url);
    return EmployeeList.fromJson(response.data);
  }

}