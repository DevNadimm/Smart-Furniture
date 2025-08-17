part of 'profit_loss_bloc.dart';

abstract class ProfitLossEvent {}

class LoadProfitLossEvent extends ProfitLossEvent {
  final String shop;
  final String? fromDate;
  final String? toDate;
  final String? customerId;

  LoadProfitLossEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
    required this.customerId,
  });
}
