class SalesRecordModel {
  final bool? success;
  final List<SalesRecord>? data;
  final CalculateData? calculateData;

  SalesRecordModel({
    this.success,
    this.data,
    this.calculateData,
  });

  factory SalesRecordModel.fromJson(Map<String, dynamic> json) {
    return SalesRecordModel(
      success: json['success'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SalesRecord.fromJson(e))
          .toList(),
      calculateData: json['calculateData'] != null
          ? CalculateData.fromJson(json['calculateData'])
          : null,
    );
  }
}

class CalculateData {
  final int? totalQuantity;
  final num? totalSalesAmount;

  CalculateData({
    this.totalQuantity,
    this.totalSalesAmount,
  });

  factory CalculateData.fromJson(Map<String, dynamic> json) {
    return CalculateData(
      totalQuantity: json['total_quantity'],
      totalSalesAmount: json['total_sales_amount'],
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

  final String? customerName;
  final String? customerContact;
  final String? customerAddress;
  final String? barcode;

  final String? branchId;
  final String? colorId;
  final String? sizeId;
  final String? bankInfo;
  final String? mobileBankingInfo;
  final String? note;

  final DateTime? createdAt;
  final DateTime? updatedAt;

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
    this.customerName,
    this.customerContact,
    this.customerAddress,
    this.barcode,
    this.branchId,
    this.colorId,
    this.sizeId,
    this.bankInfo,
    this.mobileBankingInfo,
    this.note,
    this.createdAt,
    this.updatedAt,
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
      json['sale_date'] != null ? DateTime.tryParse(json['sale_date']) : null,
      customerName: json['customer_name'],
      customerContact: json['customer_contact'],
      customerAddress: json['customer_address'],
      barcode: json['barcode'],
      branchId: json['branch_id'],
      colorId: json['color_id'],
      sizeId: json['size_id'],
      bankInfo: json['bank_info'],
      mobileBankingInfo: json['mobile_banking_info'],
      note: json['note'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      salesProduct: (json['sales_product'] as List<dynamic>?)
          ?.map((e) => SalesProduct.fromJson(e))
          .toList(),
    );
  }
}

class SalesProduct {
  final int? id;
  final DateTime? saleDate;
  final String? productId;
  final String? customerId;
  final String? saleId;
  final String? warehouseId;
  final String? productUnitId;
  final String? invoiceNo;
  final String? productName;
  final String? categoryId;
  final String? quantity;
  final String? total;
  final String? totalAmount;
  final String? barcode;
  final String? purchasePrice;
  final String? salePrice;
  final String? totalDiscount;
  final String? size;
  final String? colorId;
  final String? sizeId;
  final String? capacity;
  final String? manufactureDate;
  final String? expiryDate;
  final String? branchId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final Product? product;
  final Size1? size1;
  final ColorModel? color;
  final Category? category;
  final Customer? customer;

  SalesProduct({
    this.id,
    this.saleDate,
    this.productId,
    this.customerId,
    this.saleId,
    this.warehouseId,
    this.productUnitId,
    this.invoiceNo,
    this.productName,
    this.categoryId,
    this.quantity,
    this.total,
    this.totalAmount,
    this.barcode,
    this.purchasePrice,
    this.salePrice,
    this.totalDiscount,
    this.size,
    this.colorId,
    this.sizeId,
    this.capacity,
    this.manufactureDate,
    this.expiryDate,
    this.branchId,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.size1,
    this.color,
    this.category,
    this.customer,
  });

  factory SalesProduct.fromJson(Map<String, dynamic> json) {
    return SalesProduct(
      id: json['id'],
      saleDate:
      json['sale_date'] != null ? DateTime.tryParse(json['sale_date']) : null,
      productId: json['product_id'],
      customerId: json['customer_id'],
      saleId: json['sale_id'],
      warehouseId: json['warehouse_id'],
      productUnitId: json['product_unit_id'],
      invoiceNo: json['invoice_no'],
      productName: json['product_name'],
      categoryId: json['category_id'],
      quantity: json['quantity'],
      total: json['total'],
      totalAmount: json['total_amount'],
      barcode: json['barcode'],
      purchasePrice: json['purchase_price'],
      salePrice: json['sale_price'],
      totalDiscount: json['total_discount'],
      size: json['size'],
      colorId: json['color_id'],
      sizeId: json['size_id'],
      capacity: json['capacity'],
      manufactureDate: json['manufacture_date'],
      expiryDate: json['expiry_date'],
      branchId: json['branch_id'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      product:
      json['product'] != null ? Product.fromJson(json['product']) : null,
      size1: json['size1'] != null ? Size1.fromJson(json['size1']) : null,
      color: json['color'] != null ? ColorModel.fromJson(json['color']) : null,
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      customer:
      json['customer'] != null ? Customer.fromJson(json['customer']) : null,
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
  final String? customerId;
  final String? customerName;
  final String? customerNameBangla;
  final String? address;
  final String? mobile;

  Customer({
    this.id,
    this.customerId,
    this.customerName,
    this.customerNameBangla,
    this.address,
    this.mobile,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json['id'],
    customerId: json['customer_id'],
    customerName: json['customer_name'],
    customerNameBangla: json['customer_name_bangla'],
    address: json['address'],
    mobile: json['mobile'],
  );
}
