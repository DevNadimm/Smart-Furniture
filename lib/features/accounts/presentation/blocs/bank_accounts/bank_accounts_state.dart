part of 'bank_accounts_bloc.dart';

abstract class BankAccountsState {}

class BankAccountsInitial extends BankAccountsState {}

class BankAccountsLoading extends BankAccountsState {}

class BankAccountsLoaded extends BankAccountsState {
  final BankAccountsModel bankAccountModel;

  BankAccountsLoaded(this.bankAccountModel);
}

class BankAccountsError extends BankAccountsState {
  final String message;

  BankAccountsError(this.message);
}
