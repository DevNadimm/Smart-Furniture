part of 'supplier_due_details_bloc.dart';

abstract class SupplierDueDetailsEvent {}

/// Load supplier purchase dues by supplier ID
class LoadSupplierPurchaseDuesEvent extends SupplierDueDetailsEvent {
  final int supplierId;

  LoadSupplierPurchaseDuesEvent(this.supplierId);
}