part of 'employee_expense_bloc.dart';

abstract class EmployeeExpenseEvent {}

class LoadEmployeeExpensesEvent extends EmployeeExpenseEvent {
  final int? branchId;
  final String? fromDate;
  final String? toDate;
  final String? headId;

  LoadEmployeeExpensesEvent({this.branchId, this.fromDate, this.toDate, this.headId});
}

class CreateEmployeeExpenseEvent extends EmployeeExpenseEvent {
  final Map<String, dynamic> expenseData;

  CreateEmployeeExpenseEvent(this.expenseData);
}

class UpdateEmployeeExpenseEvent extends EmployeeExpenseEvent {
  final int id;
  final Map<String, dynamic> expenseData;

  UpdateEmployeeExpenseEvent(this.id, this.expenseData);
}

class DeleteEmployeeExpenseEvent extends EmployeeExpenseEvent {
  final int id;

  DeleteEmployeeExpenseEvent(this.id);
}
