class ReminderChequeListModel {
  final bool? success;
  final List<ReminderChequeData>? data;

  ReminderChequeListModel({this.success, this.data});

  factory ReminderChequeListModel.fromJson(Map<String, dynamic> json) {
    return ReminderChequeListModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReminderChequeData.fromJson(e))
          .toList(),
    );
  }
}

class ReminderChequeData {
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

  ReminderChequeData({
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

  factory ReminderChequeData.fromJson(Map<String, dynamic> json) {
    return ReminderChequeData(
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
