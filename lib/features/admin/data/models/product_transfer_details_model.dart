class ProductTransferDetailsModel {
  final bool? success;
  final ProductTransferData? data;

  ProductTransferDetailsModel({
    this.success,
    this.data,
  });

  factory ProductTransferDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductTransferDetailsModel(
      success: json['success'],
      data: json['data'] != null
          ? ProductTransferData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class ProductTransferData {
  final int? id;
  final String? transferNumber;
  final String? transferDate;
  final Company? company;
  final String? fromLocation;
  final Branch? toBranch;
  final String? createdBy;
  final String? remarks;
  final List<TransferItem>? items;
  final TransferDetailsSummary? summary;

  ProductTransferData({
    this.id,
    this.transferNumber,
    this.transferDate,
    this.company,
    this.fromLocation,
    this.toBranch,
    this.createdBy,
    this.remarks,
    this.items,
    this.summary,
  });

  factory ProductTransferData.fromJson(Map<String, dynamic> json) {
    return ProductTransferData(
      id: json['id'],
      transferNumber: json['transfer_number'],
      transferDate: json['transfer_date'],
      company:
          json['company'] != null ? Company.fromJson(json['company']) : null,
      fromLocation: json['from_location'],
      toBranch:
          json['to_branch'] != null ? Branch.fromJson(json['to_branch']) : null,
      createdBy: json['created_by'],
      remarks: json['remarks'],
      items: (json['items'] as List?)
          ?.map((e) => TransferItem.fromJson(e))
          .toList(),
      summary: json['summary'] != null
          ? TransferDetailsSummary.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transfer_number': transferNumber,
      'transfer_date': transferDate,
      'company': company?.toJson(),
      'from_location': fromLocation,
      'to_branch': toBranch?.toJson(),
      'created_by': createdBy,
      'remarks': remarks,
      'items': items?.map((e) => e.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class Company {
  final String? name;

  Company({this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class Branch {
  final String? name;

  Branch({this.name});

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class TransferItem {
  final String? productName;
  final String? category;
  final String? unit;
  final num? quantity;
  final num? unitPrice;
  final num? total;

  TransferItem({
    this.productName,
    this.category,
    this.unit,
    this.quantity,
    this.unitPrice,
    this.total,
  });

  factory TransferItem.fromJson(Map<String, dynamic> json) {
    return TransferItem(
      productName: json['product_name'],
      category: json['category'],
      unit: json['unit'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'category': category,
      'unit': unit,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total': total,
    };
  }
}

class TransferDetailsSummary {
  final num? totalQuantity;
  final num? totalAmount;

  TransferDetailsSummary({
    this.totalQuantity,
    this.totalAmount,
  });

  factory TransferDetailsSummary.fromJson(Map<String, dynamic> json) {
    return TransferDetailsSummary(
      totalQuantity: json['total_quantity'],
      totalAmount: json['total_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
    };
  }
}
