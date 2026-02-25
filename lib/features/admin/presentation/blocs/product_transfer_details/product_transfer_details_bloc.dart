import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/product_transfer_details_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/product_transfer_repository.dart';

part 'product_transfer_details_event.dart';
part 'product_transfer_details_state.dart';

class ProductTransferDetailsBloc extends Bloc<ProductTransferDetailsEvent, ProductTransferDetailsState> {
  ProductTransferDetailsBloc() : super(ProductTransferDetailsInitial()) {
    on<LoadTransferDetailsEvent>((event, emit) async {
      emit(ProductTransferDetailsLoading());
      try {
        final data = await ProductTransferRepository.fetchTransferDetails(event.transferId);
        if (data != null) {
          emit(ProductTransferDetailsLoaded(data));
        } else {
          emit(ProductTransferDetailsError('Transfer details not found'));
        }
      } catch (e) {
        emit(ProductTransferDetailsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
