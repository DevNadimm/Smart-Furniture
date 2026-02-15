class PurchaseDetailsModel {
  final bool? success;
  final PurchaseDetailsData? data;

  PurchaseDetailsModel({
    this.success,
    this.data,
  });

  factory PurchaseDetailsModel.fromJson(Map<String, dynamic> json) {
    return PurchaseDetailsModel(
      success: json['success'],
      data: json['data'] != null
          ? PurchaseDetailsData.fromJson(json['data'])
          : null,
    );
  }
}

class PurchaseDetailsData {
  final int? id;
  final String? purchaseDate;
  final String? purchaseNo;
  final SupplierInfo? supplier;
  final String? receivedBy;
  final List<PurchaseItem>? purchaseDetails;
  final PurchaseSummaryDetail? summary;

  PurchaseDetailsData({
    this.id,
    this.purchaseDate,
    this.purchaseNo,
    this.supplier,
    this.receivedBy,
    this.purchaseDetails,
    this.summary,
  });

  factory PurchaseDetailsData.fromJson(Map<String, dynamic> json) {
    return PurchaseDetailsData(
      id: json['id'],
      purchaseDate: json['purchase_date'],
      purchaseNo: json['purchase_no'],
      supplier: json['supplier'] != null
          ? SupplierInfo.fromJson(json['supplier'])
          : null,
      receivedBy: json['received_by'],
      purchaseDetails: json['purchase_details'] != null
          ? List<PurchaseItem>.from(
              json['purchase_details'].map((x) => PurchaseItem.fromJson(x)),
            )
          : null,
      summary: json['summary'] != null
          ? PurchaseSummaryDetail.fromJson(json['summary'])
          : null,
    );
  }
}

class SupplierInfo {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  SupplierInfo({
    this.name,
    this.phone,
    this.email,
    this.address,
  });

  factory SupplierInfo.fromJson(Map<String, dynamic> json) {
    return SupplierInfo(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }
}

class PurchaseItem {
  final String? productName;
  final int? quantity;
  final String? unit;
  final double? unitPrice;
  final double? totalPrice;

  PurchaseItem({
    this.productName,
    this.quantity,
    this.unit,
    this.unitPrice,
    this.totalPrice,
  });

  factory PurchaseItem.fromJson(Map<String, dynamic> json) {
    return PurchaseItem(
      productName: json['product_name'],
      quantity: json['quantity'],
      unit: json['unit'],
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      totalPrice: (json['total_price'] as num?)?.toDouble(),
    );
  }
}

class PurchaseSummaryDetail {
  final double? subTotal;
  final double? discount;
  final double? grandTotal;
  final double? paidAmount;
  final double? dueAmount;

  PurchaseSummaryDetail({
    this.subTotal,
    this.discount,
    this.grandTotal,
    this.paidAmount,
    this.dueAmount,
  });

  factory PurchaseSummaryDetail.fromJson(Map<String, dynamic> json) {
    return PurchaseSummaryDetail(
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      dueAmount: (json['due_amount'] as num?)?.toDouble(),
    );
  }
}
