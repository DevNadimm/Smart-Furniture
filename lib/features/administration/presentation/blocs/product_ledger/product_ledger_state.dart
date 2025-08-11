part of 'product_ledger_bloc.dart';

abstract class ProductLedgerState {}

class ProductLedgerInitial extends ProductLedgerState {}

class ProductLedgerLoading extends ProductLedgerState {}

class ProductLedgerLoaded extends ProductLedgerState {
  final ProductLedgerModel productLedgerModel;

  ProductLedgerLoaded(this.productLedgerModel);
}

class ProductLedgerError extends ProductLedgerState {
  final String message;

  ProductLedgerError(this.message);
}
