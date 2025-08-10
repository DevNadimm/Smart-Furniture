import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/sales/data/models/sales_return_model.dart';

class SalesReturnRepository {
  static Future<SalesReturnModel?> fetchData(
    String? fromDate,
    String? toDate,
    String? customerId,
  ) async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final queryParams = {
      if (fromDate?.isNotEmpty ?? false) 'from': fromDate!,
      if (toDate?.isNotEmpty ?? false) 'to': toDate!,
      if (customerId?.isNotEmpty ?? false) 'customer_id': customerId!,
    };

    final uri = Uri.parse("$baseUrl/sale-return").replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        print(jsonMap);

        final model = SalesReturnModel.fromJson(jsonMap);

        if (model.success == true) {
          return model;
        } else {
          throw Exception('API returned success: false');
        }
      } else {
        throw Exception('Failed to fetch sales return records.');
      }
    } catch (e) {
      throw Exception('Failed to fetch sales return records: $e');
    }
  }
}
