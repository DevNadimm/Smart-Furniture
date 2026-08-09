import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class EmployeeSalesDetailsModel {
  final bool? success;
  final EmployeeSalesDetailsData? data;

  EmployeeSalesDetailsModel({
    this.success,
    this.data,
  });

  factory EmployeeSalesDetailsModel.fromJson(Map<String, dynamic> json) {
    return EmployeeSalesDetailsModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? EmployeeSalesDetailsData.fromJson(
              json['data'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class EmployeeSalesDetailsData {
  final bool? isBranchUser;
  final List<EmployeeProduct>? products;
  final List<EmployeeCustomer>? customers;
  final List<EmployeeCategory>? categories;

  EmployeeSalesDetailsData({
    this.isBranchUser,
    this.products,
    this.customers,
    this.categories,
  });

  factory EmployeeSalesDetailsData.fromJson(Map<String, dynamic> json) {
    return EmployeeSalesDetailsData(
      isBranchUser: json['is_branch_user'] as bool?,
      products: (json['products'] as List?)
          ?.map((e) => EmployeeProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      customers: (json['customers'] as List?)
          ?.map((e) => EmployeeCustomer.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List?)
          ?.map((e) => EmployeeCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_branch_user': isBranchUser,
      'products': products?.map((e) => e.toJson()).toList(),
      'customers': customers?.map((e) => e.toJson()).toList(),
      'categories': categories?.map((e) => e.toJson()).toList(),
    };
  }
}

class EmployeeProduct {
  final int? id;
  final String? productName;
  final String? nameBn;
  final String? companyStock;
  final String? purchaseRate;
  final String? wholesaleRate;
  final String? salesRate;
  final String? unitId;
  final String? productCategory;
  final String? image;
  final dynamic branchStock;
  final String? fullImageUrl;
  final List<String>? imageUrls;
  final EmployeeUnit? unit;
  final EmployeeCategory? category;

  String? get primaryImage =>
      imageUrls?.isNotEmpty == true ? imageUrls!.first : (fullImageUrl ?? image);

  EmployeeProduct({
    this.id,
    this.productName,
    this.nameBn,
    this.companyStock,
    this.purchaseRate,
    this.wholesaleRate,
    this.salesRate,
    this.unitId,
    this.productCategory,
    this.image,
    this.branchStock,
    this.fullImageUrl,
    this.imageUrls,
    this.unit,
    this.category,
  });

  factory EmployeeProduct.fromJson(Map<String, dynamic> json) {
    return EmployeeProduct(
      id: SafeParse.toInt(json['id']),
      productName: SafeParse.toStringValue(json['product_name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      companyStock: SafeParse.toStringValue(json['company_stock']),
      purchaseRate: SafeParse.toStringValue(json['purchase_rate']),
      wholesaleRate: SafeParse.toStringValue(json['wholesale_rate']),
      salesRate: SafeParse.toStringValue(json['sales_rate']),
      unitId: SafeParse.toStringValue(json['unit_id']),
      productCategory: SafeParse.toStringValue(json['product_category']),
      image: SafeParse.toStringValue(json['image']),
      branchStock: json['branch_stock'],
      fullImageUrl: SafeParse.toStringValue(json['full_image_url']),
      imageUrls: SafeParse.asStringList(json['image_urls']),
      unit: json['unit'] != null
          ? EmployeeUnit.fromJson(json['unit'] as Map<String, dynamic>)
          : null,
      category: json['category'] != null
          ? EmployeeCategory.fromJson(
              json['category'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'name_bn': nameBn,
      'company_stock': companyStock,
      'purchase_rate': purchaseRate,
      'wholesale_rate': wholesaleRate,
      'sales_rate': salesRate,
      'unit_id': unitId,
      'product_category': productCategory,
      'image': image,
      'branch_stock': branchStock,
      'full_image_url': fullImageUrl,
      'image_urls': imageUrls,
      'unit': unit?.toJson(),
      'category': category?.toJson(),
    };
  }
}

class EmployeeUnit {
  final int? id;
  final String? unitName;

  EmployeeUnit({
    this.id,
    this.unitName,
  });

  factory EmployeeUnit.fromJson(Map<String, dynamic> json) {
    return EmployeeUnit(
      id: json['id'] as int?,
      unitName: json['unit_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_name': unitName,
    };
  }
}

class EmployeeCategory {
  final int? id;
  final String? categoryName;
  final String? nameBn;

  EmployeeCategory({
    this.id,
    this.categoryName,
    this.nameBn,
  });

  factory EmployeeCategory.fromJson(Map<String, dynamic> json) {
    return EmployeeCategory(
      id: json['id'] as int?,
      categoryName: json['category_name'] as String?,
      nameBn: json['name_bn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'name_bn': nameBn,
    };
  }
}

class EmployeeCustomer {
  final int? id;
  final String? customer;
  final String? nameBn;
  final String? phone;
  final String? email;

  EmployeeCustomer({
    this.id,
    this.customer,
    this.nameBn,
    this.phone,
    this.email,
  });

  factory EmployeeCustomer.fromJson(Map<String, dynamic> json) {
    return EmployeeCustomer(
      id: json['id'] as int?,
      customer: json['customer'] as String?,
      nameBn: json['name_bn'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'name_bn': nameBn,
      'phone': phone,
      'email': email,
    };
  }
}
