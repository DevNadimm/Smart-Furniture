class BankTransactionModel {
  final bool? success;
  final List<BankTransactionData>? data;

  BankTransactionModel({this.success, this.data});

  factory BankTransactionModel.fromJson(Map<String, dynamic> json) {
    return BankTransactionModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? List<BankTransactionData>.from(
              json['data'].map((x) => BankTransactionData.fromJson(x)))
          : null,
    );
  }
}

class BankTransactionData {
  final int? id;
  final String? transactionDate;
  final String? transactionType;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final String? note;
  final String? amount;
  final String? deposit;
  final String? withdraw;
  final String? savedBy;
  final String? branchId;
  final String? bankAccountId;
  final String? createdAt;
  final String? updatedAt;

  BankTransactionData({
    this.id,
    this.transactionDate,
    this.transactionType,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.note,
    this.amount,
    this.deposit,
    this.withdraw,
    this.savedBy,
    this.branchId,
    this.bankAccountId,
    this.createdAt,
    this.updatedAt,
  });

  factory BankTransactionData.fromJson(Map<String, dynamic> json) {
    return BankTransactionData(
      id: json['id'] as int?,
      transactionDate: json['transaction_date'] as String?,
      transactionType: json['transaction_type'] as String?,
      accountName: json['account_name'] as String?,
      accountNumber: json['account_number'] as String?,
      bankName: json['bank_name'] as String?,
      note: json['note'] as String?,
      amount: json['amount'] as String?,
      deposit: json['deposit'] as String?,
      withdraw: json['withdraw'] as String?,
      savedBy: json['saved_by']?.toString(),
      branchId: json['branch_id']?.toString(),
      bankAccountId: json['bank_account_id']?.toString(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
