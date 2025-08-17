import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/reports/data/models/profit_loss_model.dart';
import 'package:smart_furniture/features/reports/data/repositories/profit_loss_repository.dart';

part 'profit_loss_event.dart';
part 'profit_loss_state.dart';

class ProfitLossBloc extends Bloc<ProfitLossEvent, ProfitLossState> {
  ProfitLossBloc() : super(ProfitLossInitial()) {
    on<LoadProfitLossEvent>((event, emit) async {
      emit(ProfitLossLoading());
      try {
        final data = await ProfitLossRepository.fetchData(
          event.shop,
          event.fromDate,
          event.toDate,
          event.customerId,
        );
        emit(ProfitLossLoaded(data!));
      } catch (e) {
        emit(ProfitLossError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
