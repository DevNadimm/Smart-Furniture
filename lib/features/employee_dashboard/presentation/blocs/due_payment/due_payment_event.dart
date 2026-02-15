part of 'due_payment_bloc.dart';

abstract class DuePaymentEvent {}

/// Make a due payment
class MakeDuePaymentEvent extends DuePaymentEvent {
  final Map<String, dynamic> paymentData;

  MakeDuePaymentEvent(this.paymentData);
}

/// Reset to initial state
class ResetDuePaymentEvent extends DuePaymentEvent {}