class PurchaseRecordModel {
  final bool? success;
  final List<PurchaseRecordData>? data;

  PurchaseRecordModel({
    this.success,
    this.data,
  });

  factory PurchaseRecordModel.fromJson(Map<String, dynamic> json) {
    return PurchaseRecordModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PurchaseRecordData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PurchaseRecordData {
  final int? id;
  final String? purchaseDate;
  final String? productId;
  final String? supplierId;
  final String? purchaseId;
  final String? warehouseId;
  final String? productUnitId;
  final String? productName;
  final String? categoryId;
  final String? invoiceNo;
  final String? quantity;
  final String? total;
  final String? barcode;
  final String? purchasePrice;
  final String? salePrice;
  final String? size;
  final String? colorId;
  final String? sizeId;
  final String? capacity;
  final String? manufactureDate;
  final String? expiryDate;
  final String? branchId;
  final String? createdAt;
  final String? updatedAt;

  PurchaseRecordData({
    this.id,
    this.purchaseDate,
    this.productId,
    this.supplierId,
    this.purchaseId,
    this.warehouseId,
    this.productUnitId,
    this.productName,
    this.categoryId,
    this.invoiceNo,
    this.quantity,
    this.total,
    this.barcode,
    this.purchasePrice,
    this.salePrice,
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

  factory PurchaseRecordData.fromJson(Map<String, dynamic> json) {
    return PurchaseRecordData(
      id: json['id'] as int?,
      purchaseDate: json['purchase_date'] as String?,
      productId: json['product_id'] as String?,
      supplierId: json['supplier_id'] as String?,
      purchaseId: json['purchase_id'] as String?,
      warehouseId: json['warehouse_id'] as String?,
      productUnitId: json['product_unit_id'] as String?,
      productName: json['product_name'] as String?,
      categoryId: json['category_id'] as String?,
      invoiceNo: json['invoice_no'] as String?,
      quantity: json['quantity'] as String?,
      total: json['total'] as String?,
      barcode: json['barcode'] as String?,
      purchasePrice: json['purchase_price'] as String?,
      salePrice: json['sale_price'] as String?,
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
