import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_purchase_due_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/customer_dues_repository.dart';

part 'customer_purchase_dues_event.dart';
part 'customer_purchase_dues_state.dart';

class CustomerPurchaseDuesBloc extends Bloc<CustomerPurchaseDuesEvent, CustomerPurchaseDuesState> {
  CustomerPurchaseDuesBloc() : super(CustomerPurchaseDuesInitial()) {

    // Load customer-wise purchase dues
    on<LoadCustomerPurchaseDuesEvent>((event, emit) async {
      emit(CustomerPurchaseDuesLoading());
      try {
        final data = await CustomerDuesRepository.fetchCustomerWisePurchaseDues(
          event.customerId,
        );
        if (data != null) {
          emit(CustomerPurchaseDuesLoaded(data));
        } else {
          emit(CustomerPurchaseDuesError('Failed to fetch customer purchase dues'));
        }
      } catch (e) {
        emit(CustomerPurchaseDuesError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}