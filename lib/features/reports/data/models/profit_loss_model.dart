class ProfitLossModel {
  final bool? success;
  final List<ProfitLossData>? data;
  final num? totalDamage;
  final num? totalCashTransaction;
  final num? totalSalary;

  ProfitLossModel({
    this.success,
    this.data,
    this.totalDamage,
    this.totalCashTransaction,
    this.totalSalary,
  });

  factory ProfitLossModel.fromJson(Map<String, dynamic> json) {
    return ProfitLossModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProfitLossData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDamage: json['totalDamage'] as num?,
      totalCashTransaction: json['totalCashTransaction'] as num?,
      totalSalary: json['totalSalary'] as num?,
    );
  }
}

class ProfitLossData {
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
  final List<SaleProduct>? saleProduct;

  ProfitLossData({
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
    this.saleProduct,
  });

  factory ProfitLossData.fromJson(Map<String, dynamic> json) {
    return ProfitLossData(
      id: json['id'] as int?,
      invoiceNo: json['invoice_no'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      branchId: json['branch_id'] as String?,
      supplierId: json['supplier_id'] as String?,
      userId: json['user_id'] as String?,
      customerId: json['customer_id'] as String?,
      employeeId: json['employee_id'] as String?,
      totalAmount: json['total_amount'] as String?,
      totalLess: json['total_less'] as String?,
      totalPaid: json['total_paid'] as String?,
      totalDue: json['total_due'] as String?,
      totalTransportCost: json['total_transport_cost'] as String?,
      totalBalance: json['total_balance'] as String?,
      totalReturn: json['total_return'] as String?,
      totalDiscount: json['total_discount'] as String?,
      totalVat: json['total_vat'] as String?,
      totalVatAmount: json['total_vat_amount'] as String?,
      totalMakingCharge: json['total_making_charge'] as String?,
      totalQty: json['total_qty'] as String?,
      ref1: json['ref1'] as String?,
      ref2: json['ref2'] as String?,
      barcode: json['barcode'] as String?,
      sInvoice: json['s_invoice'] as String?,
      sInvoiceDate: json['s_invoice_date'] as String?,
      paymentType: json['payment_type'] as String?,
      paymentTrxid: json['payment_trxid'] as String?,
      cash: json['cash'] as String?,
      mobileBankingType: json['mobile_banking_type'] as String?,
      mobileBankingAmount: json['mobile_banking_amount'] as String?,
      mobileBankingTrxId: json['mobile_banking_trx_id`'] as String?, // Note backtick
      cardAmount: json['card_amount'] as String?,
      cardTrx: json['card_trx'] as String?,
      chequeAmount: json['cheque_amount'] as String?,
      chequeNumber: json['cheque_number'] as String?,
      insMonth: json['ins_month'] as String?,
      insAmount: json['ins_amount'] as String?,
      insDownPayment: json['ins_down_payment'] as String?,
      paymentNote: json['payment_note'] as String?,
      paymentDeadline: json['payment_deadline'] as String?,
      bankInfo: json['bank_info'] as String?,
      mobileBankingInfo: json['mobile_banking_info'] as String?,
      note: json['note'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      saleProduct: (json['sale_product'] as List<dynamic>?)
          ?.map((e) => SaleProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SaleProduct {
  final int? id;
  final String? saleDate;
  final String? productId;
  final String? customerId;
  final String? saleId;
  final String? warehouseId;
  final String? productUnitId;
  final String? invoiceNo;
  final String? productName;
  final String? categoryId;
  final String? quantity;
  final String? total;
  final String? totalAmount;
  final String? barcode;
  final String? purchasePrice;
  final String? salePrice;
  final String? totalDiscount;
  final String? size;
  final String? colorId;
  final String? sizeId;
  final String? capacity;
  final String? manufactureDate;
  final String? expiryDate;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  SaleProduct({
    this.id,
    this.saleDate,
    this.productId,
    this.customerId,
    this.saleId,
    this.warehouseId,
    this.productUnitId,
    this.invoiceNo,
    this.productName,
    this.categoryId,
    this.quantity,
    this.total,
    this.totalAmount,
    this.barcode,
    this.purchasePrice,
    this.salePrice,
    this.totalDiscount,
    this.size,
    this.colorId,
    this.sizeId,
    this.capacity,
    this.manufactureDate,
    this.expiryDate,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory SaleProduct.fromJson(Map<String, dynamic> json) {
    return SaleProduct(
      id: json['id'] as int?,
      saleDate: json['sale_date'] as String?,
      productId: json['product_id'] as String?,
      customerId: json['customer_id'] as String?,
      saleId: json['sale_id'] as String?,
      warehouseId: json['warehouse_id'] as String?,
      productUnitId: json['product_unit_id'] as String?,
      invoiceNo: json['invoice_no'] as String?,
      productName: json['product_name'] as String?,
      categoryId: json['category_id'] as String?,
      quantity: json['quantity'] as String?,
      total: json['total'] as String?,
      totalAmount: json['total_amount'] as String?,
      barcode: json['barcode'] as String?,
      purchasePrice: json['purchase_price'] as String?,
      salePrice: json['sale_price'] as String?,
      totalDiscount: json['total_discount'] as String?,
      size: json['size'] as String?,
      colorId: json['color_id'] as String?,
      sizeId: json['size_id'] as String?,
      capacity: json['capacity'] as String?,
      manufactureDate: json['manufacture_date'] as String?,
      expiryDate: json['expiry_date'] as String?,
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
