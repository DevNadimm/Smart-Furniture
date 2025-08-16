part of 'bank_transaction_bloc.dart';

abstract class BankTransactionEvent {}

class LoadBankTransactionEvent extends BankTransactionEvent {
  final String shop;
  final String accountId;
  final String type;
  final String fromDate;
  final String toDate;

  LoadBankTransactionEvent({
    required this.shop,
    required this.accountId,
    required this.type,
    required this.fromDate,
    required this.toDate,
  });
}

class ResetBankTransactionEvent extends BankTransactionEvent {}
