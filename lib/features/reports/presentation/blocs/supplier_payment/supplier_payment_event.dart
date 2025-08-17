part of 'supplier_payment_bloc.dart';

abstract class SupplierPaymentEvent {}

class LoadSupplierPaymentEvent extends SupplierPaymentEvent {
  final String shop;
  final String supplierId;

  LoadSupplierPaymentEvent({
    required this.shop,
    required this.supplierId,
  });
}

class ResetSupplierPaymentEvent extends SupplierPaymentEvent {}
