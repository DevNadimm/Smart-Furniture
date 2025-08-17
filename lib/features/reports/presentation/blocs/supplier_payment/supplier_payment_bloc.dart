import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/reports/data/models/supplier_payment_model.dart';
import 'package:smart_furniture/features/reports/data/repositories/supplier_payment_repository.dart';

part 'supplier_payment_event.dart';
part 'supplier_payment_state.dart';

class SupplierPaymentBloc extends Bloc<SupplierPaymentEvent, SupplierPaymentState> {
  SupplierPaymentBloc() : super(SupplierPaymentInitial()) {
    on<LoadSupplierPaymentEvent>((event, emit) async {
      emit(SupplierPaymentLoading());
      try {
        final data = await SupplierPaymentRepository.fetchData(
          event.shop,
          event.supplierId,
        );
        emit(SupplierPaymentLoaded(data!));
      } catch (e) {
        emit(SupplierPaymentError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    on<ResetSupplierPaymentEvent>((event, emit) {
      emit(SupplierPaymentInitial());
    });
  }
}
