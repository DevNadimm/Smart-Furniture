part of 'product_list_bloc.dart';

abstract class ProductListEvent {}

class LoadProductListEvent extends ProductListEvent {
  final String? search;

  LoadProductListEvent(this.search);
}
