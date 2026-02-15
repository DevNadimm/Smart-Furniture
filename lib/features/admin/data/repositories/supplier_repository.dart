import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_model.dart';

class SupplierRepository {
  /// Fetch all suppliers
  static Future<List<SupplierData>> fetchSuppliers() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.suppliers;

    final uri = Uri.parse(endpoint);
    print('📡 [FETCH SUPPLIERS] URL => $uri');

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
        jsonDecode(response.body) as Map<String, dynamic>;

        final List<dynamic> data = jsonMap['data'] ?? [];

        print('✅ Suppliers fetched successfully');
        return data.map((e) => SupplierData.fromJson(e)).toList();
      } else {
        print('❌ Fetch suppliers failed');
        throw Exception(ErrorMessages.fetchSupplierFailed);
      }
    } catch (e) {
      print('🔥 Fetch Suppliers Error => $e');
      throw Exception(ErrorMessages.fetchSupplierFailed);
    }
  }
}
