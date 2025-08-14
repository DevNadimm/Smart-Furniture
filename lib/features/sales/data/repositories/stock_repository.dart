import 'dart:convert';
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/sales/data/models/stock_model.dart';
import 'package:http/http.dart' as http;

class StockRepository {
  static Future<StockModel?> fetchData(String shop, String? fromDate, String? toDate, String? search) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.stock;

    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty) 'from': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to': toDate,
      if (search != null && search.isNotEmpty) 'search': search,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return StockModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchStockFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchStockFailed);
    }
  }
}
