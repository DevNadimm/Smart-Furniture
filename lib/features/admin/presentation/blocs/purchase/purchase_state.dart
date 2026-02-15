part of 'purchase_bloc.dart';

abstract class PurchaseState {}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoading extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final PurchaseModel purchases;

  PurchaseLoaded(this.purchases);
}

class PurchaseError extends PurchaseState {
  final String message;

  PurchaseError(this.message);
}
