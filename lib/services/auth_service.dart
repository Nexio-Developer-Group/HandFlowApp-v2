import 'dart:convert';
import 'package:http/http.dart' as http;

final String _baseUrl = "http://20.244.50.12:3011";

Future<Map<String, dynamic>> login(String email, String password) async {
  final url = Uri.parse("$_baseUrl/auth/login");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final accessToken = data['access_token'];
      final refreshToken = data['refresh_token'];
      final expiresIn = data['expires_in'];
      print("Login successful. Access Token: $accessToken");
      return {
        'statusCode': response.statusCode,
        'message': 'Login successful',
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'expires_in': expiresIn,
      };
    } else {
      print("Login failed: " + (data['detail'] ?? data['message'] ?? 'Error'));
      return {
        'statusCode': response.statusCode,
        'message': data['detail'] ?? data['message'] ?? 'Error',
      };
    }
  } catch (e) {
    print("Error: $e");
    return {'statusCode': 500, 'message': 'An error occurred'};
  }
}

Future<Map<String, dynamic>> signup(String email, String password) async {
  final url = Uri.parse("$_baseUrl/auth/signup");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Signup successful.");
      return {
        'statusCode': response.statusCode,
        'message': data['message'] ?? 'Signup successful',
      };
    } else {
      print("Signup failed: " + (data['detail'] ?? data['message'] ?? 'Error'));
      return {
        'statusCode': response.statusCode,
        'message': data['detail'] ?? data['message'] ?? 'Error',
      };
    }
  } catch (e) {
    print("Error: $e");
    return {'statusCode': 500, 'message': 'An error occurred'};
  }
}
