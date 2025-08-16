part of 'bank_transaction_bloc.dart';

abstract class BankTransactionState {}

class BankTransactionInitial extends BankTransactionState {}

class BankTransactionLoading extends BankTransactionState {}

class BankTransactionLoaded extends BankTransactionState {
  final BankTransactionModel bankTransactionModel;

  BankTransactionLoaded(this.bankTransactionModel);
}

class BankTransactionError extends BankTransactionState {
  final String message;

  BankTransactionError(this.message);
}
