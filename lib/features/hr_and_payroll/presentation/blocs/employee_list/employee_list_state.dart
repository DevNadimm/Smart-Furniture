part of 'employee_list_bloc.dart';

abstract class EmployeeListState {}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoading extends EmployeeListState {}

class EmployeeListLoaded extends EmployeeListState {
  final EmployeeListModel employeeListModel;

  EmployeeListLoaded(this.employeeListModel);
}

class EmployeeListError extends EmployeeListState {
  final String message;

  EmployeeListError(this.message);
}
