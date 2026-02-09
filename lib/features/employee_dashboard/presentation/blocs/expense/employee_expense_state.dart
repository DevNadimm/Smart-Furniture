part of 'employee_expense_bloc.dart';

abstract class EmployeeExpenseState {}

class EmployeeExpenseInitial extends EmployeeExpenseState {}

class EmployeeExpenseLoading extends EmployeeExpenseState {}

class EmployeeExpenseLoaded extends EmployeeExpenseState {
  final EmployeeExpenseModel expenseModel;

  EmployeeExpenseLoaded(this.expenseModel);
}

class EmployeeExpenseOperationLoading extends EmployeeExpenseState {}

class EmployeeExpenseOperationSuccess extends EmployeeExpenseState {
  final String message;

  EmployeeExpenseOperationSuccess(this.message);
}

class EmployeeExpenseError extends EmployeeExpenseState {
  final String message;

  EmployeeExpenseError(this.message);
}
