import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/raw_material_category_model.dart';

class RawMaterialCategoryRepository {
  /// Fetch all raw material categories
  static Future<List<RawMaterialCategoryData>>
  fetchRawMaterialCategories() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.rawMaterialCategories; // Make sure this exists

    final uri = Uri.parse(endpoint);
    print('📡 [FETCH RAW MATERIAL CATEGORIES] URL => $uri');

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

        print('✅ Raw material categories fetched successfully');

        return data
            .map((e) => RawMaterialCategoryData.fromJson(e))
            .toList();
      } else {
        print('❌ Fetch raw material categories failed');
        throw Exception(ErrorMessages.fetchRawMaterialCategoryFailed);
      }
    } catch (e) {
      print('🔥 Fetch Raw Material Categories Error => $e');
      throw Exception(ErrorMessages.fetchRawMaterialCategoryFailed);
    }
  }
}