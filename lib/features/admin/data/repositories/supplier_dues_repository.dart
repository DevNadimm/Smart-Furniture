import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_dues_details_model.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_dues_model.dart';

class SupplierDuesRepository {
  static Future<SupplierDuesModel?> fetchSupplierDues() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.supplierDues;
    final uri = Uri.parse(endpoint);

    debugPrint('📡 [FETCH SUPPLIER DUES] URL => $uri');

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

        debugPrint('✅ Supplier dues fetched');
        return SupplierDuesModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchSupplierDuesFailed);
      }
    } catch (e) {
      debugPrint('🔥 Fetch Supplier Dues Error => $e');
      throw Exception(ErrorMessages.fetchSupplierDuesFailed);
    }
  }

  static Future<SupplierPurchaseDueModel?> fetchSupplierWisePurchaseDues(int supplierId) async {

    final api = ApiEndpoints(shop: '');
    final endpoint = api.supplierWisePurchaseDues(supplierId);
    final uri = Uri.parse(endpoint);

    debugPrint('URL: $uri');

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

        debugPrint('✅ Supplier purchase dues fetched');
        return SupplierPurchaseDueModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchSupplierPurchaseDueFailed);
      }
    } catch (e) {
      debugPrint('🔥 Fetch Supplier Purchase Dues Error => $e');
      throw Exception(ErrorMessages.fetchSupplierPurchaseDueFailed);
    }
  }
}
