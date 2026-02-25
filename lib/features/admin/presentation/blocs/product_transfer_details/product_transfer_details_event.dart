part of 'product_transfer_details_bloc.dart';

@immutable
sealed class ProductTransferDetailsEvent {}

class LoadTransferDetailsEvent extends ProductTransferDetailsEvent {
  final int transferId;

  LoadTransferDetailsEvent(this.transferId);
}
