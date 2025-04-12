import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  // final String baseUrl = "http://192.168.1.103:5000/api";
  final String baseUrl = "https://dummyjson.com";

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      final loginData = jsonDecode(response.body);
      log('message:${loginData}');
      return loginData;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> getAllProducts() async {
    final url = Uri.parse('$baseUrl/products');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final getAllProductData = jsonDecode(response.body);
      log('getAllProductData$getAllProductData');
      return getAllProductData['products'];
    } else {
      throw Exception('Failed to fetch Products');
    }
  }
}
