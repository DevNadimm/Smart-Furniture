import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_sales_details_model.dart';

class EmployeeSalesDetailsRepository {
  static Future<EmployeeSalesDetailsModel?> fetchDetails() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.salesDetails;

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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;

        return EmployeeSalesDetailsModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.salesDetails);
      }
    } catch (e) {
      throw Exception(ErrorMessages.salesDetails);
    }
  }
}
