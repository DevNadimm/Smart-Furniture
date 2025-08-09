import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/sales/data/models/sales_record_model.dart';

class SalesRecordRepository {
  static Future<List<SalesRecordModel>?> fetchData(String? fromDate, String? toDate) async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty) 'from': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'to': toDate,
    };

    final uri = Uri.parse("$baseUrl/sale-records").replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        if (jsonMap["data"] != null && jsonMap["data"] is List) {
          final List<dynamic> dataList = jsonMap["data"];
          return dataList.map((item) => SalesRecordModel.fromJson(item)).toList();
        }
      } else {
        throw Exception('Failed to fetch sales records.');
      }
    } catch (e) {
      throw Exception('Failed to fetch sales records: $e');
    }

    return null;
  }
}
