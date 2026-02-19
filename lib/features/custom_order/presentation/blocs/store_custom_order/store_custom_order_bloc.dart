import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/custom_order/data/repositories/custom_order_repository.dart';

part 'store_custom_order_event.dart';
part 'store_custom_order_state.dart';

class StoreCustomOrderBloc
    extends Bloc<StoreCustomOrderEvent, StoreCustomOrderState> {
  StoreCustomOrderBloc() : super(StoreCustomOrderInitial()) {
    on<StoreCustomOrderSubmitEvent>((event, emit) async {
      emit(StoreCustomOrderLoading());
      try {
        final result = await CustomOrderRepository.storeOrder(event.body);
        if (result) {
          emit(StoreCustomOrderSuccess('Custom order created successfully'));
        } else {
          emit(StoreCustomOrderError('Failed to create custom order'));
        }
      } catch (e) {
        emit(StoreCustomOrderError(
            HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
