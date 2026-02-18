import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_dues_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/customer_dues_repository.dart';

part 'customer_dues_event.dart';
part 'customer_dues_state.dart';

class CustomerDuesBloc extends Bloc<CustomerDuesEvent, CustomerDuesState> {
  CustomerDuesBloc() : super(CustomerDuesInitial()) {

    // Load all customer dues
    on<LoadCustomerDuesEvent>((event, emit) async {
      emit(CustomerDuesLoading());
      try {
        final data = await CustomerDuesRepository.fetchCustomerDues(branchId: event.branchId);
        if (data != null) {
          emit(CustomerDuesLoaded(data));
        } else {
          emit(CustomerDuesError('Failed to fetch customer dues'));
        }
      } catch (e) {
        emit(CustomerDuesError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}