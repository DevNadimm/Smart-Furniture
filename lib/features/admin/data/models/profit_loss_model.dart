import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class ProfitLossModel {
  final bool? success;
  final ProfitLossData? data;

  ProfitLossModel({
    this.success,
    this.data,
  });

  factory ProfitLossModel.fromJson(Map<String, dynamic> json) {
    return ProfitLossModel(
      success: SafeParse.toBool(json['success']),
      data: json['data'] != null
          ? ProfitLossData.fromJson(json['data'])
          : null,
    );
  }
}

class ProfitLossData {
  final num totalSales;
  final num totalSalesReturn;
  final num transferIncome;
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
      totalSales: SafeParse.toDouble(json['total_sales']) ?? 0,
      totalSalesReturn: SafeParse.toDouble(json['total_sales_return']) ?? 0,
      transferIncome: SafeParse.toDouble(json['transfer_income']) ?? 0,
      netSales: SafeParse.toDouble(json['net_sales']) ?? 0,
      totalPurchaseCost: SafeParse.toDouble(json['total_purchase_cost']) ?? 0,
      grossProfit: SafeParse.toDouble(json['gross_profit']) ?? 0,
      totalExpenses: SafeParse.toDouble(json['total_expenses']) ?? 0,
      netProfit: SafeParse.toDouble(json['net_profit']) ?? 0,
    );
  }
}