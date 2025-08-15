part of 'additional_payments_bloc.dart';

abstract class AdditionalPaymentsState {}

class AdditionalPaymentsInitial extends AdditionalPaymentsState {}

class AdditionalPaymentsLoading extends AdditionalPaymentsState {}

class AdditionalPaymentsLoaded extends AdditionalPaymentsState {
  final AdditionalPaymentsModel additionalPaymentsModel;

  AdditionalPaymentsLoaded(this.additionalPaymentsModel);
}

class AdditionalPaymentsError extends AdditionalPaymentsState {
  final String message;

  AdditionalPaymentsError(this.message);
}
