part of 'due_payment_bloc.dart';

abstract class DuePaymentState {}

/// Initial state
class DuePaymentInitial extends DuePaymentState {}

/// Loading state for payment operation
class DuePaymentLoading extends DuePaymentState {}

/// Success state for payment operation
class DuePaymentSuccess extends DuePaymentState {
  final String message;

  DuePaymentSuccess(this.message);
}

/// Error state
class DuePaymentError extends DuePaymentState {
  final String message;

  DuePaymentError(this.message);
}
