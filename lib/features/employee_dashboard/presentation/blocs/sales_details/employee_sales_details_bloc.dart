import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_sales_details_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/employee_sales_details_repository.dart';

part 'employee_sales_details_event.dart';
part 'employee_sales_details_state.dart';

class EmployeeSalesDetailsBloc extends Bloc<EmployeeSalesDetailsEvent, EmployeeSalesDetailsState> {
  EmployeeSalesDetailsBloc() : super(SalesDetailsInitial()) {
    on<LoadSalesDetailsEvent>((event, emit) async {
      emit(SalesDetailsLoading());
      try {
        final data = await EmployeeSalesDetailsRepository.fetchDetails();
        emit(SalesDetailsLoaded(data!));
      } catch (e) {
        emit(SalesDetailsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}