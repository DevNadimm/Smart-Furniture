import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class EmployeeSalesModel {
  final bool? success;
  final List<EmployeeSaleData>? data;
  final EmployeeSalesSummary? summary;

  EmployeeSalesModel({
    this.success,
    this.data,
    this.summary,
  });

  factory EmployeeSalesModel.fromJson(Map<String, dynamic> json) {
    return EmployeeSalesModel(
      success: SafeParse.toBool(json['success']),
      data: json['sales'] != null
          ? (json['sales'] as List)
          .map((e) => EmployeeSaleData.fromJson(e))
          .toList()
          : null,
      summary: json['summary'] != null
          ? EmployeeSalesSummary.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'sales': data?.map((e) => e.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class EmployeeSaleData {
  final int? id;
  final String? saleDate;
  final String? saleNo;
  final String? customerName;
  final String? customerNameBn;
  final String? branchName;
  final int? itemCount;
  final double? grandTotal;
  final double? paidAmount;
  final double? dueAmount;
  final String? status;

  EmployeeSaleData({
    this.id,
    this.saleDate,
    this.saleNo,
    this.customerName,
    this.customerNameBn,
    this.branchName,
    this.itemCount,
    this.grandTotal,
    this.paidAmount,
    this.dueAmount,
    this.status,
  });

  factory EmployeeSaleData.fromJson(Map<String, dynamic> json) {
    return EmployeeSaleData(
      id: SafeParse.toInt(json['id']),
      saleDate: SafeParse.toStringValue(json['sale_date']),
      saleNo: SafeParse.toStringValue(json['sale_no']),
      customerName: SafeParse.toStringValue(json['customer_name']),
      customerNameBn: SafeParse.toStringValue(json['customer_name_bn']),
      branchName: SafeParse.toStringValue(json['branch_name']),
      itemCount: SafeParse.toInt(json['item_count']),
      grandTotal: SafeParse.toDouble(json['grand_total']),
      paidAmount: SafeParse.toDouble(json['paid_amount']),
      dueAmount: SafeParse.toDouble(json['due_amount']),
      status: SafeParse.toStringValue(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sale_date': saleDate,
      'sale_no': saleNo,
      'customer_name': customerName,
      'customer_name_bn': customerNameBn,
      'branch_name': branchName,
      'item_count': itemCount,
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
      'status': status,
    };
  }
}

class EmployeeSalesSummary {
  final int? totalQuantity;
  final double? totalAmount;
  final int? totalSales;

  EmployeeSalesSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalSales,
  });

  factory EmployeeSalesSummary.fromJson(Map<String, dynamic> json) {
    return EmployeeSalesSummary(
      totalQuantity: SafeParse.toInt(json['total_quantity']),
      totalAmount: SafeParse.toDouble(json['total_amount']),
      totalSales: SafeParse.toInt(json['total_sales']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'total_sales': totalSales,
    };
  }
}
