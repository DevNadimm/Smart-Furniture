class SupplierPaymentModel {
  final bool? success;
  final SupplierData? data;

  SupplierPaymentModel({this.success, this.data});

  factory SupplierPaymentModel.fromJson(Map<String, dynamic> json) {
    return SupplierPaymentModel(
      success: json['success'] as bool?,
      data: json['data'] != null ? SupplierData.fromJson(json['data']) : null,
    );
  }
}

class SupplierData {
  final Supplier? supplier;
  final Summary? summary;
  final List<Invoice>? invoices;

  SupplierData({this.supplier, this.summary, this.invoices});

  factory SupplierData.fromJson(Map<String, dynamic> json) {
    return SupplierData(
      supplier:
      json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null,
      summary:
      json['summary'] != null ? Summary.fromJson(json['summary']) : null,
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map((e) => Invoice.fromJson(e))
          .toList(),
    );
  }
}

class Supplier {
  final int? id;
  final String? supplierId;
  final String? supplierName;
  final String? supplierNameBangla;
  final String? contactPerson;
  final String? address;
  final String? contactNumber;
  final String? email;
  final String? image;
  final String? previousDue;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  Supplier({
    this.id,
    this.supplierId,
    this.supplierName,
    this.supplierNameBangla,
    this.contactPerson,
    this.address,
    this.contactNumber,
    this.email,
    this.image,
    this.previousDue,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'] as int?,
      supplierId: json['supplier_id']?.toString(),
      supplierName: json['supplier_name'] as String?,
      supplierNameBangla: json['supplier_name_bangla'] as String?,
      contactPerson: json['contact_person'] as String?,
      address: json['address'] as String?,
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      previousDue: json['previous_due']?.toString(),
      branchId: json['branch_id']?.toString(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}

class Summary {
  final num? subTotal;
  final num? totalVat;
  final num? totalDiscount;
  final num? totalTransportCost;
  final num? totalAmount;
  final num? totalPaid;
  final num? totalDue;

  Summary({
    this.subTotal,
    this.totalVat,
    this.totalDiscount,
    this.totalTransportCost,
    this.totalAmount,
    this.totalPaid,
    this.totalDue,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      subTotal: json['sub_total'] as num?,
      totalVat: json['total_vat'] as num?,
      totalDiscount: json['total_discount'] as num?,
      totalTransportCost: json['total_transport_cost'] as num?,
      totalAmount: json['total_amount'] as num?,
      totalPaid: json['total_paid'] as num?,
      totalDue: json['total_due'] as num?,
    );
  }
}

class Invoice {
  final int? id;
  final String? invoiceNo;
  final String? invoiceDate;
  final String? type;
  final String? status;
  final String? branchId;
  final String? supplierId;
  final String? userId;
  final String? customerId;
  final String? employeeId;
  final String? totalAmount;
  final String? totalLess;
  final String? totalPaid;
  final String? totalDue;
  final String? totalTransportCost;
  final String? totalBalance;
  final String? totalReturn;
  final String? totalDiscount;
  final String? totalVat;
  final String? totalVatAmount;
  final String? totalMakingCharge;
  final String? totalQty;
  final String? ref1;
  final String? ref2;
  final String? barcode;
  final String? sInvoice;
  final String? sInvoiceDate;
  final String? paymentType;
  final String? paymentTrxid;
  final String? cash;
  final String? mobileBankingType;
  final String? mobileBankingAmount;
  final String? mobileBankingTrxId;
  final String? cardAmount;
  final String? cardTrx;
  final String? chequeAmount;
  final String? chequeNumber;
  final String? insMonth;
  final String? insAmount;
  final String? insDownPayment;
  final String? paymentNote;
  final String? paymentDeadline;
  final String? bankInfo;
  final String? mobileBankingInfo;
  final String? note;
  final String? createdAt;
  final String? updatedAt;
  final Supplier? supplier;
  final Purchase? purchase;

  Invoice({
    this.id,
    this.invoiceNo,
    this.invoiceDate,
    this.type,
    this.status,
    this.branchId,
    this.supplierId,
    this.userId,
    this.customerId,
    this.employeeId,
    this.totalAmount,
    this.totalLess,
    this.totalPaid,
    this.totalDue,
    this.totalTransportCost,
    this.totalBalance,
    this.totalReturn,
    this.totalDiscount,
    this.totalVat,
    this.totalVatAmount,
    this.totalMakingCharge,
    this.totalQty,
    this.ref1,
    this.ref2,
    this.barcode,
    this.sInvoice,
    this.sInvoiceDate,
    this.paymentType,
    this.paymentTrxid,
    this.cash,
    this.mobileBankingType,
    this.mobileBankingAmount,
    this.mobileBankingTrxId,
    this.cardAmount,
    this.cardTrx,
    this.chequeAmount,
    this.chequeNumber,
    this.insMonth,
    this.insAmount,
    this.insDownPayment,
    this.paymentNote,
    this.paymentDeadline,
    this.bankInfo,
    this.mobileBankingInfo,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.supplier,
    this.purchase,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as int?,
      invoiceNo: json['invoice_no'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      branchId: json['branch_id']?.toString(),
      supplierId: json['supplier_id']?.toString(),
      userId: json['user_id']?.toString(),
      customerId: json['customer_id']?.toString(),
      employeeId: json['employee_id']?.toString(),
      totalAmount: json['total_amount']?.toString(),
      totalLess: json['total_less']?.toString(),
      totalPaid: json['total_paid']?.toString(),
      totalDue: json['total_due']?.toString(),
      totalTransportCost: json['total_transport_cost']?.toString(),
      totalBalance: json['total_balance']?.toString(),
      totalReturn: json['total_return']?.toString(),
      totalDiscount: json['total_discount']?.toString(),
      totalVat: json['total_vat']?.toString(),
      totalVatAmount: json['total_vat_amount']?.toString(),
      totalMakingCharge: json['total_making_charge']?.toString(),
      totalQty: json['total_qty']?.toString(),
      ref1: json['ref1'] as String?,
      ref2: json['ref2'] as String?,
      barcode: json['barcode'] as String?,
      sInvoice: json['s_invoice'] as String?,
      sInvoiceDate: json['s_invoice_date'] as String?,
      paymentType: json['payment_type'] as String?,
      paymentTrxid: json['payment_trxid'] as String?,
      cash: json['cash']?.toString(),
      mobileBankingType: json['mobile_banking_type'] as String?,
      mobileBankingAmount: json['mobile_banking_amount']?.toString(),
      mobileBankingTrxId: json['mobile_banking_trx_id`']?.toString(),
      cardAmount: json['card_amount']?.toString(),
      cardTrx: json['card_trx']?.toString(),
      chequeAmount: json['cheque_amount']?.toString(),
      chequeNumber: json['cheque_number']?.toString(),
      insMonth: json['ins_month']?.toString(),
      insAmount: json['ins_amount']?.toString(),
      insDownPayment: json['ins_down_payment']?.toString(),
      paymentNote: json['payment_note'] as String?,
      paymentDeadline: json['payment_deadline'] as String?,
      bankInfo: json['bank_info'] as String?,
      mobileBankingInfo: json['mobile_banking_info'] as String?,
      note: json['note'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      supplier: json['supplier'] != null
          ? Supplier.fromJson(json['supplier'])
          : null,
      purchase: json['purchase'] != null
          ? Purchase.fromJson(json['purchase'])
          : null,
    );
  }
}

class Purchase {
  final int? id;
  final String? supplierId;
  final String? invoiceNo;
  final String? userId;
  final String? totalAmount;
  final String? subTotal;
  final String? totalVat;
  final String? totalVatAmount;
  final String? totalDiscount;
  final String? totalTransport;
  final String? totalPaid;
  final String? totalDue;
  final String? purchaseDate;
  final String? supplierContact;
  final String? supplierAddress;
  final String? barcode;
  final String? branchId;
  final String? note;
  final String? createdAt;
  final String? updatedAt;

  Purchase({
    this.id,
    this.supplierId,
    this.invoiceNo,
    this.userId,
    this.totalAmount,
    this.subTotal,
    this.totalVat,
    this.totalVatAmount,
    this.totalDiscount,
    this.totalTransport,
    this.totalPaid,
    this.totalDue,
    this.purchaseDate,
    this.supplierContact,
    this.supplierAddress,
    this.barcode,
    this.branchId,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'] as int?,
      supplierId: json['supplier_id']?.toString(),
      invoiceNo: json['invoice_no'] as String?,
      userId: json['user_id']?.toString(),
      totalAmount: json['total_amount']?.toString(),
      subTotal: json['sub_total']?.toString(),
      totalVat: json['total_vat']?.toString(),
      totalVatAmount: json['total_vat_amount']?.toString(),
      totalDiscount: json['total_discount']?.toString(),
      totalTransport: json['total_transport']?.toString(),
      totalPaid: json['total_paid']?.toString(),
      totalDue: json['total_due']?.toString(),
      purchaseDate: json['purchase_date'] as String?,
      supplierContact: json['supplier_contact'] as String?,
      supplierAddress: json['supplier_address'] as String?,
      barcode: json['barcode'] as String?,
      branchId: json['branch_id']?.toString(),
      note: json['note'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
