import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/admin/data/models/product_list_model.dart';

class ProductListRepository {

  /// Fetch products by category_id
  static Future<List<ProductData>> fetchProducts({
    required int? categoryId,
  }) async {

    final api = ApiEndpoints(shop: '');
    final baseUrl = api.products;

    final uri = Uri.parse(baseUrl).replace(
      queryParameters: categoryId != null
          ? {'category_id': categoryId.toString()}
          : null,
    );

    print('📡 [FETCH PRODUCTS] URL => $uri');

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

        print('✅ Products fetched successfully');

        return data
            .map((e) => ProductData.fromJson(e))
            .toList();
      } else {
        print('❌ Fetch products failed');
        throw Exception(ErrorMessages.fetchProductFailed);
      }

    } catch (e) {
      print('🔥 Fetch Products Error => $e');
      throw Exception(ErrorMessages.fetchProductFailed);
    }
  }
}