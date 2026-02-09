import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/auth/data/models/login_model.dart';

class LoginRepository {
  final String endpoint;

  LoginRepository({required this.endpoint});

  /// Employee login
  static Future<LoginModel> loginEmployee({
    required String email,
    required String password,
  }) async {
    final api = ApiEndpoints(shop: '');
    final url = Uri.parse(api.login);

    // 1️⃣ Log request info
    print('====================');
    print('LOGIN REQUEST');
    print('URL: $url');
    print('Email: $email');
    print('Password: $password'); // Only for debug; remove in production
    print('====================');

    final data = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      // 2️⃣ Log raw response
      print('====================');
      print('LOGIN RESPONSE');
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');
      print('====================');

      // 3️⃣ Decode JSON safely
      Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        print('❌ Failed to decode JSON: $e');
        throw Exception('Invalid response format from server');
      }

      // 4️⃣ Handle success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = LoginModel.fromJson(jsonResponse);

        // Save preferences
        await AppPreferences.setUserId(model.accessToken ?? '');
        await AppPreferences.setLoggedIn(true);

        print('✅ Login successful. AccessToken saved.');
        return model;
      } else {
        // Handle server error
        final message = jsonResponse['message'] ?? 'Login failed';
        print('❌ Login failed: $message');
        throw Exception(message);
      }
    } catch (e) {
      print('❌ Exception during login: $e');
      rethrow; // Propagate to BLoC or caller
    }
  }
}
