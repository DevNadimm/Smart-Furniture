part of 'balance_sheet_bloc.dart';

abstract class BalanceSheetState {}

class BalanceSheetInitial extends BalanceSheetState {}

class BalanceSheetLoading extends BalanceSheetState {}

class BalanceSheetLoaded extends BalanceSheetState {
  final BalanceSheetModel balanceSheetModel;

  BalanceSheetLoaded(this.balanceSheetModel);
}

class BalanceSheetError extends BalanceSheetState {
  final String message;

  BalanceSheetError(this.message);
}
