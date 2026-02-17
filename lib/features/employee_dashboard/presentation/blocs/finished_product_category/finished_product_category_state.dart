part of 'finished_product_category_bloc.dart';

abstract class FinishedProductCategoryState {}

class FinishedProductCategoryInitial extends FinishedProductCategoryState {}

class FinishedProductCategoryLoading extends FinishedProductCategoryState {}

class FinishedProductCategoryLoaded extends FinishedProductCategoryState {
  final List<FinishedProductCategoryData> categories;

  FinishedProductCategoryLoaded(this.categories);
}

class FinishedProductCategoryError extends FinishedProductCategoryState {
  final String message;

  FinishedProductCategoryError(this.message);
}