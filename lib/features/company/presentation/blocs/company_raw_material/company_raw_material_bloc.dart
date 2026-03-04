import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/company/data/models/company_raw_material_model.dart';
import 'package:smart_furniture/features/company/data/repositories/company_raw_material_repository.dart';

part 'company_raw_material_event.dart';
part 'company_raw_material_state.dart';

class CompanyRawMaterialBloc extends Bloc<CompanyRawMaterialEvent, CompanyRawMaterialState> {
  CompanyRawMaterialBloc() : super(CompanyRawMaterialInitial()) {
    on<LoadCompanyRawMaterialsEvent>((event, emit) async {
      emit(CompanyRawMaterialLoading());
      try {
        final data = await CompanyRawMaterialRepository.fetchCompanyRawMaterials(categoryId: event.categoryId, search: event.search);
        emit(CompanyRawMaterialLoaded(data));
      } catch (e) {
        emit(CompanyRawMaterialError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}