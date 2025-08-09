class SalesRecordModel {
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
  final DateTime? saleDate;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SalesProduct>? salesProduct;

  SalesRecordModel({
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

  factory SalesRecordModel.fromJson(Map<String, dynamic> json) => SalesRecordModel(
    id: json["id"],
    customerId: json["customer_id"],
    employeeId: json["employee_id"],
    userId: json["user_id"],
    invoiceNo: json["invoice_no"],
    saleType: json["sale_type"],
    totalAmount: json["total_amount"],
    subTotal: json["sub_total"],
    totalVat: json["total_vat"],
    totalVatAmount: json["total_vat_amount"],
    totalDiscount: json["total_discount"],
    totalTransport: json["total_transport"],
    totalPaid: json["total_paid"],
    totalDue: json["total_due"],
    saleDate: json["sale_date"] == null ? null : DateTime.tryParse(json["sale_date"]),
    customerName: json["customer_name"],
    customerContact: json["customer_contact"],
    customerAddress: json["customer_address"],
    barcode: json["barcode"],
    branchId: json["branch_id"],
    colorId: json["color_id"],
    sizeId: json["size_id"],
    bankInfo: json["bank_info"],
    mobileBankingInfo: json["mobile_banking_info"],
    note: json["note"],
    createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
    salesProduct: json["sales_product"] == null
        ? null
        : List<SalesProduct>.from(
        json["sales_product"].map((x) => SalesProduct.fromJson(x))),
  );
}

class SalesProduct {
  final int? id;
  final DateTime? saleDate;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Size1? size1;
  final ColorModel? color;
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

  factory SalesProduct.fromJson(Map<String, dynamic> json) => SalesProduct(
    id: json["id"],
    saleDate:
    json["sale_date"] == null ? null : DateTime.tryParse(json["sale_date"]),
    productId: json["product_id"],
    customerId: json["customer_id"],
    saleId: json["sale_id"],
    warehouseId: json["warehouse_id"],
    productUnitId: json["product_unit_id"],
    invoiceNo: json["invoice_no"],
    productName: json["product_name"],
    categoryId: json["category_id"],
    quantity: json["quantity"],
    total: json["total"],
    totalAmount: json["total_amount"],
    barcode: json["barcode"],
    purchasePrice: json["purchase_price"],
    salePrice: json["sale_price"],
    totalDiscount: json["total_discount"],
    size: json["size"],
    colorId: json["color_id"],
    sizeId: json["size_id"],
    capacity: json["capacity"],
    manufactureDate: json["manufacture_date"],
    expiryDate: json["expiry_date"],
    branchId: json["branch_id"],
    createdAt:
    json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
    updatedAt:
    json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
    size1: json["size1"] == null ? null : Size1.fromJson(json["size1"]),
    color: json["color"] == null ? null : ColorModel.fromJson(json["color"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );
}

class Size1 {
  final int? id;
  final String? sizeName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Size1({
    this.id,
    this.sizeName,
    this.createdAt,
    this.updatedAt,
  });

  factory Size1.fromJson(Map<String, dynamic> json) => Size1(
    id: json["id"],
    sizeName: json["size_name"],
    createdAt:
    json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
    updatedAt:
    json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
  );
}

class ColorModel {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ColorModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
    id: json["id"],
    name: json["name"],
    createdAt:
    json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
    updatedAt:
    json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
  );
}

class Category {
  final int? id;
  final String? name;
  final String? description;
  final String? branchId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.branchId,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    branchId: json["branch_id"],
    createdAt:
    json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
    updatedAt:
    json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
  );
}

class Customer {
  final int? id;
  final String? customerId;
  final String? customerName;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Customer({
    this.id,
    this.customerId,
    this.customerName,
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

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerType: json["customer_type"],
    contactPerson: json["contact_person"],
    address: json["address"],
    area: json["area"],
    dob: json["dob"],
    marriage: json["marriage"],
    mobile: json["mobile"],
    officePhone: json["office_phone"],
    image: json["image"],
    previousDue: json["previous_due"],
    creditLimit: json["credit_limit"],
    branchId: json["branch_id"],
    createdAt:
    json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
    updatedAt:
    json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
  );
}
