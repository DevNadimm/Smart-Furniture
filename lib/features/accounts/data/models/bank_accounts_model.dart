class BankAccountsModel {
  final bool? success;
  final List<BankAccountData>? data;

  BankAccountsModel({this.success, this.data});

  factory BankAccountsModel.fromJson(Map<String, dynamic> json) {
    return BankAccountsModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? List<BankAccountData>.from(
        (json['data'] as List).map((x) => BankAccountData.fromJson(x)),
      )
          : null,
    );
  }
}

class BankAccountData {
  final int? id;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final String? accountType;
  final String? branchName;
  final String? initialBalance;
  final String? description;
  final String? status;
  final int? branchId;
  final String? createdAt;
  final String? updatedAt;

  BankAccountData({
    this.id,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.accountType,
    this.branchName,
    this.initialBalance,
    this.description,
    this.status,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory BankAccountData.fromJson(Map<String, dynamic> json) {
    return BankAccountData(
      id: json['id'] as int?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      bankName: json['bank_name'] as String?,
      accountType: json['account_type'] as String?,
      branchName: json['branch_name'] as String?,
      initialBalance: json['initial_balance'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      branchId: json['branch_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
