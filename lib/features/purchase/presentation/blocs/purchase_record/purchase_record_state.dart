part of 'purchase_record_bloc.dart';

abstract class PurchaseRecordState {}

class PurchaseRecordInitial extends PurchaseRecordState {}

class PurchaseRecordLoading extends PurchaseRecordState {}

class PurchaseRecordLoaded extends PurchaseRecordState {
  final PurchaseRecordModel purchaseRecord;

  PurchaseRecordLoaded(this.purchaseRecord);
}

class PurchaseRecordError extends PurchaseRecordState {
  final String message;

  PurchaseRecordError(this.message);
}
