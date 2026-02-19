class CustomOrderModel {
  final bool? success;
  final List<CustomOrderData>? data;

  CustomOrderModel({
    this.success,
    this.data,
  });

  factory CustomOrderModel.fromJson(Map<String, dynamic> json) {
    return CustomOrderModel(
      success: json['success'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => CustomOrderData.fromJson(e))
              .toList()
          : null,
    );
  }
}

class CustomOrderData {
  final int? id;
  final String? orderNo;
  final String? orderDate;
  final String? orderDateFormatted;
  final CustomInfo? customer;
  final String? branch;
  final num? subTotal;
  final num? discount;
  final num? totalAmount;
  final num? paidAmount;
  final num? dueAmount;
  final String? status;
  final String? expectedDeliveryDate;
  final String? actualDeliveryDate;
  final String? deliveryAddress;
  final int? itemsCount;
  final List<CustomOrderItem>? items;

  CustomOrderData({
    this.id,
    this.orderNo,
    this.orderDate,
    this.orderDateFormatted,
    this.customer,
    this.branch,
    this.subTotal,
    this.discount,
    this.totalAmount,
    this.paidAmount,
    this.dueAmount,
    this.status,
    this.expectedDeliveryDate,
    this.actualDeliveryDate,
    this.deliveryAddress,
    this.itemsCount,
    this.items,
  });

  factory CustomOrderData.fromJson(Map<String, dynamic> json) {
    return CustomOrderData(
      id: json['id'],
      orderNo: json['order_no'],
      orderDate: json['order_date'],
      orderDateFormatted: json['order_date_formatted'],
      customer: json['customer'] != null
          ? CustomInfo.fromJson(json['customer'])
          : null,
      branch: json['branch'],
      subTotal: json['sub_total'],
      discount: json['discount'],
      totalAmount: json['total_amount'],
      paidAmount: json['paid_amount'],
      dueAmount: json['due_amount'],
      status: json['status'],
      expectedDeliveryDate: json['expected_delivery_date'],
      actualDeliveryDate: json['actual_delivery_date'],
      deliveryAddress: json['delivery_address'],
      itemsCount: json['items_count'],
      items: json['items'] != null
          ? (json['items'] as List)
              .map((e) => CustomOrderItem.fromJson(e))
              .toList()
          : null,
    );
  }
}

class CustomInfo {
  final int? id;
  final String? name;
  final String? nameBn;
  final String? phone;
  final String? email;
  final String? address;

  CustomInfo({
    this.id,
    this.name,
    this.nameBn,
    this.phone,
    this.email,
    this.address,
  });

  factory CustomInfo.fromJson(Map<String, dynamic> json) {
    return CustomInfo(
      id: json['id'],
      name: json['name'],
      nameBn: json['name_bn'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
    );
  }
}

class CustomOrderItem {
  final int? id;
  final String? productName;
  final String? image;
  final String? unit;
  final int? orderedQuantity;
  final num? unitPrice;
  final num? totalPrice;

  CustomOrderItem({
    this.id,
    this.productName,
    this.image,
    this.unit,
    this.orderedQuantity,
    this.unitPrice,
    this.totalPrice,
  });

  factory CustomOrderItem.fromJson(Map<String, dynamic> json) {
    return CustomOrderItem(
      id: json['id'],
      productName: json['product_name'],
      image: json['image'],
      unit: json['unit'],
      orderedQuantity: json['ordered_quantity'],
      unitPrice: json['unit_price'],
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'image': image,
      'unit': unit,
      'ordered_quantity': orderedQuantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
    };
  }
}
