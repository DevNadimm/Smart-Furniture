part of 'bank_accounts_bloc.dart';

abstract class BankAccountsEvent {}

class LoadBankAccountsEvent extends BankAccountsEvent {
  final String shop;

  LoadBankAccountsEvent(this.shop);
}
