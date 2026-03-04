class RawMaterialCategoryModel {
  final bool? success;
  final List<RawMaterialCategoryData>? data;

  RawMaterialCategoryModel({
    this.success,
    this.data,
  });

  factory RawMaterialCategoryModel.fromJson(Map<String, dynamic> json) {
    return RawMaterialCategoryModel(
      success: json['success'],
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
      id: json['id'],
      categoryName: json['category_name'],
      nameBn: json['name_bn'],
      type: json['type'],
      companyId: json['company_id'],
      branchId: json['branch_id'],
      createdByType: json['created_by_type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
