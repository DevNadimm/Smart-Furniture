part of 'customer_bloc.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoaded extends CustomerState {
  final CustomerModel customerModel;

  CustomerLoaded(this.customerModel);
}

class CustomerOperationLoading extends CustomerState {}

class CustomerOperationSuccess extends CustomerState {
  final String message;

  CustomerOperationSuccess(this.message);
}

class CustomerError extends CustomerState {
  final String message;

  CustomerError(this.message);
}
