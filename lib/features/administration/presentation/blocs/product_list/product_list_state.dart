part of 'product_list_bloc.dart';

abstract class ProductListState {}

final class ProductListInitial extends ProductListState {}

final class ProductListLoading extends ProductListState {}

final class ProductListLoaded extends ProductListState {
  final ProductListModel productListModel;

  ProductListLoaded(this.productListModel);
}

final class ProductListError extends ProductListState {
  final String message;

  ProductListError(this.message);
}
