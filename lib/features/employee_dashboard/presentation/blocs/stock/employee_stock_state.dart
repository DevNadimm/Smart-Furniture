part of 'employee_stock_bloc.dart';

abstract class EmployeeStockState {}

class StockInitial extends EmployeeStockState {}

class StockLoading extends EmployeeStockState {}

class StockLoaded extends EmployeeStockState {
  final EmployeeStockModel stockModel;

  StockLoaded(this.stockModel);
}

class StockError extends EmployeeStockState {
  final String message;

  StockError(this.message);
}
