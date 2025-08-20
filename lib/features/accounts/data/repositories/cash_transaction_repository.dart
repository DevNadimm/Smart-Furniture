import 'dart:convert';
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/accounts/data/models/cash_transaction_model.dart';
import 'package:http/http.dart' as http;

class CashTransactionRepository {
  static Future<CashTransactionModel?> fetchData(String shop, String? type, String? fromDate, String? toDate) async {
    if (type == null || type.isEmpty || fromDate == null || fromDate.isEmpty || toDate == null || toDate.isEmpty) {
      throw Exception(ErrorMessages.selectAllFiltersBeforeFetch);
    }

    if (type.contains('All')) type = 'all';
    if (type.contains('Receive')) type = 'recieve';
    if (type.contains('Payment')) type = 'payment';

    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.cashTransaction;

    final queryParams = {
      if (type.isNotEmpty) 'type' : type,
      if (fromDate.isNotEmpty) 'from': fromDate,
      if (toDate.isNotEmpty) 'to': toDate,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return CashTransactionModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchCashTransactionsFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchCashTransactionsFailed);
    }
  }
}
