part of 'customer_bloc.dart';

abstract class CustomerEvent {}

class LoadCustomersEvent extends CustomerEvent {
  final int? branchId;

  LoadCustomersEvent({this.branchId});
}

class CreateCustomerEvent extends CustomerEvent {
  final Map<String, dynamic> customerData;

  CreateCustomerEvent(this.customerData);
}

class UpdateCustomerEvent extends CustomerEvent {
  final int id;
  final Map<String, dynamic> customerData;

  UpdateCustomerEvent(this.id, this.customerData);
}

class DeleteCustomerEvent extends CustomerEvent {
  final int id;

  DeleteCustomerEvent(this.id);
}