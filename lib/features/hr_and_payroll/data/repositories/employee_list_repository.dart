import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/models/employee_list_model.dart';

class EmployeeListRepository {
  static Future<EmployeeListModel?> fetchData(String shop) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.employeeList;

    final uri = Uri.parse(endpoint);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return EmployeeListModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchEmployeeListFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchEmployeeListFailed);
    }
  }
}
