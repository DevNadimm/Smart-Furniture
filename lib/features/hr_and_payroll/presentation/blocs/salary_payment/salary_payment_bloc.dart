import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/models/salary_payment_model.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/repositories/salary_payment_repository.dart';

part 'salary_payment_event.dart';
part 'salary_payment_state.dart';

class SalaryPaymentBloc extends Bloc<SalaryPaymentEvent, SalaryPaymentState> {
  SalaryPaymentBloc() : super(SalaryPaymentInitial()) {
    on<LoadSalaryPaymentEvent>((event, emit) async {
      emit(SalaryPaymentLoading());
      try {
        final data = await SalaryPaymentRepository.fetchData();
        emit(SalaryPaymentLoaded(data!));
      } catch (e) {
        SalaryPaymentError(HelperFunctions.cleanErrorMessage(e.toString()));
      }
    });
  }
}
