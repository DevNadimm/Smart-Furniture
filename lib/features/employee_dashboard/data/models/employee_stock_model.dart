class EmployeeStockModel {
  final bool? success;
  final List<StockItem>? data;

  EmployeeStockModel({
    this.success,
    this.data,
  });

  factory EmployeeStockModel.fromJson(Map<String, dynamic> json) {
    return EmployeeStockModel(
      success: json['success'] as bool?,
      data: (json['data'] as List?)
          ?.map((e) => StockItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class StockItem {
  final int? productId;
  final String? productName;
  final String? productNameBn;     // ✅ NEW
  final String? category;
  final String? categoryNameBn;    // ✅ NEW
  final String? quantity;
  final String? unit;

  StockItem({
    this.productId,
    this.productName,
    this.productNameBn,
    this.category,
    this.categoryNameBn,
    this.quantity,
    this.unit,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
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
