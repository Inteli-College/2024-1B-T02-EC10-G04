// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/logic/local_storage.dart';

class UserService {
  final String baseUrl = "http://10.254.19.182/api/v1";
  final LocalStorageService localStorageService = LocalStorageService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      saveUserInfos(body);
      return body;
    }
    return {};
  }

  Future<Map<String, dynamic>> signup(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'name': name,
        'password': password,
        'role': 'user'
      }),
    );

    if (response.statusCode == 201) {
      var body = jsonDecode(response.body);
      saveUserInfos(body);
      return body;
    }
    return {};
  }

  void saveUserInfos(user) {
    localStorageService.saveValue('email', user['email']);
    localStorageService.saveValue('name', user['name']);
    localStorageService.saveValue('access_token', user['access_token']);
    localStorageService.saveValue('on_duty', user['on_duty']);
    localStorageService.saveValue('id', user['id']);
    localStorageService.saveValue('role', user['role']);
  }
}
