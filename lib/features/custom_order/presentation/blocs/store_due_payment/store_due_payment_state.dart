part of 'store_due_payment_bloc.dart';

abstract class StoreDuePaymentState {}

class StoreDuePaymentInitial extends StoreDuePaymentState {}

class StoreDuePaymentLoading extends StoreDuePaymentState {}

class StoreDuePaymentSuccess extends StoreDuePaymentState {
  final String message;

  StoreDuePaymentSuccess(this.message);
}

class StoreDuePaymentError extends StoreDuePaymentState {
  final String message;

  StoreDuePaymentError(this.message);
}
