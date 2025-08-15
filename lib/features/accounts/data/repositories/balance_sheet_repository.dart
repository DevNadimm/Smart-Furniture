import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/accounts/data/models/balance_sheet_model.dart';

class BalanceSheetRepository {
  static Future<BalanceSheetModel?> fetchData(String shop, String fromDate, String toDate) async {
    if (fromDate.isEmpty || toDate.isEmpty) {
      throw Exception(ErrorMessages.selectDateFiltersBeforeFetch);
    }

    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.balanceSheet;

    final queryParams = {
      if (fromDate.isNotEmpty) 'from': fromDate,
      if (toDate.isNotEmpty) 'to': toDate,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return BalanceSheetModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchBalanceSheetFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchBalanceSheetFailed);
    }
  }
}
