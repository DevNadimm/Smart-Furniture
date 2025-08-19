class PurchaseReturnModel {
  final bool? success;
  final List<ReturnData>? data;
  final CalculateData? calculateData;

  PurchaseReturnModel({this.success, this.data, this.calculateData});

  factory PurchaseReturnModel.fromJson(Map<String, dynamic> json) {
    return PurchaseReturnModel(
      success: json['success'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => ReturnData.fromJson(item))
          .toList(),
      calculateData: json['calculateData'] != null
          ? CalculateData.fromJson(json['calculateData'])
          : null,
    );
  }
}

class ReturnData {
  final int? id;
  final String? returnDate;
  final String? supplierId;
  final String? employeeId;
  final String? productId;
  final String? userId;
  final String? categoryId;
  final String? purchaseId;
  final String? previousInvoiceId;
  final String? previousInvoiceNo;
  final String? invoiceNo;
  final String? returnQuantity;
  final String? returnRate;
  final String? returnAmount;
  final String? total;
  final String? purchasePrice;
  final String? note;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;
  final Product? product;
  final Supplier? supplier;

  ReturnData({
    this.id,
    this.returnDate,
    this.supplierId,
    this.employeeId,
    this.productId,
    this.userId,
    this.categoryId,
    this.purchaseId,
    this.previousInvoiceId,
    this.previousInvoiceNo,
    this.invoiceNo,
    this.returnQuantity,
    this.returnRate,
    this.returnAmount,
    this.total,
    this.purchasePrice,
    this.note,
    this.branchId,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.supplier,
  });

  factory ReturnData.fromJson(Map<String, dynamic> json) {
    return ReturnData(
      id: json['id'],
      returnDate: json['return_date'],
      supplierId: json['supplier_id'],
      employeeId: json['employee_id'],
      productId: json['product_id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      purchaseId: json['purchase_id'],
      previousInvoiceId: json['previous_invoice_id'],
      previousInvoiceNo: json['previous_invoice_no'],
      invoiceNo: json['invoice_no'],
      returnQuantity: json['return_quantity'],
      returnRate: json['return_rate'],
      returnAmount: json['return_amount'],
      total: json['total'],
      purchasePrice: json['purchase_price'],
      note: json['note'],
      branchId: json['branch_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
      supplier: json['supplier'] != null
          ? Supplier.fromJson(json['supplier'])
          : null,
    );
  }
}

class Product {
  final int? id;
  final String? productName;
  final String? productNameBangla;

  Product({this.id, this.productName, this.productNameBangla});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['product_name'],
      productNameBangla: json['product_name_bangla'],
    );
  }
}

class Supplier {
  final int? id;
  final String? supplierName;
  final String? supplierNameBangla;

  Supplier({this.id, this.supplierName, this.supplierNameBangla});

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      supplierName: json['supplier_name'],
      supplierNameBangla: json['supplier_name_bangla'],
    );
  }
}

class CalculateData {
  final int? returnQuantity;
  final int? returnAmount;

  CalculateData({this.returnQuantity, this.returnAmount});

  factory CalculateData.fromJson(Map<String, dynamic> json) {
    return CalculateData(
      returnQuantity: json['return_quantity'],
      returnAmount: json['return_amount'],
    );
  }
}
