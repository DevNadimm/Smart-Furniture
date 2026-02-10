part of 'employee_sales_bloc.dart';

abstract class EmployeeSalesState {}

class EmployeeSalesInitial extends EmployeeSalesState {}

class EmployeeSalesLoading extends EmployeeSalesState {}

class EmployeeSalesLoaded extends EmployeeSalesState {
  final EmployeeSalesModel salesModel;

  EmployeeSalesLoaded(this.salesModel);
}

class EmployeeSalesOperationLoading extends EmployeeSalesState {}

class EmployeeSalesOperationSuccess extends EmployeeSalesState {
  final String message;

  EmployeeSalesOperationSuccess(this.message);
}

class EmployeeSalesError extends EmployeeSalesState {
  final String message;

  EmployeeSalesError(this.message);
}