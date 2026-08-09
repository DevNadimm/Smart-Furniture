import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

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
      success: SafeParse.toBool(json['success']),
      data: json['data'] != null
          ? List<SupplierDueData>.from(
        json['data'].map((x) => SupplierDueData.fromJson(x)),
      )
          : null,
      totalDues: SafeParse.toDouble(json['total_dues']),
      totalSuppliers: SafeParse.toInt(json['total_suppliers']),
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
      id: SafeParse.toInt(json['id']),
      name: SafeParse.toStringValue(json['name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      phone: SafeParse.toStringValue(json['phone']),
      email: SafeParse.toStringValue(json['email']),
      address: SafeParse.toStringValue(json['address']),
      totalPurchases: SafeParse.toDouble(json['total_purchases']),
      totalPaid: SafeParse.toDouble(json['total_paid']),
      due: SafeParse.toDouble(json['due']),
      duePurchaseCount: SafeParse.toInt(json['due_purchase_count']),
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
