import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class CustomerDuesModel {
  final bool? success;
  final List<CustomerDueData>? data;
  final int? totalDues;
  final int? totalCustomers;

  CustomerDuesModel({
    this.success,
    this.data,
    this.totalDues,
    this.totalCustomers,
  });

  factory CustomerDuesModel.fromJson(Map<String, dynamic> json) {
    return CustomerDuesModel(
      success: SafeParse.toBool(json['success']),
      data: json['data'] != null
          ? List<CustomerDueData>.from(
        json['data'].map((x) => CustomerDueData.fromJson(x)),
      )
          : null,
      totalDues: SafeParse.toInt(json['total_dues']),
      totalCustomers: SafeParse.toInt(json['total_customers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
      'total_dues': totalDues,
      'total_customers': totalCustomers,
    };
  }
}

class CustomerDueData {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final String? address;
  final int? totalSales;
  final int? totalPaid;
  final int? due;
  final int? dueSaleCount;

  CustomerDueData({
    this.id,
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.address,
    this.totalSales,
    this.totalPaid,
    this.due,
    this.dueSaleCount,
  });

  factory CustomerDueData.fromJson(Map<String, dynamic> json) {
    return CustomerDueData(
      id: SafeParse.toInt(json['id']),
      name: SafeParse.toStringValue(json['name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      phone: SafeParse.toStringValue(json['phone']),
      email: SafeParse.toStringValue(json['email']),
      address: SafeParse.toStringValue(json['address']),
      totalSales: SafeParse.toInt(json['total_sales']),
      totalPaid: SafeParse.toInt(json['total_paid']),
      due: SafeParse.toInt(json['due']),
      dueSaleCount: SafeParse.toInt(json['due_sale_count']),
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
      'total_sales': totalSales,
      'total_paid': totalPaid,
      'due': due,
      'due_sale_count': dueSaleCount,
    };
  }
}
