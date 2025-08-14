part of 'reminder_cheque_list_bloc.dart';

abstract class ReminderChequeListEvent {}

class LoadReminderChequeListEvent extends ReminderChequeListEvent {
  final String shop;

  LoadReminderChequeListEvent(this.shop);
}
