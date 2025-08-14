import 'dart:convert';
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/features/accounts/data/models/reminder_cheque_list_model.dart';

class ReminderChequeListRepository {
  static Future<ReminderChequeListModel?> fetchData(String shop) async {
    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.reminderChequeList;

    final uri = Uri.parse(endpoint);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        return ReminderChequeListModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchReminderChequeListFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchReminderChequeListFailed);
    }
  }
}
