import 'dart:convert';
import 'package:http/http.dart' as http;

final String _baseUrl = "http://20.244.50.12:3011";

Future<String> login(String username, String password) async {
  final url = Uri.parse("$_baseUrl/login");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      print("Login successful. Token: $token");
      return "Login successful";
    } else {
      final error = jsonDecode(response.body);
      print("Login failed: ${error['detail']}");
      return error['detail'];
    }
  } catch (e) {
    print("Error: $e");
    return "An error occurred";
  }
}

Future<String> signup(
  String fullname,
  String username,
  String email,
  String password,
) async {
  final url = Uri.parse("$_baseUrl/signup");

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'fullname': fullname,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      print("Signup successful.");
      return "Signup successful";
    } else {
      final error = jsonDecode(response.body);
      print("Login failed: ${error['detail']}");
      return error['detail'];
    }
  } catch (e) {
    print("Error: $e");
    return "An error occurred";
  }
}
