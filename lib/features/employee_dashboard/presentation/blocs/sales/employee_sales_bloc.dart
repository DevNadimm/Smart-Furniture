import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_sales_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/employee_sales_repository.dart';

part 'employee_sales_event.dart';
part 'employee_sales_state.dart';

class EmployeeSalesBloc extends Bloc<EmployeeSalesEvent, EmployeeSalesState> {
  EmployeeSalesBloc() : super(EmployeeSalesInitial()) {
    // Load all sales
    on<LoadEmployeeSalesEvent>((event, emit) async {
      emit(EmployeeSalesLoading());
      try {
        final data = await EmployeeSalesRepository.fetchSales(branchId: event.branchId);
        emit(EmployeeSalesLoaded(data!));
      } catch (e) {
        emit(EmployeeSalesError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Create new sale
    on<CreateEmployeeSaleEvent>((event, emit) async {
      emit(EmployeeSalesOperationLoading());
      try {
        final result = await EmployeeSalesRepository.createSales(event.salesData);
        if (result) {
          emit(EmployeeSalesOperationSuccess('Sale created successfully'));
          // Reload sales after creation
          add(LoadEmployeeSalesEvent());
        } else {
          emit(EmployeeSalesError('Failed to create sale'));
        }
      } catch (e) {
        emit(EmployeeSalesError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}