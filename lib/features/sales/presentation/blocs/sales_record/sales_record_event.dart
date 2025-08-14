part of 'sales_record_bloc.dart';

abstract class SalesRecordEvent {}

class LoadSalesRecordEvent extends SalesRecordEvent {
  final String shop;
  final String? fromDate;
  final String? toDate;

  LoadSalesRecordEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
  });
}
