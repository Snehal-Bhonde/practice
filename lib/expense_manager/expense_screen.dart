import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:practice/expense_manager/expense_bloc.dart';
import 'package:practice/model/expense_model.dart';

import 'expense_repo.dart';

class ExpenseManager extends StatefulWidget {
  const ExpenseManager({Key? key}) : super(key: key);

  @override
  _ExpenseManagerState createState() {
    return _ExpenseManagerState();
  }
}

class _ExpenseManagerState extends State<ExpenseManager> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateAlController = TextEditingController();
  final TextEditingController _amountAlController = TextEditingController();
  final TextEditingController _descAlController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  final alertFormKey = GlobalKey<FormState>();
  ExpenseBloc expenseBloc=ExpenseBloc();
  late BuildContext contexts;

  @override
  void initState() {
    initDb();
    expenseBloc.getRecords();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  deleteAlertDialog(BuildContext context, ExpenseForm expenseForm) {
    // set up the buttons
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        expenseBloc.delete(expenseForm.expenseId);
        Navigator.pop(contexts);
      },
    );
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(contexts);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      content: Text("Do you want to delete this record?"),
      actions: [
        yesButton,
        noButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text("AlertDialog"),
          content: Text("Do you want to delete this record?"),
          actions: [
            TextButton(
              child: Text("Yes"),
              onPressed:  () {
                expenseBloc.delete(expenseForm.expenseId);
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("No"),
              onPressed:  () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    contexts=context;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    contexts=context;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Expense Manager"),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formGlobalKey,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(height: 50),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime,

                controller: _dateController,
                inputFormatters: [],
                validator: (val) {
                  if (val!.length == 0) {
                    return 'Enter Date';
                  } else
                    return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 1))
                  );
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
                  _dateController.text=formattedDate;
                },
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  //validator: validateMobile,
                  validator: (val) {
                    // _mobile = val;
                    if (val!.length == 0) {
                      return 'Enter amount';
                    } else
                      return null;
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                  ]),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(40),
                ],
                controller: _descController,
                validator: (value) {
                  if (value!.isNotEmpty)
                    return null;
                  else
                    return 'Enter description';
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () {
                    if (formGlobalKey.currentState!.validate()) {
                      addRecord();
                      formGlobalKey.currentState!.save();

                      formGlobalKey.currentState!.reset();
                    }
                  },
                  child: const Text("Submit")),
               const SizedBox(
                 height:20
               ),
              StreamBuilder<List<ExpenseForm>>(
                  stream: expenseBloc.recordStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5.0),
                                child: Card(
                                  child: Container(
                                    margin: EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("ID: ${snapshot.data![index].expenseId}"),
                                            Text("Expense Date: ${snapshot.data![index].expenseDate}"),
                                            Text("Amount: ${snapshot.data![index].amount}",
                                              textAlign: TextAlign.start,
                                            ),
                                            Text("Description : ${snapshot.data![index].description}"),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Padding(
                                              padding: EdgeInsets.all(1.0),
                                              child: IconButton(icon:Icon(Icons.mode_edit_outlined,size:23,), onPressed: () {
                                                updateRecord(snapshot.data![index]);
                                              },),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(1.0),
                                              child: IconButton(icon:Icon(Icons.delete_outline_sharp,size:23,), onPressed: () {
                                                deleteAlertDialog(context,snapshot.data![index]);
                                              },),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(
                          child: Text('No data found'),
                        );
                      }
                    } else {
                      return  Container();
                    }
                  }),

            ],
          ),
        ),
      ),
    ));
  }

  void addRecord() async {

    ExpenseForm expenseForm = ExpenseForm(
      expenseDate: _dateController.text,
      description: _descController.text,
      amount: _amountController.text,
    );

    String res=await expenseBloc.saveRecord(expenseForm);
    expenseBloc.getRecords();
    print(res);
    if(res=="Record Saved"){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Record saved')));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving record')));
    }

  }

  Future<void> updateRecord(ExpenseForm expenseForm) async {
    _dateAlController.text=expenseForm.expenseDate!;
    _amountAlController.text=expenseForm.amount!;
    _descAlController.text=expenseForm.description!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content:Wrap(
              children: [
                Form(
                  key: alertFormKey,
          child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Date'),
                    keyboardType: TextInputType.datetime,

                    controller: _dateAlController,
                    inputFormatters: [],
                    validator: (val) {
                      if (val!.length == 0) {
                        return 'Enter Date';
                      } else
                        return null;
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 1)),
                          lastDate: DateTime.now().add(const Duration(days: 1))
                      );
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
                      _dateAlController.text=formattedDate;
                    },
                  ),
                  TextFormField(
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                      controller: _amountAlController,
                      //validator: validateMobile,
                      validator: (val) {
                        // _mobile = val;
                        if (val!.length == 0) {
                          return 'Enter amount';
                        } else
                          return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                      ]),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Description"),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    controller: _descAlController,
                    validator: (value) {
                      if (value!.isNotEmpty)
                        return null;
                      else
                        return 'Enter description';
                    },
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () async {
                        if (alertFormKey.currentState!.validate()) {

                          ExpenseForm expense = ExpenseForm(
                            expenseId: expenseForm!.expenseId,
                            expenseDate: _dateAlController.text,
                            description: _descAlController.text,
                            amount: _amountAlController.text,
                          );
                          await expenseBloc.updateRecord(expense);
                          alertFormKey.currentState!.save();
                          Navigator.pop(context);
                          alertFormKey.currentState!.reset();
                        }
                      },
                      child: const Text("Submit")),
                ],
          ),
                ),
              ],
            )
        );
      },
    );
    print("update started");

  }




  }

