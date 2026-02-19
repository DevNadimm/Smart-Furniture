import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/custom_order/data/repositories/custom_order_repository.dart';

part 'store_due_payment_event.dart';
part 'store_due_payment_state.dart';

class StoreDuePaymentBloc
    extends Bloc<StoreDuePaymentEvent, StoreDuePaymentState> {
  StoreDuePaymentBloc() : super(StoreDuePaymentInitial()) {
    on<StoreDuePaymentSubmitEvent>((event, emit) async {
      emit(StoreDuePaymentLoading());
      try {
        final result = await CustomOrderRepository.duePayment(event.body);
        if (result) {
          emit(StoreDuePaymentSuccess('Payment submitted successfully'));
        } else {
          emit(StoreDuePaymentError('Failed to submit payment'));
        }
      } catch (e) {
        emit(StoreDuePaymentError(
            HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
