class CashTransactionModel {
  final bool? success;
  final List<CashTransactionData>? data;

  CashTransactionModel({this.success, this.data});

  factory CashTransactionModel.fromJson(Map<String, dynamic> json) {
    return CashTransactionModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? List<CashTransactionData>.from(
          json['data'].map((x) => CashTransactionData.fromJson(x)))
          : null,
    );
  }
}

class CashTransactionData {
  final int? id;
  final String? transactionId;
  final String? transactionType;
  final String? accountName;
  final String? date;
  final String? description;
  final String? receivedAmount;
  final String? paidAmount;
  final String? branchId;
  final String? savedBy;
  final String? createdAt;
  final String? updatedAt;

  CashTransactionData({
    this.id,
    this.transactionId,
    this.transactionType,
    this.accountName,
    this.date,
    this.description,
    this.receivedAmount,
    this.paidAmount,
    this.branchId,
    this.savedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CashTransactionData.fromJson(Map<String, dynamic> json) {
    return CashTransactionData(
      id: json['id'] as int?,
      transactionId: json['transaction_id'] as String?,
      transactionType: json['transaction_type'] as String?,
      accountName: json['account_name'] as String?,
      date: json['date'] as String?,
      description: json['description'] as String?,
      receivedAmount: json['received_amount'] as String?,
      paidAmount: json['paid_amount'] as String?,
      branchId: json['branch_id']?.toString(),
      savedBy: json['saved_by']?.toString(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
