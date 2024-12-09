import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/signup');
    try {
      print('Sending POST request to: $url');
      print('Request body: ${jsonEncode(userData)}');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return jsonDecode(response.body); // Success
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (error) {
      throw Exception('Signup failed: $error');
    }
  }
}
