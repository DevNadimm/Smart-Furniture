part of 'raw_material_category_bloc.dart';

abstract class RawMaterialCategoryState {}

class RawMaterialCategoryInitial extends RawMaterialCategoryState {}

class RawMaterialCategoryLoading extends RawMaterialCategoryState {}

class RawMaterialCategoryLoaded extends RawMaterialCategoryState {
  final List<RawMaterialCategoryData> categories;

  RawMaterialCategoryLoaded(this.categories);
}

class RawMaterialCategoryError extends RawMaterialCategoryState {
  final String message;

  RawMaterialCategoryError(this.message);
}
