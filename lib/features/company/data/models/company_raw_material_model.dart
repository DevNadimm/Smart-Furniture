import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

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
  final String? image;
  final String? fullImageUrl;
  final List<String>? imageUrls;

  String? get primaryImage =>
      imageUrls?.isNotEmpty == true ? imageUrls!.first : (fullImageUrl ?? image);

  RawMaterialData({
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

  factory RawMaterialData.fromJson(Map<String, dynamic> json) {
    return RawMaterialData(
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