

import 'package:rxdart/subjects.dart';

import 'get_repo.dart';

class GetBloc {
  final GetRepo _getRepo = GetRepo();

  BehaviorSubject<String> getBehavior = BehaviorSubject();

  Stream<String> get getStream => getBehavior.stream;

   /*setIP() async* {
    Stream<String> repoString = await _getRepo.getIPAdds();
    print("repo $repoString");
    getBehavior.sink.add('$repoString');
  }*/

  final _repository = Repository();

  setIPs() async {
    String ip = await _repository.getIPAdds();
    getBehavior.sink.add(ip);
  }
}