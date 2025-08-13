part of 'customer_list_bloc.dart';

abstract class CustomerListEvent {}

class LoadCustomerListEvent extends CustomerListEvent {
  final String shop;

  LoadCustomerListEvent(this.shop);
}
