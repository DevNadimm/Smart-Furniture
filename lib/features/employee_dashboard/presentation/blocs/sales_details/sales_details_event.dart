part of 'sales_details_bloc.dart';

abstract class SalesDetailsEvent {}

class LoadSalesDetailsEvent extends SalesDetailsEvent {
  final int saleId;

  LoadSalesDetailsEvent(this.saleId);
}