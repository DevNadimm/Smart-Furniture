class AdditionalPaymentsModel {
  final bool? success;
  final List<PaymentData>? data;

  AdditionalPaymentsModel({this.success, this.data});

  factory AdditionalPaymentsModel.fromJson(Map<String, dynamic> json) {
    return AdditionalPaymentsModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? List<PaymentData>.from(
              (json['data'] as List).map((x) => PaymentData.fromJson(x)))
          : null,
    );
  }
}

class PaymentData {
  final int? id;
  final String? paymentTo;
  final String? amount;
  final String? date;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  PaymentData({
    this.id,
    this.paymentTo,
    this.amount,
    this.date,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'] as int?,
      paymentTo: json['payment_to'] as String?,
      amount: json['amount'] as String?,
      date: json['date'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
