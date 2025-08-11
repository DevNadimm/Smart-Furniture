part of 'supplier_list_bloc.dart';

abstract class SupplierListState {}

class SupplierListInitial extends SupplierListState {}

class SupplierListLoading extends SupplierListState {}

class SupplierListLoaded extends SupplierListState {
  final SupplierListModel supplierListModel;

  SupplierListLoaded(this.supplierListModel);
}

class SupplierListError extends SupplierListState {
  final String message;

  SupplierListError(this.message);
}
