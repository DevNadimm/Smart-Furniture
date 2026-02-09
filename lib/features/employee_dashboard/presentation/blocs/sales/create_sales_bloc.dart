import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/create_sales_repository.dart';

part 'create_sales_event.dart';
part 'create_sales_state.dart';

class CreateSalesBloc extends Bloc<CreateSalesEvent, CreateSalesState> {
  CreateSalesBloc() : super(CreateSalesInitial()) {
    on<CreateSalesSubmitEvent>((event, emit) async {
      emit(CreateSalesLoading());
      try {
        final result = await CreateSalesRepository.createSales(event.salesData);
        if (result == true) {
          emit(CreateSalesSuccess());
        } else {
          emit(CreateSalesError('Failed to create sales'));
        }
      } catch (e) {
        emit(CreateSalesError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}