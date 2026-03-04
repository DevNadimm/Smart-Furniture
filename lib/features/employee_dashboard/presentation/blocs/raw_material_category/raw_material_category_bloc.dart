import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/raw_material_category_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/raw_material_category_repository.dart';

part 'raw_material_category_event.dart';
part 'raw_material_category_state.dart';

class RawMaterialCategoryBloc extends Bloc<RawMaterialCategoryEvent, RawMaterialCategoryState> {
  RawMaterialCategoryBloc() : super(RawMaterialCategoryInitial()) {
    on<LoadRawMaterialCategoriesEvent>((event, emit) async {
      emit(RawMaterialCategoryLoading());

      try {
        final data = await RawMaterialCategoryRepository.fetchRawMaterialCategories();

        emit(RawMaterialCategoryLoaded(data));
      } catch (e) {
        emit(RawMaterialCategoryError(
          HelperFunctions.cleanErrorMessage(e.toString()),
        ));
      }
    });
  }
}
