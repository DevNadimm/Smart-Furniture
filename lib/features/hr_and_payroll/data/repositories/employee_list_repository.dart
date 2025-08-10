import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/hr_and_payroll/data/models/employee_list_model.dart';

class EmployeeListRepository {
  static Future<EmployeeListModel?> fetchData() async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final uri = Uri.parse("$baseUrl/employees");
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return EmployeeListModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch employee list');
      }
    } catch (e) {
      throw Exception('Failed to fetch employee list: $e');
    }
  }
}
