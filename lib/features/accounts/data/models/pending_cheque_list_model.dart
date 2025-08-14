class PendingChequeListModel {
  final bool? success;
  final List<PendingChequeData>? data;

  PendingChequeListModel({this.success, this.data});

  factory PendingChequeListModel.fromJson(Map<String, dynamic> json) {
    return PendingChequeListModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PendingChequeData.fromJson(e))
          .toList(),
    );
  }
}

class PendingChequeData {
  final int? id;
  final String? customerId;
  final String? bankName;
  final String? chequeNumber;
  final String? chequeAmount;
  final String? chequeStatus;
  final String? date;
  final String? chequeDate;
  final String? reminderDate;
  final String? submitDate;
  final String? description;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  PendingChequeData({
    this.id,
    this.customerId,
    this.bankName,
    this.chequeNumber,
    this.chequeAmount,
    this.chequeStatus,
    this.date,
    this.chequeDate,
    this.reminderDate,
    this.submitDate,
    this.description,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory PendingChequeData.fromJson(Map<String, dynamic> json) {
    return PendingChequeData(
      id: json['id'] as int?,
      customerId: json['customer_id'] as String?,
      bankName: json['bank_name'] as String?,
      chequeNumber: json['cheque_number'] as String?,
      chequeAmount: json['cheque_amount'] as String?,
      chequeStatus: json['cheque_status'] as String?,
      date: json['date'] as String?,
      chequeDate: json['cheque_date'] as String?,
      reminderDate: json['reminder_date'] as String?,
      submitDate: json['submit_date'] as String?,
      description: json['description'] as String?,
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
