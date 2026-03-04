class StockRegisterModel {
  final bool? success;
  final StockRegisterData? data;

  StockRegisterModel({
    this.success,
    this.data,
  });

  factory StockRegisterModel.fromJson(Map<String, dynamic> json) {
    return StockRegisterModel(
      success: json['success'],
      data: json['data'] != null
          ? StockRegisterData.fromJson(json['data'])
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

class StockRegisterData {
  final StockRegisterProduct? product;
  final List<StockMovement>? movements;
  final StockRegisterSummary? summary;

  StockRegisterData({
    this.product,
    this.movements,
    this.summary,
  });

  factory StockRegisterData.fromJson(Map<String, dynamic> json) {
    return StockRegisterData(
      product: json['product'] != null
          ? StockRegisterProduct.fromJson(json['product'])
          : null,
      movements: json['movements'] != null
          ? List<StockMovement>.from(
        json['movements'].map(
              (x) => StockMovement.fromJson(x),
        ),
      )
          : null,
      summary: json['summary'] != null
          ? StockRegisterSummary.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product?.toJson(),
      'movements': movements?.map((x) => x.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class StockRegisterProduct {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? category;
  final String? categoryNameBn;
  final String? currentStock;
  final String? unit;

  StockRegisterProduct({
    this.id,
    this.name,
    this.nameBn,
    this.category,
    this.categoryNameBn,
    this.currentStock,
    this.unit,
  });

  factory StockRegisterProduct.fromJson(Map<String, dynamic> json) {
    return StockRegisterProduct(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      category: json['category'],
      categoryNameBn: json['category_name_bn'],
      currentStock: json['current_stock'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_bn': nameBn,
      'category': category,
      'category_name_bn': categoryNameBn,
      'current_stock': currentStock,
      'unit': unit,
    };
  }
}

class StockMovement {
  final String? date;
  final String? type;
  final String? reference;
  final String? inQuantity;
  final String? outQuantity;
  final String? balanceAfter;
  final String? notes;
  final String? createdBy;

  StockMovement({
    this.date,
    this.type,
    this.reference,
    this.inQuantity,
    this.outQuantity,
    this.balanceAfter,
    this.notes,
    this.createdBy,
  });

  factory StockMovement.fromJson(Map<String, dynamic> json) {
    return StockMovement(
      date: json['date'],
      type: json['type'],
      reference: json['reference'],
      inQuantity: json['in_quantity'],
      outQuantity: json['out_quantity'],
      balanceAfter: json['balance_after'],
      notes: json['notes'],
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'type': type,
      'reference': reference,
      'in_quantity': inQuantity,
      'out_quantity': outQuantity,
      'balance_after': balanceAfter,
      'notes': notes,
      'created_by': createdBy,
    };
  }
}

class StockRegisterSummary {
  final num? totalIn;
  final num? totalOut;

  StockRegisterSummary({
    this.totalIn,
    this.totalOut,
  });

  factory StockRegisterSummary.fromJson(Map<String, dynamic> json) {
    return StockRegisterSummary(
      totalIn: json['total_in'],
      totalOut: json['total_out'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_in': totalIn,
      'total_out': totalOut,
    };
  }
}
