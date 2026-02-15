part of 'purchase_details_bloc.dart';

@immutable
sealed class PurchaseDetailsState {}

final class PurchaseDetailsInitial extends PurchaseDetailsState {}

final class PurchaseDetailsLoading extends PurchaseDetailsState {}

final class PurchaseDetailsLoaded extends PurchaseDetailsState {
  final PurchaseDetailsData purchaseDetails;

  PurchaseDetailsLoaded(this.purchaseDetails);
}

final class PurchaseDetailsError extends PurchaseDetailsState {
  final String message;

  PurchaseDetailsError(this.message);
}
