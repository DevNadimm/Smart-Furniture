class CustomerModel {
  final bool? success;
  final List<CustomerData>? data;

  CustomerModel({
    this.success,
    this.data,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      success: json['success'],
      data: json['data'] != null
          ? (json['data'] as List).map((e) => CustomerData.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomerData {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? email;
  final String? phone;
  final String? address;
  final String? branchId;
  final dynamic branch;

  CustomerData({
    this.id,
    this.name,
    this.nameBn,
    this.email,
    this.phone,
    this.address,
    this.branchId,
    this.branch,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      branchId: json['branch_id'],
      branch: json['branch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_bn': nameBn,
      'email': email,
      'phone': phone,
      'address': address,
      'branch_id': branchId,
      'branch': branch,
    };
  }
}
