import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class ExpenseHeadModel {
  final bool? success;
  final List<ExpenseHeadData>? data;

  ExpenseHeadModel({this.success, this.data});

  factory ExpenseHeadModel.fromJson(Map<String, dynamic> json) {
    return ExpenseHeadModel(
      success: SafeParse.toBool(json['success']),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExpenseHeadData.fromJson(e))
          .toList(),
    );
  }
}

class ExpenseHeadData {
  final int? id;
  final String? head;
  final String? nameBn; // ✅ NEW
  final String? description;

  ExpenseHeadData({
    this.id,
    this.head,
    this.nameBn,
    this.description,
  });

  factory ExpenseHeadData.fromJson(Map<String, dynamic> json) {
    return ExpenseHeadData(
      id: SafeParse.toInt(json['id']),
      head: SafeParse.toStringValue(json['head']),
      nameBn: SafeParse.toStringValue(json['name_bn']),
      description: SafeParse.toStringValue(json['description']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'head': head,
      'name_bn': nameBn,
      'description': description,
    };
  }
}
