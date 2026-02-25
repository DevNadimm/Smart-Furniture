part of 'finished_product_bloc.dart';

@immutable
sealed class FinishedProductEvent {}

class LoadFinishedProductsEvent extends FinishedProductEvent {
  final int? categoryId;
  final String? search;

  LoadFinishedProductsEvent(this.categoryId, this.search);
}
