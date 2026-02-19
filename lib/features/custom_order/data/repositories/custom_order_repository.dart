import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/custom_order/data/models/custom_order_model.dart';

class CustomOrderRepository {

  static Future<List<CustomOrderData>> fetchOrders({int? branchId, String? fromDate, String? toDate, String? status}) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.customOrders;

    final queryParams = {
      if (branchId != null) 'branch_id': branchId.toString(),
      if (fromDate != null && fromDate.isNotEmpty) 'start_date': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'end_date': toDate,
      if (status != null && status.isNotEmpty)
        'status': status.toLowerCase(),
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    debugPrint('URL => $uri');

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
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        final List<dynamic> data = jsonMap['data'] ?? [];

        debugPrint('✅ Custom orders fetched successfully');

        return data
            .map((e) => CustomOrderData.fromJson(e))
            .toList();
      } else {
        throw Exception(ErrorMessages.fetchOrderFailed);
      }
    } catch (e) {
      debugPrint('🔥 Fetch Orders Error => $e');
      throw Exception(ErrorMessages.fetchOrderFailed);
    }
  }

  static Future<bool> storeOrder(Map<String, dynamic> body) async {

    final api = ApiEndpoints(shop: '');
    final endpoint = api.storeCustomOrder;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [STORE CUSTOM ORDER]');
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('✅ Custom order stored successfully');
        return true;
      } else {
        throw Exception(ErrorMessages.createOrderFailed);
      }
    } catch (e) {
      debugPrint('🔥 Store Order Error => $e');
      throw Exception(ErrorMessages.createOrderFailed);
    }
  }

  static Future<bool> duePayment(Map<String, dynamic> body) async {

    final api = ApiEndpoints(shop: '');
    final endpoint = api.customOrderDuePayment;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [CUSTOM ORDER DUE PAYMENT]');
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('✅ Custom order payment successful');
        return true;
      } else {
        throw Exception(ErrorMessages.paymentFailed);
      }
    } catch (e) {
      debugPrint('🔥 Custom Order Payment Error => $e');
      throw Exception(ErrorMessages.paymentFailed);
    }
  }
}
