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
          json['data'].map((item) => ProductData.fromJson(item)))
          : null,
    );
  }
}

class ProductData {
  final int? id;
  final String? productId;
  final String? productName;
  final String? productNameBangla;
  final String? productImage;
  final String? brand;
  final Category? category;
  final String? model;
  final String? sku;
  final String? size;
  final String? unit;
  final String? vat;
  final String? reorderLevel;
  final String? purchaseRate;
  final String? salesRate;
  final String? wholesaleRate;
  final String? isService;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  ProductData({
    this.id,
    this.productId,
    this.productName,
    this.productNameBangla,
    this.productImage,
    this.brand,
    this.category,
    this.model,
    this.sku,
    this.size,
    this.unit,
    this.vat,
    this.reorderLevel,
    this.purchaseRate,
    this.salesRate,
    this.wholesaleRate,
    this.isService,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productNameBangla: json['product_name_bangla'],
      productImage: json['product_image'],
      brand: json['brand'],
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      model: json['model'],
      sku: json['sku'],
      size: json['size'],
      unit: json['unit'],
      vat: json['vat'],
      reorderLevel: json['reorder_level'],
      purchaseRate: json['purchase_rate'],
      salesRate: json['sales_rate'],
      wholesaleRate: json['wholesale_rate'],
      isService: json['isService'],
      branchId: json['branch_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Category {
  final int? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
