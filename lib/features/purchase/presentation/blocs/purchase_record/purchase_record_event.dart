part of 'purchase_record_bloc.dart';

abstract class PurchaseRecordEvent {}

class LoadPurchaseRecordEvent extends PurchaseRecordEvent {
  final String shop;
  final String? fromDate;
  final String? toDate;

  LoadPurchaseRecordEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
  });
}
