class SalesRecordModel {
  final bool? success;
  final List<SalesRecord>? data;

  SalesRecordModel({this.success, this.data});

  factory SalesRecordModel.fromJson(Map<String, dynamic> json) {
    return SalesRecordModel(
      success: json['success'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => SalesRecord.fromJson(item))
          .toList(),
    );
  }
}

class SalesRecord {
  final int? id;
  final String? customerId;
  final String? employeeId;
  final String? userId;
  final String? invoiceNo;
  final String? saleType;
  final String? totalAmount;
  final String? subTotal;
  final String? totalVat;
  final String? totalVatAmount;
  final String? totalDiscount;
  final String? totalTransport;
  final String? totalPaid;
  final String? totalDue;
  final DateTime? saleDate;
  final String? branchId;
  final List<SalesProduct>? salesProduct;

  SalesRecord({
    this.id,
    this.customerId,
    this.employeeId,
    this.userId,
    this.invoiceNo,
    this.saleType,
    this.totalAmount,
    this.subTotal,
    this.totalVat,
    this.totalVatAmount,
    this.totalDiscount,
    this.totalTransport,
    this.totalPaid,
    this.totalDue,
    this.saleDate,
    this.branchId,
    this.salesProduct,
  });

  factory SalesRecord.fromJson(Map<String, dynamic> json) {
    return SalesRecord(
      id: json['id'],
      customerId: json['customer_id'],
      employeeId: json['employee_id'],
      userId: json['user_id'],
      invoiceNo: json['invoice_no'],
      saleType: json['sale_type'],
      totalAmount: json['total_amount'],
      subTotal: json['sub_total'],
      totalVat: json['total_vat'],
      totalVatAmount: json['total_vat_amount'],
      totalDiscount: json['total_discount'],
      totalTransport: json['total_transport'],
      totalPaid: json['total_paid'],
      totalDue: json['total_due'],
      saleDate:
      json['sale_date'] == null ? null : DateTime.tryParse(json['sale_date']),
      branchId: json['branch_id'],
      salesProduct: (json['sales_product'] as List<dynamic>?)
          ?.map((item) => SalesProduct.fromJson(item))
          .toList(),
    );
  }
}

class SalesProduct {
  final int? id;
  final String? productId;
  final String? customerId;
  final String? saleId;
  final String? invoiceNo;
  final String? productName;
  final String? categoryId;
  final String? quantity;
  final String? total;
  final String? purchasePrice;
  final String? salePrice;
  final Size1? size1;
  final ColorModel? color;
  final Category? category;
  final Customer? customer;
  final Product? product;

  SalesProduct({
    this.id,
    this.productId,
    this.customerId,
    this.saleId,
    this.invoiceNo,
    this.productName,
    this.categoryId,
    this.quantity,
    this.total,
    this.purchasePrice,
    this.salePrice,
    this.size1,
    this.color,
    this.category,
    this.customer,
    this.product,
  });

  factory SalesProduct.fromJson(Map<String, dynamic> json) {
    return SalesProduct(
      id: json['id'],
      productId: json['product_id'],
      customerId: json['customer_id'],
      saleId: json['sale_id'],
      invoiceNo: json['invoice_no'],
      productName: json['product_name'],
      categoryId: json['category_id'],
      quantity: json['quantity'],
      total: json['total'],
      purchasePrice: json['purchase_price'],
      salePrice: json['sale_price'],
      size1: json['size1'] != null ? Size1.fromJson(json['size1']) : null,
      color: json['color'] != null ? ColorModel.fromJson(json['color']) : null,
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      customer:
      json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}

class Product {
  final int? id;
  final String? productName;
  final String? productNameBangla;

  Product({this.id, this.productName, this.productNameBangla});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    productName: json['product_name'],
    productNameBangla: json['product_name_bangla'],
  );
}

class Size1 {
  final int? id;
  final String? sizeName;

  Size1({this.id, this.sizeName});

  factory Size1.fromJson(Map<String, dynamic> json) => Size1(
    id: json['id'],
    sizeName: json['size_name'],
  );
}

class ColorModel {
  final int? id;
  final String? name;

  ColorModel({this.id, this.name});

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
    id: json['id'],
    name: json['name'],
  );
}

class Category {
  final int? id;
  final String? name;
  final String? nameBangla;

  Category({this.id, this.name, this.nameBangla});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'],
    nameBangla: json['name_bangla'],
  );
}

class Customer {
  final int? id;
  final String? customerName;
  final String? customerNameBangla;
  final String? address;
  final String? mobile;

  Customer({
    this.id,
    this.customerName,
    this.customerNameBangla,
    this.address,
    this.mobile,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json['id'],
    customerName: json['customer_name'],
    customerNameBangla: json['customer_name_bangla'],
    address: json['address'],
    mobile: json['mobile'],
  );
}
