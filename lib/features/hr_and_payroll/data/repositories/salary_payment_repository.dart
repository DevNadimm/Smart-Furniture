import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/models/salary_payment_model.dart';

class SalaryPaymentRepository {
  static Future<List<SalaryPaymentModel>?> fetchData() async {
    const baseUrl = "https://sfapi.qualityf.xyz/api";

    final uri = Uri.parse("$baseUrl/report-module/salary-payment-report");
    print("URL: $uri");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(res.body);

        if (jsonMap["data"] != null && jsonMap["data"] is List) {
          final List<dynamic> dataList = jsonMap["data"];
          return dataList.map((item) => SalaryPaymentModel.fromJson(item)).toList();
        }
      } else {
        throw Exception(ErrorMessages.fetchSalaryPaymentListFailed);
      }
    } catch (e) {
      throw Exception(ErrorMessages.fetchSalaryPaymentListFailed);
    }

    return null;
  }
}
