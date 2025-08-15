import 'dart:convert';
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/accounts/data/models/additional_payments_model.dart';

class AdditionalPaymentsRepository {
  static Future<AdditionalPaymentsModel?> fetchData(String shop) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.additionalPayments;

    final uri = Uri.parse(endpoint);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return AdditionalPaymentsModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchAdditionalPaymentsFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchAdditionalPaymentsFailed);
    }
  }
}
