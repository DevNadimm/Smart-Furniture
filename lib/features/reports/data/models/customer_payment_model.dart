class CustomerPaymentModel {
  final bool? success;
  final Customer? customer;
  final Summary? summary;

  CustomerPaymentModel({
    this.success,
    this.customer,
    this.summary,
  });

  factory CustomerPaymentModel.fromJson(Map<String, dynamic> json) {
    return CustomerPaymentModel(
      success: json['success'],
      customer:
      json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      summary:
      json['summary'] != null ? Summary.fromJson(json['summary']) : null,
    );
  }
}

class Customer {
  final int? id;
  final String? customerId;
  final String? customerName;
  final String? customerNameBangla;
  final String? customerType;
  final String? contactPerson;
  final String? address;
  final String? area;
  final String? dob;
  final String? marriage;
  final String? mobile;
  final String? officePhone;
  final String? image;
  final String? previousDue;
  final String? creditLimit;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  Customer({
    this.id,
    this.customerId,
    this.customerName,
    this.customerNameBangla,
    this.customerType,
    this.contactPerson,
    this.address,
    this.area,
    this.dob,
    this.marriage,
    this.mobile,
    this.officePhone,
    this.image,
    this.previousDue,
    this.creditLimit,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      customerNameBangla: json['customer_name_bangla'],
      customerType: json['customer_type'],
      contactPerson: json['contact_person'],
      address: json['address'],
      area: json['area'],
      dob: json['dob'],
      marriage: json['marriage'],
      mobile: json['mobile'],
      officePhone: json['office_phone'],
      image: json['image'],
      previousDue: json['previous_due'],
      creditLimit: json['credit_limit'],
      branchId: json['branch_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Summary {
  final int? subTotal;
  final int? totalVat;
  final int? totalDiscount;
  final int? totalTransportCost;
  final int? totalAmount;
  final int? totalPaid;
  final int? totalDue;

  Summary({
    this.subTotal,
    this.totalVat,
    this.totalDiscount,
    this.totalTransportCost,
    this.totalAmount,
    this.totalPaid,
    this.totalDue,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      subTotal: json['sub_total'],
      totalVat: json['total_vat'],
      totalDiscount: json['total_discount'],
      totalTransportCost: json['total_transport_cost'],
      totalAmount: json['total_amount'],
      totalPaid: json['total_paid'],
      totalDue: json['total_due'],
    );
  }
}
