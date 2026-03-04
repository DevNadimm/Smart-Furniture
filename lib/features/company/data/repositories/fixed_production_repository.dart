import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/company/data/models/fixed_production_model.dart';

class FixedProductionRepository {
  /// Fetch fixed production data
  /// Optional parameters: start_date, end_date
  static Future<FixedProductionModel> fetchFixedProductions({
    String? startDate,
    String? endDate,
  }) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.fixedProductions; // Make sure this exists

    final queryParams = {
      if (startDate != null && startDate.isNotEmpty) 'start_date': startDate,
      if (endDate != null && endDate.isNotEmpty) 'end_date': endDate,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print('📡 [FETCH FIXED PRODUCTIONS] URL => $uri');

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

        print('✅ Fixed productions fetched successfully');
        return FixedProductionModel.fromJson(jsonMap);
      } else {
        print('❌ Fetch fixed productions failed');
        throw Exception(ErrorMessages.fetchFixedProductionFailed);
      }
    } catch (e) {
      print('🔥 Fetch Fixed Productions Error => $e');
      throw Exception(ErrorMessages.fetchFixedProductionFailed);
    }
  }
}