part of 'custom_production_bloc.dart';

abstract class CustomProductionState {}

class CustomProductionInitial extends CustomProductionState {}

class CustomProductionLoading extends CustomProductionState {}

class CustomProductionLoaded extends CustomProductionState {
  final CustomProductionModel customProduction;

  CustomProductionLoaded(this.customProduction);
}

class CustomProductionError extends CustomProductionState {
  final String message;

  CustomProductionError(this.message);
}
