part of 'pending_cheque_list_bloc.dart';

abstract class PendingChequeListState {}

class PendingChequeListInitial extends PendingChequeListState {}

class PendingChequeListLoading extends PendingChequeListState {}

class PendingChequeListLoaded extends PendingChequeListState {
  final PendingChequeListModel pendingChequeListModel;

  PendingChequeListLoaded(this.pendingChequeListModel);
}

class PendingChequeListError extends PendingChequeListState {
  final String message;

  PendingChequeListError(this.message);
}
