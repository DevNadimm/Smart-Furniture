part of 'store_custom_order_bloc.dart';

abstract class StoreCustomOrderEvent {}

class StoreCustomOrderSubmitEvent extends StoreCustomOrderEvent {
  /// Flat string fields (order_date, customer_id, sub_total, etc.)
  final Map<String, String> fields;

  /// Item list with optional image files
  final List<CustomOrderItemPayload> items;

  StoreCustomOrderSubmitEvent({
    required this.fields,
    required this.items,
  });
}

class ResetStoreCustomOrderEvent extends StoreCustomOrderEvent {}
