import 'dart:convert';
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/accounts/data/models/bank_transaction_model.dart';
import 'package:http/http.dart' as http;

class BankTransactionRepository {
  static Future<BankTransactionModel?> fetchData({
    required String shop,
    required String accountId,
    required String type,
    required String fromDate,
    required String toDate,
  }) async {
    if (accountId.isEmpty || type.isEmpty || fromDate.isEmpty || toDate.isEmpty) {
      throw Exception(ErrorMessages.selectAllFiltersBeforeFetch);
    }

    if (type.contains('All')) type = 'all';
    if (type.contains('Deposit')) type = 'deposit';
    if (type.contains('Withdraw')) type = 'withdraw';

    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.bankTransaction;

    final queryParams = {
      if (accountId.isNotEmpty) 'account_id': accountId,
      if (type.isNotEmpty) 'type': type,
      if (fromDate.isNotEmpty) 'from': fromDate,
      if (toDate.isNotEmpty) 'to': toDate,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return BankTransactionModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchBankTransactionsFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchBankTransactionsFailed);
    }
  }
}
