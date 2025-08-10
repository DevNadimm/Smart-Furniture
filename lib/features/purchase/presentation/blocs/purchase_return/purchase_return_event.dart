part of 'purchase_return_bloc.dart';

abstract class PurchaseReturnEvent {}

class LoadPurchaseReturnEvent extends PurchaseReturnEvent {
  final String? fromDate;
  final String? toDate;
  final String? supplierId;

  LoadPurchaseReturnEvent({
    required this.fromDate,
    required this.toDate,
    required this.supplierId,
  });
}
