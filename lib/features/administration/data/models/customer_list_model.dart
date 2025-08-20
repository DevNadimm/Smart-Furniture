class CustomerListModel {
  final bool? success;
  final List<CustomerData>? data;

  CustomerListModel({this.success, this.data});

  factory CustomerListModel.fromJson(Map<String, dynamic> json) {
    return CustomerListModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CustomerData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CustomerData {
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

  CustomerData({
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

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'] as int?,
      customerId: json['customer_id'] as String?,
      customerName: json['customer_name'] as String?,
      customerNameBangla: json['customer_name_bangla'] as String?,
      customerType: json['customer_type'] as String?,
      contactPerson: json['contact_person'] as String?,
      address: json['address'] as String?,
      area: json['area'] as String?,
      dob: json['dob'] as String?,
      marriage: json['marriage'] as String?,
      mobile: json['mobile'] as String?,
      officePhone: json['office_phone'] as String?,
      image: json['image'] as String?,
      previousDue: json['previous_due'] as String?,
      creditLimit: json['credit_limit'] as String?,
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
