import 'dart:convert';
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/administration/data/models/damage_list_model.dart';
import 'package:http/http.dart' as http;

class DamageListRepository {
  static Future<DamageListModel?> fetchData(String shop, String? productId) async {
    if (productId == null || productId.isEmpty) {
      throw Exception(ErrorMessages.selectProductBeforeFetch);
    }

    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.damageList;

    final queryParams = {
      if (productId.isNotEmpty) 'product_id': productId,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return DamageListModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchDamageListFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchDamageListFailed);
    }
  }
}
