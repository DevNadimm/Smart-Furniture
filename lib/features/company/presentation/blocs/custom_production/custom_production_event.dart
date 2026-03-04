part of 'custom_production_bloc.dart';

abstract class CustomProductionEvent {}

class LoadCustomProductionsEvent extends CustomProductionEvent {
  final String? startDate;
  final String? endDate;

  LoadCustomProductionsEvent({
    required this.startDate,
    required this.endDate,
  });
}