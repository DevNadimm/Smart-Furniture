class SalesDetailsModel {
  final bool? success;
  final SalesDetailsData? data;

  SalesDetailsModel({
    this.success,
    this.data,
  });

  factory SalesDetailsModel.fromJson(Map<String, dynamic> json) {
    return SalesDetailsModel(
      success: json['success'],
      data: json['data'] != null
          ? SalesDetailsData.fromJson(json['data'])
          : null,
    );
  }
}

class SalesDetailsData {
  final int? id;
  final String? saleDate;
  final String? saleNo;
  final Customer? customer;
  final String? branch;
  final String? createdBy;
  final List<SaleDetail>? saleDetails;
  final FinancialSummary? financialSummary;

  SalesDetailsData({
    this.id,
    this.saleDate,
    this.saleNo,
    this.customer,
    this.branch,
    this.createdBy,
    this.saleDetails,
    this.financialSummary,
  });

  factory SalesDetailsData.fromJson(Map<String, dynamic> json) {
    return SalesDetailsData(
      id: json['id'],
      saleDate: json['sale_date'],
      saleNo: json['sale_no'],
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      branch: json['branch'],
      createdBy: json['created_by'],
      saleDetails: (json['sale_details'] as List?)
          ?.map((e) => SaleDetail.fromJson(e))
          .toList(),
      financialSummary: json['financial_summary'] != null
          ? FinancialSummary.fromJson(json['financial_summary'])
          : null,
    );
  }
}

class Customer {
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final String? address;

  Customer({
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      nameBn: json['name_bn'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }
}

class SaleDetail {
  final int? serial;
  final String? productName;
  final String? productNameBn;
  final int? quantity;
  final String? unit;
  final double? unitPrice;
  final double? totalPrice;

  SaleDetail({
    this.serial,
    this.productName,
    this.productNameBn,
    this.quantity,
    this.unit,
    this.unitPrice,
    this.totalPrice,
  });

  factory SaleDetail.fromJson(Map<String, dynamic> json) {
    return SaleDetail(
      serial: json['serial'],
      productName: json['product_name'],
      productNameBn: json['product_name_bn'],
      quantity: json['quantity'],
      unit: json['unit'],
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      totalPrice: (json['total_price'] as num?)?.toDouble(),
    );
  }
}

class FinancialSummary {
  final double? subTotal;
  final double? discount;
  final double? grandTotal;
  final double? paidAmount;
  final double? dueAmount;

  FinancialSummary({
    this.subTotal,
    this.discount,
    this.grandTotal,
    this.paidAmount,
    this.dueAmount,
  });

  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      dueAmount: (json['due_amount'] as num?)?.toDouble(),
    );
  }
}
