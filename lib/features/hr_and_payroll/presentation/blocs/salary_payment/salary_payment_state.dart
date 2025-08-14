part of 'salary_payment_bloc.dart';

abstract class SalaryPaymentState {}

class SalaryPaymentInitial extends SalaryPaymentState {}

class SalaryPaymentLoading extends SalaryPaymentState {}

class SalaryPaymentLoaded extends SalaryPaymentState {
  final SalaryPaymentModel salaryPaymentModel;

  SalaryPaymentLoaded(this.salaryPaymentModel);
}

class SalaryPaymentError extends SalaryPaymentState {
  final String message;

  SalaryPaymentError(this.message);
}
