part of 'reminder_cheque_list_bloc.dart';

abstract class ReminderChequeListState {}

class ReminderChequeListInitial extends ReminderChequeListState {}

class ReminderChequeListLoading extends ReminderChequeListState {}

class ReminderChequeListLoaded extends ReminderChequeListState {
  final ReminderChequeListModel reminderChequeListModel;

  ReminderChequeListLoaded(this.reminderChequeListModel);
}

class ReminderChequeListError extends ReminderChequeListState {
  final String message;

  ReminderChequeListError(this.message);
}
