import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/administration/data/models/supplier_list_model.dart';

class SupplierListRepository {
  static Future<SupplierListModel?> fetchData() async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final uri = Uri.parse("$baseUrl/suppliers");
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
