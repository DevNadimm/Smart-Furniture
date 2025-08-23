class ProfitLossModel {
  final bool? success;
  final int? totalPurchased;
  final int? totalSold;
  final int? totalDiscount;
  final int? totalReturnedValue;
  final int? totalDamaged;
  final int? totalCashTransaction;
  final int? totalEmployeePayment;
  final int? totalProfit;

  ProfitLossModel({
    this.success,
    this.totalPurchased,
    this.totalSold,
    this.totalDiscount,
    this.totalReturnedValue,
    this.totalDamaged,
    this.totalCashTransaction,
    this.totalEmployeePayment,
    this.totalProfit,
  });

  factory ProfitLossModel.fromJson(Map<String, dynamic> json) {
    return ProfitLossModel(
      success: json['success'] as bool?,
      totalPurchased: json['totalPurchased'] as int?,
      totalSold: json['totalSold'] as int?,
      totalDiscount: json['totalDiscount'] as int?,
      totalReturnedValue: json['totalReturnedValue'] as int?,
      totalDamaged: json['totalDamaged'] as int?,
      totalCashTransaction: json['totalCashTransaction'] as int?,
      totalEmployeePayment: json['totalEmployeePayment'] as int?,
      totalProfit: json['totalProfit'] as int?,
    );
  }
}
