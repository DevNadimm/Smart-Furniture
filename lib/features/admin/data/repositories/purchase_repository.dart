import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/admin/data/models/purchase_details_model.dart';
import 'package:smart_furniture/features/admin/data/models/purchase_model.dart';

class PurchaseRepository {
  static Future<PurchaseModel> fetchPurchase({String? fromDate, String? toDate, String? categoryId}) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.purchases;

    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty) 'start_date': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'end_date': toDate,
      if (categoryId != null && categoryId.isNotEmpty) 'category_id': categoryId,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print('📡 [FETCH PURCHASES] URL => $uri');

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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;

        print('✅ Purchases fetched successfully');
        return PurchaseModel.fromJson(jsonMap);
      } else {
        print('❌ Fetch purchases failed');
        throw Exception(ErrorMessages.fetchPurchaseFailed);
      }
    } catch (e) {
      print('🔥 Fetch Purchases Error => $e');
      throw Exception(ErrorMessages.fetchPurchaseFailed);
    }
  }

  static Future<PurchaseDetailsData?> fetchPurchaseDetails(int id) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.purchaseDetails(id);

    final uri = Uri.parse(endpoint);
    print('📡 [FETCH PURCHASE DETAILS] ID => $id');

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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body) as Map<String, dynamic>;

        // Extract the 'data' field
        final Map<String, dynamic>? dataMap = jsonMap['data'] as Map<String, dynamic>?;

        if (dataMap != null) {
          print('✅ Purchase details fetched successfully');
          return PurchaseDetailsData.fromJson(dataMap);
        } else {
          print('❌ Purchase details data is null');
          throw Exception(ErrorMessages.fetchPurchaseDetailsFailed);
        }
      } else {
        print('❌ Fetch purchase details failed');
        throw Exception(ErrorMessages.fetchPurchaseDetailsFailed);
      }
    } catch (e) {
      print('🔥 Fetch Purchase Details Error => $e');
      throw Exception(ErrorMessages.fetchPurchaseDetailsFailed);
    }
  }
}
