import 'package:intl/intl.dart';
import 'package:practice/model/expense_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';
import 'expense_repo.dart';

class ExpenseBloc {

  BehaviorSubject<String> expenseBehavior = BehaviorSubject();

  Stream<String> get expenseStream => expenseBehavior.stream;

  Future<String> saveRecord(ExpenseForm expenseForm) async {
    String result="";
    await DatabaseRepository.instance.insert(expenseForm: expenseForm).then((value){
      result="Record Saved";
      print("saved");
      getRecords();
    }).catchError((e) {
      result=e.toString();
    });
     return result;
     // expenseBehavior.sink.add(result);

  }

  Future<String> updateRecord(ExpenseForm expenseForm) async {
    String result="";
    await DatabaseRepository.instance.update(expenseForm).then((value){
      result="Record updated";
      print("edited");
      getRecords();
    }).catchError((e) {
      result=e.toString();
    });
    return result;
    // expenseBehavior.sink.add(result);

  }

  Future delete(expenseId) async {
   await DatabaseRepository.instance.delete(expenseId!).then((value) {
        print("record deleted");
        getRecords();
    }).catchError((e) {
      print("error");
    });
  }


  BehaviorSubject<List<ExpenseForm>> getDataBehavior = BehaviorSubject();

  Stream<List<ExpenseForm>> get recordStream => getDataBehavior.stream;

   getRecords() async {
    List<ExpenseForm> expenseList=await DatabaseRepository.instance.getAllRecords();
    if(expenseList!=null){
      expenseList.forEach((element) {
        //element.expenseDate.compareTo(other)
      });

      // sort by expenseDate: descending
      final sortedExpenseDesc = expenseList.map((user) => user).toList()
        ..sort((a, b) => b.expenseDate!.compareTo(a.expenseDate!));

      sortedExpenseDesc.forEach((user) => print(user.expenseDate.toString()));

      getDataBehavior.sink.add(sortedExpenseDesc);
    }
    else{
      getDataBehavior.sink.add([]);
    }
  }
}