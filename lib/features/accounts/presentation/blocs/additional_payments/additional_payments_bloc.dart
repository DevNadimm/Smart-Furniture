import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/accounts/data/models/additional_payments_model.dart';
import 'package:smart_furniture/features/accounts/data/repositories/additional_payments_repository.dart';

part 'additional_payments_event.dart';
part 'additional_payments_state.dart';

class AdditionalPaymentsBloc extends Bloc<AdditionalPaymentsEvent, AdditionalPaymentsState> {
  AdditionalPaymentsBloc() : super(AdditionalPaymentsInitial()) {
    on<LoadAdditionalPaymentsEvent>((event, emit) async {
      emit(AdditionalPaymentsLoading());
      try {
        final data = await AdditionalPaymentsRepository.fetchData(event.shop);
        emit(AdditionalPaymentsLoaded(data!));
      } catch (e) {
        emit(AdditionalPaymentsError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
