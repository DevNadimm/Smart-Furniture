part of 'purchase_details_bloc.dart';

@immutable
sealed class PurchaseDetailsEvent {}

class LoadPurchaseDetailsEvent extends PurchaseDetailsEvent {
  final int purchaseId;

  LoadPurchaseDetailsEvent(this.purchaseId);
}
