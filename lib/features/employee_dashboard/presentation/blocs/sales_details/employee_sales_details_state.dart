part of 'employee_sales_details_bloc.dart';

abstract class EmployeeSalesDetailsState {}

class SalesDetailsInitial extends EmployeeSalesDetailsState {}

class SalesDetailsLoading extends EmployeeSalesDetailsState {}

class SalesDetailsLoaded extends EmployeeSalesDetailsState {
  final EmployeeSalesDetailsModel salesDetailsModel;

  SalesDetailsLoaded(this.salesDetailsModel);
}

class SalesDetailsError extends EmployeeSalesDetailsState {
  final String message;

  SalesDetailsError(this.message);
}