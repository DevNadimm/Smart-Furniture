part of 'sales_details_bloc.dart';

abstract class SalesDetailsState {}

class SalesDetailsInitial extends SalesDetailsState {}

class SalesDetailsLoading extends SalesDetailsState {}

class SalesDetailsLoaded extends SalesDetailsState {
  final SalesDetailsModel salesDetailsModel;

  SalesDetailsLoaded(this.salesDetailsModel);
}

class SalesDetailsError extends SalesDetailsState {
  final String message;

  SalesDetailsError(this.message);
}