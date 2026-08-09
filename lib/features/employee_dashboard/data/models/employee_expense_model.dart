import 'package:smart_furniture/core/utils/helper_functions/safe_parse.dart';

class EmployeeExpenseModel {
  final bool? success;
  final List<EmployeeExpenseData>? data;

  EmployeeExpenseModel({
    this.success,
    this.data,
  });

  factory EmployeeExpenseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeExpenseModel(
      success: SafeParse.toBool(json['success']),
      data: (json['data'] as List?)
          ?.map((e) => EmployeeExpenseData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class EmployeeExpenseData {
  final int? id;
  final String? transactionDate;
  final String? amount;
  final String? remarks;
  final String? expenseId;
  final String? branchId;
  final ExpenseHead? expense;
  final BranchInfo? branch;

  EmployeeExpenseData({
    this.id,
    this.transactionDate,
    this.amount,
    this.remarks,
    this.expenseId,
    this.branchId,
    this.expense,
    this.branch,
  });

  factory EmployeeExpenseData.fromJson(Map<String, dynamic> json) {
    return EmployeeExpenseData(
      id: SafeParse.toInt(json['id']),
      transactionDate: SafeParse.toStringValue(json['transaction_date']),
      amount: SafeParse.toStringValue(json['amount']),
      remarks: SafeParse.toStringValue(json['remarks']),
      expenseId: SafeParse.toStringValue(json['expense_id']),
      branchId: SafeParse.toStringValue(json['branch_id']),
      expense: json['expense'] != null
          ? ExpenseHead.fromJson(json['expense'])
          : null,
      branch:
          json['branch'] != null ? BranchInfo.fromJson(json['branch']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_date': transactionDate,
      'amount': amount,
      'remarks': remarks,
      'expense_id': expenseId,
      'branch_id': branchId,
      'expense': expense?.toJson(),
      'branch': branch?.toJson(),
    };
  }
}

class ExpenseHead {
  final int? id;
  final String? head;
  final String? nameBn; // ✅ NEW
  final String? description;

  ExpenseHead({
    this.id,
    this.head,
    this.nameBn,
    this.description,
  });

  factory ExpenseHead.fromJson(Map<String, dynamic> json) {
    return ExpenseHead(
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

class BranchInfo {
  final int? id;
  final String? name;

  BranchInfo({
    this.id,
    this.name,
  });

  factory BranchInfo.fromJson(Map<String, dynamic> json) {
    return BranchInfo(
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
