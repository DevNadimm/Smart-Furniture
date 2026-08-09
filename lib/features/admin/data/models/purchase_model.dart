import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class PurchaseModel {
  final bool? success;
  final List<PurchaseData>? purchases;
  final PurchaseSummary? summary;

  PurchaseModel({
    this.success,
    this.purchases,
    this.summary,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      success: SafeParse.toBool(json['success']),
      purchases: (json['purchases'] as List?)
          ?.map((x) => PurchaseData.fromJson(x as Map<String, dynamic>))
          .toList(),
      summary: json['summary'] != null
          ? PurchaseSummary.fromJson(json['summary'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'purchases': purchases?.map((x) => x.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class PurchaseData {
  final int? id;
  final String? purchaseDate;
  final String? purchaseNo;
  final String? supplierName;
  final String? supplierNameBn; // added
  final double? grandTotal;
  final double? paidAmount;
  final double? dueAmount;
  final String? status;

  PurchaseData({
    this.id,
    this.purchaseDate,
    this.purchaseNo,
    this.supplierName,
    this.supplierNameBn, // added
    this.grandTotal,
    this.paidAmount,
    this.dueAmount,
    this.status,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) {
    return PurchaseData(
      id: SafeParse.toInt(json['id']),
      purchaseDate: SafeParse.toStringValue(json['purchase_date']),
      purchaseNo: SafeParse.toStringValue(json['purchase_no']),
      supplierName: SafeParse.toStringValue(json['supplier_name']),
      supplierNameBn: SafeParse.toStringValue(json['supplier_name_bn']), // nullable
      grandTotal: SafeParse.toDouble(json['grand_total']),
      paidAmount: SafeParse.toDouble(json['paid_amount']),
      dueAmount: SafeParse.toDouble(json['due_amount']),
      status: SafeParse.toStringValue(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'purchase_date': purchaseDate,
      'purchase_no': purchaseNo,
      'supplier_name': supplierName,
      'supplier_name_bn': supplierNameBn, // added
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
      'status': status,
    };
  }
}

class PurchaseSummary {
  final double? totalQuantity;
  final double? totalAmount;
  final int? totalPurchases;

  PurchaseSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalPurchases,
  });

  factory PurchaseSummary.fromJson(Map<String, dynamic> json) {
    return PurchaseSummary(
      totalQuantity: SafeParse.toDouble(json['total_quantity']),
      totalAmount: SafeParse.toDouble(json['total_amount']),
      totalPurchases: SafeParse.toInt(json['total_purchases']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'total_purchases': totalPurchases,
    };
  }
}
