class SupplierListModel {
  final bool? success;
  final List<SupplierData>? data;

  SupplierListModel({this.success, this.data});

  factory SupplierListModel.fromJson(Map<String, dynamic> json) {
    return SupplierListModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => SupplierData.fromJson(item))
          .toList(),
    );
  }
}

class SupplierData {
  final int? id;
  final String? supplierId;
  final String? supplierName;
  final String? contactPerson;
  final String? address;
  final String? contactNumber;
  final String? email;
  final String? image;
  final String? previousDue;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  SupplierData({
    this.id,
    this.supplierId,
    this.supplierName,
    this.contactPerson,
    this.address,
    this.contactNumber,
    this.email,
    this.image,
    this.previousDue,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory SupplierData.fromJson(Map<String, dynamic> json) {
    return SupplierData(
      id: json['id'] as int?,
      supplierId: json['supplier_id']?.toString(),
      supplierName: json['supplier_name'] as String?,
      contactPerson: json['contact_person'] as String?,
      address: json['address'] as String?,
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      previousDue: json['previous_due']?.toString(),
      branchId: json['branch_id']?.toString(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
