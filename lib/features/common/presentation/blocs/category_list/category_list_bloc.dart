import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/common/data/models/category_model.dart';
import 'package:smart_furniture/features/common/data/repositories/category_list_repository.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc() : super(CategoryListInitial()) {
    on<LoadCategoryListEvent>((event, emit) async {
      emit(CategoryListLoading());
      try {
        final data = await CategoryListRepository.fetchData(event.shop);
        emit(CategoryListLoaded(data!));
      } catch (e) {
        emit(CategoryListError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}