import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/reports/data/models/customer_payment_model.dart';

class CustomerPaymentRepository {
  static Future<CustomerPaymentModel?> fetchData(
      String shop,
      String? fromDate,
      String? toDate,
      String? customerId,
      ) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.customerPaymentReports;

    final queryParams = {
      if (customerId?.isNotEmpty ?? false) 'customer_id': customerId!,
      if (fromDate?.isNotEmpty ?? false) 'from': fromDate!,
      if (toDate?.isNotEmpty ?? false) 'to': toDate!,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return CustomerPaymentModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchCustomerPaymentReportFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchCustomerPaymentReportFailed);
    }
  }
}
