import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';

class CreateSalesRepository {
  static Future<bool> createSales(Map<String, dynamic> body) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.createSales;

    final uri = Uri.parse(endpoint);
    print('URL: $uri');

    try {
      final token = await AppPreferences.getUserId();
      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      throw Exception(ErrorMessages.createSalesFailed);
    } catch (e) {
      throw Exception(ErrorMessages.createSalesFailed);
    }
  }
}
