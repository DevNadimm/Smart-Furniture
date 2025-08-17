part of 'customer_payment_bloc.dart';

abstract class CustomerPaymentEvent {}

class LoadCustomerPaymentEvent extends CustomerPaymentEvent {
  final String shop;
  final String fromDate;
  final String toDate;
  final String customerId;

  LoadCustomerPaymentEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
    required this.customerId,
  });
}

class ResetCustomerPaymentEvent extends CustomerPaymentEvent {}
