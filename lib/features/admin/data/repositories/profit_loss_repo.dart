import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/admin/data/models/profit_loss_model.dart';

class ProfitLossRepository {
  /// Fetch Profit & Loss Report
  static Future<ProfitLossModel> fetchProfitLoss({
    String? fromDate,
    String? toDate,
    int? branchId,
  }) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.profitLoss;

    /// Build query parameters dynamically
    final queryParams = <String, String>{};

    if (fromDate != null && fromDate.isNotEmpty) {
      queryParams['from_date'] = fromDate;
    }
    if (toDate != null && toDate.isNotEmpty) {
      queryParams['to_date'] = toDate;
    }
    if (branchId != null) {
      queryParams['branch_id'] = branchId.toString();
    }

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    print('📡 [FETCH PROFIT LOSS] URL => $uri');

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

        print('✅ Profit & Loss fetched successfully');
        return ProfitLossModel.fromJson(jsonMap);
      } else {
        print('❌ Profit & Loss fetch failed');
        throw Exception(ErrorMessages.fetchProfitLossFailed);
      }
    } catch (e) {
      print('🔥 Profit & Loss Error => $e');
      throw Exception(ErrorMessages.fetchProfitLossFailed);
    }
  }
}
