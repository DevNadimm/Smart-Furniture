part of 'store_custom_order_bloc.dart';

abstract class StoreCustomOrderState {}

class StoreCustomOrderInitial extends StoreCustomOrderState {}

class StoreCustomOrderLoading extends StoreCustomOrderState {}

class StoreCustomOrderSuccess extends StoreCustomOrderState {
  final String message;
  StoreCustomOrderSuccess(this.message);
}

class StoreCustomOrderError extends StoreCustomOrderState {
  final String message;
  StoreCustomOrderError(this.message);
}
