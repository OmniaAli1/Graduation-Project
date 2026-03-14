import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:3000";
  // Android Emulator → 10.0.2.2
  // لو موبايل حقيقي → حطي IP جهازك

  static Future<dynamic> login(String email, String password) async {
    print("Sending request to backend...");

    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    return jsonDecode(response.body);
  }
}
