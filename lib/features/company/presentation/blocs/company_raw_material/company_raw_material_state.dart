part of 'company_raw_material_bloc.dart';

@immutable
sealed class CompanyRawMaterialState {}

final class CompanyRawMaterialInitial extends CompanyRawMaterialState {}

final class CompanyRawMaterialLoading extends CompanyRawMaterialState {}

final class CompanyRawMaterialLoaded extends CompanyRawMaterialState {
  final CompanyRawMaterialModel rawMaterials;

  CompanyRawMaterialLoaded(this.rawMaterials);
}

final class CompanyRawMaterialError extends CompanyRawMaterialState {
  final String message;

  CompanyRawMaterialError(this.message);
}
