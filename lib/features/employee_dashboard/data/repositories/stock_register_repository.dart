import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/stock_register_model.dart';

class StockRegisterRepository {
  /// Fetch stock register
  /// Optional params: product_id, start_date, end_date
  static Future<StockRegisterModel> fetchStockRegister({required int? productId, required String? branchId, required String? startDate, required String? endDate}) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.stockRegister(productId ?? 0);

    final queryParameters = {
      if (branchId != null && branchId.isNotEmpty) 'branch_id': branchId,
      if (startDate != null && startDate.isNotEmpty) 'start_date': startDate,
      if (endDate != null && endDate.isNotEmpty) 'end_date': endDate
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParameters);

    print('📡 [FETCH STOCK REGISTER] URL => $uri');

    try {
      final token = await AppPreferences.getUserId();
      print('🔐 Token Loaded');

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('📥 Status Code => ${response.statusCode}');
      print('📥 Response Body => ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap =
            jsonDecode(response.body) as Map<String, dynamic>;

        print('✅ Stock register fetched successfully');

        return StockRegisterModel.fromJson(jsonMap);
      } else {
        print('❌ Fetch stock register failed');
        throw Exception(ErrorMessages.fetchStockRegisterFailed);
      }
    } catch (e) {
      print('🔥 Fetch Stock Register Error => $e');
      throw Exception(ErrorMessages.fetchStockRegisterFailed);
    }
  }
}
