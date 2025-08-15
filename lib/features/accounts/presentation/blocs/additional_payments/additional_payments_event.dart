part of 'additional_payments_bloc.dart';

abstract class AdditionalPaymentsEvent {}

class LoadAdditionalPaymentsEvent extends AdditionalPaymentsEvent {
  final String shop;

  LoadAdditionalPaymentsEvent(this.shop);
}
