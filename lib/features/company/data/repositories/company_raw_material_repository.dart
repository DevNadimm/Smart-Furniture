import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/company/data/models/company_raw_material_model.dart';

class CompanyRawMaterialRepository {
  /// Fetch all company raw materials
  static Future<CompanyRawMaterialModel> fetchCompanyRawMaterials({String? categoryId, String? search}) async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.companyRawMaterials;

    final queryParams = {
      if (search != null && search.isNotEmpty) 'search': search,
      if (categoryId != null && categoryId.isNotEmpty) 'category_id': categoryId,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print('URL => $uri');

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

        print('✅ Company raw materials fetched successfully');
        return CompanyRawMaterialModel.fromJson(jsonMap);
      } else {
        print('❌ Fetch company raw materials failed');
        throw Exception(ErrorMessages.fetchCompanyRawMaterialFailed);
      }
    } catch (e) {
      print('🔥 Fetch Company Raw Materials Error => $e');
      throw Exception(ErrorMessages.fetchCompanyRawMaterialFailed);
    }
  }
}
