
class ExpenseForm {
  int? expenseId;
  String? expenseDate;
  String? description;
  String? amount;

  ExpenseForm({this.expenseId, this.expenseDate,this.description,this.amount});
  factory ExpenseForm.fromJson(Map<String, dynamic> data) => ExpenseForm(
    expenseId: data['expenseId'],
    expenseDate: data['expenseDate'],
    description: data['description'],
    amount: data['amount'].toString()
  );
  Map<String, dynamic> toMap() => {
    "expenseId": this.expenseId,
    "expenseDate": this.expenseDate,
    "description": this.description,
    "amount": this.amount,
  };
}