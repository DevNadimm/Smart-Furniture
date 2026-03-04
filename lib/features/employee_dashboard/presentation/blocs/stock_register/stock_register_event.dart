part of 'stock_register_bloc.dart';

abstract class StockRegisterEvent {}

class LoadStockRegisterEvent extends StockRegisterEvent {
  final int? productId;
  final String? branchId;
  final String? startDate;
  final String? endDate;

  LoadStockRegisterEvent({
    required this.productId,
    required this.branchId,
    this.startDate,
    this.endDate,
  });
}
