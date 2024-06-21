import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/logic/local_storage.dart';
import 'package:mobile/models/order.dart';

class OrderService {
  final String baseUrl = dotenv.env['PUCLIC_URL']!;
  String? accessToken;
  String? id;
  String? role;
  List<Order> orders = [];
  List<Order> userOrders = [];

  OrderService() {
    _initializeLocalStorage();
  }

  Future<void> _initializeLocalStorage() async {
    try {
      accessToken = await LocalStorageService().getValue('access_token');
      id = await LocalStorageService().getValue('id');
      role = await LocalStorageService().getValue('role');

      if (accessToken == null) {
        throw Exception("Token is null");
      }
    } catch (e) {
      print("Error initializing token: $e");
      // Handle error, e.g., by setting accessToken to a default value or rethrowing the exception
    }
  }

  Future<List<Order>> getOrders() async {
    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {

      if (role == "user"){
        response = await http.get(
          Uri.parse('$baseUrl/orders'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );
      }

      if (role == "collector"){
        response = await http.get(
          Uri.parse('$baseUrl/orders/collector'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );
      }

      if (role == "admin" || role == "manager"){
        response = await http.get(
          Uri.parse('$baseUrl/orders'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = json.decode(response.body);
        orders = jsonResponse.map((order) => Order.fromJson(order)).toList();
        return orders;

      } else {
        throw Exception(
            'Failed to load orders, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load medicine orders: $e');
    }
  }

  Future<Map<String, dynamic>> createOrder(
      List<String> medicineIds, String observation) async {
    await _initializeLocalStorage(); // Ensure local storage is initialized
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{
          "medicine_ids": medicineIds,
          "user_id": id,
          "observation":
              observation == "" ? "Order without comments" : observation,
          "on_duty": true,
          "quantity": 1,
          "priority": "green",
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body;
      } else {
        throw Exception(
            'Failed to create order, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}
