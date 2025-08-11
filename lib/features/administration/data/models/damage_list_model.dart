class DamageListModel {
  final bool? success;
  final List<DamageData>? data;

  DamageListModel({this.success, this.data});

  factory DamageListModel.fromJson(Map<String, dynamic> json) {
    return DamageListModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DamageData.fromJson(e as Map<String, dynamic>))
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

class DamageData {
  final int? id;
  final String? code;
  final String? date;
  final String? productId;
  final String? productName;
  final String? categoryId;
  final String? quantity;
  final String? amount;
  final String? description;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;
  final Product? product;

  DamageData({
    this.id,
    this.code,
    this.date,
    this.productId,
    this.productName,
    this.categoryId,
    this.quantity,
    this.amount,
    this.description,
    this.branchId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory DamageData.fromJson(Map<String, dynamic> json) {
    return DamageData(
      id: json['id'] as int?,
      code: json['code'] as String?,
      date: json['date'] as String?,
      productId: json['product_id'] as String?,
      productName: json['product_name'] as String?,
      categoryId: json['category_id'] as String?,
      quantity: json['quantity'] as String?,
      amount: json['amount'] as String?,
      description: json['description'] as String?,
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'date': date,
      'product_id': productId,
      'product_name': productName,
      'category_id': categoryId,
      'quantity': quantity,
      'amount': amount,
      'description': description,
      'branch_id': branchId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product': product?.toJson(),
    };
  }
}

class Product {
  final int? id;
  final String? productId;
  final String? productName;
  final String? productNameBangla;
  final String? productImage;
  final String? brand;
  final String? category;
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

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      productId: json['product_id'] as String?,
      productName: json['product_name'] as String?,
      productNameBangla: json['product_name_bangla'] as String?,
      productImage: json['product_image'] as String?,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_name_bangla': productNameBangla,
      'product_image': productImage,
      'brand': brand,
      'category': category,
      'model': model,
      'sku': sku,
      'size': size,
      'unit': unit,
      'vat': vat,
      'reorder_level': reorderLevel,
      'purchase_rate': purchaseRate,
      'sales_rate': salesRate,
      'wholesale_rate': wholesaleRate,
      'isService': isService,
      'branch_id': branchId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
