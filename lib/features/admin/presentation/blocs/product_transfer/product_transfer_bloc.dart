import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/product_transfer_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/product_transfer_repository.dart';

part 'product_transfer_event.dart';
part 'product_transfer_state.dart';

class ProductTransferBloc extends Bloc<ProductTransferEvent, ProductTransferState> {
  ProductTransferBloc() : super(ProductTransferInitial()) {
    on<LoadTransfersEvent>((event, emit) async {
      emit(ProductTransferLoading());
      try {
        final data = await ProductTransferRepository.fetchTransfers(
          fromDate: event.fromDate,
          toDate: event.toDate,
          categoryId: event.categoryId,
          branchId: event.branchId,
        );
        emit(ProductTransferLoaded(data));
      } catch (e) {
        emit(ProductTransferError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
