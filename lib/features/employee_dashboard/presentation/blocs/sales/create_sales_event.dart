part of 'create_sales_bloc.dart';

abstract class CreateSalesEvent {}

class CreateSalesSubmitEvent extends CreateSalesEvent {
  final Map<String, dynamic> salesData;

  CreateSalesSubmitEvent(this.salesData);
}
