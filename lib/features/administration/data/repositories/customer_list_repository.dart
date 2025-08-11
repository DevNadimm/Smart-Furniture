import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/administration/data/models/customer_list_model.dart';

class CustomerListRepository {
  static Future<CustomerListModel?> fetchData() async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final uri = Uri.parse("$baseUrl/customers");
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return CustomerListModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchCustomerListFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchCustomerListFailed);
    }
  }
}
