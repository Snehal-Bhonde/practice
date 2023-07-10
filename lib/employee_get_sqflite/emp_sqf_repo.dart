import 'package:dio/dio.dart';
import 'package:practice/model/emp_list_model.dart';

import 'package:path/path.dart';
import 'package:practice/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class EmpSqfRepo{
  final Dio _dio=Dio();

  final String url="https://dummy.restapiexample.com/api/v1/employees";

  Future<EmployeeList> fetchEmpList() async{
    Response? response;
    response= await _dio.get(url);
    return EmployeeList.fromJson(response.data);
  }

}


class DatabaseRepo {
  Database?_database;
  static final DatabaseRepo instance = DatabaseRepo
      ._init(); // our class will always have one instane only to make sure the database is only one
  DatabaseRepo._init();


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("employee_db.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
create table ${AppConst.tableName} ( 
  ${AppConst.empId} integer primary key autoincrement, 
  ${AppConst.empName} text not null,
   ${AppConst.empAge} integer not null,
   ${AppConst.empSalary} integer not null)
''');
  }

  Future<void> insert({required Data data}) async {
    try {
      final db = await database;
      db.insert(AppConst.tableName, data.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Data>> getAllRecords() async {
    final db = await instance.database;

    final result = await db.query(AppConst.tableName);

    return result.map((json) => Data.fromJson(json)).toList();
  }


}
class AppConst {
  static const String empId = 'id';
  static const String empName = 'employee_name';
  static const String empSalary = 'employee_salary';
  static const String empAge = 'employee_age';
  static const String tableName = 'employee_Table';

}