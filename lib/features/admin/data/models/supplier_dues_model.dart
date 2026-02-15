class SupplierDuesModel {
  final bool? success;
  final List<SupplierDueData>? data;
  final double? totalDues;
  final int? totalSuppliers;

  SupplierDuesModel({
    this.success,
    this.data,
    this.totalDues,
    this.totalSuppliers,
  });

  factory SupplierDuesModel.fromJson(Map<String, dynamic> json) {
    return SupplierDuesModel(
      success: json['success'],
      data: json['data'] != null
          ? List<SupplierDueData>.from(
        json['data'].map((x) => SupplierDueData.fromJson(x)),
      )
          : null,
      totalDues: (json['total_dues'] as num?)?.toDouble(),
      totalSuppliers: json['total_suppliers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
      'total_dues': totalDues,
      'total_suppliers': totalSuppliers,
    };
  }
}

class SupplierDueData {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final String? address;
  final double? totalPurchases;
  final double? totalPaid;
  final double? due;
  final int? duePurchaseCount;

  SupplierDueData({
    this.id,
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.address,
    this.totalPurchases,
    this.totalPaid,
    this.due,
    this.duePurchaseCount,
  });

  factory SupplierDueData.fromJson(Map<String, dynamic> json) {
    return SupplierDueData(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      totalPurchases: (json['total_purchases'] as num?)?.toDouble(),
      totalPaid: (json['total_paid'] as num?)?.toDouble(),
      due: (json['due'] as num?)?.toDouble(),
      duePurchaseCount: json['due_purchase_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_bn': nameBn,
      'phone': phone,
      'email': email,
      'address': address,
      'total_purchases': totalPurchases,
      'total_paid': totalPaid,
      'due': due,
      'due_purchase_count': duePurchaseCount,
    };
  }
}
