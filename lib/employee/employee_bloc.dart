import 'package:practice/employee/employee_repo.dart';
import 'package:practice/model/emp_list_model.dart';
import 'package:rxdart/subjects.dart';

class EmpBloc {
  final EmpRepo _empRepo = EmpRepo();

  BehaviorSubject<EmployeeList> empBehavior = BehaviorSubject();

  Stream<EmployeeList> get empStream => empBehavior.stream;

  fetchEmpList() async {
    empBehavior.sink.add(await _empRepo.fetchEmpList());
  }
}