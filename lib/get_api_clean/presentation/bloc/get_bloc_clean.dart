import 'package:rxdart/subjects.dart';

//import 'get_repo.dart';

class GetBlocs {
  //final GetRepo _getRepo = GetRepo();

  BehaviorSubject<String> getBehavior = BehaviorSubject();

  Stream<String> get getStream => getBehavior.stream;

  setIPs() async {
    //String ip= await _getRepo.getIPAddress();
  //  getBehavior.sink.add(await _getRepo.getIPAddress());
  }
}