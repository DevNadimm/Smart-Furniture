import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/product_list_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/product_list_repo.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<LoadProductListEvent>((event, emit) async {
      emit(ProductListLoading());

      try {
        final data = await ProductListRepository.fetchProducts(
          categoryId: event.categoryId,
        );

        emit(ProductListLoaded(data));
      } catch (e) {
        emit(
          ProductListError(
            HelperFunctions.cleanErrorMessage(e.toString()),
          ),
        );
      }
    });
  }
}