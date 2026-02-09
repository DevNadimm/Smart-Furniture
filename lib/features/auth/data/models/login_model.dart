class LoginModel {
  final bool? success;
  final String? message;
  final Data? data;
  final String? accessToken;
  final String? tokenType;

  LoginModel({
    this.success,
    this.message,
    this.data,
    this.accessToken,
    this.tokenType,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }
}

class Data {
  final int? id;
  final String? name;
  final String? email;
  final String? isSuperadmin;
  final String? companyId;
  final String? branchId;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.isSuperadmin,
    this.companyId,
    this.branchId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      isSuperadmin: json['is_superadmin'],
      companyId: json['company_id'],
      branchId: json['branch_id'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'is_superadmin': isSuperadmin,
      'company_id': companyId,
      'branch_id': branchId,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
