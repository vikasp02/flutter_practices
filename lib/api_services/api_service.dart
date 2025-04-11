import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService {
  // final String baseUrl = "http://192.168.1.103:5000/api";
  final String baseUrl = "http://192.168.1.103:5000/api";

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      final loginResData = jsonDecode(response.body);
      log('message:${loginResData}');
      return loginResData;
    } else {
      return null;
    }
  }
}
