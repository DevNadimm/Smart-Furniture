part of 'custom_order_bloc.dart';

abstract class CustomOrderState {}

class CustomOrderInitial extends CustomOrderState {}

class CustomOrderLoading extends CustomOrderState {}

class CustomOrderLoaded extends CustomOrderState {
  final CustomOrderModel orders;

  CustomOrderLoaded(this.orders);
}

class CustomOrderError extends CustomOrderState {
  final String message;

  CustomOrderError(this.message);
}
