

import 'dart:convert';
import 'dart:io';

class GetRepo {

  Future<String> getIPAddress() async {
    final url = Uri.parse('https://httpbin.org/ip');
    final httpClient = HttpClient();
    final request = await httpClient.getUrl(url);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    final String ip = jsonDecode(responseBody)['origin'];
    print(ip);
    return ip;
  }

}

class Repository {
  final getRepo = GetRepo();

  Future<String> getIPAdds() => getRepo.getIPAddress();
}