import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/pyxis.dart';


class PyxisService{
  final String baseUrl = dotenv.env['PUCLIC_URL']!;


  Future<Pyxis> getPyxisById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pyxis/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Pyxis.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load Pyxis');
      }
    } catch (e) {
      throw Exception(e);
    }
  }


}