import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/company/data/models/fixed_production_model.dart';
import 'package:smart_furniture/features/company/data/repositories/fixed_production_repository.dart';

part 'fixed_production_event.dart';
part 'fixed_production_state.dart';

class FixedProductionBloc extends Bloc<FixedProductionEvent, FixedProductionState> {
  FixedProductionBloc() : super(FixedProductionInitial()) {
    on<LoadFixedProductionsEvent>((event, emit) async {
      emit(FixedProductionLoading());
      try {
        final data = await FixedProductionRepository.fetchFixedProductions(
          startDate: event.startDate,
          endDate: event.endDate,
        );
        emit(FixedProductionLoaded(data));
      } catch (e) {
        emit(FixedProductionError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}