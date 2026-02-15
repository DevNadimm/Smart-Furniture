part of 'supplier_due_details_bloc.dart';

abstract class SupplierDueDetailsState {}

/// Initial state
class SupplierDueDetailsInitial extends SupplierDueDetailsState {}

/// Loading state for fetching supplier purchase dues
class SupplierDueDetailsLoading extends SupplierDueDetailsState {}

/// State when supplier purchase dues are loaded
class SupplierDueDetailsLoaded extends SupplierDueDetailsState {
  final SupplierPurchaseDueModel supplierPurchaseDueModel;

  SupplierDueDetailsLoaded(this.supplierPurchaseDueModel);
}

/// Error state
class SupplierDueDetailsError extends SupplierDueDetailsState {
  final String message;

  SupplierDueDetailsError(this.message);
}