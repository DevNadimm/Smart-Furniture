class EmployeeExpenseModel {
  final bool? success;
  final List<EmployeeExpenseData>? data;

  EmployeeExpenseModel({
    this.success,
    this.data,
  });

  factory EmployeeExpenseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeExpenseModel(
      success: json['success'] as bool?,
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
      id: json['id'] as int?,
      transactionDate: json['transaction_date'] as String?,
      amount: json['amount'] as String?,
      remarks: json['remarks'] as String?,
      expenseId: json['expense_id'] as String?,
      branchId: json['branch_id'] as String?,
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
      id: json['id'] as int?,
      head: json['head'] as String?,
      nameBn: json['name_bn'] as String?,
      description: json['description'] as String?,
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
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
