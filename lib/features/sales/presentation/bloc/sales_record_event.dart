part of 'sales_record_bloc.dart';

abstract class SalesRecordEvent {}

class LoadSalesRecordEvent extends SalesRecordEvent {
  final DateTime startDate;
  final DateTime endDate;

  LoadSalesRecordEvent({
    required this.startDate,
    required this.endDate,
  });
}
