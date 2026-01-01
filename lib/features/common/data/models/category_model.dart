class CategoryModel {
  final bool? success;
  final List<CategoryData>? data;

  CategoryModel({this.success, this.data});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        success: json['success'] as bool?,
        data: json['data'] != null
            ? List<CategoryData>.from(
                (json['data'] as List).map((x) => CategoryData.fromJson(x)),
              )
            : null,
      );
}

class CategoryData {
  final int? id;
  final String? name;
  final String? nameBangla;
  final String? description;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  CategoryData({
    this.id,
    this.name,
    this.nameBangla,
    this.description,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json['id'] as int?,
        name: json['name'] as String?,
        nameBangla: json['name_bangla'] as String?,
        description: json['description'] as String?,
        branchId: json['branch_id'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );
}
