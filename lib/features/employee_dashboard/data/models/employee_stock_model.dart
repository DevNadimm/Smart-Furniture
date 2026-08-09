import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class EmployeeStockModel {
  final bool? success;
  final List<StockItem>? data;
  final StockSummary? summary;

  EmployeeStockModel({
    this.success,
    this.data,
    this.summary,
  });

  factory EmployeeStockModel.fromJson(Map<String, dynamic> json) {
    return EmployeeStockModel(
      success: json['success'] as bool?,
      data: (json['data'] as List?)?.map((e) => StockItem.fromJson(e)).toList(),
      summary: json['summary'] != null
          ? StockSummary.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class StockItem {
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

  StockItem({
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

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
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

class StockSummary {
  final int? totalQuantity;
  final int? totalAmount;
  final int? totalProducts;

  StockSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalProducts,
  });

  factory StockSummary.fromJson(Map<String, dynamic> json) {
    return StockSummary(
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
