part of 'damage_list_bloc.dart';

abstract class DamageListEvent {}

class LoadDamageListEvent extends DamageListEvent {
  final String shop;
  final String productId;

  LoadDamageListEvent(this.shop, this.productId);
}

class ResetDamageListEvent extends DamageListEvent {}
