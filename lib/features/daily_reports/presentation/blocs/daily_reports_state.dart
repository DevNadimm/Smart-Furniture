part of 'daily_reports_bloc.dart';

abstract class DailyReportsState {}

class DailyReportsInitial extends DailyReportsState {}

class DailyReportsLoading extends DailyReportsState {}

class DailyReportsLoaded extends DailyReportsState {
  final DailyReportsModel dailyReportsModel;

  DailyReportsLoaded(this.dailyReportsModel);
}

class DailyReportsError extends DailyReportsState {
  final String message;

  DailyReportsError(this.message);
}
