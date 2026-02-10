import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_model.dart';

class CustomerRepository {

  /// Fetch all customers
  static Future<CustomerModel?> fetchCustomers() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.customers;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [FETCH CUSTOMERS] URL => $uri');

    try {
      final token = await AppPreferences.getUserId();
      debugPrint('🔐 Token Loaded');

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('📥 Status Code => ${response.statusCode}');
      debugPrint('📥 Response Body => ${response.body}');

      if (response.statusCode == 200) {
        final jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        debugPrint('✅ Customers fetched successfully');
        return CustomerModel.fromJson(jsonMap);
      } else {
        debugPrint('❌ Fetch failed');
        throw Exception(ErrorMessages.fetchCustomerFailed);
      }
    } catch (e) {
      debugPrint('🔥 Fetch Customers Error => $e');
      throw Exception(ErrorMessages.fetchCustomerFailed);
    }
  }

  /// Create customer
  static Future<bool> createCustomer(Map<String, dynamic> body) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.createCustomer;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [CREATE CUSTOMER] URL => $uri');
    debugPrint('📤 Payload => $body');

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

      debugPrint('📥 Status Code => ${response.statusCode}');
      debugPrint('📥 Response Body => ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('✅ Customer created successfully');
        return true;
      } else {
        debugPrint('❌ Create customer failed');
        throw Exception(ErrorMessages.createCustomerFailed);
      }
    } catch (e) {
      debugPrint('🔥 Create Customer Error => $e');
      throw Exception(ErrorMessages.createCustomerFailed);
    }
  }

  /// Update customer
  static Future<bool> updateCustomer(
      int id,
      Map<String, dynamic> body,
      ) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.updateCustomer(id);
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [UPDATE CUSTOMER] ID => $id');
    debugPrint('📤 Payload => $body');

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

      debugPrint('📥 Status Code => ${response.statusCode}');
      debugPrint('📥 Response Body => ${response.body}');

      if (response.statusCode == 200) {
        debugPrint('✅ Customer updated successfully');
        return true;
      } else {
        debugPrint('❌ Update customer failed');
        throw Exception(ErrorMessages.updateCustomerFailed);
      }
    } catch (e) {
      debugPrint('🔥 Update Customer Error => $e');
      throw Exception(ErrorMessages.updateCustomerFailed);
    }
  }

  /// Delete customer
  static Future<bool> deleteCustomer(int id) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.deleteCustomer(id);
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [DELETE CUSTOMER] ID => $id');

    try {
      final token = await AppPreferences.getUserId();

      final response = await http.delete(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('📥 Status Code => ${response.statusCode}');
      debugPrint('📥 Response Body => ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        debugPrint('✅ Customer deleted successfully');
        return true;
      } else {
        debugPrint('❌ Delete customer failed');
        throw Exception(ErrorMessages.deleteCustomerFailed);
      }
    } catch (e) {
      debugPrint('🔥 Delete Customer Error => $e');
      throw Exception(ErrorMessages.deleteCustomerFailed);
    }
  }
}
