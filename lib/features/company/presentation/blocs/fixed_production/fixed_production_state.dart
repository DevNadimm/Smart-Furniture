part of 'fixed_production_bloc.dart';

abstract class FixedProductionState {}

class FixedProductionInitial extends FixedProductionState {}

class FixedProductionLoading extends FixedProductionState {}

class FixedProductionLoaded extends FixedProductionState {
  final FixedProductionModel fixedProduction;

  FixedProductionLoaded(this.fixedProduction);
}

class FixedProductionError extends FixedProductionState {
  final String message;

  FixedProductionError(this.message);
}