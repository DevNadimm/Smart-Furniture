part of 'product_transfer_details_bloc.dart';

@immutable
sealed class ProductTransferDetailsState {}

final class ProductTransferDetailsInitial extends ProductTransferDetailsState {}

final class ProductTransferDetailsLoading extends ProductTransferDetailsState {}

final class ProductTransferDetailsLoaded extends ProductTransferDetailsState {
  final ProductTransferData transferDetails;

  ProductTransferDetailsLoaded(this.transferDetails);
}

final class ProductTransferDetailsError extends ProductTransferDetailsState {
  final String message;

  ProductTransferDetailsError(this.message);
}
