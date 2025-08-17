import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/reports/data/models/customer_payment_model.dart';
import 'package:smart_furniture/features/reports/data/repositories/customer_payment_repository.dart';

part 'customer_payment_event.dart';
part 'customer_payment_state.dart';

class CustomerPaymentBloc extends Bloc<CustomerPaymentEvent, CustomerPaymentState> {
  CustomerPaymentBloc() : super(CustomerPaymentInitial()) {
    on<LoadCustomerPaymentEvent>((event, emit) async {
      emit(CustomerPaymentLoading());
      try {
        final data = await CustomerPaymentRepository.fetchData(
          event.shop,
          event.fromDate,
          event.toDate,
          event.customerId,
        );
        emit(CustomerPaymentLoaded(data!));
      } catch (e) {
        emit(CustomerPaymentError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    on<ResetCustomerPaymentEvent>((event, emit) {
      emit(CustomerPaymentInitial());
    });
  }
}
