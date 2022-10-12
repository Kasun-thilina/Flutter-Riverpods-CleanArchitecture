import 'dart:io';

class Connection {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final Connection _singleton = new Connection._internal();
  Connection._internal();

  //This is what's used to retrieve the instance through the app
  static Connection getInstance() => _singleton;

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch(_) {
      return false;
    }
  }
}
