part of 'expense_head_bloc.dart';

abstract class ExpenseHeadState {}

class ExpenseHeadInitial extends ExpenseHeadState {}

class ExpenseHeadLoading extends ExpenseHeadState {}

class ExpenseHeadLoaded extends ExpenseHeadState {
  final List<ExpenseHeadData> expenseHeads;

  ExpenseHeadLoaded(this.expenseHeads);
}

class ExpenseHeadError extends ExpenseHeadState {
  final String message;

  ExpenseHeadError(this.message);
}
