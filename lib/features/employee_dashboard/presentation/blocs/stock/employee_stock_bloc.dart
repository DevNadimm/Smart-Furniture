import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_stock_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/employee_stock_repository.dart';

part 'employee_stock_event.dart';
part 'employee_stock_state.dart';

class EmployeeStockBloc extends Bloc<EmployeeStockEvent, EmployeeStockState> {
  EmployeeStockBloc() : super(StockInitial()) {
    on<LoadStocksEvent>((event, emit) async {
      emit(StockLoading());
      try {
        final data = await EmployeeStockRepository.fetchStocks();
        emit(StockLoaded(data!));
      } catch (e) {
        emit(StockError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
