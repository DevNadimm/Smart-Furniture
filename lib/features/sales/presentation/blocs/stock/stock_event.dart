part of 'stock_bloc.dart';

abstract class StockEvent {}

class LoadStockEvent extends StockEvent {
  final String shop;
  final String? fromDate;
  final String? toDate;
  final String? search;

  LoadStockEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
    required this.search,
  });
}
