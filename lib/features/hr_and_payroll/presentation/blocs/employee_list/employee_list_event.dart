part of 'employee_list_bloc.dart';

abstract class EmployeeListEvent {}

class LoadEmployeeListEvent extends EmployeeListEvent {
  final String shop;

  LoadEmployeeListEvent(this.shop);
}
