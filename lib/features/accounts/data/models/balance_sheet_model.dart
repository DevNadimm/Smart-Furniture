class BalanceSheetModel {
  final bool? success;
  final BalanceSheetData? data;

  BalanceSheetModel({this.success, this.data});

  factory BalanceSheetModel.fromJson(Map<String, dynamic> json) {
    return BalanceSheetModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? BalanceSheetData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class BalanceSheetData {
  final num? totalSales;
  final num? totalPurchase;
  final num? cashReceived;
  final num? cashPaid;
  final num? bankDeposit;
  final num? bankWithdraw;
  final num? supplierPaymentPaid;
  final num? supplierPaymentReceive;
  final num? customerPaymentPaid;
  final num? customerPaymentReceive;
  final num? employeePayment;
  final num? cashIn;
  final num? cashOut;
  final num? cashBalance;

  BalanceSheetData({
    this.totalSales,
    this.totalPurchase,
    this.cashReceived,
    this.cashPaid,
    this.bankDeposit,
    this.bankWithdraw,
    this.supplierPaymentPaid,
    this.supplierPaymentReceive,
    this.customerPaymentPaid,
    this.customerPaymentReceive,
    this.employeePayment,
    this.cashIn,
    this.cashOut,
    this.cashBalance,
  });

  factory BalanceSheetData.fromJson(Map<String, dynamic> json) {
    return BalanceSheetData(
      totalSales: json['total_sales'] as num?,
      totalPurchase: json['total_purchase'] as num?,
      cashReceived: json['cash_received'] as num?,
      cashPaid: json['cash_paid'] as num?,
      bankDeposit: json['bank_deposit'] as num?,
      bankWithdraw: json['bank_withdraw'] as num?,
      supplierPaymentPaid: json['supplier_payment_paid'] as num?,
      supplierPaymentReceive: json['supplier_payment_receive'] as num?,
      customerPaymentPaid: json['customer_payment_paid'] as num?,
      customerPaymentReceive: json['customer_payment_receive'] as num?,
      employeePayment: json['employee_payment'] as num?,
      cashIn: json['cash_in'] as num?,
      cashOut: json['cash_out'] as num?,
      cashBalance: json['cash_balance'] as num?,
    );
  }
}
