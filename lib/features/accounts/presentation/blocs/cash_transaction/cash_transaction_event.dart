part of 'cash_transaction_bloc.dart';

abstract class CashTransactionEvent {}

class LoadCashTransactionEvent extends CashTransactionEvent {
  final String shop;
  final String type;
  final String fromDate;
  final String toDate;

  LoadCashTransactionEvent({
    required this.shop,
    required this.type,
    required this.fromDate,
    required this.toDate,
  });
}

class ResetCashTransactionEvent extends CashTransactionEvent {}
