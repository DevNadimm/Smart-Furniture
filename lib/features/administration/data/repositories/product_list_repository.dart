import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/administration/data/models/product_list_model.dart';

class ProductListRepository {
  static Future<ProductListModel?> fetchData(String? search) async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final queryParams = {
      if (search != null && search.isNotEmpty) 'search': search,
    };

    final uri = Uri.parse("$baseUrl/administration/product-list").replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return ProductListModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
