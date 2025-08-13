import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/administration/data/models/supplier_list_model.dart';

class SupplierListRepository {
  static Future<SupplierListModel?> fetchData(String shop) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.supplierList;

    final uri = Uri.parse(endpoint);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return SupplierListModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchSupplierListFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchSupplierListFailed);
    }
  }
}
