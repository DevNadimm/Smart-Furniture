part of 'sales_return_bloc.dart';

abstract class SalesReturnState {}

class SalesReturnInitial extends SalesReturnState {}

class SalesReturnLoading extends SalesReturnState {}

class SalesReturnLoaded extends SalesReturnState {
  final SalesReturnModel salesReturnModel;

  SalesReturnLoaded(this.salesReturnModel);
}

class SalesReturnError extends SalesReturnState {
  final String message;

  SalesReturnError(this.message);
}
