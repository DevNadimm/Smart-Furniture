part of 'customer_dues_bloc.dart';

abstract class CustomerDuesState {}

/// Initial state
class CustomerDuesInitial extends CustomerDuesState {}

/// Loading state for fetching dues
class CustomerDuesLoading extends CustomerDuesState {}

/// State when all customer dues are loaded
class CustomerDuesLoaded extends CustomerDuesState {
  final CustomerDuesModel customerDuesModel;

  CustomerDuesLoaded(this.customerDuesModel);
}

/// Error state
class CustomerDuesError extends CustomerDuesState {
  final String message;

  CustomerDuesError(this.message);
}