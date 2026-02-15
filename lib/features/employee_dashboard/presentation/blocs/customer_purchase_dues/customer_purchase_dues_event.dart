part of 'customer_purchase_dues_bloc.dart';

abstract class CustomerPurchaseDuesEvent {}

/// Load customer-wise purchase dues
class LoadCustomerPurchaseDuesEvent extends CustomerPurchaseDuesEvent {
  final int customerId;

  LoadCustomerPurchaseDuesEvent(this.customerId);
}
