part of 'damage_list_bloc.dart';

abstract class DamageListState {}

class DamageListInitial extends DamageListState {}

class DamageListLoading extends DamageListState {}

class DamageListLoaded extends DamageListState {
  final DamageListModel damageListModel;

  DamageListLoaded(this.damageListModel);
}

class DamageListError extends DamageListState {
  final String message;

  DamageListError(this.message);
}
