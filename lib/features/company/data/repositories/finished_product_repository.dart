import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/company/data/models/finished_product_model.dart';

class FinishedProductRepository {
  /// Fetch all finished products
  static Future<FinishedProductModel> fetchFinishedProducts({int? categoryId, String? search}) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.finishedProducts;

    final queryParams = {
      if (categoryId != null) 'category_id': categoryId.toString(),
      if (search != null) 'search': search,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
        print('✅ Finished products fetched successfully');
        return FinishedProductModel.fromJson(jsonMap); // ✅
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
