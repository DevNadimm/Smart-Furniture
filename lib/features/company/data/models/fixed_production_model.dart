class FixedProductionModel {
  final bool? success;
  final List<FixedProductionData>? data;
  final FixedProductionSummary? summary;

  FixedProductionModel({
    this.success,
    this.data,
    this.summary,
  });

  factory FixedProductionModel.fromJson(Map<String, dynamic> json) {
    return FixedProductionModel(
      success: json['success'],
      data: json['data'] != null
          ? List<FixedProductionData>.from(
        json['data'].map(
              (x) => FixedProductionData.fromJson(x),
        ),
      )
          : null,
      summary: json['summary'] != null
          ? FixedProductionSummary.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class FixedProductionData {
  final int? id;
  final String? bomNumber;
  final String? recipeNumber;
  final String? recipeVersion;
  final String? productName;
  final String? productNameBn;
  final String? productUnit;
  final num? quantity;
  final num? materialsCount;
  final num? totalMaterialCost;
  final String? createdAt;

  FixedProductionData({
    this.id,
    this.bomNumber,
    this.recipeNumber,
    this.recipeVersion,
    this.productName,
    this.productNameBn,
    this.productUnit,
    this.quantity,
    this.materialsCount,
    this.totalMaterialCost,
    this.createdAt,
  });

  factory FixedProductionData.fromJson(Map<String, dynamic> json) {
    return FixedProductionData(
      id: json['id'],
      bomNumber: json['bom_number'],
      recipeNumber: json['recipe_number'],
      recipeVersion: json['recipe_version'],
      productName: json['product_name'],
      productNameBn: json['product_name_bn'],
      productUnit: json['product_unit'],
      quantity: json['quantity'],
      materialsCount: json['materials_count'],
      totalMaterialCost: json['total_material_cost'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bom_number': bomNumber,
      'recipe_number': recipeNumber,
      'recipe_version': recipeVersion,
      'product_name': productName,
      'product_name_bn': productNameBn,
      'product_unit': productUnit,
      'quantity': quantity,
      'materials_count': materialsCount,
      'total_material_cost': totalMaterialCost,
      'created_at': createdAt,
    };
  }
}

class FixedProductionSummary {
  final num? totalBoms;
  final num? totalQuantity;
  final num? totalMaterialCost;
  final num? totalMaterialsUsed;

  FixedProductionSummary({
    this.totalBoms,
    this.totalQuantity,
    this.totalMaterialCost,
    this.totalMaterialsUsed,
  });

  factory FixedProductionSummary.fromJson(Map<String, dynamic> json) {
    return FixedProductionSummary(
      totalBoms: json['total_boms'],
      totalQuantity: json['total_quantity'],
      totalMaterialCost: json['total_material_cost'],
      totalMaterialsUsed: json['total_materials_used'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_boms': totalBoms,
      'total_quantity': totalQuantity,
      'total_material_cost': totalMaterialCost,
      'total_materials_used': totalMaterialsUsed,
    };
  }
}