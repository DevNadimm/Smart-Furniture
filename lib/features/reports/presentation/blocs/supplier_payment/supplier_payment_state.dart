part of 'supplier_payment_bloc.dart';

abstract class SupplierPaymentState {}

class SupplierPaymentInitial extends SupplierPaymentState {}

class SupplierPaymentLoading extends SupplierPaymentState {}

class SupplierPaymentLoaded extends SupplierPaymentState {
  final SupplierPaymentModel supplierPaymentModel;

  SupplierPaymentLoaded(this.supplierPaymentModel);
}

class SupplierPaymentError extends SupplierPaymentState {
  final String message;

  SupplierPaymentError(this.message);
}
