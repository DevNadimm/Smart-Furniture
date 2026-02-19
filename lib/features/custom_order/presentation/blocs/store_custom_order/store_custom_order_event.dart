part of 'store_custom_order_bloc.dart';

abstract class StoreCustomOrderEvent {}

class StoreCustomOrderSubmitEvent extends StoreCustomOrderEvent {
  final Map<String, dynamic> body;

  StoreCustomOrderSubmitEvent(this.body);
}
