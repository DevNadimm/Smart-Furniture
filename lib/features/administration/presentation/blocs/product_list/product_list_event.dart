part of 'product_list_bloc.dart';

abstract class ProductListEvent {}

class LoadProductListEvent extends ProductListEvent {
  final String shop;
  final String? search;

  LoadProductListEvent(this.shop, this.search);
}
