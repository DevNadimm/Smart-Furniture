class CompanyRawMaterialModel {
  final bool? success;
  final List<RawMaterialData>? data;
  final RawMaterialSummary? summary;

  CompanyRawMaterialModel({
    this.success,
    this.data,
    this.summary,
  });

  factory CompanyRawMaterialModel.fromJson(Map<String, dynamic> json) {
    return CompanyRawMaterialModel(
      success: json['success'],
      data: json['data'] != null
          ? List<RawMaterialData>.from(
        json['data'].map((x) => RawMaterialData.fromJson(x)),
      )
          : null,
      summary: json['summary'] != null
          ? RawMaterialSummary.fromJson(json['summary'])
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

class RawMaterialData {
  final int? productId;
  final String? productName;
  final String? productNameBn;
  final String? category;
  final String? categoryNameBn;
  final String? quantity;
  final String? unit;
  final String? rate;

  RawMaterialData({
    this.productId,
    this.productName,
    this.productNameBn,
    this.category,
    this.categoryNameBn,
    this.quantity,
    this.unit,
    this.rate,
  });

  factory RawMaterialData.fromJson(Map<String, dynamic> json) {
    return RawMaterialData(
      productId: json['product_id'],
      productName: json['product_name'],
      productNameBn: json['product_name_bn'],
      category: json['category'],
      categoryNameBn: json['category_name_bn'],
      quantity: json['quantity'],
      unit: json['unit'],
      rate: json['rate'],
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
      'rate': rate,
    };
  }
}

class RawMaterialSummary {
  final int? totalQuantity;
  final num? totalAmount;
  final int? totalProducts;

  RawMaterialSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalProducts,
  });

  factory RawMaterialSummary.fromJson(Map<String, dynamic> json) {
    return RawMaterialSummary(
      totalQuantity: json['total_quantity'],
      totalAmount: json['total_amount'],
      totalProducts: json['total_products'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'total_products': totalProducts,
    };
  }
}