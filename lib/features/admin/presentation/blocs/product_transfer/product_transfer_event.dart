part of 'product_transfer_bloc.dart';

abstract class ProductTransferEvent {}

class LoadTransfersEvent extends ProductTransferEvent {
  final String? fromDate;
  final String? toDate;
  final String? categoryId;
  final String? branchId;

  LoadTransfersEvent({
    required this.fromDate,
    required this.toDate,
    required this.categoryId,
    required this.branchId,
  });
}
