part of 'sales_record_bloc.dart';

abstract class SalesRecordEvent {}

class LoadSalesRecordEvent extends SalesRecordEvent {
  final String shop;
  final String? fromDate;
  final String? toDate;
  final String? categoryId;

  LoadSalesRecordEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
    required this.categoryId,
  });
}
