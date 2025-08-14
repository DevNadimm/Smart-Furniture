part of 'pending_cheque_list_bloc.dart';

abstract class PendingChequeListEvent {}

class LoadPendingChequeListEvent extends PendingChequeListEvent {
  final String shop;

  LoadPendingChequeListEvent(this.shop);
}
