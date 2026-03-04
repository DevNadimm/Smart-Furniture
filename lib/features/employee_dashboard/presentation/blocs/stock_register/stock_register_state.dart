part of 'stock_register_bloc.dart';

abstract class StockRegisterState {}

class StockRegisterInitial extends StockRegisterState {}

class StockRegisterLoading extends StockRegisterState {}

class StockRegisterLoaded extends StockRegisterState {
  final StockRegisterModel stockRegister;

  StockRegisterLoaded(this.stockRegister);
}

class StockRegisterError extends StockRegisterState {
  final String message;

  StockRegisterError(this.message);
}