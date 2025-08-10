import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/purchase/data/models/supplier_list_model.dart';

class SupplierListRepository {
  static Future<SupplierListModel?> fetchData() async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final uri = Uri.parse("$baseUrl/suppliers");
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        print(jsonMap);

        return SupplierListModel.fromJson(jsonMap);
      } else {
        throw Exception('Failed to fetch suppliers');
      }
    } catch (e) {
      throw Exception('Failed to fetch suppliers: $e');
    }
  }
}
