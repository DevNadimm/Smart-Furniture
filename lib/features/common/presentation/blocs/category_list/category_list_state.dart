part of 'category_list_bloc.dart';

abstract class CategoryListState {}

class CategoryListInitial extends CategoryListState {}

class CategoryListLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  final CategoryModel categoryModel;

  CategoryListLoaded(this.categoryModel);
}

class CategoryListError extends CategoryListState {
  final String message;

  CategoryListError(this.message);
}