class DailyReportsModel {
  final bool? success;
  final DailyReportData? data;

  DailyReportsModel({this.success, this.data});

  factory DailyReportsModel.fromJson(Map<String, dynamic> json) {
    return DailyReportsModel(
      success: json['success'],
      data: json['data'] != null ? DailyReportData.fromJson(json['data']) : null,
    );
  }
}

class DailyReportData {
  final List<Sale>? sales;
  final List<SupplierPayment>? supplierPayments;
  final List<AdditionalPayment>? additionalPayments;
  final List<CashPayment>? cashPayments;
  final List<EmployeePayment>? employeePayments;

  DailyReportData({
    this.sales,
    this.supplierPayments,
    this.additionalPayments,
    this.cashPayments,
    this.employeePayments,
  });

  factory DailyReportData.fromJson(Map<String, dynamic> json) {
    return DailyReportData(
      sales: (json['sales'] as List?)?.map((e) => Sale.fromJson(e)).toList(),
      supplierPayments: (json['supplierPayments'] as List?)
          ?.map((e) => SupplierPayment.fromJson(e))
          .toList(),
      additionalPayments: (json['additionalPayments'] as List?)
          ?.map((e) => AdditionalPayment.fromJson(e))
          .toList(),
      cashPayments: (json['cashPayments'] as List?)
          ?.map((e) => CashPayment.fromJson(e))
          .toList(),
      employeePayments: (json['employeePayments'] as List?)
          ?.map((e) => EmployeePayment.fromJson(e))
          .toList(),
    );
  }
}

/// ------------------ Sales ------------------ ///
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
  final List<SalesProduct>? salesProduct;

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
    this.salesProduct,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
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
      salesProduct: (json['sales_product'] as List?)
          ?.map((e) => SalesProduct.fromJson(e))
          .toList(),
    );
  }
}

class SalesProduct {
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
  final Size1? size1;
  final Color? color;
  final Category? category;
  final Customer? customer;

  SalesProduct({
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
    this.size1,
    this.color,
    this.category,
    this.customer,
  });

  factory SalesProduct.fromJson(Map<String, dynamic> json) {
    return SalesProduct(
      id: json['id'],
      saleDate: json['sale_date'],
      productId: json['product_id'],
      customerId: json['customer_id'],
      saleId: json['sale_id'],
      warehouseId: json['warehouse_id'],
      productUnitId: json['product_unit_id'],
      invoiceNo: json['invoice_no'],
      productName: json['product_name'],
      categoryId: json['category_id'],
      quantity: json['quantity'],
      total: json['total'],
      totalAmount: json['total_amount'],
      barcode: json['barcode'],
      purchasePrice: json['purchase_price'],
      salePrice: json['sale_price'],
      totalDiscount: json['total_discount'],
      size: json['size'],
      colorId: json['color_id'],
      sizeId: json['size_id'],
      capacity: json['capacity'],
      manufactureDate: json['manufacture_date'],
      expiryDate: json['expiry_date'],
      branchId: json['branch_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      size1: json['size1'] != null ? Size1.fromJson(json['size1']) : null,
      color: json['color'] != null ? Color.fromJson(json['color']) : null,
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
      customer:
      json['customer'] != null ? Customer.fromJson(json['customer']) : null,
    );
  }
}

class Size1 {
  final int? id;
  final String? sizeName;
  final String? createdAt;
  final String? updatedAt;

  Size1({this.id, this.sizeName, this.createdAt, this.updatedAt});

  factory Size1.fromJson(Map<String, dynamic> json) {
    return Size1(
      id: json['id'],
      sizeName: json['size_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Color {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Color({this.id, this.name, this.createdAt, this.updatedAt});

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Category {
  final int? id;
  final String? name;
  final String? nameBangla;
  final String? description;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  Category({
    this.id,
    this.name,
    this.nameBangla,
    this.description,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      nameBangla: json['name_bangla'],
      description: json['description'],
      branchId: json['branch_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Customer {
  final int? id;
  final String? customerId;
  final String? customerName;
  final String? customerNameBangla;
  final String? customerType;
  final String? contactPerson;
  final String? address;
  final String? area;
  final String? dob;
  final String? marriage;
  final String? mobile;
  final String? officePhone;
  final String? image;
  final String? previousDue;
  final String? creditLimit;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  Customer({
    this.id,
    this.customerId,
    this.customerName,
    this.customerNameBangla,
    this.customerType,
    this.contactPerson,
    this.address,
    this.area,
    this.dob,
    this.marriage,
    this.mobile,
    this.officePhone,
    this.image,
    this.previousDue,
    this.creditLimit,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      customerNameBangla: json['customer_name_bangla'],
      customerType: json['customer_type'],
      contactPerson: json['contact_person'],
      address: json['address'],
      area: json['area'],
      dob: json['dob'],
      marriage: json['marriage'],
      mobile: json['mobile'],
      officePhone: json['office_phone'],
      image: json['image'],
      previousDue: json['previous_due'],
      creditLimit: json['credit_limit'],
      branchId: json['branch_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

/// ------------------ Supplier Payments ------------------ ///
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
  final Supplier? supplier;
  final User? userName;

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
    this.supplier,
    this.userName,
  });

  factory SupplierPayment.fromJson(Map<String, dynamic> json) {
    return SupplierPayment(
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
      supplier:
      json['supplier'] != null ? Supplier.fromJson(json['supplier']) : null,
      userName: json['user_name'] != null ? User.fromJson(json['user_name']) : null,
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
      id: json['id'],
      supplierId: json['supplier_id'],
      supplierName: json['supplier_name'],
      supplierNameBangla: json['supplier_name_bangla'],
      contactPerson: json['contact_person'],
      address: json['address'],
      contactNumber: json['contact_number'],
      email: json['email'],
      image: json['image'],
      previousDue: json['previous_due'],
      branchId: json['branch_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

/// ------------------ Additional Payments ------------------ ///
class AdditionalPayment {
  final int? id;
  final String? paymentTo;
  final String? amount;
  final String? date;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  AdditionalPayment({
    this.id,
    this.paymentTo,
    this.amount,
    this.date,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory AdditionalPayment.fromJson(Map<String, dynamic> json) {
    return AdditionalPayment(
      id: json['id'],
      paymentTo: json['payment_to'],
      amount: json['amount'],
      date: json['date'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

/// ------------------ Cash Payments ------------------ ///
class CashPayment {
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
  final User? user;

  CashPayment({
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
    this.user,
  });

  factory CashPayment.fromJson(Map<String, dynamic> json) {
    return CashPayment(
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
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

/// ------------------ Employee Payments ------------------ ///
class EmployeePayment {
  final int? id;
  final String? branchId;
  final String? empId;
  final String? name;
  final String? date;
  final String? month;
  final String? paymentAmount;
  final String? deductedAmount;
  final String? createdAt;
  final String? updatedAt;
  final Employee? employee;

  EmployeePayment({
    this.id,
    this.branchId,
    this.empId,
    this.name,
    this.date,
    this.month,
    this.paymentAmount,
    this.deductedAmount,
    this.createdAt,
    this.updatedAt,
    this.employee,
  });

  factory EmployeePayment.fromJson(Map<String, dynamic> json) {
    return EmployeePayment(
      id: json['id'],
      branchId: json['branch_id'],
      empId: json['emp_id'],
      name: json['name'],
      date: json['date'],
      month: json['month'],
      paymentAmount: json['payment_amount'],
      deductedAmount: json['deducted_amount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      employee:
      json['employee'] != null ? Employee.fromJson(json['employee']) : null,
    );
  }
}

class Employee {
  final int? id;
  final String? empId;
  final String? name;
  final String? designation;
  final String? department;
  final String? joinDate;
  final String? salaryRange;
  final String? activationStatus;
  final String? presentAddress;
  final String? permanentAddress;
  final String? contact;
  final String? email;
  final String? photo;
  final String? fathersName;
  final String? mothersName;
  final String? gender;
  final String? dob;
  final String? maritalStatus;
  final String? createdAt;
  final String? updatedAt;

  Employee({
    this.id,
    this.empId,
    this.name,
    this.designation,
    this.department,
    this.joinDate,
    this.salaryRange,
    this.activationStatus,
    this.presentAddress,
    this.permanentAddress,
    this.contact,
    this.email,
    this.photo,
    this.fathersName,
    this.mothersName,
    this.gender,
    this.dob,
    this.maritalStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      empId: json['emp_id'],
      name: json['name'],
      designation: json['designation'],
      department: json['department'],
      joinDate: json['join_date'],
      salaryRange: json['salary_range'],
      activationStatus: json['activation_status'],
      presentAddress: json['present_address'],
      permanentAddress: json['permanent_address'],
      contact: json['contact'],
      email: json['email'],
      photo: json['photo'],
      fathersName: json['fathers_name'],
      mothersName: json['mothers_name'],
      gender: json['gender'],
      dob: json['dob'],
      maritalStatus: json['marital_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

/// ------------------ User ------------------ ///
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? roleId;
  final String? branchId;
  final String? status;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.roleId,
    this.branchId,
    this.status,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roleId: json['role_id'],
      branchId: json['branch_id'],
      status: json['status'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
