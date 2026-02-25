part of 'product_transfer_bloc.dart';

abstract class ProductTransferState {}

class ProductTransferInitial extends ProductTransferState {}

class ProductTransferLoading extends ProductTransferState {}

class ProductTransferLoaded extends ProductTransferState {
  final ProductTransferModel transfers;

  ProductTransferLoaded(this.transfers);
}

class ProductTransferError extends ProductTransferState {
  final String message;

  ProductTransferError(this.message);
}
