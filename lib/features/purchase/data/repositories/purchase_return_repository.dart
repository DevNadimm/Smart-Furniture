import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/purchase/data/models/purchase_return_model.dart';

class PurchaseReturnRepository {
  static Future<PurchaseReturnModel?> fetchData(String? fromDate, String? toDate, String? supplierId) async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty) 'from': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to': toDate,
      if (supplierId != null && supplierId.isNotEmpty) 'supplier_id': supplierId,
    };

    final uri = Uri.parse("$baseUrl/purchase-return").replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return PurchaseReturnModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch purchase return');
      }
    } catch (e) {
      throw Exception('Failed to fetch purchase return: $e');
    }
  }
}
