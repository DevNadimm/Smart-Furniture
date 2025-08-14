part of 'cash_transaction_bloc.dart';

abstract class CashTransactionState {}

class CashTransactionInitial extends CashTransactionState {}

class CashTransactionLoading extends CashTransactionState {}

class CashTransactionLoaded extends CashTransactionState {
  final CashTransactionModel cashTransactionModel;

  CashTransactionLoaded(this.cashTransactionModel);
}

class CashTransactionError extends CashTransactionState {
  final String message;

  CashTransactionError(this.message);
}
