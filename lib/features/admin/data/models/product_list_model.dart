import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class ProductListModel {
  final bool? success;
  final List<ProductData>? data;

  ProductListModel({
    this.success,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      success: json['success'],
      data: json['data'] != null
          ? List<ProductData>.from(
          json['data'].map((x) => ProductData.fromJson(x)))
          : null,
    );
  }
}

class ProductData {
  final int? id;
  final String? itemDescription;
  final String? nameBn;
  final String? productSlug;
  final Category? category;
  final Unit? unit;
  final num? rate;
  final num? salesRate;
  final num? transferRate;
  final String? image;
  final String? fullImageUrl;
  final List<String>? imageUrls;

  String? get primaryImage =>
      imageUrls?.isNotEmpty == true ? imageUrls!.first : (fullImageUrl ?? image);

  ProductData({
    this.id,
    this.itemDescription,
    this.nameBn,
    this.productSlug,
    this.category,
    this.unit,
    this.rate,
    this.salesRate,
    this.transferRate,
    this.image,
    this.fullImageUrl,
    this.imageUrls,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: SafeParse.toInt(json['id']),
      itemDescription: SafeParse.toStringValue(json['item_description']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      productSlug: SafeParse.toStringValue(json['product_slug']),
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      unit: json['unit'] != null
          ? Unit.fromJson(json['unit'])
          : null,
      rate: json['rate'] != null ? num.tryParse(json['rate'].toString()) : null,
      salesRate: json['sales_rate'] != null ? num.tryParse(json['sales_rate'].toString()) : null,
      transferRate: json['transfer_rate'] != null ? num.tryParse(json['transfer_rate'].toString()) : null,
      image: SafeParse.toStringValue(json['image']),
      fullImageUrl: SafeParse.toStringValue(json['full_image_url']),
      imageUrls: SafeParse.asStringList(json['image_urls']),
    );
  }
}

class Category {
  final int? id;
  final String? name;
  final String? nameBn;

  Category({
    this.id,
    this.name,
    this.nameBn,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'], // ✅ Added this
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_bn': nameBn,
    };
  }
}

class Unit {
  final int? id;
  final String? name;

  Unit({
    this.id,
    this.name,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
