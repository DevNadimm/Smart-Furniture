import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/custom_order/data/models/custom_order_model.dart';
import 'package:smart_furniture/features/custom_order/data/repositories/custom_order_repository.dart';

part 'custom_order_event.dart';
part 'custom_order_state.dart';

class CustomOrderBloc extends Bloc<CustomOrderEvent, CustomOrderState> {
  CustomOrderBloc() : super(CustomOrderInitial()) {
    on<LoadCustomOrdersEvent>((event, emit) async {
      emit(CustomOrderLoading());
      try {
        final data = await CustomOrderRepository.fetchOrders(
          branchId: event.branchId,
          fromDate: event.fromDate,
          toDate: event.toDate,
          status: event.status,
        );
        emit(CustomOrderLoaded(data));
      } catch (e) {
        emit(CustomOrderError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
