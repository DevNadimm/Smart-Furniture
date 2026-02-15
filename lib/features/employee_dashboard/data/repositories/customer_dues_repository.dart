import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_dues_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_purchase_due_model.dart';

class CustomerDuesRepository {

  /// ===============================
  /// Fetch All Customer Dues
  /// ===============================
  static Future<CustomerDuesModel?> fetchCustomerDues() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.customerDues;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [FETCH CUSTOMER DUES] URL => $uri');

    try {
      final token = await AppPreferences.getUserId();

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('📥 Status Code => ${response.statusCode}');
      debugPrint('📥 Response => ${response.body}');

      if (response.statusCode == 200) {
        final jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        debugPrint('✅ Customer dues fetched');
        return CustomerDuesModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchCustomerFailed);
      }
    } catch (e) {
      debugPrint('🔥 Fetch Customer Dues Error => $e');
      throw Exception(ErrorMessages.fetchCustomerFailed);
    }
  }

  /// ===============================
  /// Fetch Customer Wise Purchase Dues
  /// ===============================
  static Future<CustomerPurchaseDueModel?>
  fetchCustomerWisePurchaseDues(int customerId) async {

    final api = ApiEndpoints(shop: '');
    final endpoint = api.customerWisePurchaseDues(customerId);
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [FETCH CUSTOMER PURCHASE DUES] ID => $customerId');

    try {
      final token = await AppPreferences.getUserId();

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('📥 Status Code => ${response.statusCode}');
      debugPrint('📥 Response => ${response.body}');

      if (response.statusCode == 200) {
        final jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        debugPrint('✅ Customer purchase dues fetched');
        return CustomerPurchaseDueModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchCustomerFailed);
      }
    } catch (e) {
      debugPrint('🔥 Fetch Purchase Dues Error => $e');
      throw Exception(ErrorMessages.fetchCustomerFailed);
    }
  }

  /// ===============================
  /// Due Payment (POST)
  /// ===============================
  static Future<bool> duePayment(Map<String, dynamic> body) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.duePayment;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [DUE PAYMENT]');
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
      debugPrint('📥 Response => ${response.body}');

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        debugPrint('✅ Due payment successful');
        return true;
      } else {
        throw Exception(ErrorMessages.paymentFailed);
      }
    } catch (e) {
      debugPrint('🔥 Due Payment Error => $e');
      throw Exception(ErrorMessages.paymentFailed);
    }
  }
}
