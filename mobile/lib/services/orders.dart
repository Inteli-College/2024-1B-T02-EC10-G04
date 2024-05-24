import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/order.dart';

class OrderService {
  final String baseUrl = "http://10.254.19.182/api/v1";
  final String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJJbnRlbGlNb2R1bG8xMCIsInN1YiI6IjQ3Yzk1NmM2LTIxMGEtNGU2My04ZDEyLWMwMTJlZGMxZjFhMCIsImV4cCI6MTcxNjc3NjA1OX0.EWSuAKHOH0SYBAvMmgSaz2I2gkVApo8ICHh_SuFzjhg";

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
        print(jsonResponse); // Log da resposta
        return jsonResponse.map((order) => Order.fromJson(order)).toList();
      } else {
        print('Failed to load orders. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load medicine orders');
      }

    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load medicine orders');
    }
  }


}
