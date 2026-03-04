part of 'fixed_production_bloc.dart';

abstract class FixedProductionEvent {}

class LoadFixedProductionsEvent extends FixedProductionEvent {
  final String? startDate;
  final String? endDate;

  LoadFixedProductionsEvent({
    required this.startDate,
    required this.endDate,
  });
}