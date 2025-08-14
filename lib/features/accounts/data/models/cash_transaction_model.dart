class CashTransactionModel {
  final bool? success;
  final DataModel? data;
  final SummaryModel? summary;

  CashTransactionModel({this.success, this.data, this.summary});

  factory CashTransactionModel.fromJson(Map<String, dynamic> json) {
    return CashTransactionModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? DataModel.fromJson(json['data']) : null,
      summary: json['summary'] != null ? SummaryModel.fromJson(json['summary']) : null,
    );
  }
}

class DataModel {
  final List<CashTransactionData>? cashTransactions;

  DataModel({this.cashTransactions});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      cashTransactions: json['cash_transactions'] != null
          ? List<CashTransactionData>.from(
          json['cash_transactions'].map((x) => CashTransactionData.fromJson(x)))
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

class SummaryModel {
  final num? cashIn;
  final num? cashOut;
  final num? balance;

  SummaryModel({this.cashIn, this.cashOut, this.balance});

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      cashIn: json['cash_in'] as num?,
      cashOut: json['cash_out'] as num?,
      balance: json['balance'] as num?,
    );
  }
}
