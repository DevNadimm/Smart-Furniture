import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_expense_model.dart';

class EmployeeExpenseRepository {
  static Future<EmployeeExpenseModel?> fetchEmployeeExpenses({int? branchId}) async {
    final api = ApiEndpoints(shop: '');
    String endpoint = api.employeeExpenses;

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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
        return EmployeeExpenseModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchExpenseFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchExpenseFailed);
    }
  }

  static Future<bool> createEmployeeExpense(Map<String, dynamic> body) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.createEmployeeExpense;

    final uri = Uri.parse(endpoint);
    print('URL: $uri');

    try {
      final token = await AppPreferences.getUserId();
      final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception(ErrorMessages.createExpenseFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.createExpenseFailed);
    }
  }

  static Future<bool> updateEmployeeExpense(int id, Map<String, dynamic> body) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.updateEmployeeExpense(id);

    final uri = Uri.parse(endpoint);
    print('URL: $uri');

    try {
      final token = await AppPreferences.getUserId();
      final response = await http.put(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(ErrorMessages.updateExpenseFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.updateExpenseFailed);
    }
  }

  static Future<bool> deleteEmployeeExpense(int id) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.deleteEmployeeExpense(id);

    final uri = Uri.parse(endpoint);
    print('URL: $uri');

    try {
      final token = await AppPreferences.getUserId();
      final response = await http.delete(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception(ErrorMessages.deleteExpenseFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.deleteExpenseFailed);
    }
  }
}