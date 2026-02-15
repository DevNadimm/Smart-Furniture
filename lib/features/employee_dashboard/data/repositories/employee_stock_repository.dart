import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_stock_model.dart';

class EmployeeStockRepository {
  static Future<EmployeeStockModel?> fetchStocks({int? branchId}) async {
    final api = ApiEndpoints(shop: '');
    String endpoint = api.branchStock;

    // if(branchId != null) {
    //   endpoint += '?branch_id=$branchId';
    // }

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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return EmployeeStockModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchStockFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchStockFailed);
    }
  }
}
