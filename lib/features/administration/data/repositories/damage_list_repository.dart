import 'dart:convert';
import 'package:smart_furniture/features/administration/data/models/damage_list_model.dart';
import 'package:http/http.dart' as http;

class DamageListRepository {
  static Future<DamageListModel?> fetchData(String? productId) async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final queryParams = {
      if (productId != null && productId.isNotEmpty) 'product_id': productId,
    };

    final uri = Uri.parse("$baseUrl/administration/damage-list").replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return DamageListModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch damage products');
      }
    } catch (e) {
      throw Exception('Failed to fetch damage products: $e');
    }
  }
}
