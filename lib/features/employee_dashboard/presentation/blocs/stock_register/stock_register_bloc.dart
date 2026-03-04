import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/stock_register_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/stock_register_repository.dart';

part 'stock_register_event.dart';
part 'stock_register_state.dart';

class StockRegisterBloc extends Bloc<StockRegisterEvent, StockRegisterState> {
  StockRegisterBloc() : super(StockRegisterInitial()) {
    on<LoadStockRegisterEvent>((event, emit) async {
      emit(StockRegisterLoading());
      try {
        final data = await StockRegisterRepository.fetchStockRegister(
          productId: event.productId,
          branchId: event.branchId,
          startDate: event.startDate,
          endDate: event.endDate,
        );
        emit(StockRegisterLoaded(data));
      } catch (e) {
        emit(StockRegisterError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}