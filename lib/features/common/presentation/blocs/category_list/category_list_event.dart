part of 'category_list_bloc.dart';

abstract class CategoryListEvent {}

class LoadCategoryListEvent extends CategoryListEvent {
  final String shop;

  LoadCategoryListEvent(this.shop);
}