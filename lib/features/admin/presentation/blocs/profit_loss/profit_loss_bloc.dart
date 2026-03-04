import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/admin/data/models/profit_loss_model.dart';
import 'package:smart_furniture/features/admin/data/repositories/profit_loss_repo.dart';

part 'profit_loss_event.dart';
part 'profit_loss_state.dart';

class ProfitLossBloc extends Bloc<ProfitLossEvent, ProfitLossState> {
  ProfitLossBloc() : super(ProfitLossInitial()) {
    on<LoadProfitLossEvent>((event, emit) async {
      emit(ProfitLossLoading());
      try {
        print(event.branchId);
        print(event.fromDate);
        print(event.toDate);
        final data = await ProfitLossRepository.fetchProfitLoss(
          fromDate: event.fromDate,
          toDate: event.toDate,
          branchId: event.branchId,
        );
        emit(ProfitLossLoaded(data));
      } catch (e) {
        emit(ProfitLossError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}