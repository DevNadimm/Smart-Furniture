import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/company/data/models/finished_product_model.dart';
import 'package:smart_furniture/features/company/data/repositories/finished_product_repository.dart';

part 'finished_product_event.dart';
part 'finished_product_state.dart';

class FinishedProductBloc extends Bloc<FinishedProductEvent, FinishedProductState> {
  FinishedProductBloc() : super(FinishedProductInitial()) {
    on<LoadFinishedProductsEvent>((event, emit) async {
      emit(FinishedProductLoading());
      try {
        final data = await FinishedProductRepository.fetchFinishedProducts(categoryId: event.categoryId, search: event.search);
        emit(FinishedProductLoaded(data));
      } catch (e) {
        emit(FinishedProductError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}