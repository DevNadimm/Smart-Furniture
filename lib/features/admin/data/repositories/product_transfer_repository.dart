import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/admin/data/models/product_transfer_model.dart';
import 'package:smart_furniture/features/admin/data/models/product_transfer_details_model.dart';

class ProductTransferRepository {
  static Future<ProductTransferModel> fetchTransfers({
    String? fromDate,
    String? toDate,
    String? categoryId,
    String? branchId,
  }) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.transfers;

    final queryParams = {
      if (fromDate != null && fromDate.isNotEmpty)
        'start_date': fromDate,
      if (toDate != null && toDate.isNotEmpty)
        'end_date': toDate,
      if (categoryId != null && categoryId.isNotEmpty)
        'category_id': categoryId,
      if (branchId != null && branchId.isNotEmpty)
        'branch_id': branchId,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    print('📡 [FETCH TRANSFERS] URL => $uri');

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
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body);

        print('✅ Transfers fetched successfully');
        return ProductTransferModel.fromJson(jsonMap);
      } else {
        print('❌ Fetch transfers failed');
        throw Exception(ErrorMessages.fetchTransferFailed);
      }
    } catch (e) {
      print('🔥 Fetch Transfers Error => $e');
      throw Exception(ErrorMessages.fetchTransferFailed);
    }
  }

  static Future<ProductTransferData?> fetchTransferDetails(int id) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.transferDetails(id);

    final uri = Uri.parse(endpoint);

    print('📡 [FETCH TRANSFER DETAILS] ID => $id');

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
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);

        final dataMap = jsonMap['data'] as Map<String, dynamic>?;

        if (dataMap != null) {
          print('✅ Transfer details fetched successfully');
          return ProductTransferData.fromJson(dataMap);
        } else {
          print('❌ Transfer details data is null');
          throw Exception(ErrorMessages.fetchTransferDetailsFailed);
        }
      } else {
        print('❌ Fetch transfer details failed');
        throw Exception(ErrorMessages.fetchTransferDetailsFailed);
      }
    } catch (e) {
      print('🔥 Fetch Transfer Details Error => $e');
      throw Exception(ErrorMessages.fetchTransferDetailsFailed);
    }
  }
}