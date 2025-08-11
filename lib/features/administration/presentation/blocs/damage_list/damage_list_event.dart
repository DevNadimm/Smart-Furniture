part of 'damage_list_bloc.dart';

abstract class DamageListEvent {}

class LoadDamageListEvent extends DamageListEvent {
  final String productId;

  LoadDamageListEvent(this.productId);
}
