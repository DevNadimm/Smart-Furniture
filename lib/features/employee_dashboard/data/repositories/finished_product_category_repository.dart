import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/finished_product_category_model.dart';

class FinishedProductCategoryRepository {
  /// Fetch all finished product categories
  static Future<List<FinishedProductCategoryData>>
      fetchFinishedProductCategories() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.finishedProductCategories;

    final uri = Uri.parse(endpoint);
    print('📡 [FETCH FINISHED PRODUCT CATEGORIES] URL => $uri');

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

        print('✅ Finished product categories fetched successfully');

        return data
            .map((e) => FinishedProductCategoryData.fromJson(e))
            .toList();
      } else {
        print('❌ Fetch finished product categories failed');
        throw Exception(ErrorMessages.fetchFinishedProductCategoryFailed);
      }
    } catch (e) {
      print('🔥 Fetch Finished Product Categories Error => $e');
      throw Exception(ErrorMessages.fetchFinishedProductCategoryFailed);
    }
  }
}
