class SupplierPurchaseDueModel {
  final bool? success;
  final SupplierDueInfo? supplier;
  final List<SupplierPurchaseDue>? purchases;

  SupplierPurchaseDueModel({
    this.success,
    this.supplier,
    this.purchases,
  });

  factory SupplierPurchaseDueModel.fromJson(Map<String, dynamic> json) {
    return SupplierPurchaseDueModel(
      success: json['success'],
      supplier: json['supplier'] != null
          ? SupplierDueInfo.fromJson(json['supplier'])
          : null,
      purchases: json['purchases'] != null
          ? List<SupplierPurchaseDue>.from(
        json['purchases']
            .map((x) => SupplierPurchaseDue.fromJson(x)),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'supplier': supplier?.toJson(),
      'purchases': purchases?.map((x) => x.toJson()).toList(),
    };
  }
}

class SupplierDueInfo {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final double? totalDue;

  SupplierDueInfo({
    this.id,
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.totalDue,
  });

  factory SupplierDueInfo.fromJson(Map<String, dynamic> json) {
    return SupplierDueInfo(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      phone: json['phone'],
      email: json['email'],
      totalDue: (json['total_due'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_bn': nameBn,
      'phone': phone,
      'email': email,
      'total_due': totalDue,
    };
  }
}

class SupplierPurchaseDue {
  final int? id;
  final String? purchaseNo;
  final String? purchaseDate;
  final String? purchaseDateFormatted;
  final double? grandTotal;
  final double? paidAmount;
  final double? dueAmount;

  SupplierPurchaseDue({
    this.id,
    this.purchaseNo,
    this.purchaseDate,
    this.purchaseDateFormatted,
    this.grandTotal,
    this.paidAmount,
    this.dueAmount,
  });

  factory SupplierPurchaseDue.fromJson(Map<String, dynamic> json) {
    return SupplierPurchaseDue(
      id: json['id'],
      purchaseNo: json['purchase_no'],
      purchaseDate: json['purchase_date'],
      purchaseDateFormatted: json['purchase_date_formatted'],
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      dueAmount: (json['due_amount'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'purchase_no': purchaseNo,
      'purchase_date': purchaseDate,
      'purchase_date_formatted': purchaseDateFormatted,
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
    };
  }
}
