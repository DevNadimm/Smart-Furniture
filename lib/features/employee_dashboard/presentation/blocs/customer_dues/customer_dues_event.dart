part of 'customer_dues_bloc.dart';

abstract class CustomerDuesEvent {}

class LoadCustomerDuesEvent extends CustomerDuesEvent {
  final int? branchId;

  LoadCustomerDuesEvent({this.branchId});
}
