import 'package:smart_furniture/core/constants/base_url.dart';

class ApiEndpoints {
  final String shop;

  ApiEndpoints({required this.shop});

  String get baseUrl => BaseUrl.getBaseUrl(shop);

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

  // 📦 Accounts
  String get bankTransaction => '$baseUrl/report-module/bank-transaction-report';
  String get cashTransaction => '$baseUrl/report-module/cash-statment';
  String get pendingChequeList => '$baseUrl/accounts/pendingChequeList';
  String get reminderChequeList => '$baseUrl/accounts/reminderChequeList';
  String get balanceSheet => '$baseUrl/report-module/balance-sheet';
  String get additionalPayments => '$baseUrl/accounts/additionalPayments';

  // 📦 Misc
  String get bankAccounts => '$baseUrl/bank-accounts';
}
