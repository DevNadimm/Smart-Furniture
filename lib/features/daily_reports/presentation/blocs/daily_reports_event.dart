part of 'daily_reports_bloc.dart';

abstract class DailyReportsEvent {}

class LoadDailyReportsEvent extends DailyReportsEvent {
  final String shop;
  final String date;

  LoadDailyReportsEvent(this.shop, this.date);
}
