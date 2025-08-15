import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/accounts/data/models/balance_sheet_model.dart';
import 'package:smart_furniture/features/accounts/data/repositories/balance_sheet_repository.dart';

part 'balance_sheet_event.dart';
part 'balance_sheet_state.dart';

class BalanceSheetBloc extends Bloc<BalanceSheetEvent, BalanceSheetState> {
  BalanceSheetBloc() : super(BalanceSheetInitial()) {
    on<LoadBalanceSheetEvent>((event, emit) async {
      emit(BalanceSheetLoading());
      try {
        final data = await BalanceSheetRepository.fetchData(event.shop, event.fromDate, event.toDate);
        emit(BalanceSheetLoaded(data!));
      } catch (e) {
        emit(BalanceSheetError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });

    on<ResetBalanceSheetEvent>((event, emit) {
      emit(BalanceSheetInitial());
    });
  }
}
