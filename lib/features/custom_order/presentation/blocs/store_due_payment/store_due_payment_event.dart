part of 'store_due_payment_bloc.dart';

abstract class StoreDuePaymentEvent {}

class StoreDuePaymentSubmitEvent extends StoreDuePaymentEvent {
  final Map<String, dynamic> body;

  StoreDuePaymentSubmitEvent(this.body);
}
