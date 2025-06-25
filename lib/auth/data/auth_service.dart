import 'package:shared_preferences/shared_preferences.dart';
import 'session_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String _baseUrl = "http://20.244.50.12:3011";

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
      // print("Signup successful.");
      // Always log in with rememberMe: true after signup
      await login(email, password, false);
      return {
        'statusCode': response.statusCode,
        'message': data['message'] ?? 'Signup successful',
      };
    } else {
      // print("Signup failed: " + (data['detail'] ?? data['message'] ?? 'Error'));
      return {
        'statusCode': response.statusCode,
        'message': data['detail'] ?? data['message'] ?? 'Error',
      };
    }
  } catch (e) {
    // print("Error: $e");
    return {'statusCode': 500, 'message': 'An error occurred'};
  }
}

Future<Map<String, dynamic>> login(
  String email,
  String password,
  bool rememberMe,
) async {
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
      if (rememberMe) {
        // Store email and tokens in local storage
        saveRememberedUser(email);
      }
      // Store in memory only
      final session = Session();
      session.email = email;
      session.accessToken = accessToken;
      session.refreshToken = refreshToken;
      session.expiresIn = expiresIn;

      return {
        'statusCode': response.statusCode,
        'message': 'Login successful',
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'expires_in': expiresIn,
      };
    } else {
      return {
        'statusCode': response.statusCode,
        'message': data['detail'] ?? data['message'] ?? 'Error',
      };
    }
  } catch (e) {
    return {'statusCode': 500, 'message': 'An error occurred'};
  }
}

Future<void> sendPasswordReset(String email) async {
  await Future.delayed(Duration(seconds: 1));
}

Future<void> saveRememberedUser(String email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  // await prefs.setString('access_token', accessToken);
  // await prefs.setString('refresh_token', refreshToken);
  // await prefs.setInt('expires_in', expiresIn);
}

Future<String?> getRememberedUser() async {
  if (Session().isNotEmpty) {
    return Session().email;
  }

  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("email");
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('email');
  // await prefs.remove('access_token');
  // await prefs.remove('refresh_token');
  // await prefs.remove('expires_in');
  // Clear in-memory session as well
  Session().clear();
}

