part of 'supplier_list_bloc.dart';

abstract class SupplierListEvent {}

class LoadSupplierListEvent extends SupplierListEvent {
  final String shop;

  LoadSupplierListEvent(this.shop);
}
