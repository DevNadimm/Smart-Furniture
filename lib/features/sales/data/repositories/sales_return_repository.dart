import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/error_messages.dart';
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

        return SalesReturnModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchSalesReturnFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchSalesReturnFailed);
    }
  }
}
