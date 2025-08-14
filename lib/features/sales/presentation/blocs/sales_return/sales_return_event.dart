part of 'sales_return_bloc.dart';

abstract class SalesReturnEvent {}

class LoadSalesReturnEvent extends SalesReturnEvent {
  final String shop;
  final String? fromDate;
  final String? toDate;
  final String? customerId;

  LoadSalesReturnEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
    required this.customerId,
  });
}
