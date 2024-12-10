import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  final String baseUrl;

  ProfileService({required this.baseUrl});

  Future<Map<String, dynamic>> fetchUserDetails(String token) async {
    final url = Uri.parse('$baseUrl/api/auth/me');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Pass the JWT token
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the user data
    } else {
      throw Exception('Failed to fetch user details: ${response.body}');
    }
  }
}
