part of 'customer_list_bloc.dart';

abstract class CustomerListState {}

class CustomerListInitial extends CustomerListState {}

class CustomerListLoading extends CustomerListState {}

class CustomerListLoaded extends CustomerListState {
  final CustomerListModel customerListModel;

  CustomerListLoaded(this.customerListModel);
}

class CustomerListError extends CustomerListState {
  final String message;

  CustomerListError(this.message);
}
