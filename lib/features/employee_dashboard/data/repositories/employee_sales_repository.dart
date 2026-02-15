import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_sales_model.dart';

class EmployeeSalesRepository {
  /// Fetch employee sales
  static Future<EmployeeSalesModel?> fetchSales({int? branchId}) async {
    final api = ApiEndpoints(shop: '');
    String endpoint = api.employeeSales;

    if(branchId != null) {
      endpoint += '?branch_id=$branchId';
    }

    final uri = Uri.parse(endpoint);
    print('URL: $uri');

    try {
      final token = await AppPreferences.getUserId();

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap =
            jsonDecode(response.body) as Map<String, dynamic>;

        return EmployeeSalesModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchSalesFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchSalesFailed);
    }
  }

  /// Create sales
  static Future<bool> createSales(Map<String, dynamic> body) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.createSales;

    final uri = Uri.parse(endpoint);
    print('URL: $uri');

    try {
      final token = await AppPreferences.getUserId();

      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(ErrorMessages.createSalesFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.createSalesFailed);
    }
  }
}
