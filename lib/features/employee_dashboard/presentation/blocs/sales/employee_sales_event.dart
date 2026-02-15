part of 'employee_sales_bloc.dart';

abstract class EmployeeSalesEvent {}

class LoadEmployeeSalesEvent extends EmployeeSalesEvent {
  final int? branchId;

  LoadEmployeeSalesEvent({this.branchId});
}

class CreateEmployeeSaleEvent extends EmployeeSalesEvent {
  final Map<String, dynamic> salesData;

  CreateEmployeeSaleEvent(this.salesData);
}