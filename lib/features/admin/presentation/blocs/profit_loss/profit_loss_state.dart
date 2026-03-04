part of 'profit_loss_bloc.dart';

abstract class ProfitLossState {}

class ProfitLossInitial extends ProfitLossState {}

class ProfitLossLoading extends ProfitLossState {}

class ProfitLossLoaded extends ProfitLossState {
  final ProfitLossModel profitLoss;

  ProfitLossLoaded(this.profitLoss);
}

class ProfitLossError extends ProfitLossState {
  final String message;

  ProfitLossError(this.message);
}