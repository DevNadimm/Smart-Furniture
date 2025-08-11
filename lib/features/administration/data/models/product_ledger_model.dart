class ProductLedgerModel {
  final bool? success;
  final List<ProductLedgerData>? data;

  ProductLedgerModel({this.success, this.data});

  factory ProductLedgerModel.fromJson(Map<String, dynamic> json) {
    return ProductLedgerModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductLedgerData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProductLedgerData {
  final String? date;
  final String? type;
  final String? invoiceNo;
  final String? personeName;
  final String? rate;
  final int? inQty;
  final int? outQty;

  ProductLedgerData({
    this.date,
    this.type,
    this.invoiceNo,
    this.personeName,
    this.rate,
    this.inQty,
    this.outQty,
  });

  factory ProductLedgerData.fromJson(Map<String, dynamic> json) {
    return ProductLedgerData(
      date: json['date'] as String?,
      type: json['type'] as String?,
      invoiceNo: json['invoice_no'] as String?,
      personeName: json['persone_name'] as String?,
      rate: json['rate'] as String?,
      inQty: json['in_qty'] as int?,
      outQty: json['out_qty'] as int?,
    );
  }
}
