part of 'supplier_bloc.dart';

abstract class SupplierState {}

class SupplierInitial extends SupplierState {}

class SupplierLoading extends SupplierState {}

class SupplierLoaded extends SupplierState {
  final List<SupplierData> suppliers;

  SupplierLoaded(this.suppliers);
}

class SupplierError extends SupplierState {
  final String message;

  SupplierError(this.message);
}