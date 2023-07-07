import 'package:path/path.dart';
import 'package:practice/model/expense_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  Database?_database;
  static final DatabaseRepository instance = DatabaseRepository
      ._init(); // our class will always have one instane only to make sure the database is only one
  DatabaseRepository._init();


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("expense_db.db");
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
  ${AppConst.expenseId} integer primary key autoincrement, 
  ${AppConst.expenseDate} text not null,
   ${AppConst.description} text not null,
   ${AppConst.amount} text not null)
''');
  }

  Future<void> insert({required ExpenseForm expenseForm}) async {
    try {
      final db = await database;
      db.insert(AppConst.tableName, expenseForm.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<ExpenseForm>> getAllRecords() async {
    final db = await instance.database;

    final result = await db.query(AppConst.tableName);

    return result.map((json) => ExpenseForm.fromJson(json)).toList();
  }

  Future<void> delete(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        AppConst.tableName,
        where: '${AppConst.expenseId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteAll() async {
    try {
      final db = await instance.database;
      await db.execute(
          "delete from "+ AppConst.tableName
      );
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> update(ExpenseForm expenseForm) async {
    try {
      final db = await instance.database;
      db.update(
        AppConst.tableName,
        expenseForm.toMap(),
        where: '${AppConst.expenseId} = ?',
        whereArgs: [expenseForm.expenseId],
      );
    } catch (e) {
      print("update failed");
      print(e.toString());
    }
  }


}
class AppConst {
  static const String expenseId = 'expenseId';
  static const String expenseDate = 'expenseDate';
  static const String description = 'description';
  static const String amount = 'amount';
  static const String tableName = 'ExpenseFormTable';
}