import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class CustomOrderModel {
  final bool? success;
  final List<CustomOrderData>? data;
  final OrderSummary? summary;

  CustomOrderModel({
    this.success,
    this.data,
    this.summary,
  });

  factory CustomOrderModel.fromJson(Map<String, dynamic> json) {
    return CustomOrderModel(
      success: SafeParse.toBool(json['success']),
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => CustomOrderData.fromJson(e))
          .toList()
          : null,
      summary: json['summary'] != null
          ? OrderSummary.fromJson(json['summary'])
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
      id: SafeParse.toInt(json['id']),
      orderNo: SafeParse.toStringValue(json['order_no']),
      orderDate: SafeParse.toStringValue(json['order_date']),
      orderDateFormatted: SafeParse.toStringValue(json['order_date_formatted']),
      customer: json['customer'] != null
          ? CustomInfo.fromJson(json['customer'])
          : null,
      branch: SafeParse.toStringValue(json['branch']),
      subTotal: SafeParse.toNum(json['sub_total']),
      discount: SafeParse.toNum(json['discount']),
      totalAmount: SafeParse.toNum(json['total_amount']),
      paidAmount: SafeParse.toNum(json['paid_amount']),
      dueAmount: SafeParse.toNum(json['due_amount']),
      status: SafeParse.toStringValue(json['status']),
      expectedDeliveryDate: SafeParse.toStringValue(json['expected_delivery_date']),
      actualDeliveryDate: SafeParse.toStringValue(json['actual_delivery_date']),
      deliveryAddress: SafeParse.toStringValue(json['delivery_address']),
      itemsCount: SafeParse.toInt(json['items_count']),
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
      id: SafeParse.toInt(json['id']),
      name: SafeParse.toStringValue(json['name']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      phone: SafeParse.toStringValue(json['phone']),
      email: SafeParse.toStringValue(json['email']),
      address: SafeParse.toStringValue(json['address']),
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
      id: SafeParse.toInt(json['id']),
      productName: SafeParse.toStringValue(json['product_name']),
      image: SafeParse.toStringValue(json['image']),
      unit: SafeParse.toStringValue(json['unit']),
      orderedQuantity: SafeParse.toInt(json['ordered_quantity']),
      unitPrice: SafeParse.toNum(json['unit_price']),
      totalPrice: SafeParse.toNum(json['total_price']),
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

class OrderSummary {
  final SummaryStatus? pending;
  final SummaryStatus? delivered;

  OrderSummary({
    this.pending,
    this.delivered,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      pending: json['pending'] != null
          ? SummaryStatus.fromJson(json['pending'])
          : null,
      delivered: json['delivered'] != null
          ? SummaryStatus.fromJson(json['delivered'])
          : null,
    );
  }
}

class SummaryStatus {
  final int? count;
  final int? totalQuantity;
  final num? totalValue;

  SummaryStatus({
    this.count,
    this.totalQuantity,
    this.totalValue,
  });

  factory SummaryStatus.fromJson(Map<String, dynamic> json) {
    return SummaryStatus(
      count: SafeParse.toInt(json['count']),
      totalQuantity: SafeParse.toInt(json['total_quantity']),
      totalValue: SafeParse.toNum(json['total_value']),
    );
  }
}
