import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/order.dart';
import 'package:mobile/main.dart';

class OrderService {
  final String baseUrl = dotenv.env['PUCLIC_URL']!;
  String? accessToken;

  OrderService() {
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

  Future<List<Order>> getOrders() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        // Log da resposta
        return jsonResponse.map((order) => Order.fromJson(order)).toList();
      } else {
        throw Exception('Failed to load medicine orders');
      }
    } catch (e) {
      throw Exception('Failed to load medicine orders');
    }
  }
}
