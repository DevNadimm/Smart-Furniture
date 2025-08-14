part of 'purchase_return_bloc.dart';

abstract class PurchaseReturnEvent {}

class LoadPurchaseReturnEvent extends PurchaseReturnEvent {
  final String shop;
  final String? fromDate;
  final String? toDate;
  final String? supplierId;

  LoadPurchaseReturnEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
    required this.supplierId,
  });
}
