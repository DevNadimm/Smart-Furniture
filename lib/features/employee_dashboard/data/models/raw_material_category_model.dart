import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class RawMaterialCategoryModel {
  final bool? success;
  final List<RawMaterialCategoryData>? data;

  RawMaterialCategoryModel({
    this.success,
    this.data,
  });

  factory RawMaterialCategoryModel.fromJson(Map<String, dynamic> json) {
    return RawMaterialCategoryModel(
      success: SafeParse.toBool(json['success']),
      data: json['data'] != null
          ? List<RawMaterialCategoryData>.from(
        json['data'].map(
              (x) => RawMaterialCategoryData.fromJson(x),
        ),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class RawMaterialCategoryData {
  final int? id;
  final String? categoryName;
  final String? nameBn;
  final String? type;
  final String? companyId;
  final String? branchId;
  final String? createdByType;
  final String? createdAt;
  final String? updatedAt;

  RawMaterialCategoryData({
    this.id,
    this.categoryName,
    this.nameBn,
    this.type,
    this.companyId,
    this.branchId,
    this.createdByType,
    this.createdAt,
    this.updatedAt,
  });

  factory RawMaterialCategoryData.fromJson(Map<String, dynamic> json) {
    return RawMaterialCategoryData(
      id: SafeParse.toInt(json['id']),
      categoryName: SafeParse.toStringValue(json['category_name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      type: SafeParse.toStringValue(json['type']),
      companyId: SafeParse.toStringValue(json['company_id']),
      branchId: SafeParse.toStringValue(json['branch_id']),
      createdByType: SafeParse.toStringValue(json['created_by_type']),
      createdAt: SafeParse.toStringValue(json['created_at']),
      updatedAt: SafeParse.toStringValue(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'name_bn': nameBn,
      'type': type,
      'company_id': companyId,
      'branch_id': branchId,
      'created_by_type': createdByType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
