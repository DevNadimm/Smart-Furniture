class CustomerDuesModel {
  final bool? success;
  final List<CustomerDueData>? data;
  final int? totalDues;
  final int? totalCustomers;

  CustomerDuesModel({
    this.success,
    this.data,
    this.totalDues,
    this.totalCustomers,
  });

  factory CustomerDuesModel.fromJson(Map<String, dynamic> json) {
    return CustomerDuesModel(
      success: json['success'],
      data: json['data'] != null
          ? List<CustomerDueData>.from(
        json['data'].map((x) => CustomerDueData.fromJson(x)),
      )
          : null,
      totalDues: json['total_dues'],
      totalCustomers: json['total_customers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
      'total_dues': totalDues,
      'total_customers': totalCustomers,
    };
  }
}

class CustomerDueData {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final String? address;
  final int? totalSales;
  final int? totalPaid;
  final int? due;
  final int? dueSaleCount;

  CustomerDueData({
    this.id,
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.address,
    this.totalSales,
    this.totalPaid,
    this.due,
    this.dueSaleCount,
  });

  factory CustomerDueData.fromJson(Map<String, dynamic> json) {
    return CustomerDueData(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      totalSales: json['total_sales'],
      totalPaid: json['total_paid'],
      due: json['due'],
      dueSaleCount: json['due_sale_count'],
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
      'total_sales': totalSales,
      'total_paid': totalPaid,
      'due': due,
      'due_sale_count': dueSaleCount,
    };
  }
}
