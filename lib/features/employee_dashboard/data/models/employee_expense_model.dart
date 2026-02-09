class EmployeeExpenseModel {
  final bool? success;
  final List<EmployeeExpenseData>? data;

  EmployeeExpenseModel({
    this.success,
    this.data,
  });

  factory EmployeeExpenseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeExpenseModel(
      success: json['success'],
      data: (json['data'] as List?)
          ?.map((e) => EmployeeExpenseData.fromJson(e))
          .toList(),
    );
  }
}

class EmployeeExpenseData {
  final int? id;
  final String? transactionDate;
  final String? amount;
  final String? remarks;
  final String? expenseId;
  final ExpenseHead? expense;

  EmployeeExpenseData({
    this.id,
    this.transactionDate,
    this.amount,
    this.remarks,
    this.expenseId,
    this.expense,
  });

  factory EmployeeExpenseData.fromJson(Map<String, dynamic> json) {
    return EmployeeExpenseData(
      id: json['id'],
      transactionDate: json['transaction_date'],
      amount: json['amount'],
      remarks: json['remarks'],
      expenseId: json['expense_id'],
      expense: json['expense'] != null
          ? ExpenseHead.fromJson(json['expense'])
          : null,
    );
  }
}

class ExpenseHead {
  final int? id;
  final String? head;
  final String? description;

  ExpenseHead({
    this.id,
    this.head,
    this.description,
  });

  factory ExpenseHead.fromJson(Map<String, dynamic> json) {
    return ExpenseHead(
      id: json['id'],
      head: json['head'],
      description: json['description'],
    );
  }
}
