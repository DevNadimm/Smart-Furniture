import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/company/data/models/finished_product_model.dart';

class FinishedProductRepository {
  /// Fetch all finished products
  static Future<List<FinishedProductData>> fetchFinishedProducts() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.finishedProducts;

    final uri = Uri.parse(endpoint);
    print('URL => $uri');

    try {
      final token = await AppPreferences.getUserId();
      print('🔐 Token Loaded');

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('📥 Status Code => ${response.statusCode}');
      print('📥 Response Body => ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;
        final List<dynamic> data = jsonMap['data'] ?? [];

        print('✅ Finished products fetched successfully');
        return data.map((e) => FinishedProductData.fromJson(e)).toList();
      } else {
        print('❌ Fetch finished products failed');
        throw Exception(ErrorMessages.fetchFinishedProductFailed);
      }
    } catch (e) {
      print('🔥 Fetch Finished Products Error => $e');
      throw Exception(ErrorMessages.fetchFinishedProductFailed);
    }
  }
}
