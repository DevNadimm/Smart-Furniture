import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class SalesDetailsModel {
  final bool? success;
  final SalesDetailsData? data;

  SalesDetailsModel({
    this.success,
    this.data,
  });

  factory SalesDetailsModel.fromJson(Map<String, dynamic> json) {
    return SalesDetailsModel(
      success: SafeParse.toBool(json['success']),
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
      id: SafeParse.toInt(json['id']),
      saleDate: SafeParse.toStringValue(json['sale_date']),
      saleNo: SafeParse.toStringValue(json['sale_no']),
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      branch: SafeParse.toStringValue(json['branch']),
      createdBy: SafeParse.toStringValue(json['created_by']),
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
      name: SafeParse.toStringValue(json['name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      phone: SafeParse.toStringValue(json['phone']),
      email: SafeParse.toStringValue(json['email']),
      address: SafeParse.toStringValue(json['address']),
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
      serial: SafeParse.toInt(json['serial']),
      productName: SafeParse.toStringValue(json['product_name']),
      productNameBn: SafeParse.toStringValue(json['product_name_bn']),
      quantity: SafeParse.toInt(json['quantity']),
      unit: SafeParse.toStringValue(json['unit']),
      unitPrice: SafeParse.toDouble(json['unit_price']),
      totalPrice: SafeParse.toDouble(json['total_price']),
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
      subTotal: SafeParse.toDouble(json['sub_total']),
      discount: SafeParse.toDouble(json['discount']),
      grandTotal: SafeParse.toDouble(json['grand_total']),
      paidAmount: SafeParse.toDouble(json['paid_amount']),
      dueAmount: SafeParse.toDouble(json['due_amount']),
    );
  }
}
