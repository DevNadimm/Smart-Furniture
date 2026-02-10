part of 'employee_sales_bloc.dart';

abstract class EmployeeSalesEvent {}

class LoadEmployeeSalesEvent extends EmployeeSalesEvent {}

class CreateEmployeeSaleEvent extends EmployeeSalesEvent {
  final Map<String, dynamic> salesData;

  CreateEmployeeSaleEvent(this.salesData);
}