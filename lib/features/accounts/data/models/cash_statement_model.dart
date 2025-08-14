class CashStatementModel {
  final bool? success;
  final CashStatementData? data;
  final CashSummary? summary;

  CashStatementModel({this.success, this.data, this.summary});

  factory CashStatementModel.fromJson(Map<String, dynamic> json) {
    return CashStatementModel(
      success: json['success'],
      data: json['data'] != null ? CashStatementData.fromJson(json['data']) : null,
      summary: json['summary'] != null ? CashSummary.fromJson(json['summary']) : null,
    );
  }
}

class CashStatementData {
  final List<Sale>? sales;
  final List<Purchase>? purchases;
  final List<SupplierPayment>? supplierPayments;
  final List<CustomerPayment>? customerPayments;
  final List<CashTransaction>? cashTransactions;
  final List<BankTransaction>? bankTransactions;

  CashStatementData({
    this.sales,
    this.purchases,
    this.supplierPayments,
    this.customerPayments,
    this.cashTransactions,
    this.bankTransactions,
  });

  factory CashStatementData.fromJson(Map<String, dynamic> json) {
    return CashStatementData(
      sales: json['sales'] != null
          ? List<Sale>.from(json['sales'].map((x) => Sale.fromJson(x)))
          : null,
      purchases: json['purchases'] != null
          ? List<Purchase>.from(json['purchases'].map((x) => Purchase.fromJson(x)))
          : null,
      supplierPayments: json['supplier_payments'] != null
          ? List<SupplierPayment>.from(json['supplier_payments'].map((x) => SupplierPayment.fromJson(x)))
          : null,
      customerPayments: json['customer_payments'] != null
          ? List<CustomerPayment>.from(json['customer_payments'].map((x) => CustomerPayment.fromJson(x)))
          : null,
      cashTransactions: json['cash_transactions'] != null
          ? List<CashTransaction>.from(json['cash_transactions'].map((x) => CashTransaction.fromJson(x)))
          : null,
      bankTransactions: json['bank_transactions'] != null
          ? List<BankTransaction>.from(json['bank_transactions'].map((x) => BankTransaction.fromJson(x)))
          : null,
    );
  }
}

class Sale {
  final int? id;
  final String? customerId;
  final String? employeeId;
  final String? userId;
  final String? invoiceNo;
  final String? saleType;
  final String? totalAmount;
  final String? subTotal;
  final String? totalVat;
  final String? totalVatAmount;
  final String? totalDiscount;
  final String? totalTransport;
  final String? totalPaid;
  final String? totalDue;
  final String? saleDate;
  final String? customerName;
  final String? customerContact;
  final String? customerAddress;
  final String? barcode;
  final String? branchId;
  final String? colorId;
  final String? sizeId;
  final String? bankInfo;
  final String? mobileBankingInfo;
  final String? note;
  final String? createdAt;
  final String? updatedAt;

  Sale({
    this.id,
    this.customerId,
    this.employeeId,
    this.userId,
    this.invoiceNo,
    this.saleType,
    this.totalAmount,
    this.subTotal,
    this.totalVat,
    this.totalVatAmount,
    this.totalDiscount,
    this.totalTransport,
    this.totalPaid,
    this.totalDue,
    this.saleDate,
    this.customerName,
    this.customerContact,
    this.customerAddress,
    this.barcode,
    this.branchId,
    this.colorId,
    this.sizeId,
    this.bankInfo,
    this.mobileBankingInfo,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    id: json['id'],
    customerId: json['customer_id'],
    employeeId: json['employee_id'],
    userId: json['user_id'],
    invoiceNo: json['invoice_no'],
    saleType: json['sale_type'],
    totalAmount: json['total_amount'],
    subTotal: json['sub_total'],
    totalVat: json['total_vat'],
    totalVatAmount: json['total_vat_amount'],
    totalDiscount: json['total_discount'],
    totalTransport: json['total_transport'],
    totalPaid: json['total_paid'],
    totalDue: json['total_due'],
    saleDate: json['sale_date'],
    customerName: json['customer_name'],
    customerContact: json['customer_contact'],
    customerAddress: json['customer_address'],
    barcode: json['barcode'],
    branchId: json['branch_id'],
    colorId: json['color_id'],
    sizeId: json['size_id'],
    bankInfo: json['bank_info'],
    mobileBankingInfo: json['mobile_banking_info'],
    note: json['note'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}

// Similarly, create Purchase, SupplierPayment, CustomerPayment, CashTransaction, BankTransaction classes

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

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    id: json['id'],
    supplierId: json['supplier_id'],
    invoiceNo: json['invoice_no'],
    userId: json['user_id'],
    totalAmount: json['total_amount'],
    subTotal: json['sub_total'],
    totalVat: json['total_vat'],
    totalVatAmount: json['total_vat_amount'],
    totalDiscount: json['total_discount'],
    totalTransport: json['total_transport'],
    totalPaid: json['total_paid'],
    totalDue: json['total_due'],
    purchaseDate: json['purchase_date'],
    supplierContact: json['supplier_contact'],
    supplierAddress: json['supplier_address'],
    barcode: json['barcode'],
    branchId: json['branch_id'],
    note: json['note'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}

class SupplierPayment {
  final int? id;
  final String? transactionId;
  final String? transactionType;
  final String? paymentType;
  final String? supplierId;
  final String? due;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final String? date;
  final String? description;
  final String? amount;
  final String? savedBy;
  final String? branchId;
  final String? bankAccountId;
  final String? invoiceId;
  final String? createdAt;
  final String? updatedAt;

  SupplierPayment({
    this.id,
    this.transactionId,
    this.transactionType,
    this.paymentType,
    this.supplierId,
    this.due,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.date,
    this.description,
    this.amount,
    this.savedBy,
    this.branchId,
    this.bankAccountId,
    this.invoiceId,
    this.createdAt,
    this.updatedAt,
  });

  factory SupplierPayment.fromJson(Map<String, dynamic> json) => SupplierPayment(
    id: json['id'],
    transactionId: json['transaction_id'],
    transactionType: json['transaction_type'],
    paymentType: json['payment_type'],
    supplierId: json['supplier_id'],
    due: json['due'],
    accountName: json['account_name'],
    accountNumber: json['account_number'],
    bankName: json['bank_name'],
    date: json['date'],
    description: json['description'],
    amount: json['amount'],
    savedBy: json['saved_by'],
    branchId: json['branch_id'],
    bankAccountId: json['bank_account_id'],
    invoiceId: json['invoice_id'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}

class CustomerPayment {
  // empty for now, same as SupplierPayment if data exists
  CustomerPayment();

  factory CustomerPayment.fromJson(Map<String, dynamic> json) => CustomerPayment();
}

class CashTransaction {
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

  CashTransaction({
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

  factory CashTransaction.fromJson(Map<String, dynamic> json) => CashTransaction(
    id: json['id'],
    transactionId: json['transaction_id'],
    transactionType: json['transaction_type'],
    accountName: json['account_name'],
    date: json['date'],
    description: json['description'],
    receivedAmount: json['received_amount'],
    paidAmount: json['paid_amount'],
    branchId: json['branch_id'],
    savedBy: json['saved_by'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}

class BankTransaction {
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

  BankTransaction({
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

  factory BankTransaction.fromJson(Map<String, dynamic> json) => BankTransaction(
    id: json['id'],
    transactionDate: json['transaction_date'],
    transactionType: json['transaction_type'],
    accountName: json['account_name'],
    accountNumber: json['account_number'],
    bankName: json['bank_name'],
    note: json['note'],
    amount: json['amount'],
    deposit: json['deposit'],
    withdraw: json['withdraw'],
    savedBy: json['saved_by'],
    branchId: json['branch_id'],
    bankAccountId: json['bank_account_id'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}

class CashSummary {
  final int? cashIn;
  final int? cashOut;
  final int? balance;

  CashSummary({this.cashIn, this.cashOut, this.balance});

  factory CashSummary.fromJson(Map<String, dynamic> json) => CashSummary(
    cashIn: json['cash_in'],
    cashOut: json['cash_out'],
    balance: json['balance'],
  );
}
