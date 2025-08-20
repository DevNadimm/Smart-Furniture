class EmployeeListModel {
  final bool? success;
  final List<EmployeeData>? data;

  EmployeeListModel({this.success, this.data});

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) {
    return EmployeeListModel(
      success: json['success'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => EmployeeData.fromJson(item))
          .toList(),
    );
  }
}

class EmployeeData {
  final int? id;
  final String? empId;
  final String? name;
  final String? nameBangla;
  final String? designation;
  final String? department;
  final String? joinDate;
  final String? salaryRange;
  final String? activationStatus;
  final String? presentAddress;
  final String? permanentAddress;
  final String? contact;
  final String? email;
  final String? photo;
  final String? fathersName;
  final String? mothersName;
  final String? gender;
  final String? dob;
  final String? maritalStatus;
  final String? createdAt;
  final String? updatedAt;

  EmployeeData({
    this.id,
    this.empId,
    this.name,
    this.nameBangla,
    this.designation,
    this.department,
    this.joinDate,
    this.salaryRange,
    this.activationStatus,
    this.presentAddress,
    this.permanentAddress,
    this.contact,
    this.email,
    this.photo,
    this.fathersName,
    this.mothersName,
    this.gender,
    this.dob,
    this.maritalStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      id: json['id'],
      empId: json['emp_id'],
      name: json['name'],
      nameBangla: json['name_bangla'],
      designation: json['designation'],
      department: json['department'],
      joinDate: json['join_date'],
      salaryRange: json['salary_range'],
      activationStatus: json['activation_status'],
      presentAddress: json['present_address'],
      permanentAddress: json['permanent_address'],
      contact: json['contact'],
      email: json['email'],
      photo: json['photo'],
      fathersName: json['fathers_name'],
      mothersName: json['mothers_name'],
      gender: json['gender'],
      dob: json['dob'],
      maritalStatus: json['marital_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
