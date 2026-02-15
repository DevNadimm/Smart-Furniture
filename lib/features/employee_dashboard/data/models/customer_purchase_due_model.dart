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
      success: json['success'],
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
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      totalDue: json['total_due'],
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
      id: json['id'],
      saleNo: json['sale_no'],
      saleDate: json['sale_date'],
      saleDateFormatted: json['sale_date_formatted'],
      grandTotal: json['grand_total'],
      paidAmount: json['paid_amount'],
      dueAmount: json['due_amount'],
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
