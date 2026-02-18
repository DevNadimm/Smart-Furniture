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
      success: json['success'] as bool?,
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
      id: json['id'] as int?,
      purchaseDate: json['purchase_date'] as String?,
      purchaseNo: json['purchase_no'] as String?,
      supplierName: json['supplier_name'] as String?,
      supplierNameBn: json['supplier_name_bn'] as String?, // nullable
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      dueAmount: (json['due_amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
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
      totalQuantity: (json['total_quantity'] as num?)?.toDouble(),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      totalPurchases: json['total_purchases'] as int?,
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
