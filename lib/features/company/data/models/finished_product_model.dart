class FinishedProductModel {
  final bool? success;
  final List<FinishedProductData>? data;

  FinishedProductModel({
    this.success,
    this.data,
  });

  factory FinishedProductModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductModel(
      success: json['success'],
      data: json['data'] != null
          ? List<FinishedProductData>.from(
        json['data'].map((x) => FinishedProductData.fromJson(x)),
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

class FinishedProductData {
  final int? productId;
  final String? productName;
  final String? productNameBn;     // ✅ NEW
  final String? category;
  final String? categoryNameBn;    // ✅ NEW
  final String? quantity;
  final String? unit;

  FinishedProductData({
    this.productId,
    this.productName,
    this.productNameBn,
    this.category,
    this.categoryNameBn,
    this.quantity,
    this.unit,
  });

  factory FinishedProductData.fromJson(Map<String, dynamic> json) {
    return FinishedProductData(
      productId: json['product_id'] as int?,
      productName: json['product_name'] as String?,
      productNameBn: json['product_name_bn'] as String?,
      category: json['category'] as String?,
      categoryNameBn: json['category_name_bn'] as String?,
      quantity: json['quantity'] as String?,
      unit: json['unit'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'product_name_bn': productNameBn,
      'category': category,
      'category_name_bn': categoryNameBn,
      'quantity': quantity,
      'unit': unit,
    };
  }
}
