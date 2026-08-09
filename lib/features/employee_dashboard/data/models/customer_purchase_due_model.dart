import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class CustomerPurchaseDueModel {
  final bool? success;
  final CustomerInfo? customer;
  final List<CustomerSaleData>? sales;

  CustomerPurchaseDueModel({
    this.success,
    this.customer,
    this.sales,
  });

  factory CustomerPurchaseDueModel.fromJson(Map<String, dynamic> json) {
    return CustomerPurchaseDueModel(
      success: SafeParse.toBool(json['success']),
      customer: json['customer'] != null
          ? CustomerInfo.fromJson(json['customer'])
          : null,
      sales: json['sales'] != null
          ? List<CustomerSaleData>.from(
        json['sales'].map((x) => CustomerSaleData.fromJson(x)),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'customer': customer?.toJson(),
      'sales': sales?.map((x) => x.toJson()).toList(),
    };
  }
}

class CustomerInfo {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final String? address;
  final int? totalDue;

  CustomerInfo({
    this.id,
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.address,
    this.totalDue,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      id: SafeParse.toInt(json['id']),
      name: SafeParse.toStringValue(json['name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      phone: SafeParse.toStringValue(json['phone']),
      email: SafeParse.toStringValue(json['email']),
      address: SafeParse.toStringValue(json['address']),
      totalDue: SafeParse.toInt(json['total_due']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_bn': nameBn,
      'phone': phone,
      'email': email,
      'address': address,
      'total_due': totalDue,
    };
  }
}

class CustomerSaleData {
  final int? id;
  final String? saleNo;
  final String? saleDate;
  final String? saleDateFormatted;
  final int? grandTotal;
  final int? paidAmount;
  final int? dueAmount;

  CustomerSaleData({
    this.id,
    this.saleNo,
    this.saleDate,
    this.saleDateFormatted,
    this.grandTotal,
    this.paidAmount,
    this.dueAmount,
  });

  factory CustomerSaleData.fromJson(Map<String, dynamic> json) {
    return CustomerSaleData(
      id: SafeParse.toInt(json['id']),
      saleNo: SafeParse.toStringValue(json['sale_no']),
      saleDate: SafeParse.toStringValue(json['sale_date']),
      saleDateFormatted: SafeParse.toStringValue(json['sale_date_formatted']),
      grandTotal: SafeParse.toInt(json['grand_total']),
      paidAmount: SafeParse.toInt(json['paid_amount']),
      dueAmount: SafeParse.toInt(json['due_amount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sale_no': saleNo,
      'sale_date': saleDate,
      'sale_date_formatted': saleDateFormatted,
      'grand_total': grandTotal,
      'paid_amount': paidAmount,
      'due_amount': dueAmount,
    };
  }
}
