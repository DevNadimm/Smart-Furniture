part of 'balance_sheet_bloc.dart';

abstract class BalanceSheetEvent {}

class LoadBalanceSheetEvent extends BalanceSheetEvent {
  final String shop;
  final String fromDate;
  final String toDate;

  LoadBalanceSheetEvent({
    required this.shop,
    required this.fromDate,
    required this.toDate,
  });
}

class ResetBalanceSheetEvent extends BalanceSheetEvent {}
