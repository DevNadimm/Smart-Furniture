class ProfitLossModel {
  final bool? success;
  final ProfitLossData? data;

  ProfitLossModel({
    this.success,
    this.data,
  });

  factory ProfitLossModel.fromJson(Map<String, dynamic> json) {
    return ProfitLossModel(
      success: json['success'],
      data: json['data'] != null
          ? ProfitLossData.fromJson(json['data'])
          : null,
    );
  }
}

class ProfitLossData {
  final num? totalSales;
  final num? totalSalesReturn;
  final num? netSales;
  final num? totalPurchaseCost;
  final num? grossProfit;
  final num? totalExpenses;
  final num? netProfit;

  ProfitLossData({
    this.totalSales,
    this.totalSalesReturn,
    this.netSales,
    this.totalPurchaseCost,
    this.grossProfit,
    this.totalExpenses,
    this.netProfit,
  });

  factory ProfitLossData.fromJson(Map<String, dynamic> json) {
    return ProfitLossData(
      totalSales: json['total_sales'],
      totalSalesReturn: json['total_sales_return'],
      netSales: json['net_sales'],
      totalPurchaseCost: json['total_purchase_cost'],
      grossProfit: json['gross_profit'],
      totalExpenses: json['total_expenses'],
      netProfit: json['net_profit'],
    );
  }
}