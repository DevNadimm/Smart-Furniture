class StockModel {
  final bool? success;
  final List<StockData>? data;
  final CalculateData? calculateData;

  StockModel({
    this.success,
    this.data,
    this.calculateData,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => StockData.fromJson(item as Map<String, dynamic>))
          .toList(),
      calculateData: json['calculateData'] != null
          ? CalculateData.fromJson(json['calculateData'] as Map<String, dynamic>)
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
  final String? productNameBangla;
  final String? categoryName;
  final String? categoryNameBangla;
  final String? brandName;
  final String? brandNameBangla;
  final String? sku;
  final String? purchaseRate;
  final String? salesRate;
  final String? totalPurchased;
  final String? totalPurchaseReturn;
  final String? totalSold;
  final String? totalSaleReturn;
  final String? totalDamages;
  final String? remainingStock;

  StockData({
    this.productId,
    this.colorId,
    this.sizeId,
    this.purchasePrice,
    this.productName,
    this.productNameBangla,
    this.categoryName,
    this.categoryNameBangla,
    this.brandName,
    this.brandNameBangla,
    this.sku,
    this.purchaseRate,
    this.salesRate,
    this.totalPurchased,
    this.totalPurchaseReturn,
    this.totalSold,
    this.totalSaleReturn,
    this.totalDamages,
    this.remainingStock,
  });

  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      productId: json['product_id'] as String?,
      colorId: json['color_id'] as String?,
      sizeId: json['size_id'] as String?,
      purchasePrice: json['purchase_price'] as String?,
      productName: json['product_name'] as String?,
      productNameBangla: json['product_name_bangla'] as String?,
      categoryName: json['category_name'] as String?,
      categoryNameBangla: json['category_name_bangla'] as String?,
      brandName: json['brand_name'] as String?,
      brandNameBangla: json['brand_name_bangla'] as String?,
      sku: json['sku'] as String?,
      purchaseRate: json['purchase_rate'] as String?,
      salesRate: json['sales_rate'] as String?,
      totalPurchased: json['total_purchased'] as String?,
      totalPurchaseReturn: json['total_purchase_return'] as String?,
      totalSold: json['total_sold'] as String?,
      totalSaleReturn: json['total_sale_return'] as String?,
      totalDamages: json['total_demages'] as String?,
      remainingStock: json['remaining_stock'] as String?,
    );
  }
}

class CalculateData {
  final int? totalRemainingStock;
  final int? totalPurchasePrice;

  CalculateData({
    this.totalRemainingStock,
    this.totalPurchasePrice,
  });

  factory CalculateData.fromJson(Map<String, dynamic> json) {
    return CalculateData(
      totalRemainingStock: json['total_remaining_stock'] as int?,
      totalPurchasePrice: json['total_purchase_price'] as int?,
    );
  }
}
