class FinishedProductCategoryModel {
  final bool? success;
  final List<FinishedProductCategoryData>? data;

  FinishedProductCategoryModel({
    this.success,
    this.data,
  });

  factory FinishedProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductCategoryModel(
      success: json['success'],
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
      id: json['id'],
      categoryName: json['category_name'],
      nameBn: json['name_bn'],
      type: json['type'],
      companyId: int.tryParse(json['company_id'].toString()),
      branchId: int.tryParse(json['branch_id'].toString()),
      createdByType: json['created_by_type'],
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
