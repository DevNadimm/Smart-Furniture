import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class FinishedProductModel {
  final bool? success;
  final List<FinishedProductData>? data;
  final FinishedProductSummary? summary;

  FinishedProductModel({
    this.success,
    this.data,
    this.summary,
  });

  factory FinishedProductModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductModel(
      success: json['success'] as bool?,
      data: (json['data'] as List?)
          ?.map((e) => FinishedProductData.fromJson(e))
          .toList(),
      summary: json['summary'] != null
          ? FinishedProductSummary.fromJson(json['summary'])
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

class FinishedProductData {
  final int? productId;
  final String? productName;
  final String? productNameBn;
  final String? category;
  final String? categoryNameBn;
  final String? quantity;
  final String? unit;
  final String? rate;
  final String? image;
  final String? fullImageUrl;
  final List<String>? imageUrls;

  String? get primaryImage =>
      imageUrls?.isNotEmpty == true ? imageUrls!.first : (fullImageUrl ?? image);

  FinishedProductData({
    this.productId,
    this.productName,
    this.productNameBn,
    this.category,
    this.categoryNameBn,
    this.quantity,
    this.unit,
    this.rate,
    this.image,
    this.fullImageUrl,
    this.imageUrls,
  });

  factory FinishedProductData.fromJson(Map<String, dynamic> json) {
    return FinishedProductData(
      productId: SafeParse.toInt(json['product_id']),
      productName: SafeParse.toStringValue(json['product_name']),
      productNameBn: SafeParse.toStringValue(json['product_name_bn']),
      category: SafeParse.toStringValue(json['category']),
      categoryNameBn: SafeParse.toStringValue(json['category_name_bn']),
      quantity: SafeParse.toStringValue(json['quantity']),
      unit: SafeParse.toStringValue(json['unit']),
      rate: SafeParse.toStringValue(json['rate']),
      image: SafeParse.toStringValue(json['image']),
      fullImageUrl: SafeParse.toStringValue(json['full_image_url']),
      imageUrls: SafeParse.asStringList(json['image_urls']),
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
      'image': image,
      'full_image_url': fullImageUrl,
      'image_urls': imageUrls,
    };
  }
}

class FinishedProductSummary {
  final int? totalQuantity;
  final int? totalAmount;
  final int? totalProducts;

  FinishedProductSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalProducts,
  });

  factory FinishedProductSummary.fromJson(Map<String, dynamic> json) {
    return FinishedProductSummary(
      totalQuantity: json['total_quantity'] as int?,
      totalAmount: json['total_amount'] as int?,
      totalProducts: json['total_products'] as int?,
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
