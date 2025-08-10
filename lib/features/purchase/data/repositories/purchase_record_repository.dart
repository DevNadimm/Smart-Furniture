import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/purchase/data/models/purchase_record_model.dart';

class PurchaseRecordRepository {
  static Future<PurchaseRecordModel?> fetchData(String? fromDate, String? toDate) async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty) 'from': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to': toDate,
    };

    final uri = Uri.parse("$baseUrl/purchase-records").replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return PurchaseRecordModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch purchase record');
      }
    } catch (e) {
      throw Exception('Failed to fetch purchase record: $e');
    }
  }
}
