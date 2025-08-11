part of 'product_ledger_bloc.dart';

abstract class ProductLedgerEvent {}

class LoadProductLedgerEvent extends ProductLedgerEvent {
  final String? productId;
  final String? fromDate;
  final String? toDate;

  LoadProductLedgerEvent({
    required this.productId,
    required this.fromDate,
    required this.toDate,
  });
}

class ResetProductLedgerEvent extends ProductLedgerEvent {}
