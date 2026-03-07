class ProfitLossModel {
  final bool? success;
  final ProfitLossData? data;

  ProfitLossModel({
    this.success,
    this.data,
  });

  factory ProfitLossModel.fromJson(Map<String, dynamic> json) {
    return ProfitLossModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? ProfitLossData.fromJson(json['data'])
          : null,
    );
  }
}

class ProfitLossData {
  final num totalSales;
  final num totalSalesReturn;
  final num transferIncome;   // ✅ NEW FIELD
  final num netSales;
  final num totalPurchaseCost;
  final num grossProfit;
  final num totalExpenses;
  final num netProfit;

  ProfitLossData({
    required this.totalSales,
    required this.totalSalesReturn,
    required this.transferIncome,
    required this.netSales,
    required this.totalPurchaseCost,
    required this.grossProfit,
    required this.totalExpenses,
    required this.netProfit,
  });

  factory ProfitLossData.fromJson(Map<String, dynamic> json) {
    return ProfitLossData(
      totalSales: json['total_sales'] ?? 0,
      totalSalesReturn: json['total_sales_return'] ?? 0,
      transferIncome: json['transfer_income'] ?? 0, // ✅ mapped
      netSales: json['net_sales'] ?? 0,
      totalPurchaseCost: json['total_purchase_cost'] ?? 0,
      grossProfit: json['gross_profit'] ?? 0,
      totalExpenses: json['total_expenses'] ?? 0,
      netProfit: json['net_profit'] ?? 0,
    );
  }
}