part of 'employee_sales_bloc.dart';

abstract class EmployeeSalesEvent {}

class LoadEmployeeSalesEvent extends EmployeeSalesEvent {
  final int? branchId;
  final String? fromDate;
  final String? toDate;
  final String? categoryId;

  LoadEmployeeSalesEvent({
    required this.branchId,
    required this.fromDate,
    required this.toDate,
    required this.categoryId,
  });
}

class CreateEmployeeSaleEvent extends EmployeeSalesEvent {
  final Map<String, dynamic> salesData;

  CreateEmployeeSaleEvent(this.salesData);
}
