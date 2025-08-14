import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/purchase/data/models/purchase_record_model.dart';

class PurchaseRecordRepository {
  static Future<PurchaseRecordModel?> fetchData(String shop, String? fromDate, String? toDate) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.purchaseRecord;

    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty) 'from': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to': toDate,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return PurchaseRecordModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchPurchaseRecordFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchPurchaseRecordFailed);
    }
  }
}
