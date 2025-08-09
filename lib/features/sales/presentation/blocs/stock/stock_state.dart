part of 'stock_bloc.dart';

abstract class StockState {}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final StockModel stock;

  StockLoaded(this.stock);
}

class StockError extends StockState {
  final String message;

  StockError(this.message);
}
