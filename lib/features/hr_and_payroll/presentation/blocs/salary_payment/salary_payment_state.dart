part of 'salary_payment_bloc.dart';

abstract class SalaryPaymentState {}

class SalaryPaymentInitial extends SalaryPaymentState {}

class SalaryPaymentLoading extends SalaryPaymentState {}

class SalaryPaymentLoaded extends SalaryPaymentState {
  final List<SalaryPaymentModel> salaryPaymentModelList;

  SalaryPaymentLoaded(this.salaryPaymentModelList);
}

class SalaryPaymentError extends SalaryPaymentState {
  final String message;

  SalaryPaymentError(this.message);
}
