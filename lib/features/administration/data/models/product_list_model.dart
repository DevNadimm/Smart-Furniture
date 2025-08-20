class ProductListModel {
  final bool? success;
  final List<ProductData>? data;

  ProductListModel({
    this.success,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? List<ProductData>.from(
          (json['data'] as List<dynamic>)
              .map((item) => ProductData.fromJson(item)))
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
  final Brand? brand;
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
      id: json['id'] as int?,
      productId: json['product_id'] as String?,
      productName: json['product_name'] as String?,
      productNameBangla: json['product_name_bangla'] as String?,
      productImage: json['product_image'] as String?,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      model: json['model'] as String?,
      sku: json['sku'] as String?,
      size: json['size'] as String?,
      unit: json['unit'] as String?,
      vat: json['vat'] as String?,
      reorderLevel: json['reorder_level'] as String?,
      purchaseRate: json['purchase_rate'] as String?,
      salesRate: json['sales_rate'] as String?,
      wholesaleRate: json['wholesale_rate'] as String?,
      isService: json['isService'] as String?,
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class Brand {
  final int? id;
  final String? name;
  final String? nameBangla;

  Brand({
    this.id,
    this.name,
    this.nameBangla,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] as int?,
      name: json['name'] as String?,
      nameBangla: json['name_bangla'] as String?,
    );
  }
}

class Category {
  final int? id;
  final String? name;
  final String? nameBangla;

  Category({
    this.id,
    this.name,
    this.nameBangla,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      nameBangla: json['name_bangla'] as String?,
    );
  }
}
