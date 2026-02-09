part of 'create_sales_bloc.dart';

abstract class CreateSalesState {}

class CreateSalesInitial extends CreateSalesState {}

class CreateSalesLoading extends CreateSalesState {}

class CreateSalesSuccess extends CreateSalesState {}

class CreateSalesError extends CreateSalesState {
  final String message;

  CreateSalesError(this.message);
}
