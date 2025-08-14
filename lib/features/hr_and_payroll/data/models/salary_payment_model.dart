class SalaryPaymentModel {
  final bool? success;
  final List<SalaryPaymentData>? data;

  SalaryPaymentModel({this.success, this.data});

  factory SalaryPaymentModel.fromJson(Map<String, dynamic> json) {
    return SalaryPaymentModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SalaryPaymentData.fromJson(e))
          .toList(),
    );
  }
}

class SalaryPaymentData {
  final int? id;
  final String? branchId;
  final String? empId;
  final String? name;
  final String? date;
  final String? month;
  final String? paymentAmount;
  final String? deductedAmount;
  final String? createdAt;
  final String? updatedAt;
  final Employee? employee;

  SalaryPaymentData({
    this.id,
    this.branchId,
    this.empId,
    this.name,
    this.date,
    this.month,
    this.paymentAmount,
    this.deductedAmount,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  factory SalaryPaymentData.fromJson(Map<String, dynamic> json) {
    return SalaryPaymentData(
      id: json['id'] as int?,
      branchId: json['branch_id'] as String?,
      empId: json['emp_id'] as String?,
      name: json['name'] as String?,
      date: json['date'] as String?,
      month: json['month'] as String?,
      paymentAmount: json['payment_amount'] as String?,
      deductedAmount: json['deducted_amount'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      employee: json['employee'] != null
          ? Employee.fromJson(json['employee'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Employee {
  final int? id;
  final String? name;
  final String? empId;

  Employee({this.id, this.name, this.empId});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int?,
      name: json['name'] as String?,
      empId: json['emp_id'] as String?,
    );
  }
}
