part of 'customer_purchase_dues_bloc.dart';

abstract class CustomerPurchaseDuesState {}

/// Initial state
class CustomerPurchaseDuesInitial extends CustomerPurchaseDuesState {}

/// Loading state
class CustomerPurchaseDuesLoading extends CustomerPurchaseDuesState {}

/// State when customer purchase dues are loaded
class CustomerPurchaseDuesLoaded extends CustomerPurchaseDuesState {
  final CustomerPurchaseDueModel customerPurchaseDueModel;

  CustomerPurchaseDuesLoaded(this.customerPurchaseDueModel);
}

/// Error state
class CustomerPurchaseDuesError extends CustomerPurchaseDuesState {
  final String message;

  CustomerPurchaseDuesError(this.message);
}
