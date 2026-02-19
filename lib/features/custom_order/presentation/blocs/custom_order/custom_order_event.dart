part of 'custom_order_bloc.dart';

abstract class CustomOrderEvent {}

class LoadCustomOrdersEvent extends CustomOrderEvent {
  final int? branchId;
  final String? fromDate;
  final String? toDate;
  final String? status;

  LoadCustomOrdersEvent({
    this.branchId,
    this.fromDate,
    this.toDate,
    this.status,
  });
}
