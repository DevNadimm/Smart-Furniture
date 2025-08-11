import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/models/employee_list_model.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/repositories/employee_list_repository.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc() : super(EmployeeListInitial()) {
    on<LoadEmployeeListEvent>((event, emit) async {
      emit(EmployeeListLoading());
      try {
        final data = await EmployeeListRepository.fetchData();
        emit(EmployeeListLoaded(data!));
      } catch (e) {
        emit(EmployeeListError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
