import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class BranchModel {
  final bool? success;
  final List<BranchData>? branches;

  BranchModel({
    this.success,
    this.branches,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      success: SafeParse.toBool(json['success']),
      branches: json['branches'] != null
          ? List<BranchData>.from(
              json['branches'].map((x) => BranchData.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'branches': branches?.map((x) => x.toJson()).toList(),
    };
  }
}

class BranchData {
  final int? id;
  final String? name;
  final String? email;
  final String? contactNumber;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final String? area;
  final String? address;

  BranchData({
    this.id,
    this.name,
    this.email,
    this.contactNumber,
    this.contactPersonName,
    this.contactPersonNumber,
    this.area,
    this.address,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) {
    return BranchData(
      id: SafeParse.toInt(json['id']),
      name: SafeParse.toStringValue(json['name']),
      email: SafeParse.toStringValue(json['email']),
      contactNumber: SafeParse.toStringValue(json['contact_number']),
      contactPersonName: SafeParse.toStringValue(json['contact_person_name']),
      contactPersonNumber: SafeParse.toStringValue(json['contact_person_number']),
      area: SafeParse.toStringValue(json['area']),
      address: SafeParse.toStringValue(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact_number': contactNumber,
      'contact_person_name': contactPersonName,
      'contact_person_number': contactPersonNumber,
      'area': area,
      'address': address,
    };
  }
}
