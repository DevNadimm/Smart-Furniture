import 'package:smart_furniture/core/constants/base_url.dart';

class ApiEndpoints {
  final String shop;

  ApiEndpoints({required this.shop});

  String get baseUrl => BaseUrl.getBaseUrl(shop);
  String get employeeBaseUrl => 'https://sff.jabedinternational.com';

  // Login
  String get login => '$employeeBaseUrl/api/login';
  String get branchStock => '$employeeBaseUrl/api/stock/branch';
  String get salesDetails => '$employeeBaseUrl/api/sales/create-data';
  String get createSales => '$employeeBaseUrl/api/sales';
  String get employeeSales => '$employeeBaseUrl/api/sales';
  String get expenseHeads => '$employeeBaseUrl/api/expense/heads';
  String get employeeExpenses => '$employeeBaseUrl/api/expense/transactions';
  String get createEmployeeExpense => '$employeeBaseUrl/api/expense/transactions';
  String updateEmployeeExpense(int id) => '$employeeBaseUrl/api/expense/transactions/$id';
  String deleteEmployeeExpense(int id) => '$employeeBaseUrl/api/expense/transactions/$id';
  String get customers => '$employeeBaseUrl/api/customers';
  String get createCustomer => '$employeeBaseUrl/api/customers';
  String updateCustomer(int id) => '$employeeBaseUrl/api/customers/$id';
  String deleteCustomer(int id) => '$employeeBaseUrl/api/customers/$id';
  String get branches => '$employeeBaseUrl/api/branches';
  String get customerDues => '$employeeBaseUrl/api/payments/customer-dues';
  String customerWisePurchaseDues(int id) => '$employeeBaseUrl/api/payments/customer/$id/sales';
  String get duePayment => '$employeeBaseUrl/api/payments/customer-payment/store';
  String get finishedProducts => '$employeeBaseUrl/api/stock/finished-products';
  String get companyRawMaterials => '$employeeBaseUrl/api/stock/raw-materials';
  String get purchases => '$employeeBaseUrl/api/purchases';
  String purchaseDetails(int id) => '$employeeBaseUrl/api/purchases/$id';
  String get suppliers => '$employeeBaseUrl/api/suppliers';
  String get supplierDues => '$employeeBaseUrl/api/payments/supplier-dues';
  String supplierWisePurchaseDues(int id) => '$employeeBaseUrl/api/payments/supplier/$id/purchases';
  String get finishedProductCategories => '$employeeBaseUrl/api/categories/finished-product';
  String get customOrders => '$employeeBaseUrl/api/custom-orders';
  String get storeCustomOrder => '$employeeBaseUrl/api/custom-orders';
  String get customOrderDuePayment => '$employeeBaseUrl/api/custom-orders/payment';
  String get transfers => '$employeeBaseUrl/api/transfers';
  String transferDetails(int id) => '$employeeBaseUrl/api/transfers/$id';

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
