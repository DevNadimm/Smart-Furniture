part of 'purchase_return_bloc.dart';

abstract class PurchaseReturnState {}

class PurchaseReturnInitial extends PurchaseReturnState {}

class PurchaseReturnLoading extends PurchaseReturnState {}

class PurchaseReturnLoaded extends PurchaseReturnState {
  final PurchaseReturnModel purchaseReturnModel;

  PurchaseReturnLoaded(this.purchaseReturnModel);
}

class PurchaseReturnError extends PurchaseReturnState {
  final String message;

  PurchaseReturnError(this.message);
}
