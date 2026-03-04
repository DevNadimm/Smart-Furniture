import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/custom_order/data/models/custom_order_model.dart';

class CustomOrderRepository {
  static Future<CustomOrderModel> fetchOrders({
    int? branchId,
    String? fromDate,
    String? toDate,
    String? status,
  }) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.customOrders;

    final queryParams = {
      if (branchId != null) 'branch_id': branchId.toString(),
      if (fromDate != null && fromDate.isNotEmpty) 'start_date': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'end_date': toDate,
      if (status != null && status.isNotEmpty) 'status': status.toLowerCase(),
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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint('✅ Custom orders fetched successfully');
        return CustomOrderModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchOrderFailed);
      }
    } catch (e) {
      debugPrint('📥 Fetch Orders Error => $e');
      throw Exception(ErrorMessages.fetchOrderFailed);
    }
  }

  static Future<bool> storeOrder({
    required Map<String, String> fields,
    required List<CustomOrderItemPayload> items,
  }) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.storeCustomOrder;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [STORE CUSTOM ORDER]');
    debugPrint('📤 Fields => $fields');
    debugPrint('📤 Items count => ${items.length}');

    try {
      final token = await AppPreferences.getUserId();

      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

      request.fields.addAll(fields);

      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        request.fields['items[$i][product_name]'] = item.productName;
        request.fields['items[$i][unit]'] = item.unit;
        request.fields['items[$i][ordered_quantity]'] = item.orderedQuantity.toString();
        request.fields['items[$i][unit_price]'] = item.unitPrice.toString();

        if (item.imageFile != null) {
          final imageBytes = await item.imageFile!.readAsBytes();
          final fileName = item.imageFile!.path.split('/').last;
          request.files.add(
            http.MultipartFile.fromBytes(
              'items[$i][image]',
              imageBytes,
              filename: fileName,
            ),
          );
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('📥 Status Code => ${response.statusCode}');
      debugPrint('📥 Response => ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('✅ Custom order stored successfully');
        return true;
      } else {
        throw Exception(ErrorMessages.createOrderFailed);
      }
    } catch (e) {
      debugPrint('📥 Store Order Error => $e');
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
      debugPrint('📥 Custom Order Payment Error => $e');
      throw Exception(ErrorMessages.paymentFailed);
    }
  }
}

class CustomOrderItemPayload {
  final String productName;
  final String unit;
  final int orderedQuantity;
  final num unitPrice;
  final File? imageFile;

  const CustomOrderItemPayload({
    required this.productName,
    required this.unit,
    required this.orderedQuantity,
    required this.unitPrice,
    this.imageFile,
  });
}