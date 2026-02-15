part of 'supplier_dues_bloc.dart';

abstract class SupplierDuesState {}

/// Initial state
class SupplierDuesInitial extends SupplierDuesState {}

/// Loading state for fetching dues
class SupplierDuesLoading extends SupplierDuesState {}

/// State when all supplier dues are loaded
class SupplierDuesLoaded extends SupplierDuesState {
  final SupplierDuesModel supplierDuesModel;

  SupplierDuesLoaded(this.supplierDuesModel);
}

/// Error state
class SupplierDuesError extends SupplierDuesState {
  final String message;

  SupplierDuesError(this.message);
}