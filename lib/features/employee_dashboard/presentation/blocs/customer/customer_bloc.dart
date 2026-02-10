import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/customer_repository.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitial()) {
    // Load all customers
    on<LoadCustomersEvent>((event, emit) async {
      emit(CustomerLoading());
      try {
        final data = await CustomerRepository.fetchCustomers();
        emit(CustomerLoaded(data!));
      } catch (e) {
        emit(CustomerError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Create new customer
    on<CreateCustomerEvent>((event, emit) async {
      emit(CustomerOperationLoading());
      try {
        final result = await CustomerRepository.createCustomer(event.customerData);
        if (result) {
          emit(CustomerOperationSuccess('Customer created successfully'));
          // Reload customers after creation
          add(LoadCustomersEvent());
        } else {
          emit(CustomerError('Failed to create customer'));
        }
      } catch (e) {
        emit(CustomerError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Update existing customer
    on<UpdateCustomerEvent>((event, emit) async {
      emit(CustomerOperationLoading());
      try {
        final result = await CustomerRepository.updateCustomer(
          event.id,
          event.customerData,
        );
        if (result) {
          emit(CustomerOperationSuccess('Customer updated successfully'));
          // Reload customers after update
          add(LoadCustomersEvent());
        } else {
          emit(CustomerError('Failed to update customer'));
        }
      } catch (e) {
        emit(CustomerError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Delete customer
    on<DeleteCustomerEvent>((event, emit) async {
      emit(CustomerOperationLoading());
      try {
        final result = await CustomerRepository.deleteCustomer(event.id);
        if (result) {
          emit(CustomerOperationSuccess('Customer deleted successfully'));
          // Reload customers after deletion
          add(LoadCustomersEvent());
        } else {
          emit(CustomerError('Failed to delete customer'));
        }
      } catch (e) {
        emit(CustomerError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
