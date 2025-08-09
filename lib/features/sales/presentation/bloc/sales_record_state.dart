part of 'sales_record_bloc.dart';

abstract class SalesRecordState {}

class SalesRecordInitial extends SalesRecordState {}

class SalesRecordLoading extends SalesRecordState {}

// class SalesRecordLoaded extends SalesRecordState {
//   final List<SalesRecordEntity> salesRecords;
//
//   SalesRecordLoaded(this.salesRecords);
// }

class SalesRecordError extends SalesRecordState {
  final String message;

  SalesRecordError(this.message);
}
