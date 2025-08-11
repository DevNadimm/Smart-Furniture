import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/purchase/data/models/purchase_return_model.dart';
import 'package:smart_furniture/features/purchase/data/repositories/purchase_return_repository.dart';

part 'purchase_return_event.dart';
part 'purchase_return_state.dart';

class PurchaseReturnBloc extends Bloc<PurchaseReturnEvent, PurchaseReturnState> {
  PurchaseReturnBloc() : super(PurchaseReturnInitial()) {
    on<LoadPurchaseReturnEvent>((event, emit) async {
      emit(PurchaseReturnLoading());
      try {
        final data = await PurchaseReturnRepository.fetchData(
          event.fromDate,
          event.toDate,
          event.supplierId,
        );
        emit(PurchaseReturnLoaded(data!));
      } catch (e) {
        emit(PurchaseReturnError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
