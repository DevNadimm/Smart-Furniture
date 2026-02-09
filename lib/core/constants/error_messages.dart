class ErrorMessages {
  ErrorMessages._();

  // Purchase Module
  static const String fetchPurchaseRecordFailed = 'Failed to fetch purchase records. Please try again later.';
  static const String fetchPurchaseReturnFailed = 'Failed to fetch purchase return records. Please try again later.';

  // Sales Module
  static const String fetchSalesRecordFailed = 'Failed to fetch sales records. Please try again later.';
  static const String fetchSalesReturnFailed = 'Failed to fetch sales return records. Please try again later.';
  static const String fetchStockFailed = 'Failed to fetch stock data. Please try again later.';

  // Administration Module
  static const String fetchProductListFailed = 'Failed to fetch product list. Please try again later.';
  static const String fetchCustomerListFailed = 'Failed to fetch customer list. Please try again later.';
  static const String fetchSupplierListFailed = 'Failed to fetch supplier list. Please try again later.';
  static const String fetchDamageListFailed = 'Failed to fetch damage list. Please try again later.';
  static const String fetchProductLedgerFailed = 'Failed to fetch product ledger data. Please try again later.';

  // HR Module
  static const String fetchSalaryPaymentListFailed = 'Failed to fetch salary payment list. Please try again later.';
  static const String fetchEmployeeListFailed = 'Failed to fetch employee list. Please try again later.';

  // Accounts Module
  static const String fetchBankTransactionsFailed = 'Failed to fetch bank transactions. Please try again later.';
  static const String fetchCashTransactionsFailed = 'Failed to fetch cash transactions. Please try again later.';
  static const String fetchCashStatementFailed = 'Failed to fetch cash statement. Please try again later.';
  static const String fetchPendingChequeListFailed = 'Failed to fetch pending cheque list. Please try again later.';
  static const String fetchReminderChequeListFailed = 'Failed to fetch reminder cheque list. Please try again later.';
  static const String fetchBalanceSheetFailed = 'Failed to fetch balance sheet. Please try again later.';
  static const String fetchAdditionalPaymentsFailed = 'Failed to fetch additional payments. Please try again later.';
  static const String fetchBankAccountsFailed = 'Failed to fetch bank accounts. Please try again later.';

  // Reports Module
  static const String fetchSupplierPaymentReportFailed = 'Failed to fetch supplier payment report. Please try again later.';
  static const String fetchCustomerPaymentReportFailed = 'Failed to fetch customer payment report. Please try again later.';
  static const String fetchProfitLossReportFailed = 'Failed to fetch profit and loss report. Please try again later.';
  static const String fetchDailyReportsFailed = 'Failed to fetch daily reports. Please try again later.';

  // Validation & General Errors
  static const String selectProductBeforeFetch = 'Please select a product before fetching data.';
  static const String selectSupplierBeforeFetch = 'Please select a supplier before fetching data.';
  static const String selectAllFiltersBeforeFetch = 'Please select all filters before fetching data.';
  static const String selectDateFiltersBeforeFetch = 'Please select date filters before fetching data.';
  static const String networkError = 'Network error occurred. Please check your connection and try again later.';
  static const String unknownError = 'An unknown error occurred. Please try again later.';

  // Misc
  static const String fetchCategoryListFailed = 'Failed to fetch category list. Please try again later.';
  static const String salesDetails = 'Failed to fetch sales details. Please try again later.';
}
