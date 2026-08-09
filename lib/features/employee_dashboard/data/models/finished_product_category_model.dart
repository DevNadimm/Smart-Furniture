import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class FinishedProductCategoryModel {
  final bool? success;
  final List<FinishedProductCategoryData>? data;

  FinishedProductCategoryModel({
    this.success,
    this.data,
  });

  factory FinishedProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductCategoryModel(
      success: SafeParse.toBool(json['success']),
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => FinishedProductCategoryData.fromJson(e))
              .toList()
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

class FinishedProductCategoryData {
  final int? id;
  final String? categoryName;
  final String? nameBn;
  final String? type;
  final int? companyId;
  final int? branchId;
  final String? createdByType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FinishedProductCategoryData({
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

  factory FinishedProductCategoryData.fromJson(Map<String, dynamic> json) {
    return FinishedProductCategoryData(
      id: SafeParse.toInt(json['id']),
      categoryName: SafeParse.toStringValue(json['category_name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      type: SafeParse.toStringValue(json['type']),
      companyId: SafeParse.toInt(json['company_id']),
      branchId: SafeParse.toInt(json['branch_id']),
      createdByType: SafeParse.toStringValue(json['created_by_type']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
