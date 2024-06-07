import 'package:mobile/main.dart';

class PyxisService{
  String? accessToken;

  PyxisService() {
    _initializeToken();
  }

  Future<void> _initializeToken() async {
    try {
      accessToken = await returnToken();
    } catch (e) {
      print("Error initializing token: $e");
      // Handle error, e.g., by setting accessToken to a default value or rethrowing the exception
    }
  }

  Future<String> returnToken() async {
    var token = await HomeScreen.localStorageService.getValue('token');
    if (token == null) {
      throw Exception("Token is null");
    }
    return token;
  }

}