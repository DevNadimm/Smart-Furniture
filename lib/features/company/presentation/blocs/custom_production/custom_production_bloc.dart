import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/company/data/models/custom_production_model.dart';
import 'package:smart_furniture/features/company/data/repositories/custom_production_repository.dart';

part 'custom_production_event.dart';
part 'custom_production_state.dart';

class CustomProductionBloc extends Bloc<CustomProductionEvent, CustomProductionState> {
  CustomProductionBloc() : super(CustomProductionInitial()) {
    on<LoadCustomProductionsEvent>((event, emit) async {
      emit(CustomProductionLoading());
      try {
        final data = await CustomProductionRepository.fetchCustomProductions(
          startDate: event.startDate,
          endDate: event.endDate,
        );
        emit(CustomProductionLoaded(data));
      } catch (e) {
        emit(CustomProductionError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}