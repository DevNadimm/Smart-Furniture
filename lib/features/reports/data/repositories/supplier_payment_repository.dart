import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/reports/data/models/supplier_payment_model.dart';

class SupplierPaymentRepository {
  static Future<SupplierPaymentModel?> fetchData(
    String shop,
    String? supplierId,
  ) async {
    if (supplierId == null || supplierId.isEmpty) {
      throw Exception(ErrorMessages.selectSupplierBeforeFetch);
    }

    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.supplierPaymentReports;

    final queryParams = {
      if (supplierId.isNotEmpty) 'supplier_id': supplierId,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return SupplierPaymentModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchSupplierPaymentReportFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchSupplierPaymentReportFailed);
    }
  }
}
