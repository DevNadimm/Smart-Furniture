import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/reports/data/models/profit_loss_model.dart';

class ProfitLossRepository {
  static Future<ProfitLossModel?> fetchData(
      String shop,
      String? fromDate,
      String? toDate,
      String? customerId,
      ) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.profitLoss;

    final queryParams = {
      if (fromDate?.isNotEmpty ?? false) 'from': fromDate!,
      if (toDate?.isNotEmpty ?? false) 'to': toDate!,
      if (customerId?.isNotEmpty ?? false) 'customer_id': customerId!,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return ProfitLossModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchProfitLossReportFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchProfitLossReportFailed);
    }
  }
}
