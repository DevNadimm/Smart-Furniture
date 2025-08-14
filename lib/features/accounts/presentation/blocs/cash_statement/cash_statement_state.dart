part of 'cash_statement_bloc.dart';

abstract class CashStatementState {}

class CashStatementInitial extends CashStatementState {}

class CashStatementLoading extends CashStatementState {}

class CashStatementLoaded extends CashStatementState {
  final CashStatementModel cashStatementModel;

  CashStatementLoaded(this.cashStatementModel);
}

class CashStatementError extends CashStatementState {
  final String message;

  CashStatementError(this.message);
}
