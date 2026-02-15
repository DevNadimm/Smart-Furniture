import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/employee_dashboard/data/repositories/customer_dues_repository.dart';

part 'due_payment_event.dart';
part 'due_payment_state.dart';

class DuePaymentBloc extends Bloc<DuePaymentEvent, DuePaymentState> {
  DuePaymentBloc() : super(DuePaymentInitial()) {

    // Make due payment
    on<MakeDuePaymentEvent>((event, emit) async {
      emit(DuePaymentLoading());
      try {
        final result = await CustomerDuesRepository.duePayment(
          event.paymentData,
        );
        if (result) {
          emit(DuePaymentSuccess('Payment completed successfully'));
        } else {
          emit(DuePaymentError('Payment failed'));
        }
      } catch (e) {
        emit(DuePaymentError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    // Reset to initial state
    on<ResetDuePaymentEvent>((event, emit) {
      emit(DuePaymentInitial());
    });
  }
}