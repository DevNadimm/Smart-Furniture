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

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
    };
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

  ProductData({
    this.id,
    this.itemDescription,
    this.nameBn,
    this.productSlug,
    this.category,
    this.unit,
    this.rate,
    this.salesRate,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      itemDescription: json['item_description'],
      nameBn: json['name_bn'],
      productSlug: json['product_slug'],
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
      unit: json['unit'] != null
          ? Unit.fromJson(json['unit'])
          : null,
      rate: json['rate'] != null ? num.tryParse(json['rate'].toString()) : null,
      salesRate: json['sales_rate'] != null
          ? num.tryParse(json['sales_rate'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_description': itemDescription,
      'name_bn': nameBn,
      'product_slug': productSlug,
      'category': category?.toJson(),
      'unit': unit?.toJson(),
      'rate': rate,
      'sales_rate': salesRate,
    };
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
