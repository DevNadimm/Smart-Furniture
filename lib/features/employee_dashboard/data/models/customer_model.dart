import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class CustomerModel {
  final bool? success;
  final List<CustomerData>? data;

  CustomerModel({
    this.success,
    this.data,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      success: SafeParse.toBool(json['success']),
      data: json['data'] != null
          ? (json['data'] as List).map((e) => CustomerData.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomerData {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? email;
  final String? phone;
  final String? address;
  final String? branchId;
  final dynamic branch;

  CustomerData({
    this.id,
    this.name,
    this.nameBn,
    this.email,
    this.phone,
    this.address,
    this.branchId,
    this.branch,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: SafeParse.toInt(json['id']),
      name: SafeParse.toStringValue(json['name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      email: SafeParse.toStringValue(json['email']),
      phone: SafeParse.toStringValue(json['phone']),
      address: SafeParse.toStringValue(json['address']),
      branchId: SafeParse.toStringValue(json['branch_id']),
      branch: json['branch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_bn': nameBn,
      'email': email,
      'phone': phone,
      'address': address,
      'branch_id': branchId,
      'branch': branch,
    };
  }
}
