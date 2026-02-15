class SupplierModel {
  final bool? success;
  final List<SupplierData>? data;

  SupplierModel({
    this.success,
    this.data,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      success: json['success'],
      data: json['data'] != null
          ? List<SupplierData>.from(
        json['data'].map((x) => SupplierData.fromJson(x)),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class SupplierData {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final String? address;

  SupplierData({
    this.id,
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.address,
  });

  factory SupplierData.fromJson(Map<String, dynamic> json) {
    return SupplierData(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
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
    };
  }
}
