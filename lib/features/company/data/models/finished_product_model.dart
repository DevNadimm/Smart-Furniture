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
  final String? category;
  final String? quantity;
  final String? unit;

  FinishedProductData({
    this.productId,
    this.productName,
    this.category,
    this.quantity,
    this.unit,
  });

  factory FinishedProductData.fromJson(Map<String, dynamic> json) {
    return FinishedProductData(
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
