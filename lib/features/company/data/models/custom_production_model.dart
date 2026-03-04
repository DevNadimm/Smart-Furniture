class CustomProductionModel {
  final bool? success;
  final List<CustomProductionData>? data;
  final CustomProductionSummary? summary;

  CustomProductionModel({
    this.success,
    this.data,
    this.summary,
  });

  factory CustomProductionModel.fromJson(Map<String, dynamic> json) {
    return CustomProductionModel(
      success: json['success'],
      data: json['data'] != null
          ? List<CustomProductionData>.from(
        json['data'].map(
              (x) => CustomProductionData.fromJson(x),
        ),
      )
          : null,
      summary: json['summary'] != null
          ? CustomProductionSummary.fromJson(json['summary'])
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

class CustomProductionData {
  final int? id;
  final String? bomNumber;
  final String? productName;
  final String? productNameBn;
  final String? productUnit;
  final num? quantity;
  final num? materialsCount;
  final num? totalMaterialCost;
  final String? createdAt;

  CustomProductionData({
    this.id,
    this.bomNumber,
    this.productName,
    this.productNameBn,
    this.productUnit,
    this.quantity,
    this.materialsCount,
    this.totalMaterialCost,
    this.createdAt,
  });

  factory CustomProductionData.fromJson(Map<String, dynamic> json) {
    return CustomProductionData(
      id: json['id'],
      bomNumber: json['bom_number'],
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

class CustomProductionSummary {
  final num? totalBoms;
  final num? totalQuantity;
  final num? totalMaterialCost;
  final num? totalMaterialsUsed;

  CustomProductionSummary({
    this.totalBoms,
    this.totalQuantity,
    this.totalMaterialCost,
    this.totalMaterialsUsed,
  });

  factory CustomProductionSummary.fromJson(Map<String, dynamic> json) {
    return CustomProductionSummary(
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
