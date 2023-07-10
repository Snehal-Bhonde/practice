import 'package:practice/model/emp_list_model.dart';
import 'package:rxdart/subjects.dart';
import 'emp_sqf_repo.dart';

class EmpSqfBloc {
  final EmpSqfRepo _empRepo = EmpSqfRepo();

  BehaviorSubject<List<Data>> empBehavior = BehaviorSubject();

  Stream<List<Data>> get empStream => empBehavior.stream;

  fetchEmpList() async {
    EmployeeList empList=await _empRepo.fetchEmpList();
    if(empList.data!=null){
      //empBehavior.sink.add(empList.data!);

      empList.data!.forEach((element) async {
        Data empData = Data(
          employeeName: element.employeeName,
          employeeAge: element.employeeAge,
          employeeSalary: element.employeeSalary,
        );
       await DatabaseRepo.instance.insert(data: empData);
        print("saved ${element.id}");
      });

        getRecords();
    }
  }

  BehaviorSubject<List<Data>> getDataBehavior = BehaviorSubject();

  Stream<List<Data>> get recordStream => getDataBehavior.stream;

  getRecords() async {
    List<Data> empList=await DatabaseRepo.instance.getAllRecords();
    if(empList!=null){
      getDataBehavior.sink.add(empList);
    }
    else{
      getDataBehavior.sink.add([]);
    }
  }
}