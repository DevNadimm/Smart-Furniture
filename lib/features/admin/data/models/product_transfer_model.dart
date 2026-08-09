import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class ProductTransferModel {
  final bool? success;
  final List<Transfer>? transfers;
  final TransferSummary? summary;

  ProductTransferModel({
    this.success,
    this.transfers,
    this.summary,
  });

  factory ProductTransferModel.fromJson(Map<String, dynamic> json) {
    return ProductTransferModel(
      success: SafeParse.toBool(json['success']),
      transfers: (json['transfers'] as List?)
          ?.map((e) => Transfer.fromJson(e))
          .toList(),
      summary: json['summary'] != null
          ? TransferSummary.fromJson(json['summary'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'transfers': transfers?.map((e) => e.toJson()).toList(),
      'summary': summary?.toJson(),
    };
  }
}

class Transfer {
  final int? id;
  final String? transferNumber;
  final String? transferDate;
  final Branch? toBranch;
  final int? itemsCount;
  final int? totalQuantity;
  final num? totalAmount;

  Transfer({
    this.id,
    this.transferNumber,
    this.transferDate,
    this.toBranch,
    this.itemsCount,
    this.totalQuantity,
    this.totalAmount,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      id: SafeParse.toInt(json['id']),
      transferNumber: SafeParse.toStringValue(json['transfer_number']),
      transferDate: SafeParse.toStringValue(json['transfer_date']),
      toBranch:
          json['to_branch'] != null ? Branch.fromJson(json['to_branch']) : null,
      itemsCount: SafeParse.toInt(json['items_count']),
      totalQuantity: SafeParse.toInt(json['total_quantity']),
      totalAmount: SafeParse.toDouble(json['total_amount']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transfer_number': transferNumber,
      'transfer_date': transferDate,
      'to_branch': toBranch?.toJson(),
      'items_count': itemsCount,
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
    };
  }
}

class Branch {
  final int? id;
  final String? name;

  Branch({
    this.id,
    this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: SafeParse.toInt(json['id']),
      name: SafeParse.toStringValue(json['name']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class TransferSummary {
  final int? totalQuantity;
  final num? totalAmount;
  final int? totalTransfers;

  TransferSummary({
    this.totalQuantity,
    this.totalAmount,
    this.totalTransfers,
  });

  factory TransferSummary.fromJson(Map<String, dynamic> json) {
    return TransferSummary(
      totalQuantity: SafeParse.toInt(json['total_quantity']),
      totalAmount: SafeParse.toDouble(json['total_amount']),
      totalTransfers: SafeParse.toInt(json['total_transfers']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_quantity': totalQuantity,
      'total_amount': totalAmount,
      'total_transfers': totalTransfers,
    };
  }
}
