part of 'salary_payment_bloc.dart';

abstract class SalaryPaymentEvent {}

class LoadSalaryPaymentEvent extends SalaryPaymentEvent {
  final String shop;

  LoadSalaryPaymentEvent(this.shop);
}
