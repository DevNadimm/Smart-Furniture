import 'package:smart_furniture/core/constants/base_url.dart';

class ApiEndpoints {
  final String shopId;

  ApiEndpoints({required this.shopId});

  String get baseUrl => BaseUrl.getBaseUrl(shopId);

  // 📦 Administration
  String get customerList => '$baseUrl/customers';
  String get supplierList => '$baseUrl/suppliers';
  String get productList => '$baseUrl/administration/product-list';
  String get damageList => '$baseUrl/administration/damage-list';
  String get productLedger => '$baseUrl/administration/product-ledger';

  // 📦 Sales
  String get salesRecord => '$baseUrl/sale-records';
  String get salesReturn => '$baseUrl/sale-return';
  String get stock => '$baseUrl/stock';

  // 📦 Purchase
  String get purchaseRecord => '$baseUrl/purchase-records';
  String get purchaseReturn => '$baseUrl/purchase-return';

  // 📦 HR & Payroll
  String get employeeList => '$baseUrl/employees';
  String get salaryPayments => '$baseUrl/report-module/salary-payment-report';

  // 📦 Misc
}
