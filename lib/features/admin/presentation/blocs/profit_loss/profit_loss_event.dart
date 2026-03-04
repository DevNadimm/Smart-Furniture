part of 'profit_loss_bloc.dart';

abstract class ProfitLossEvent {}

class LoadProfitLossEvent extends ProfitLossEvent {
  final String? fromDate;
  final String? toDate;
  final int? branchId;

  LoadProfitLossEvent({
    required this.fromDate,
    required this.toDate,
    required this.branchId,
  });
}