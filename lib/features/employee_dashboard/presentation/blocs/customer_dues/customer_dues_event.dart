part of 'customer_dues_bloc.dart';

abstract class CustomerDuesEvent {}

/// Load all customer dues
class LoadCustomerDuesEvent extends CustomerDuesEvent {}