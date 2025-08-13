import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/administration/data/models/product_list_model.dart';

class ProductListRepository {
  static Future<ProductListModel?> fetchData(String shop, String? search) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.productList;

    final queryParams = {
      if (search != null && search.isNotEmpty) 'search': search,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return ProductListModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchProductListFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchProductListFailed);
    }
  }
}
