import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/accounts/data/models/pending_cheque_list_model.dart';
import 'package:smart_furniture/features/accounts/data/repositories/pending_cheque_list_repository.dart';

part 'pending_cheque_list_event.dart';
part 'pending_cheque_list_state.dart';

class PendingChequeListBloc extends Bloc<PendingChequeListEvent, PendingChequeListState> {
  PendingChequeListBloc() : super(PendingChequeListInitial()) {
    on<LoadPendingChequeListEvent>((event, emit) async {
      emit(PendingChequeListLoading());
      try {
        final data = await PendingChequeListRepository.fetchData(event.shop);
        emit(PendingChequeListLoaded(data!));
      } catch (e) {
        emit(PendingChequeListError(HelperFunctions.cleanErrorMessage(e.toString())));
      }
    });
  }
}
