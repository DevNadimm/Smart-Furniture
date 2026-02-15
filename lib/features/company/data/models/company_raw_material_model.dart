class CompanyRawMaterialModel {
  final bool? success;
  final List<RawMaterialData>? data;

  CompanyRawMaterialModel({
    this.success,
    this.data,
  });

  factory CompanyRawMaterialModel.fromJson(Map<String, dynamic> json) {
    return CompanyRawMaterialModel(
      success: json['success'],
      data: json['data'] != null
          ? List<RawMaterialData>.from(
        json['data'].map((x) => RawMaterialData.fromJson(x)),
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

class RawMaterialData {
  final int? productId;
  final String? productName;
  final String? category;
  final String? quantity;
  final String? unit;

  RawMaterialData({
    this.productId,
    this.productName,
    this.category,
    this.quantity,
    this.unit,
  });

  factory RawMaterialData.fromJson(Map<String, dynamic> json) {
    return RawMaterialData(
      productId: json['product_id'],
      productName: json['product_name'],
      category: json['category'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'category': category,
      'quantity': quantity,
      'unit': unit,
    };
  }
}
