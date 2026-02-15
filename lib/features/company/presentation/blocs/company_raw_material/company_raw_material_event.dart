part of 'company_raw_material_bloc.dart';

@immutable
sealed class CompanyRawMaterialEvent {}

class LoadCompanyRawMaterialsEvent extends CompanyRawMaterialEvent {}