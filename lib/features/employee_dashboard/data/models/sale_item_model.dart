class SaleItem {
  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final String? unitName;
  final String? image;

  SaleItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    this.unitName,
    this.image,
  });

  double get total => quantity * unitPrice;

  SaleItem copyWith({
    int? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    String? unitName,
    String? image,
  }) {
    return SaleItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      unitName: unitName ?? this.unitName,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'unit_price': unitPrice,
    };
  }
}