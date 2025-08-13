import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/administration/data/models/customer_list_model.dart';

class CustomerListRepository {
  static Future<CustomerListModel?> fetchData(String shop) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    String endpoint = api.customerList;

    final uri = Uri.parse(endpoint);
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
