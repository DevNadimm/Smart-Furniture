class SalesReturnModel {
  final bool? success;
  final List<SalesReturnData>? data;
  final CalculateData? calculateData;

  SalesReturnModel({
    this.success,
    this.data,
    this.calculateData,
  });

  factory SalesReturnModel.fromJson(Map<String, dynamic> json) {
    return SalesReturnModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SalesReturnData.fromJson(e as Map<String, dynamic>))
          .toList(),
      calculateData: json['calculateData'] != null
          ? CalculateData.fromJson(json['calculateData'] as Map<String, dynamic>)
          : null,
    );
  }
}

class SalesReturnData {
  final int? id;
  final String? returnDate;
  final String? customerId;
  final String? employeeId;
  final String? productId;
  final String? userId;
  final String? categoryId;
  final String? previousInvoiceId;
  final String? previousInvoiceNo;
  final String? invoiceNo;
  final String? saleId;
  final String? returnQuantity;
  final String? returnRate;
  final String? returnAmount;
  final String? total;
  final String? salesPrice;
  final String? note;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;
  final Customer? customer;
  final Product? product;

  SalesReturnData({
    this.id,
    this.returnDate,
    this.customerId,
    this.employeeId,
    this.productId,
    this.userId,
    this.categoryId,
    this.previousInvoiceId,
    this.previousInvoiceNo,
    this.invoiceNo,
    this.saleId,
    this.returnQuantity,
    this.returnRate,
    this.returnAmount,
    this.total,
    this.salesPrice,
    this.note,
    this.branchId,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.product,
  });

  factory SalesReturnData.fromJson(Map<String, dynamic> json) {
    return SalesReturnData(
      id: json['id'] as int?,
      returnDate: json['return_date'] as String?,
      customerId: json['customer_id'] as String?,
      employeeId: json['employee_id'] as String?,
      productId: json['product_id'] as String?,
      userId: json['user_id'] as String?,
      categoryId: json['category_id'] as String?,
      previousInvoiceId: json['previous_invoice_id'] as String?,
      previousInvoiceNo: json['previous_invoice_no'] as String?,
      invoiceNo: json['invoice_no'] as String?,
      saleId: json['sale_id'] as String?,
      returnQuantity: json['return_quantity'] as String?,
      returnRate: json['return_rate'] as String?,
      returnAmount: json['return_amount'] as String?,
      total: json['total'] as String?,
      salesPrice: json['sales_price'] as String?,
      note: json['note'] as String?,
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      customer: json['customer'] != null
          ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
          : null,
      product: json['product'] != null
          ? Product.fromJson(json['product'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Customer {
  final int? id;
  final String? customerName;

  Customer({
    this.id,
    this.customerName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int?,
      customerName: json['customer_name'] as String?,
    );
  }
}

class Product {
  final int? id;
  final String? productName;

  Product({
    this.id,
    this.productName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      productName: json['product_name'] as String?,
    );
  }
}

class CalculateData {
  final int? returnQuantity;
  final int? returnAmount;

  CalculateData({
    this.returnQuantity,
    this.returnAmount,
  });

  factory CalculateData.fromJson(Map<String, dynamic> json) {
    return CalculateData(
      returnQuantity: json['return_quantity'] as int?,
      returnAmount: json['return_amount'] as int?,
    );
  }
}
