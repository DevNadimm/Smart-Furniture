part of 'employee_stock_bloc.dart';

abstract class EmployeeStockEvent {}

class LoadStocksEvent extends EmployeeStockEvent {
  final int? branchId;
  final int? categoryId;
  final String? search;

  LoadStocksEvent({this.branchId, this.categoryId, this.search});
}
