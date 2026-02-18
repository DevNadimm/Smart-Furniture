import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/sales_details_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/employee_sales_repository.dart';

part 'sales_details_event.dart';
part 'sales_details_state.dart';

class SalesDetailsBloc extends Bloc<SalesDetailsEvent, SalesDetailsState> {
  SalesDetailsBloc() : super(SalesDetailsInitial()) {
    on<LoadSalesDetailsEvent>((event, emit) async {
      emit(SalesDetailsLoading());
      try {
        final data = await EmployeeSalesRepository.fetchSalesDetails(event.saleId);
        if (data != null) {
          emit(SalesDetailsLoaded(data));
        } else {
          emit(SalesDetailsError('Failed to load sales details'));
        }
      } catch (e) {
        emit(SalesDetailsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}