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
  String get cashTransaction => '$baseUrl/report-module/cash-transaction-report';
  String get pendingChequeList => '$baseUrl/accounts/pendingChequeList';
  String get reminderChequeList => '$baseUrl/accounts/reminderChequeList';
  String get balanceSheet => '$baseUrl/report-module/balance-sheet';
  String get additionalPayments => '$baseUrl/accounts/additionalPayments';

  // 📦 Reports
  String get dailyReport => '$baseUrl/daily-report';
  String get supplierPaymentReports => '$baseUrl/report-module/supplier-payment-report';
  String get customerPaymentReports => '$baseUrl/report-module/customer-payment-report';
  String get profitLoss => '$baseUrl/report-module/profit-loss';

  // 📦 Misc
  String get bankAccounts => '$baseUrl/bank-accounts';
  String get categoryList => '$baseUrl/categories';
}
