import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/finished_product_category_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/finished_product_category_repository.dart';

part 'finished_product_category_event.dart';
part 'finished_product_category_state.dart';

class FinishedProductCategoryBloc extends Bloc<FinishedProductCategoryEvent, FinishedProductCategoryState> {
  FinishedProductCategoryBloc() : super(FinishedProductCategoryInitial()) {
    on<LoadFinishedProductCategoriesEvent>((event, emit) async {
      emit(FinishedProductCategoryLoading());
      try {
        final data = await FinishedProductCategoryRepository.fetchFinishedProductCategories();
        emit(FinishedProductCategoryLoaded(data));
      } catch (e) {
        emit(FinishedProductCategoryError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}