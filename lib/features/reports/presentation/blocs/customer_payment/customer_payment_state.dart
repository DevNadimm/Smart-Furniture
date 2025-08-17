part of 'customer_payment_bloc.dart';

abstract class CustomerPaymentState {}

class CustomerPaymentInitial extends CustomerPaymentState {}

class CustomerPaymentLoading extends CustomerPaymentState {}

class CustomerPaymentLoaded extends CustomerPaymentState {
  final CustomerPaymentModel customerPaymentModel;

  CustomerPaymentLoaded(this.customerPaymentModel);
}

class CustomerPaymentError extends CustomerPaymentState {
  final String message;

  CustomerPaymentError(this.message);
}
