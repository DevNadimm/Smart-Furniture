import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/constants/api_endpoints.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/daily_reports/data/models/daily_reports_model.dart';

class DailyReportsRepository {
  static Future<DailyReportsModel?> fetchData(String shop, String? date) async {
    if (date == null || date.isEmpty) {
      final DateTime dateTime = DateTime.now();
      date = DateFormat('yyyy-MM-dd').format(dateTime);
    }

    ApiEndpoints api = ApiEndpoints(shop: shop);
    final endpoint = api.dailyReport;

    final queryParams = {
      if (date.isNotEmpty) 'date': date,
    };

    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);
        return DailyReportsModel.fromJson(jsonMap);
      } else {
        throw Exception(ErrorMessages.fetchDailyReportsFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchDailyReportsFailed);
    }
  }
}
