import 'dart:convert';
import 'package:smart_furniture/features/administration/data/models/product_ledger_model.dart';
import 'package:http/http.dart' as http;

class ProductLedgerRepository {
  static Future<ProductLedgerModel?> fetchData({
    String? productId,
    String? fromDate,
    String? toDate,
  }) async {
    if ((productId == null || productId.isEmpty) || (fromDate == null || fromDate.isEmpty) || (toDate == null || toDate.isEmpty)) {
      throw Exception('Please select all filters before fetching data.');
    }

    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final queryParams = {
      if (productId.isNotEmpty) 'product_id': productId,
      if (fromDate.isNotEmpty) 'from': fromDate,
      if (toDate.isNotEmpty) 'to': toDate,
    };

    final uri = Uri.parse("$baseUrl/administration/product-ledger").replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return ProductLedgerModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch product ledger data');
      }
    } catch (e) {
      throw Exception('Failed to fetch product ledger data: $e');
    }
  }
}
