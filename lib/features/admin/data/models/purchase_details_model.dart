class PurchaseDetailsModel {
  final bool? success;
  final PurchaseDetailsData? data;

  PurchaseDetailsModel({
    this.success,
    this.data,
  });

  factory PurchaseDetailsModel.fromJson(Map<String, dynamic> json) {
    return PurchaseDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? PurchaseDetailsData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
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
      id: json['id'] as int?,
      purchaseDate: json['purchase_date'] as String?,
      purchaseNo: json['purchase_no'] as String?,
      supplier: json['supplier'] != null
          ? SupplierInfo.fromJson(json['supplier'] as Map<String, dynamic>)
          : null,
      receivedBy: json['received_by'] as String?,
      purchaseDetails: (json['purchase_details'] as List?)
          ?.map((x) => PurchaseItem.fromJson(x as Map<String, dynamic>))
          .toList(),
      summary: json['summary'] != null
          ? PurchaseSummaryDetail.fromJson(json['summary'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'purchase_date': purchaseDate,
      'purchase_no': purchaseNo,
      'supplier': supplier?.toJson(),
      'received_by': receivedBy,
      'purchase_details': purchaseDetails?.map((x) => x.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class SupplierInfo {
  final String? name;
  final String? nameBn; // added
  final String? phone;
  final String? email;
  final String? address;

  SupplierInfo({
    this.name,
    this.nameBn, // added
    this.phone,
    this.email,
    this.address,
  });

  factory SupplierInfo.fromJson(Map<String, dynamic> json) {
    return SupplierInfo(
      name: json['name'] as String?,
      nameBn: json['name_bn'] as String?, // nullable
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'name_bn': nameBn, // added
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}

class PurchaseItem {
  final String? productName;
  final String? productNameBn; // added
  final int? quantity;
  final String? unit;
  final double? unitPrice;
  final double? totalPrice;

  PurchaseItem({
    this.productName,
    this.productNameBn, // added
    this.quantity,
    this.unit,
    this.unitPrice,
    this.totalPrice,
  });

  factory PurchaseItem.fromJson(Map<String, dynamic> json) {
    return PurchaseItem(
      productName: json['product_name'] as String?,
      productNameBn: json['product_name_bn'] as String?, // nullable
      quantity: json['quantity'] as int?,
      unit: json['unit'] as String?,
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      totalPrice: (json['total_price'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'product_name_bn': productNameBn, // added
      'quantity': quantity,
      'unit': unit,
      'unit_price': unitPrice,
      'total_price': totalPrice,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'sub_total': subTotal,
      'discount': discount,
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
    };
  }
}
