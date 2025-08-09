class StockModel {
  final List<StockData>? data;
  final CalculateData? calculateData;

  StockModel({
    this.data,
    this.calculateData,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => StockData.fromJson(item))
          .toList(),
      calculateData: json['calculateData'] != null
          ? CalculateData.fromJson(json['calculateData'])
          : null,
    );
  }
}

class StockData {
  final String? productId;
  final String? colorId;
  final String? sizeId;
  final String? purchasePrice;
  final String? productName;
  final String? categoryName;
  final String? brand;
  final String? sku;
  final String? purchaseRate;
  final String? salesRate;
  final String? totalPurchased;
  final String? totalSoldQuantity;
  final String? remainingStock;

  StockData({
    this.productId,
    this.colorId,
    this.sizeId,
    this.purchasePrice,
    this.productName,
    this.categoryName,
    this.brand,
    this.sku,
    this.purchaseRate,
    this.salesRate,
    this.totalPurchased,
    this.totalSoldQuantity,
    this.remainingStock,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      productId: json['product_id'] as String?,
      colorId: json['color_id'] as String?,
      sizeId: json['size_id'] as String?,
      purchasePrice: json['purchase_price'] as String?,
      productName: json['product_name'] as String?,
      categoryName: json['category_name'] as String?,
      brand: json['brand'] as String?,
      sku: json['sku'] as String?,
      purchaseRate: json['purchase_rate'] as String?,
      salesRate: json['sales_rate'] as String?,
      totalPurchased: json['total_purchased'] as String?,
      totalSoldQuantity: json['total_sold_quantity'] as String?,
      remainingStock: json['remaining_stock'] as String?,
    );
  }
}

class CalculateData {
  final String? totalRemainingStock;
  final String? totalPurchasePrice;

  CalculateData({
    this.totalRemainingStock,
    this.totalPurchasePrice,
  });

  factory CalculateData.fromJson(Map<String, dynamic> json) {
    return CalculateData(
      totalRemainingStock: json['total_remaining_stock'] as String?,
      totalPurchasePrice: json['total_purchase_price'] as String?,
    );
  }
}

