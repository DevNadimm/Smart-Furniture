import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/company/data/models/custom_production_model.dart';

class CustomProductionRepository {
  /// Fetch custom production data
  /// Optional parameters: start_date, end_date
  static Future<CustomProductionModel> fetchCustomProductions({
    String? startDate,
    String? endDate,
  }) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.customProductions;

    final queryParams = {
      if (startDate != null && startDate.isNotEmpty) 'start_date': startDate,
      if (endDate != null && endDate.isNotEmpty) 'end_date': endDate,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print('📡 [FETCH CUSTOM PRODUCTIONS] URL => $uri');

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

        print('✅ Custom productions fetched successfully');
        return CustomProductionModel.fromJson(jsonMap);
      } else {
        print('❌ Fetch custom productions failed');
        throw Exception(ErrorMessages.fetchCustomProductionFailed);
      }
    } catch (e) {
      print('🔥 Fetch Custom Productions Error => $e');
      throw Exception(ErrorMessages.fetchCustomProductionFailed);
    }
  }
}