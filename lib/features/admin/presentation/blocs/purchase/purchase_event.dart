part of 'purchase_bloc.dart';

abstract class PurchaseEvent {}

class LoadPurchasesEvent extends PurchaseEvent {
  final String? fromDate;
  final String? toDate;
  final String? categoryId;

  LoadPurchasesEvent({
    required this.fromDate,
    required this.toDate,
    required this.categoryId,
  });
}
