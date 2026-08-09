import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

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
      success: SafeParse.toBool(json['success']),
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
      id: SafeParse.toInt(json['id']),
      bomNumber: SafeParse.toStringValue(json['bom_number']),
      recipeNumber: SafeParse.toStringValue(json['recipe_number']),
      recipeVersion: SafeParse.toStringValue(json['recipe_version']),
      productName: SafeParse.toStringValue(json['product_name']),
      productNameBn: SafeParse.toStringValue(json['product_name_bn']),
      productUnit: SafeParse.toStringValue(json['product_unit']),
      quantity: SafeParse.toNum(json['quantity']),
      materialsCount: SafeParse.toNum(json['materials_count']),
      totalMaterialCost: SafeParse.toNum(json['total_material_cost']),
      createdAt: SafeParse.toStringValue(json['created_at']),
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
      totalBoms: SafeParse.toNum(json['total_boms']),
      totalQuantity: SafeParse.toNum(json['total_quantity']),
      totalMaterialCost: SafeParse.toNum(json['total_material_cost']),
      totalMaterialsUsed: SafeParse.toNum(json['total_materials_used']),
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