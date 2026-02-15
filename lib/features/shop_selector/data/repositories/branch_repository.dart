import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/shop_selector/data/models/branch_model.dart';

class BranchRepository {
  static Future<BranchModel?> fetchBranches() async {
    final api = ApiEndpoints(shop: '');
    final endpoint = api.branches;

    final uri = Uri.parse(endpoint);
    print("Branch URL: $uri");

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
        final Map<String, dynamic> jsonMap =
        jsonDecode(response.body) as Map<String, dynamic>;

        return BranchModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchBranchesFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchBranchesFailed);
    }
  }
}
