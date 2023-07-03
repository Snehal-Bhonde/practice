import 'package:practice/employee/employee_repo.dart';
import 'package:practice/model/emp_list_model.dart';
import 'package:rxdart/subjects.dart';

class EmpBloc {
  final EmpRepo _empRepo = EmpRepo();

  BehaviorSubject<List<Data>> empBehavior = BehaviorSubject();

  Stream<List<Data>> get empStream => empBehavior.stream;

  fetchEmpList() async {
    EmployeeList empList=await _empRepo.fetchEmpList();
    if(empList.data!=null){
      empBehavior.sink.add(empList.data!);
    }
    else{
      empBehavior.sink.add([]);
    }
  }
}