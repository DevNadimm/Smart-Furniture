part of 'sales_record_bloc.dart';

abstract class SalesRecordEvent {}

class LoadSalesRecordEvent extends SalesRecordEvent {
  final String? fromDate;
  final String? toDate;

  LoadSalesRecordEvent({
    required this.fromDate,
    required this.toDate,
  });
}
