import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/accounts/data/models/bank_accounts_model.dart';

class BankAccountsRepository {
  static Future<BankAccountsModel?> fetchData(String shop) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.bankAccounts;

    final uri = Uri.parse(endpoint);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return BankAccountsModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchBankAccountsFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchBankAccountsFailed);
    }
  }
}
